Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265617AbTFRXp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbTFRXp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:45:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59889 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265617AbTFRXob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:44:31 -0400
Date: Thu, 19 Jun 2003 01:58:25 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: FYI: [2.5 patch] let broken drivers depend on BROKEN
Message-ID: <20030618235825.GL29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below isn't meant to be applied now, a similar patch should be 
applied soon before 2.6.0.

This patch adds a dependency on an undefined BROKEN to all drivers that 
have longstanding compile errors.

Additionally I'll add a

  config BROKEN_ON_SMP
    default y if !SMP

and add BROKEN_ON_SMP to the dependencies of drivers that don't compile
with SMP enabled (e.g. because of cli/sti usage). I was too lazy to 
search for the BROKEN_ON_SMP drivers in 2.5.72 but the idea should be 
clear.


diffstat output of the patch below:

 char/Kconfig        |   12 ++++++------
 isdn/Kconfig        |    1 +
 media/video/Kconfig |    4 ++--
 mtd/devices/Kconfig |    2 +-
 net/Kconfig         |    4 ++--
 net/wan/Kconfig     |    2 +-
 scsi/Kconfig        |   16 ++++++++--------
 video/Kconfig       |    6 +++---
 8 files changed, 24 insertions(+), 23 deletions(-)


cu
Adrian


--- linux-2.5.72/drivers/net/wan/Kconfig.old	2003-06-18 23:09:14.000000000 +0200
+++ linux-2.5.72/drivers/net/wan/Kconfig	2003-06-18 23:10:11.000000000 +0200
@@ -506,7 +506,7 @@
 
 config VENDOR_SANGOMA
 	tristate "Sangoma WANPIPE(tm) multiprotocol cards"
-	depends on WAN_ROUTER_DRIVERS && WAN_ROUTER && (PCI || ISA)
+	depends on WAN_ROUTER_DRIVERS && WAN_ROUTER && (PCI || ISA) && BROKEN
 	---help---
 	  WANPIPE from Sangoma Technologies Inc. (<http://www.sangoma.com/>)
 	  is a family of intelligent multiprotocol WAN adapters with data
--- linux-2.5.72/drivers/net/Kconfig.old	2003-06-18 23:03:07.000000000 +0200
+++ linux-2.5.72/drivers/net/Kconfig	2003-06-18 23:20:36.000000000 +0200
@@ -2139,7 +2139,7 @@
 
 config DEFXX
 	tristate "Digital DEFEA and DEFPA adapter support"
-	depends on FDDI && (PCI || EISA)
+	depends on FDDI && (PCI || EISA) && BROKEN
 	help
 	  This is support for the DIGITAL series of EISA (DEFEA) and PCI
 	  (DEFPA) controllers which can connect you to a local FDDI network.
@@ -2482,7 +2482,7 @@
 
 config IPHASE5526
 	tristate "Interphase 5526 Tachyon chipset based adapter support"
-	depends on NET_FC && SCSI && PCI
+	depends on NET_FC && SCSI && PCI && BROKEN
 	help
 	  Say Y here if you have a Fibre Channel adaptor of this kind.
 
--- linux-2.5.72/drivers/video/Kconfig.old	2003-06-18 23:50:05.000000000 +0200
+++ linux-2.5.72/drivers/video/Kconfig	2003-06-19 00:06:08.000000000 +0200
@@ -40,7 +40,7 @@
 
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
-	depends on FB && (AMIGA || PCI)
+	depends on FB && (AMIGA || PCI) && BROKEN
 	---help---
 	  This enables support for Cirrus Logic GD542x/543x based boards on
 	  Amiga: SD64, Piccolo, Picasso II/II+, Picasso IV, or EGS Spectrum.
@@ -55,7 +55,7 @@
 
 config FB_PM2
 	tristate "Permedia2 support"
-	depends on FB && (AMIGA || PCI)
+	depends on FB && (AMIGA || PCI) && BROKEN
 	help
 	  This is the frame buffer device driver for the Permedia2 AGP frame
 	  buffer card from ASK, aka `Graphic Blaster Exxtreme'.  There is a
@@ -802,7 +802,7 @@
 
 config FB_PM3
 	tristate "Permedia3 support"
-	depends on FB && PCI
+	depends on FB && PCI && BROKEN
 	help
 	  This is the frame buffer device driver for the 3DLabs Permedia3
 	  chipset, used in Formac ProFormance III, 3DLabs Oxygen VX1 &
--- linux-2.5.72/drivers/isdn/Kconfig.old	2003-06-18 22:28:04.000000000 +0200
+++ linux-2.5.72/drivers/isdn/Kconfig	2003-06-18 22:29:09.000000000 +0200
@@ -26,6 +26,7 @@
 
 config ISDN
 	tristate "Old ISDN4Linux (obsolete)"
+	depends on BROKEN
 	---help---
 	  This driver allows you to use an ISDN-card for networking
 	  connections and as dialin/out device.  The isdn-tty's have a built
--- linux-2.5.72/drivers/media/video/Kconfig.old	2003-06-18 22:32:56.000000000 +0200
+++ linux-2.5.72/drivers/media/video/Kconfig	2003-06-18 22:36:54.000000000 +0200
@@ -161,7 +161,7 @@
 
 config VIDEO_ZORAN
 	tristate "Zoran ZR36057/36060 Video For Linux"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI && I2C && BROKEN
 	help
 	  Say Y here to include support for video cards based on the Zoran
 	  ZR36057/36060 encoder/decoder chip (including the Iomega Buz and the
@@ -190,7 +190,7 @@
 
 config VIDEO_ZR36120
 	tristate "Zoran ZR36120/36125 Video For Linux"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI && I2C && BROKEN
 	help
 	  Support for ZR36120/ZR36125 based frame grabber/overlay boards.
 	  This includes the Victor II, WaveWatcher, Video Wonder, Maxi-TV,
--- linux-2.5.72/drivers/char/Kconfig.old	2003-06-18 21:44:21.000000000 +0200
+++ linux-2.5.72/drivers/char/Kconfig	2003-06-19 01:40:16.000000000 +0200
@@ -162,7 +162,7 @@
 
 config DIGI
 	tristate "Digiboard PC/Xx Support"
-	depends on SERIAL_NONSTANDARD && DIGIEPCA=n
+	depends on SERIAL_NONSTANDARD && DIGIEPCA=n && BROKEN
 	help
 	  This is a driver for the Digiboard PC/Xe, PC/Xi, and PC/Xeve cards
 	  that give you many serial ports. You would need something like this
@@ -175,7 +175,7 @@
 
 config ESPSERIAL
 	tristate "Hayes ESP serial port support"
-	depends on SERIAL_NONSTANDARD && ISA
+	depends on SERIAL_NONSTANDARD && ISA && BROKEN
 	help
 	  This is a driver which supports Hayes ESP serial ports.  Both single
 	  port cards and multiport cards are supported.  Make sure to read
@@ -260,7 +260,7 @@
 
 config RISCOM8
 	tristate "SDL RISCom/8 card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN
 	help
 	  This is a driver for the SDL Communications RISCom/8 multiport card,
 	  which gives you many serial ports. You would need something like
@@ -273,7 +273,7 @@
 
 config SPECIALIX
 	tristate "Specialix IO8+ card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN
 	help
 	  This is a driver for the Specialix IO8+ multiport card (both the
 	  ISA and the PCI version) which gives you many serial ports. You
@@ -337,7 +337,7 @@
 
 config STALLION
 	tristate "Stallion EasyIO or EC8/32 support"
-	depends on STALDRV
+	depends on STALDRV && BROKEN
 	help
 	  If you have an EasyIO or EasyConnection 8/32 multiport Stallion
 	  card, then this is for you; say Y.  Make sure to read
@@ -350,7 +350,7 @@
 
 config ISTALLION
 	tristate "Stallion EC8/64, ONboard, Brumby support"
-	depends on STALDRV
+	depends on STALDRV && BROKEN
 	help
 	  If you have an EasyConnection 8/64, ONboard, Brumby or Stallion
 	  serial multiport card, say Y here. Make sure to read
--- linux-2.5.72/drivers/scsi/Kconfig.old	2003-06-18 20:40:21.000000000 +0200
+++ linux-2.5.72/drivers/scsi/Kconfig	2003-06-18 23:38:33.000000000 +0200
@@ -329,7 +329,7 @@
 # All the I2O code and drivers do not seem to be 64bit safe.
 config SCSI_DPT_I2O
 	tristate "Adaptec I2O RAID support "
-	depends on !X86_64 && SCSI
+	depends on !X86_64 && SCSI && BROKEN
 	help
 	  This driver supports all of Adaptec's I2O based RAID controllers as 
 	  well as the DPT SmartRaid V cards.  This is an Adaptec maintained
@@ -372,7 +372,7 @@
 # does not use pci dma and seems to be isa/onboard only for old machines
 config SCSI_AM53C974
 	tristate "AM53/79C974 PCI SCSI support"
-	depends on !X86_64 && SCSI && PCI
+	depends on !X86_64 && SCSI && PCI && BROKEN
 	---help---
 	  This is support for the AM53/79C974 SCSI host adapters.  Please read
 	  <file:Documentation/scsi/AM53C974.txt> for details.  Also, the
@@ -429,7 +429,7 @@
 
 config SCSI_CPQFCTS
 	tristate "Compaq Fibre Channel 64-bit/66Mhz HBA support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && BROKEN
 	help
 	  Say Y here to compile in support for the Compaq StorageWorks Fibre
 	  Channel 64-bit/66Mhz Host Bus Adapter.
@@ -715,7 +715,7 @@
 
 config SCSI_INITIO
 	tristate "Initio 9100U(W) support"
-	depends on SCSI && PCI
+	depends on SCSI && PCI && BROKEN
 	help
 	  This is support for the Initio 91XXU(W) SCSI host adapter.  Please
 	  read the SCSI-HOWTO, available from
@@ -728,7 +728,7 @@
 
 config SCSI_INIA100
 	tristate "Initio INI-A100U2W support"
-	depends on SCSI && PCI
+	depends on SCSI && PCI && BROKEN
 	help
 	  This is support for the Initio INI-A100U2W SCSI host adapter.
 	  Please read the SCSI-HOWTO, available from
@@ -1231,7 +1231,7 @@
 
 config SCSI_PCI2000
 	tristate "PCI2000 support"
-	depends on SCSI
+	depends on SCSI && BROKEN
 	help
 	  This is support for the PCI2000I EIDE interface card which acts as a
 	  SCSI host adapter.  Please read the SCSI-HOWTO, available from
@@ -1244,7 +1244,7 @@
 
 config SCSI_PCI2220I
 	tristate "PCI2220i support"
-	depends on SCSI
+	depends on SCSI && BROKEN
 	help
 	  This is support for the PCI2220i EIDE interface card which acts as a
 	  SCSI host adapter.  Please read the SCSI-HOWTO, available from
@@ -1409,7 +1409,7 @@
 
 config SCSI_DC390T
 	tristate "Tekram DC390(T) and Am53/79C974 SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && BROKEN
 	---help---
 	  This driver supports PCI SCSI host adapters based on the Am53C974A
 	  chip, e.g. Tekram DC390(T), DawiControl 2974 and some onboard
--- linux-2.5.72/drivers/mtd/devices/Kconfig.old	2003-06-18 22:38:39.000000000 +0200
+++ linux-2.5.72/drivers/mtd/devices/Kconfig	2003-06-18 22:39:08.000000000 +0200
@@ -102,7 +102,7 @@
 
 config MTD_BLKMTD
 	tristate "MTD emulation using block device"
-	depends on MTD
+	depends on MTD && BROKEN
 	help
 	  This driver allows a block device to appear as an MTD. It would
 	  generally be used in the following cases:
