Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbUKHTTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbUKHTTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbUKHTRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:17:50 -0500
Received: from alog0232.analogic.com ([208.224.220.247]:8576 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261189AbUKHTQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:16:24 -0500
Date: Mon, 8 Nov 2004 14:12:18 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Adrian Bunk <bunk@stusta.de>
cc: Pawe?? Sikora <pluto@pld-linux.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
In-Reply-To: <20041108183120.GB15077@stusta.de>
Message-ID: <Pine.LNX.4.61.0411081410560.6407@chaos.analogic.com>
References: <20041107142445.GH14308@stusta.de> <20041108161935.GC2456@wotan.suse.de>
 <20041108163101.GA13234@stusta.de> <200411081904.13969.pluto@pld-linux.org>
 <20041108183120.GB15077@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, Adrian Bunk wrote:

> On Mon, Nov 08, 2004 at 07:04:13PM +0100, Pawe?? Sikora wrote:
>> On Monday 08 of November 2004 17:31, you wrote:
>>> On Mon, Nov 08, 2004 at 05:19:35PM +0100, Andi Kleen wrote:
>>>>> Rethinking it, I don't even understand the sprintf example in your
>>>>> changelog entry - shouldn't an inclusion of kernel.h always get it
>>>>> right?
>>>>
>>>> Newer gcc rewrites sprintf(buf,"%s",str) to strcpy(buf,str)
>>>> transparently.
>>>
>>> Which gcc is "Newer"?
>>>
>>> My gcc 3.4.2 didn't show this problem.
>>
>> #include <stdio.h>
>> #include <string.h>
>> char buf[128];
>> void test(char *str)
>> {
>>     sprintf(buf, "%s", str);
>> }
>> ...
>>         jmp     strcpy
>> ...
>
>
> This is the userspace example.
>
> The kernel example is:
>
> #include <linux/string.h>
> #include <linux/kernel.h>
>
> char buf[128];
> void test(char *str)
> {
>  sprintf(buf, "%s", str);
> }
>
>
> This results with gcc-3.4 (GCC) 3.4.2 (Debian 3.4.2-3) in:
>
>        .file   "test.c"
>        .section        .rodata.str1.1,"aMS",@progbits,1
> .LC0:
>        .string "%s"
>        .text
>        .p2align 4,,15
> .globl test
>        .type   test, @function
> test:
>        pushl   %eax
>        pushl   $.LC0
>        pushl   $buf
>        call    sprintf
>        addl    $12, %esp
>        ret
>        .size   test, .-test
> .globl buf
>        .bss
>        .align 32
>        .type   buf, @object
>        .size   buf, 128
> buf:
>        .zero   128
>        .section        .note.GNU-stack,"",@progbits
>        .ident  "GCC: (GNU) 3.4.2 (Debian 3.4.2-3)"
>
>
>
> cu
> Adrian
>

On this compiler 3.3.3, -O2 will cause it to use strcpy().

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
