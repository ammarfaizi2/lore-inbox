Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318140AbSFTHPA>; Thu, 20 Jun 2002 03:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318137AbSFTHO7>; Thu, 20 Jun 2002 03:14:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:13263 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318136AbSFTHO4>; Thu, 20 Jun 2002 03:14:56 -0400
Date: Thu, 20 Jun 2002 09:14:55 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: kai.germaschewski@gmx.de
cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] tqueue.h fixes for ISDN
Message-ID: <Pine.NEB.4.44.0206200911520.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

the following two tqueue.h fixes are needed to fix compile errors in the
ISDN subsystem (the error messages follow below):


--- drivers/isdn/pcbit/drv.c.old	Thu Jun 20 08:55:22 2002
+++ drivers/isdn/pcbit/drv.c	Thu Jun 20 08:56:17 2002
@@ -30,6 +30,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/string.h>
+#include <linux/tqueue.h>
 #include <linux/skbuff.h>

 #include <linux/isdnif.h>
--- drivers/isdn/tpam/tpam.h.old	Thu Jun 20 09:04:05 2002
+++ drivers/isdn/tpam/tpam.h	Thu Jun 20 09:04:31 2002
@@ -16,6 +16,7 @@

 #include <linux/isdnif.h>
 #include <linux/init.h>
+#include <linux/tqueue.h>

 /* Maximum number of channels for this board */
 #define TPAM_NBCHANNEL		30


cu
Adrian


<--  snip  -->

...
  gcc -Wp,-MD,./.drv.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.23
/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=drv   -c -o drv.o drv.c
In file included from drv.c:40:
pcbit.h:75: field `qdelivery' has incomplete type
make[3]: *** [drv.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.23/drivers/isd

<--  snip  -->

...
  gcc -Wp,-MD,./.tpam_memory.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.23/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6
 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=tpam_memory   -c -o
tpam_memory.o tpam_memory.c
In file included from tpam_memory.c:17:
tpam.h:88: field `send_tq' has incomplete type
tpam.h:89: field `recv_tq' has incomplete type
make[3]: *** [tpam_memory.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.23/drivers/isdn/tpam'

<--  snip  -->

