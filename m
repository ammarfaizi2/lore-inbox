Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUBYLPS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 06:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUBYLPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 06:15:18 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:63399 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S261263AbUBYLPK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 06:15:10 -0500
Date: Wed, 25 Feb 2004 12:14:59 +0100 (CET)
From: =?iso-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.auc.dk>
To: linux-kernel@vger.kernel.org
cc: umbrella@cs.auc.dk
Subject: Re: Implement new system call in 2.6
In-Reply-To: <Pine.LNX.4.56.0402250933001.648@homer.cs.auc.dk>
Message-ID: <Pine.LNX.4.56.0402251214350.16998@scenic29.cs.auc.dk>
References: <Pine.LNX.4.56.0402250933001.648@homer.cs.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PS. including <errno.h> in test.c doesn't solve the problem :-(

-- 
Kristian Sørensen <ks@cs.auc.dk>

On Wed, 25 Feb 2004, Kristian Sørensen wrote:

> Hi all!
>
> How do I invoke a newly created system call in the 2.6.3 kernel from
> userspace?
>
> The call is added it arch/i386/kernel/entry.S and include/asm/unistd.h
> and the call is implemented in a security module called Umbrella(*).
>
> The kernel compiles and boots nicely.
>
> The main problem is now to compile a userspace program that invokes this
> call. The guide for implementing the systemcall at
> http://fossil.wpi.edu/docs/howto_add_systemcall.html
> has been followed, which yields the following userspace program:
>
> // test.h
> #include "/home/snc/linux-2.6.3-umbrella/include/linux/unistd.h"
> _syscall1(int, umbrella_scr, int, arg1);
>
> // test.c
> #include "test.h"
> main() {
>   int test = umbrella_scr(1);
>   printf ("%i\n", test);
> }
>
> When compiling:
>
> gcc -I/home/snc/linux-2.6.3/include test.c
>
> /tmp/ccYYs1zB.o(.text+0x20): In function `umbrella_scr':
> : undefined reference to `errno'
> collect2: ld returned 1 exit status
>
>
> It seems like a little stupid error :-( Does some of you have a solution?
>
>
>
> Thanks in advance and best regards,
> Kristian Sørensen.
>
>
>
> (*) Umbrella is a security project for securing handheld devices. Umbrella
> for implements a combination of process based mandatory access control
> (MAC) and authentication of files. This is implemented on top of the Linux
> Security Modules framework. The MAC scheme is enforced by a set of
> restrictions for each process.
> More information on http://umbrella.sf.net
>
>
>
