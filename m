Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbUKHXBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbUKHXBX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 18:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbUKHXBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 18:01:23 -0500
Received: from alog0167.analogic.com ([208.224.220.182]:13952 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261287AbUKHXBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 18:01:14 -0500
Date: Mon, 8 Nov 2004 17:57:12 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Adrian Bunk <bunk@stusta.de>
cc: Pawe?? Sikora <pluto@pld-linux.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] kill IN_STRING_C
In-Reply-To: <20041108222952.GJ15077@stusta.de>
Message-ID: <Pine.LNX.4.61.0411081751500.8711@chaos.analogic.com>
References: <20041107142445.GH14308@stusta.de> <20041108161935.GC2456@wotan.suse.de>
 <20041108163101.GA13234@stusta.de> <200411081904.13969.pluto@pld-linux.org>
 <20041108183120.GB15077@stusta.de> <Pine.LNX.4.61.0411081410560.6407@chaos.analogic.com>
 <20041108212713.GH15077@stusta.de> <Pine.LNX.4.61.0411081640320.8258@chaos.analogic.com>
 <20041108222952.GJ15077@stusta.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-1094138819-1099954632=:8711"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678434306-1094138819-1099954632=:8711
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Mon, 8 Nov 2004, Adrian Bunk wrote:
>
> If you don't compile the code as it would be compiled inside the kernel,
> that's your fault...
>
> Please reply only if you can reproduce this with
> #include <linux/string.h>, #include <linux/kernel.h> _and_ a gcc command
> line as it would be in the kernel - everything else is useless.

I attached a script that duplicates the gcc command line for the
compile and also generates the 'C' code.

Script started on Mon 08 Nov 2004 05:50:54 PM EST
# sh -v xxx.sh
#!/bin/bash

cat >xxx.c <<EOF
KERN=/usr/src/linux-`uname -r`
uname -r
touch xxx.o.d
gcc -Wp,-MD,xxx.o.d -nostdinc -iwithprefix include -D__KERNEL__ -I${KERN}/include  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -fomit-frame-pointer -Wdeclaration-after-statement -pipe -msoft-float -mpreferred-stack-boundary=2  -march=pentium4 -I${KERN}/include/asm-i386/mach-generic -I${KERN}/include/asm-i386/mach-default -DKVER6 -DMAJOR_NR=178 -DTRUE=1 -DFALSE=0  -DMODULE -DKBUILD_BASENAME=xxx -DKBUILD_MODNAME=Junk -S -o xxx xxx.c
cat xxx
 	.file	"xxx.c"
 	.section	.rodata
 	.type	hello, @object
 	.size	hello, 6
hello:
 	.string	"Hello"
 	.text
.globl xxx
 	.type	xxx, @function
xxx:
 	subl	$268, %esp
 	movl	%ebx, 264(%esp)
 	movl	$hello, 4(%esp)
 	leal	8(%esp), %ebx
 	movl	%ebx, (%esp)
 	call	strcpy
 	movl	%ebx, (%esp)
 	call	printk
 	movl	264(%esp), %ebx
 	xorl	%eax, %eax
 	addl	$268, %esp
 	ret
 	.size	xxx, .-xxx
 	.type	strcpy, @function
strcpy:
 	subl	$8, %esp
 	movl	12(%esp), %ecx
 	movl	%esi, (%esp)
 	movl	%edi, 4(%esp)
 	movl	16(%esp), %esi
 	movl	%ecx, %edi
#APP
 	1:	lodsb
 	stosb
 	testb %al,%al
 	jne 1b
#NO_APP
 	movl	%ecx, %eax
 	movl	(%esp), %esi
 	movl	4(%esp), %edi
 	addl	$8, %esp
 	ret
 	.size	strcpy, .-strcpy
 	.section	.note.GNU-stack,"",@progbits
 	.ident	"GCC: (GNU) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)"

# exit

Script done on Mon 08 Nov 2004 05:51:03 PM EST


It clearly invents strcpy, having never been referenced in the
source.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
--1678434306-1094138819-1099954632=:8711
Content-Type: APPLICATION/x-sh; name="xxx.sh"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0411081757120.8711@chaos.analogic.com>
Content-Description: 
Content-Disposition: attachment; filename="xxx.sh"

IyEvYmluL2Jhc2gKCmNhdCA+eHh4LmMgPDxFT0YKI2luY2x1ZGUgPGxpbnV4
L2tlcm5lbC5oPgojaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+CnN0YXRpYyBj
b25zdCBjaGFyIGhlbGxvW109IkhlbGxvIjsKaW50IHh4eCh2b2lkKTsKaW50
IHh4eCgpewogICBjaGFyIGJ1ZlsweDEwMF07CiAgIHNwcmludGYoYnVmLCAi
JXMiLCBoZWxsbyk7CiAgIHByaW50ayhidWYpOwogICByZXR1cm4gMDsKfQpF
T0YKS0VSTj0vdXNyL3NyYy9saW51eC1gdW5hbWUgLXJgCnRvdWNoIHh4eC5v
LmQKZ2NjIC1XcCwtTUQseHh4Lm8uZCAtbm9zdGRpbmMgLWl3aXRocHJlZml4
IGluY2x1ZGUgLURfX0tFUk5FTF9fIC1JJHtLRVJOfS9pbmNsdWRlICAtV2Fs
bCAtV3N0cmljdC1wcm90b3R5cGVzIC1Xbm8tdHJpZ3JhcGhzIC1mbm8tc3Ry
aWN0LWFsaWFzaW5nIC1mbm8tY29tbW9uIC1PMiAtZm9taXQtZnJhbWUtcG9p
bnRlciAtV2RlY2xhcmF0aW9uLWFmdGVyLXN0YXRlbWVudCAtcGlwZSAtbXNv
ZnQtZmxvYXQgLW1wcmVmZXJyZWQtc3RhY2stYm91bmRhcnk9MiAgLW1hcmNo
PXBlbnRpdW00IC1JJHtLRVJOfS9pbmNsdWRlL2FzbS1pMzg2L21hY2gtZ2Vu
ZXJpYyAtSSR7S0VSTn0vaW5jbHVkZS9hc20taTM4Ni9tYWNoLWRlZmF1bHQg
LURLVkVSNiAtRE1BSk9SX05SPTE3OCAtRFRSVUU9MSAtREZBTFNFPTAgIC1E
TU9EVUxFIC1ES0JVSUxEX0JBU0VOQU1FPXh4eCAtREtCVUlMRF9NT0ROQU1F
PUp1bmsgLVMgLW8geHh4IHh4eC5jCmNhdCB4eHgKCg==

--1678434306-1094138819-1099954632=:8711--
