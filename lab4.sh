#!/bin/bash

DATE_FLAG="--date"
LOGS_FLAG="--logs"
HELP_FLAG="--help"
INIT_FLAG="--init"

SINGLE_DATE_FLAG="-d"
SINGLE_LOGS_FLAG="-l"
SINGLE_HELP_FLAG="-h"
SINGLE_INIT_FLAG="-i"

display_date() {
    echo "Dzisiejsza data: $(date)"
}

create_logs() {
    for ((i=1; i<=100; i++)); do
        filename="log$i.txt"
        echo "Nazwa pliku: $filename" > "$filename"
        echo "Nazwa skryptu: skrypt.sh" >> "$filename"
        echo "Data utworzenia: $(date)" >> "$filename"
    done
}

display_help() {
    echo "Dostępne opcje:"
    echo "  $DATE_FLAG, $SINGLE_DATE_FLAG, -d : Wyświetla dzisiejszą datę."
    echo "  $LOGS_FLAG, $SINGLE_LOGS_FLAG, -l : Tworzy 100 plików logx.txt i wpisuje informacje o nich."
    echo "  $HELP_FLAG, $SINGLE_HELP_FLAG, -h : Wyświetla tę pomoc."
    echo "  $INIT_FLAG, $SINGLE_INIT_FLAG, -i : Klonuje całe repozytorium do katalogu i ustawia ścieżkę w PATH."
    echo "  --error, -e [liczba] : Tworzy pliki errorx.txt, domyślnie 100, lub określoną liczbę plików."
}

initialize_repository() {
    git clone https://github.com/twojekonto/twojerepo.git .

    export PATH="$(pwd):$PATH"
}

create_error_files() {
    local num_files=${1:-100}  # Ustawienie domyślnej liczby plików na 100, jeśli nie podano innego argumentu

    for ((i=1; i<=$num_files; i++)); do
        filename="error$i.txt"
        echo "This is error file $i" > "error/$filename"
    done
}

case "$1" in
    "$DATE_FLAG" | "$SINGLE_DATE_FLAG")
        # Wyświetlenie dzisiejszej daty
        display_date
        ;;
    "$LOGS_FLAG" | "$SINGLE_LOGS_FLAG")
        # Utworzenie 100 plików logowych
        create_logs
        ;;
    "$HELP_FLAG" | "$SINGLE_HELP_FLAG")
        # Wyświetlenie pomocy
        display_help
        ;;
    "$INIT_FLAG" | "$SINGLE_INIT_FLAG")
        # Inicjalizacja repozytorium
        initialize_repository
        ;;
    "--error" | "-e")
        if [ -n "$2" ] && [ "$2" -eq "$2" ] 2>/dev/null; then
            create_error_files "$2"
        else
            create_error_files
        fi
        ;;
    *)
        echo "Nieznana flaga lub brak flagi."
        echo "Użyj '$HELP_FLAG' lub '$SINGLE_HELP_FLAG' aby wyświetlić dostępne opcje."
        ;;
esac
