Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314483AbSFQPMD>; Mon, 17 Jun 2002 11:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSFQPMC>; Mon, 17 Jun 2002 11:12:02 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:30161 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314483AbSFQPMB>; Mon, 17 Jun 2002 11:12:01 -0400
Date: Mon, 17 Jun 2002 17:11:57 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>, <greg@kroah.com>,
       NAGANO Daisuke <breeze.nagano@nifty.ne.jp>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5 patch] drivers/usb/class/usb-midi.c must include linux/version.h
Message-ID: <Pine.NEB.4.44.0206171706550.1866-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following compile error in 2.5.22:

<--  snip  -->

...
  gcc -Wp,-MD,./.usb-midi.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2
.5.22-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=usb_midi   -c -o
usb-midi.o usb-midi.c
usb-midi.c:109: parse error
make[3]: *** [usb-midi.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.22-full/drivers/usb/class'

<--  snip  -->


Line 109 is:
  #if LINUX_VERSION_CODE  >= KERNEL_VERSION(2,4,14)


The fix is simple:

--- drivers/usb/class/usb-midi.c~	Mon Jun 17 04:31:24 2002
+++ drivers/usb/class/usb-midi.c	Mon Jun 17 16:36:36 2002
@@ -38,6 +38,7 @@
 #include <linux/poll.h>
 #include <linux/sound.h>
 #include <linux/init.h>
+#include <linux/version.h>
 #include <asm/semaphore.h>

 /** This declaration is missing from linux/usb.h **/

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


