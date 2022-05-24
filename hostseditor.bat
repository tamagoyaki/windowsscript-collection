@echo off
::
:: Add pair of srver name and ip address to hosts file.
::
:: USAGE
::
::   Edit srv and ip variable on this file. then run this batch file as admin.
::

:: ip address and host name
set srv=karasuuri
set ip=192.168.1.10

:: file name and directory
set directory=c:\Windows\System32\drivers\etc
set hosts=%directory%\hosts
set curdate=%date:~6,4%%date:~0,2%%date:~3,2%
set curtime=%time:~0,2%%time:~3,2%%time:~6,2%
set backup=%hosts%%curdate%%curtime%.backup

::echo %hosts%
::echo %backup%
::type %hosts%
::pause

net session > nul 2>&1
if not %errorlevel% == 0 (
   echo must be admin.
   pause
   exit
)

::
:: make backup and add entry to the hosts.
::
:: NOTE
::
::   'move %hosts% %backup%' didn't work, so use the type command instead.
::
type %hosts% > %backup%
findstr /v %srv% %backup% > %hosts%
echo %ip% %srv% >> %hosts%
