Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbSJTM24>; Sun, 20 Oct 2002 08:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262453AbSJTM24>; Sun, 20 Oct 2002 08:28:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10998 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262448AbSJTM2y>; Sun, 20 Oct 2002 08:28:54 -0400
Date: Sun, 20 Oct 2002 14:34:54 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-irda@pasta.cs.uit.no, <jt@hpl.hp.com>, Martin Diehl <info@mdiehl.de>
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>
Subject: [2.5 patch] remove 2.4 compatibility code from irda/vlsi_ir.h
Message-ID: <Pine.NEB.4.44.0210201422530.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the following compile error in 2.5.44:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/irda/.vlsi_ir.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vlsi_ir   -c -o
drivers/net/irda/vlsi_ir.o drivers/net/irda/vlsi_ir.c
In file included from drivers/net/irda/vlsi_ir.c:53:
include/net/irda/vlsi_ir.h:30: parse error
make[3]: *** [drivers/net/irda/vlsi_ir.o] Error 1

<--  snip  -->


vlsi_ir.h in 2.4 and 2.5 differ significantly, and I therefore suggest the
following patch to remove the compatibility stuff that caused this problem
(IMHO a better solution than an #include <linux/version.h>):


--- linux-2.5.44-full/include/net/irda/vlsi_ir.h~	2002-10-19 06:01:59.000000000 +0200
+++ linux-2.5.44-full/include/net/irda/vlsi_ir.h	2002-10-20 14:23:32.000000000 +0200
@@ -27,26 +27,6 @@
 #ifndef IRDA_VLSI_FIR_H
 #define IRDA_VLSI_FIR_H

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,4)
-#ifdef CONFIG_PROC_FS
-/* PDE() introduced in 2.5.4 */
-#define PDE(inode) ((inode)->u.generic_ip)
-#endif
-#endif
-
-/*
- * #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,xx)
- *
- * missing pci-dma api call to give streaming dma buffer back to hw
- * patch floating on lkml - probably present in 2.5.26 or later
- * otherwise defining it as noop is ok, since the vlsi-ir is only
- * used on two oldish x86-based notebooks which are cache-coherent
- */
-#define pci_dma_prep_single(dev, addr, size, direction)	/* nothing */
-/*
- * #endif
- */
-
 /* ================================================================ */

 /* non-standard PCI registers */


cu
Adrian

-- 

               "Is there not promise of rain?" Ling Tan asked suddenly out
                of the darkness. There had been need of rain for many days.
               "Only a promise," Lao Er said.
                                               Pearl S. Buck - Dragon Seed




