Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVCMJdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVCMJdy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 04:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbVCMJdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 04:33:54 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:28879 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261899AbVCMJd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 04:33:29 -0500
Message-ID: <423408EA.3040106@tiscali.de>
Date: Sun, 13 Mar 2005 10:33:30 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange Linking Problem
References: <4232F642.2050704@tiscali.de> <Pine.LNX.4.61.0503120929200.7904@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0503120929200.7904@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:

> On Sat, 12 Mar 2005, Matthias-Christian Ott wrote:
>
>> Hi!
>> I hope I'm right here. I've the following assembler code:
>>
>> SECTION .DATA
>>       hello:     db 'Hello world!',10
>>       helloLen:  equ $-hello
>>
>> SECTION .TEXT
>>       GLOBAL main
>>
>> main:
>>
>>
>>
>>       ; Write 'Hello world!' to the screen
>>       mov eax,4            ; 'write' system call
>>       mov ebx,1            ; file descriptor 1 = screen
>>       mov ecx,hello        ; string to write
>>       mov edx,helloLen     ; length of string to write
>>       int 80h              ; call the kernel
>>
>>       ; Terminate program
>>       mov eax,1            ; 'exit' system call
>>       mov ebx,0            ; exit with error code 0
>>       int 80h              ; call the kernel
>>
>>
>> Then I run:
>>
>> nasm -f elf hello.asm
>>
>>
>> I link it with ld and run it:
>>
>> ld -s -o hello hello.o
>> ./hello
>> segmentation fault
>>
>>
>> I link it with the gcc and run it:
>>
>> gcc hello.o -o hello
>> ./hello
>> Hello world!
>>
>>
>> What's wrong with the ld?
>>
>
> Nothing at all. Where is _start: ?
>
> Remove the 'main' label and substitute _start:
>
> It is 'C' convention that programs start with main(). They
> really don't. With the Linux API, they start at _start: and
> do some housekeeping before calling main. That's what the
> crt.o file that the 'C' tool-chain uses, does.
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction.
>
Ofcourse you have to edit it, but this is not the problem (the linker 
will give an error message if you don't change it). Why does it cause a 
segementation fault?

Matthias-Christian Ott
