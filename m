Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317914AbSFSP4g>; Wed, 19 Jun 2002 11:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317916AbSFSP4f>; Wed, 19 Jun 2002 11:56:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:732 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317914AbSFSP4e>; Wed, 19 Jun 2002 11:56:34 -0400
Date: Wed, 19 Jun 2002 17:56:30 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Vojtech Pavlik <vojtech@ucw.cz>, Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-dj patch] fix compilation of drivers/input/serio/ct82c710.c
Message-ID: <Pine.NEB.4.44.0206191751210.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

drivers/input/serio/ct82c710.c fails to compile in 2.5.23-dj1 with the
following error:

<--  snip  -->

...
  gcc -Wp,-MD,./.ct82c710.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.23-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6 -nostdinc -iwithprefix
include    -DKBUILD_BASENAME=ct82c710   -c -o ct82c710.o ct82c710.c
ct82c710.c: In function `ct82c710_close':
ct82c710.c:97: warning: implicit declaration of function `free_irq'
ct82c710.c: In function `ct82c710_open':
ct82c710.c:104: warning: implicit declaration of function `request_irq'
ct82c710.c: In function `ct82c710_init':
ct82c710.c:188: `ENODEV' undeclared (first use in this function)
ct82c710.c:188: (Each undeclared identifier is reported only once
ct82c710.c:188: for each function it appears in.)
ct82c710.c:191: `EBUSY' undeclared (first use in this function)
make[2]: *** [ct82c710.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.23-full/drivers/input/serio'

<--  snip  -->


It seems ct82c710.c should include errno.h and sched.h?


--- drivers/input/serio/ct82c710.c.old	Wed Jun 19 17:49:23 2002
+++ drivers/input/serio/ct82c710.c	Wed Jun 19 17:50:45 2002
@@ -36,6 +36,8 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/serio.h>
+#include <linux/errno.h>
+#include <linux/sched.h>

 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("82C710 C&T mouse port chip driver");

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


