Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSI3L0t>; Mon, 30 Sep 2002 07:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbSI3L0t>; Mon, 30 Sep 2002 07:26:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2253 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262023AbSI3L0s>; Mon, 30 Sep 2002 07:26:48 -0400
Date: Mon, 30 Sep 2002 13:32:08 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-dj patch] fix compilation with CONFIG_AGP_ALI
Message-ID: <Pine.NEB.4.44.0209301322350.12605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

with CONFIG_AGP_ALI 2.5.39-dj2 doesn't compile:

<--  snip  -->

...
  gcc -Wp,-MD,./.agp.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6
-I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/arch/i386/mach-generic
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=agp   -c -o agp.o agp.c
agp.c:826: `PCI_DEVICE_ID_AL_M1671_0' undeclared here (not in a function)
agp.c:826: initializer element is not constant
agp.c:826: (near initialization for `agp_bridge_info[8].device_id')
make[3]: *** [agp.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.39-full/drivers/char/agp'

<--  snip  -->


The following patch fixes it (PCI_DEVICE_ID_AL_M1671_0 was defined in
agp.h in 2.5.30-dj1 but this definition wasn't in 2.5.39-dj2):


--- linux-2.5.39-full/include/linux/pci_ids.h.old	2002-09-30 13:18:07.000000000 +0200
+++ linux-2.5.39-full/include/linux/pci_ids.h	2002-09-30 13:20:06.000000000 +0200
@@ -848,6 +848,7 @@
 #define PCI_DEVICE_ID_AL_M1644		0x1644
 #define PCI_DEVICE_ID_AL_M1647		0x1647
 #define PCI_DEVICE_ID_AL_M1651		0x1651
+#define PCI_DEVICE_ID_AL_M1671		0x1671
 #define PCI_DEVICE_ID_AL_M1543		0x1543
 #define PCI_DEVICE_ID_AL_M3307		0x3307
 #define PCI_DEVICE_ID_AL_M4803		0x5215
--- linux-2.5.39-full/drivers/char/agp/agp.c.old	2002-09-30 13:20:48.000000000 +0200
+++ linux-2.5.39-full/drivers/char/agp/agp.c	2002-09-30 13:21:58.000000000 +0200
@@ -823,7 +823,7 @@
 		.chipset_setup	= ali_generic_setup,
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_AL_M1671_0,
+		.device_id	= PCI_DEVICE_ID_AL_M1671,
 		.vendor_id	= PCI_VENDOR_ID_AL,
 		.chipset	= ALI_M1671,
 		.vendor_name	= "Ali",

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox





