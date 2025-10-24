@echo off
REM ========================================
REM Script para criar ambiente, instalar requirements e rodar stresser.py
REM ========================================

echo.
echo [1/5] Verificando instalacao do Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERRO: Python nao foi encontrado no sistema.
    echo Instale o Python 3 e tente novamente.
    pause
    exit /b
)

echo.
echo [2/5] Criando ambiente virtual (.venv) (se nao existir)...
if not exist .venv (
    python -m venv .venv
    if errorlevel 1 (
        echo ERRO: Falha ao criar o ambiente virtual.
        pause
        exit /b
    )
)

echo.
echo [3/5] Ativando ambiente virtual...
call .venv\Scripts\activate
if errorlevel 1 (
    echo ERRO: Falha ao ativar o ambiente virtual.
    pause
    exit /b
)

echo.
echo [4/5] Instalando dependencias (requirements.txt)...
if exist requirements.txt (
    pip install --upgrade pip
    pip install -r requirements.txt
) else (
    echo AVISO: requirements.txt nao encontrado. Instalando colorama por padrao...
    pip install --upgrade pip
    pip install colorama>=0.4.6
)

echo.
echo [5/5] Executando stresser.py...
python stresser.py
set EXITCODE=%ERRORLEVEL%

echo.
if %EXITCODE%==0 (
    echo stresser.py finalizou com sucesso.
) else (
    echo stresser.py terminou com codigo de erro %EXITCODE%.
)

echo.
pause
exit /b %EXITCODE%