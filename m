Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316490AbSFUIgY>; Fri, 21 Jun 2002 04:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSFUIgY>; Fri, 21 Jun 2002 04:36:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:10996 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316490AbSFUIgW>; Fri, 21 Jun 2002 04:36:22 -0400
Date: Fri, 21 Jun 2002 10:36:20 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Elmer Joandi <elmer@ylenurme.ee>
cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] drivers/net/aironet4500.h must include tqueue.h
Message-ID: <Pine.NEB.4.44.0206211032470.22563-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below is needed to fix the following compile error in 2.5.24-dj1
(and most likely also in 2.5.24):

<--  snip  -->

...
  gcc -Wp,-MD,./.aironet4500_cs.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.24-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=aironet4500_cs   -c -o
aironet4500_cs.o aironet4500_cs.c
In file included from aironet4500_cs.c:57:
../aironet4500.h:1502: field `immediate_bh' has incomplete type
make[3]: *** [aironet4500_cs.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.24-full/drivers/net/pcmcia'

<--  snip  -->


--- drivers/net/aironet4500.h.old	Fri Jun 21 10:31:22 2002
+++ drivers/net/aironet4500.h	Fri Jun 21 10:31:54 2002
@@ -28,6 +28,7 @@
 #include <linux/time.h>
 */
 #include <linux/802_11.h>
+#include <linux/tqueue.h>

 //damn idiot PCMCIA stuff
 #ifndef DEV_NAME_LEN

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


