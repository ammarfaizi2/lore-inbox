Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288565AbSADJ2v>; Fri, 4 Jan 2002 04:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288562AbSADJ2m>; Fri, 4 Jan 2002 04:28:42 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:17925 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id <S288561AbSADJ2d>;
	Fri, 4 Jan 2002 04:28:33 -0500
Message-Id: <200201041041.g04AfiL05830@clueserver.org>
Content-Type: text/plain;
  charset="us-ascii"
From: Alan <alan@clueserver.org>
Reply-To: alan@clueserver.org
To: linux-kernel@vger.kernel.org
Subject: [PATCH] USB Storage Config patch for 2.4.17 and 2.5.1
Date: Fri, 4 Jan 2002 00:11:58 -0800
X-Mailer: KMail [version 1.3.1]
Cc: mec@shout.net, alan@redhat.com, Ingo Molnar <mingo@elte.hu>,
        Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a pretty trivial patch, but it fixes something kind of annoying.

USB Storage does not show up in the config menu if SCSI is not enabled.

My laptop is the only place i ever use USB.  I would always disable SCSI 
because I don't have any SCSI devices for my laptop.  

Then I tried to figure out why my USB floppy drive would never work...

The following patch modifies the config to display a "You need to enable SCSI 
for USB Storage" message if SCSI is not enabled.  (Using the exact phrasing 
(and code) from the USB multimedia message.)

Here is the patch. It has been tested for 2.4.17 and 2.5.1.  It would have 
been shorter, but i added indenting to make the code look consistant.) 
Hopefully linewrap does not hose this.

--------------- use boxknife on monitor here------------------
--- drivers/usb/Config.in	Fri Nov  2 17:18:58 2001
+++ drivers/usb/Config.in	Fri Jan  4 03:29:49 2002
@@ -32,15 +32,19 @@
 comment 'USB Device Class drivers'
 dep_tristate '  USB Audio support' CONFIG_USB_AUDIO $CONFIG_USB $CONFIG_SOUND
 dep_tristate '  USB Bluetooth support (EXPERIMENTAL)' CONFIG_USB_BLUETOOTH 
$CONFIG_USB $CONFIG_EXPERIMENTAL
-dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_USB 
$CONFIG_SCSI
-   dep_mbool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG 
$CONFIG_USB_STORAGE
-   dep_mbool '    Datafab MDCFE-B Compact Flash Reader support' 
CONFIG_USB_STORAGE_DATAFAB $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
-   dep_mbool '    Freecom USB/ATAPI Bridge support' 
CONFIG_USB_STORAGE_FREECOM  $CONFIG_USB_STORAGE
-   dep_mbool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_ISD200 
$CONFIG_USB_STORAGE
-   dep_mbool '    Microtech CompactFlash/SmartMedia support' 
CONFIG_USB_STORAGE_DPCM $CONFIG_USB_STORAGE
-   dep_mbool '    HP CD-Writer 82xx support' CONFIG_USB_STORAGE_HP8200e 
$CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
-   dep_mbool '    SanDisk SDDR-09 (and other SmartMedia) support' 
CONFIG_USB_STORAGE_SDDR09 $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
-   dep_mbool '    Lexar Jumpshot Compact Flash Reader' 
CONFIG_USB_STORAGE_JUMPSHOT $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+if [ "$CONFIG_SCSI" = "n" ]; then
+   comment '  SCSI support is needed for USB Storage'
+else
+   dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_USB 
$CONFIG_SCSI
+      dep_mbool '    USB Mass Storage verbose debug' 
CONFIG_USB_STORAGE_DEBUG $CONFIG_USB_STORAGE
+      dep_mbool '    Datafab MDCFE-B Compact Flash Reader support' 
CONFIG_USB_STORAGE_DATAFAB $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+      dep_mbool '    Freecom USB/ATAPI Bridge support' 
CONFIG_USB_STORAGE_FREECOM  $CONFIG_USB_STORAGE
+      dep_mbool '    ISD-200 USB/ATA Bridge support' 
CONFIG_USB_STORAGE_ISD200 $CONFIG_USB_STORAGE
+      dep_mbool '    Microtech CompactFlash/SmartMedia support' 
CONFIG_USB_STORAGE_DPCM $CONFIG_USB_STORAGE
+      dep_mbool '    HP CD-Writer 82xx support' CONFIG_USB_STORAGE_HP8200e 
$CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+      dep_mbool '    SanDisk SDDR-09 (and other SmartMedia) support' 
CONFIG_USB_STORAGE_SDDR09 $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+      dep_mbool '    Lexar Jumpshot Compact Flash Reader' 
CONFIG_USB_STORAGE_JUMPSHOT $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+fi
 dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_USB
 dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB
 
