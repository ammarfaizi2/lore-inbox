Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbUAYQVb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 11:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUAYQVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 11:21:31 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43006 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264510AbUAYQV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 11:21:29 -0500
Date: Sun, 25 Jan 2004 17:21:22 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Eric <eric@cisu.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernels > 2.6.1-mm3 do not boot.
Message-ID: <20040125162122.GJ513@fs.tum.de>
References: <200401232253.08552.eric@cisu.net> <200401251452.58318.cova@ferrara.linux.it> <20040125143438.GI513@fs.tum.de> <200401251639.56799.cova@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401251639.56799.cova@ferrara.linux.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 04:39:56PM +0100, Fabio Coatti wrote:
>...
> > If this kernel works, please try -mm4 with disabled SMP support and
> > support for the Athlon (and no other CPUs).
> 
> Doesn't work
> 
> > If you compile with
> >   make V=1
> 
>   gcc -Wp,-MD,fs/.dcache.o.d -nostdinc -iwithprefix include -D__KERNEL__ 
> -Iinclude  -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs 
> -fno-strict-aliasing -fno-common -pipe -msoft-float 
> -mpreferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default 
> -O2 -fomit-frame-pointer -funit-at-a-time     -DKBUILD_BASENAME=dcache 
> -DKBUILD_MODNAME=dcache -c -o fs/.tmp_dcache.o fs/dcache.c

What's your gcc version ("gcc --version")?

Could you back out ("patch -p1 -R < ..." or manually remove the lines) 
the patch below and retry?

TIA
Adrian


diff -puN Makefile~use-funit-at-a-time Makefile
--- 25/Makefile~use-funit-at-a-time	2004-01-14 00:56:05.000000000 -0800
+++ 25-akpm/Makefile	2004-01-14 00:56:05.000000000 -0800
@@ -445,6 +445,10 @@ ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
 endif
 
+# Enable unit-at-a-time mode when possible. It shrinks the
+# kernel considerably.
+CFLAGS += $(call check_gcc,-funit-at-a-time,)
+
 # warn about C99 declaration after statement
 CFLAGS += $(call check_gcc,-Wdeclaration-after-statement,)
 

_
