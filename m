Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318291AbSHKMRG>; Sun, 11 Aug 2002 08:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318292AbSHKMRG>; Sun, 11 Aug 2002 08:17:06 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24021 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318291AbSHKMRF>; Sun, 11 Aug 2002 08:17:05 -0400
Date: Sun, 11 Aug 2002 14:20:48 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Julien BLACHE <jb@technologeek.org>, <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] tiglusb.c must include version.h
Message-ID: <Pine.NEB.4.44.0208111416110.3636-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compile error in 2.5.31:

<--  snip  -->

...
  gcc -Wp,-MD,./.tiglusb.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.31-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=tiglusb   -c
-o tiglusb.o tiglusb.c
tiglusb.c:44: parse error
make[3]: *** [tiglusb.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.31-full/drivers/usb/misc'

<--  snip  -->

line 44 is:
  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)


The fix is simple:

--- drivers/usb/misc/tiglusb.c~	2002-08-11 03:41:17.000000000 +0200
+++ drivers/usb/misc/tiglusb.c	2002-08-11 14:17:13.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/usb.h>
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/version.h>

 #include <linux/ticable.h>
 #include "tiglusb.h"


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


