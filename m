Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280825AbRKONaj>; Thu, 15 Nov 2001 08:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280827AbRKONaU>; Thu, 15 Nov 2001 08:30:20 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:52946 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S280825AbRKONaK>; Thu, 15 Nov 2001 08:30:10 -0500
Date: Thu, 15 Nov 2001 14:30:03 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: mdharm-usb@one-eyed-alien.net
cc: linux-kernel@vger.kernel.org
Subject: [patch] add a remark that CONFIG_USB_STORAGE needs SCSI
Message-ID: <Pine.NEB.4.40.0111151424130.7895-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

I found it non-intuitively while looking for CONFIG_USB_STORAGE in "make
menuconfig" that it needs SCSI enabled, so I made the small patch below
(against 2.4.15-pre4) that adds a comment that "SCSI support is needed for
USB Mass Storage support" if SCSI isn't enabled.


--- drivers/usb/Config.in.old	Thu Nov 15 14:16:30 2001
+++ drivers/usb/Config.in	Thu Nov 15 14:21:00 2001
@@ -32,15 +32,19 @@
 comment 'USB Device Class drivers'
 dep_tristate '  USB Audio support' CONFIG_USB_AUDIO $CONFIG_USB $CONFIG_SOUND
 dep_tristate '  USB Bluetooth support (EXPERIMENTAL)' CONFIG_USB_BLUETOOTH $CONFIG_USB $CONFIG_EXPERIMENTAL
-dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_USB $CONFIG_SCSI
-   dep_mbool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG $CONFIG_USB_STORAGE
-   dep_mbool '    Datafab MDCFE-B Compact Flash Reader support' CONFIG_USB_STORAGE_DATAFAB $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
-   dep_mbool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM  $CONFIG_USB_STORAGE
-   dep_mbool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_ISD200 $CONFIG_USB_STORAGE
-   dep_mbool '    Microtech CompactFlash/SmartMedia support' CONFIG_USB_STORAGE_DPCM $CONFIG_USB_STORAGE
-   dep_mbool '    HP CD-Writer 82xx support' CONFIG_USB_STORAGE_HP8200e $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
-   dep_mbool '    SanDisk SDDR-09 (and other SmartMedia) support' CONFIG_USB_STORAGE_SDDR09 $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
-   dep_mbool '    Lexar Jumpshot Compact Flash Reader' CONFIG_USB_STORAGE_JUMPSHOT $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+if [ "$CONFIG_SCSI" = "n" ]; then
+   comment '  SCSI support is needed for USB Mass Storage support'
+else
+   dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_USB $CONFIG_SCSI
+      dep_mbool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG $CONFIG_USB_STORAGE
+      dep_mbool '    Datafab MDCFE-B Compact Flash Reader support' CONFIG_USB_STORAGE_DATAFAB $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+      dep_mbool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM  $CONFIG_USB_STORAGE
+      dep_mbool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_ISD200 $CONFIG_USB_STORAGE
+      dep_mbool '    Microtech CompactFlash/SmartMedia support' CONFIG_USB_STORAGE_DPCM $CONFIG_USB_STORAGE
+      dep_mbool '    HP CD-Writer 82xx support' CONFIG_USB_STORAGE_HP8200e $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+      dep_mbool '    SanDisk SDDR-09 (and other SmartMedia) support' CONFIG_USB_STORAGE_SDDR09 $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+      dep_mbool '    Lexar Jumpshot Compact Flash Reader' CONFIG_USB_STORAGE_JUMPSHOT $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+fi
 dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_USB
 dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB


cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

