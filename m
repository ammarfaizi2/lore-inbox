Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVCLOBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVCLOBm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 09:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVCLOBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 09:01:42 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:57486 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261912AbVCLOBe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 09:01:34 -0500
Message-ID: <4232F642.2050704@tiscali.de>
Date: Sat, 12 Mar 2005 15:01:38 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Strange Linking Problem
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I hope I'm right here. I've the following assembler code:

SECTION .DATA
        hello:     db 'Hello world!',10
        helloLen:  equ $-hello

SECTION .TEXT
        GLOBAL main

main:



        ; Write 'Hello world!' to the screen
        mov eax,4            ; 'write' system call
        mov ebx,1            ; file descriptor 1 = screen
        mov ecx,hello        ; string to write
        mov edx,helloLen     ; length of string to write
        int 80h              ; call the kernel

        ; Terminate program
        mov eax,1            ; 'exit' system call
        mov ebx,0            ; exit with error code 0
        int 80h              ; call the kernel


Then I run:

nasm -f elf hello.asm


I link it with ld and run it:

ld -s -o hello hello.o
./hello
segmentation fault


I link it with the gcc and run it:

gcc hello.o -o hello
./hello
Hello world!


What's wrong with the ld?

Matthias-Christian Ott
