Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUBYSmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbUBYSln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:41:43 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4992 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261673AbUBYSlU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:41:20 -0500
Date: Wed, 25 Feb 2004 13:41:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Kristian =?ISO-8859-1?Q?S=F8rensen?= <ks@cs.auc.dk>,
       linux-kernel@vger.kernel.org, umbrella@cs.auc.dk
Subject: Re: Implement new system call in 2.6
In-Reply-To: <20040225101419.5f058573.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.53.0402251336510.3401@chaos>
References: <Pine.LNX.4.56.0402250933001.648@homer.cs.auc.dk>
 <20040225101419.5f058573.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Randy.Dunlap wrote:

> On Wed, 25 Feb 2004 11:07:41 +0100 (CET) Kristian Sørensen wrote:
>
> | Hi all!
> |
> | How do I invoke a newly created system call in the 2.6.3 kernel from
> | userspace?
> |
> | The call is added it arch/i386/kernel/entry.S and include/asm/unistd.h
> | and the call is implemented in a security module called Umbrella(*).
> |
> | The kernel compiles and boots nicely.
> |
> | The main problem is now to compile a userspace program that invokes this
> | call. The guide for implementing the systemcall at
> | http://fossil.wpi.edu/docs/howto_add_systemcall.html
> | has been followed, which yields the following userspace program:
> |
> | // test.h
> | #include "/home/snc/linux-2.6.3-umbrella/include/linux/unistd.h"
> | _syscall1(int, umbrella_scr, int, arg1);
> |
> | // test.c
> | #include "test.h"
> | main() {
> |   int test = umbrella_scr(1);
> |   printf ("%i\n", test);
> | }
> |
> | When compiling:
> |
> | gcc -I/home/snc/linux-2.6.3/include test.c
> |
> | /tmp/ccYYs1zB.o(.text+0x20): In function `umbrella_scr':
> | : undefined reference to `errno'
> | collect2: ld returned 1 exit status
> |

#include <errno.h>

Some versions of 'C' define errno as *__errno_location().


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


