Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVCLOg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVCLOg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 09:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVCLOg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 09:36:56 -0500
Received: from alog0168.analogic.com ([208.224.220.183]:16360 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261926AbVCLOgw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 09:36:52 -0500
Date: Sat, 12 Mar 2005 09:34:49 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange Linking Problem
In-Reply-To: <4232F642.2050704@tiscali.de>
Message-ID: <Pine.LNX.4.61.0503120929200.7904@chaos.analogic.com>
References: <4232F642.2050704@tiscali.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2005, Matthias-Christian Ott wrote:

> Hi!
> I hope I'm right here. I've the following assembler code:
>
> SECTION .DATA
>       hello:     db 'Hello world!',10
>       helloLen:  equ $-hello
>
> SECTION .TEXT
>       GLOBAL main
>
> main:
>
>
>
>       ; Write 'Hello world!' to the screen
>       mov eax,4            ; 'write' system call
>       mov ebx,1            ; file descriptor 1 = screen
>       mov ecx,hello        ; string to write
>       mov edx,helloLen     ; length of string to write
>       int 80h              ; call the kernel
>
>       ; Terminate program
>       mov eax,1            ; 'exit' system call
>       mov ebx,0            ; exit with error code 0
>       int 80h              ; call the kernel
>
>
> Then I run:
>
> nasm -f elf hello.asm
>
>
> I link it with ld and run it:
>
> ld -s -o hello hello.o
> ./hello
> segmentation fault
>
>
> I link it with the gcc and run it:
>
> gcc hello.o -o hello
> ./hello
> Hello world!
>
>
> What's wrong with the ld?
>

Nothing at all. Where is _start: ?

Remove the 'main' label and substitute _start:

It is 'C' convention that programs start with main(). They
really don't. With the Linux API, they start at _start: and
do some housekeeping before calling main. That's what the
crt.o file that the 'C' tool-chain uses, does.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
