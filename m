Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSJUSZg>; Mon, 21 Oct 2002 14:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbSJUSZe>; Mon, 21 Oct 2002 14:25:34 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:49170 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S261594AbSJUSYy>; Mon, 21 Oct 2002 14:24:54 -0400
Date: Mon, 21 Oct 2002 20:34:35 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Adrian Bunk <bunk@fs.tum.de>
cc: Jean Tourrilhes <jt@hpl.hp.com>, <linux-kernel@vger.kernel.org>,
       <trivial@rustcorp.com.au>
Subject: Re: [2.5 patch] remove 2.4 compatibility code from irda/vlsi_ir.h
In-Reply-To: <Pine.NEB.4.44.0210201422530.28761-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0210210921140.5689-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Adrian Bunk wrote:

Hi Adrian,

> I got the following compile error in 2.5.44:
> 
> <--  snip  -->
> 
> ...
>   gcc -Wp,-MD,drivers/net/irda/.vlsi_ir.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
> -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vlsi_ir   -c -o
> drivers/net/irda/vlsi_ir.o drivers/net/irda/vlsi_ir.c
> In file included from drivers/net/irda/vlsi_ir.c:53:
> include/net/irda/vlsi_ir.h:30: parse error
> make[3]: *** [drivers/net/irda/vlsi_ir.o] Error 1

Thanks for doing these tests. Unfortunately I've never seen this problem 
before. Might be it's because the whole linux-irda system is assumed to be 
build as module and I've almost never tried compiling it into the kernel.

Anyway, of course I agree with you the stuff must not break compiling. 
It looks like you are right, there's a linux/version.h missing in the 
includes. Does this solve the issue for you (it does for me)?

> vlsi_ir.h in 2.4 and 2.5 differ significantly, and I therefore suggest the
> following patch to remove the compatibility stuff that caused this problem
> (IMHO a better solution than an #include <linux/version.h>):

The 2.5/2.4 differences are only temporarily there and due to the usual 
approach to apply new stuff to 2.5 first before moving into 2.4. The 
current 2.5 code should go into 2.4 rather soon and there will be further 
changes along this path. So the compatibility defines are there for a good 
reason and the very few differences between 2.4 and 2.5 (wrt. this 
driver) do not justify the increased effort of having two versions.

> -#define pci_dma_prep_single(dev, addr, size, direction)	/* nothing */

If this gets removed I can assure you the driver won't compile ;-)

Please apply the following fix.

Thanks
Martin

-------------------------------------

--- linux-2.5.44/drivers/net/irda/vlsi_ir.c	Sat Oct 12 13:51:07 2002
+++ v2.5.44-md-ob/drivers/net/irda/vlsi_ir.c	Mon Oct 21 19:23:53 2002
@@ -44,6 +44,7 @@
 #include <linux/time.h>
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/version.h>
 #include <asm/uaccess.h>
 
 #include <net/irda/irda.h>



