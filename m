Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135714AbRAGFCD>; Sun, 7 Jan 2001 00:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135733AbRAGFBy>; Sun, 7 Jan 2001 00:01:54 -0500
Received: from www.wen-online.de ([212.223.88.39]:57618 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135714AbRAGFBd>;
	Sun, 7 Jan 2001 00:01:33 -0500
Date: Sun, 7 Jan 2001 06:01:31 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: posix_types.h  error
In-Reply-To: <Pine.LNX.3.95.1010106222520.20496A-100000@chaos.analogic.com>
Message-ID: <Pine.Linu.4.10.10101070526410.1227-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2001, Richard B. Johnson wrote:

Hi Richard,

> There is an error at line 80 in linux-2.4.0/include/asm/posix_types.h
> which prevents source-code from being compiled using the new C compiler
> that I was forced to install in order to build the new kernel.

Hmm.. line 80 is the last line in the file, an #endif.

What do you mean by 'forced to install..'?  gcc-2.95.2, gcc-2.95.2.1
and gcc-2.97 snapshots will build 2.4.0 (minus netfilter empty struct
initialzer glitchies).

> 		gcc 2.95.3

(Only exists at mdk afaik.. RedHat didn't get enough flak?;)

> Script started on Sat Jan  6 22:16:30 2001
> # cat xxx.c
> 
> 
> #include <stdio.h>
> #include <stdlib.h>
> 
> 
> main()
> {
>     fd_set x;
> 
>     FD_ZERO(&x);
> }
> 
> # gcc -c -o xxx.o xxx.c
> xxx.c: In function `main':
> xxx.c:11: Invalid `asm' statement:
> xxx.c:11: fixed or forbidden register 2 (cx) was spilled for class CREG.
> # vi /usr/include/asm/posix_types.h
> #ifndef __ARCH_I386_POSIX_TYPES_H
> #define __ARCH_I386_POSIX_TYPES_H
> 
> 
> 
> 
> 
> 
> 
> 
> [Snipped...]
> 
> #define __FD_ZERO(fdsetp) \
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> exit
> Script done on Sat Jan  6 22:19:03 2001
> 
> Since these inline asm statements no longer use register names, I
> don't know how to fix them. One of life's little mystries is how
> previously readable code got into this shape.

<g>  Agreed!  That code is terribly unreadable.. down right invisible.

Seriously though, the constraints look fine to me (and the register
name is there in the output constraint).  I'd say you have a busted
compiler.  None of the named compilers gripe.

#include <linux/types.h>

main()
{
fd_set x;

__FD_ZERO(&x);
}

	.file	"xxx.c"
	.version	"01.01"
gcc2_compiled.:
	.text
	.align 16
.globl main
	.type	main,@function
main:
	pushl	%ebp
	xorl	%eax, %eax
	movl	%esp, %ebp
	pushl	%edi
	subl	$132, %esp
	movl	$32, %ecx
	leal	-136(%ebp), %edi
#APP
	cld ; rep ; stosl
#NO_APP
	addl	$132, %esp
	popl	%edi
	popl	%ebp
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.ident	"GCC: (GNU) gcc-2.97 20001225 (experimental)"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
