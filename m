Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262012AbSI3Krf>; Mon, 30 Sep 2002 06:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262014AbSI3Krf>; Mon, 30 Sep 2002 06:47:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23502 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262012AbSI3Kre>; Mon, 30 Sep 2002 06:47:34 -0400
Date: Mon, 30 Sep 2002 12:52:55 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-dj patch] fix compilation of eisa.c
Message-ID: <Pine.NEB.4.44.0209301250130.12605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

eisa.c doesn't compile in 2.5.39-dj2:

<--  snip  -->

...
  gcc -Wp,-MD,./.eisa.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/arch/i386/mach-generic -nostdinc -iwithprefix
include    -DKBUILD_BASENAME=eisa   -c -o eisa.o eisa.c
eisa.c:14: parse error before `init_eisa'
...
make[1]: *** [eisa.o] Error 1
make[1]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.39-full/arch/i386/kernel'

<--  snip  -->


The fix is simple:


--- linux-2.5.39-full/arch/i386/kernel/eisa.c.old	2002-09-30 12:44:55.000000000 +0200
+++ linux-2.5.39-full/arch/i386/kernel/eisa.c	2002-09-30 12:45:48.000000000 +0200
@@ -6,6 +6,7 @@
  */

 #include <linux/device.h>
+#include <linux/init.h>
 #include <linux/slab.h>
 #include <asm/io.h>


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox




