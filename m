Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbSJTObz>; Sun, 20 Oct 2002 10:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbSJTOby>; Sun, 20 Oct 2002 10:31:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27124 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262784AbSJTObu>; Sun, 20 Oct 2002 10:31:50 -0400
Date: Sun, 20 Oct 2002 16:37:49 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>
Subject: [2.5 patch] don't #include tqueue.h in drivers/net/wan/cycx_main.c
Message-ID: <Pine.NEB.4.44.0210201634170.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's the following compile error in 2.5.44:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/wan/.cycx_main.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=cycx_main   -c -o
drivers/net/wan/cycx_main.o drivers/net/wan/cycx_main.c
drivers/net/wan/cycx_main.c:47: linux/tqueue.h: No such file or directory
make[3]: *** [drivers/net/wan/cycx_main.o] Error 1

<--  snip  -->


With the following trivial patch it compiles without errors or warnings:


--- linux-2.5.44-full/drivers/net/wan/cycx_main.c.old	2002-10-20 16:20:02.000000000 +0200
+++ linux-2.5.44-full/drivers/net/wan/cycx_main.c	2002-10-20 16:20:25.000000000 +0200
@@ -44,7 +44,6 @@
 #include <linux/kernel.h>	/* printk(), and other useful stuff */
 #include <linux/module.h>	/* support for loadable modules */
 #include <linux/ioport.h>	/* request_region(), release_region() */
-#include <linux/tqueue.h>	/* for kernel task queues */
 #include <linux/wanrouter.h>	/* WAN router definitions */
 #include <linux/cyclomx.h>	/* cyclomx common user API definitions */
 #include <asm/uaccess.h>	/* kernel <-> user copy */


cu
Adrian

-- 

               "Is there not promise of rain?" Ling Tan asked suddenly out
                of the darkness. There had been need of rain for many days.
               "Only a promise," Lao Er said.
                                               Pearl S. Buck - Dragon Seed



