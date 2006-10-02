Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWJBEze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWJBEze (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 00:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWJBEze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 00:55:34 -0400
Received: from havoc.gtf.org ([69.61.125.42]:11925 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932611AbWJBEzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 00:55:32 -0400
Date: Mon, 2 Oct 2006 00:55:12 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Cc: chas@cmf.nrl.navy.mil, netdev@vger.kernel.org, kkeil@suse.de,
       kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       mac@melware.de, markus.lidel@shadowconnect.com, samuel@sortiz.org,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       Greg KH <greg@kroah.com>, thomas@winischhofer.net, ak@suse.de
Subject: [PATCH] Introduce BROKEN_ON_64BIT facility
Message-ID: <20061002045512.GA8835@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a broken-on-64bit option, similar to the existing broken-on-smp
config option.  This is just the first pass, marking the obvious
candidates.

Several driver have been marked as dependent on CONFIG_32BIT in the
past, when they should really be dependent on this new
CONFIG_BROKEN_ON_64BIT option, because the 32BIT marker was due to bugs
rather than fundamentals.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

 drivers/atm/Kconfig                    |    2 +-
 drivers/char/ftape/Kconfig             |    2 +-
 drivers/isdn/capi/Kconfig              |    4 ++--
 drivers/isdn/hardware/eicon/Kconfig    |    2 +-
 drivers/isdn/hisax/Kconfig             |    1 +
 drivers/message/i2o/Kconfig            |    2 +-
 drivers/net/irda/Kconfig               |    2 +-
 drivers/scsi/megaraid/Kconfig.megaraid |    2 +-
 drivers/usb/misc/sisusbvga/Kconfig     |    2 +-
 init/Kconfig                           |    5 +++++
 sound/oss/Kconfig                      |   10 +++++-----
 11 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/atm/Kconfig b/drivers/atm/Kconfig
index cfa5af8..36c0fd7 100644
--- a/drivers/atm/Kconfig
+++ b/drivers/atm/Kconfig
@@ -139,7 +139,7 @@ config ATM_ENI_BURST_RX_2W
 
 config ATM_FIRESTREAM
 	tristate "Fujitsu FireStream (FS50/FS155) "
-	depends on PCI && ATM
+	depends on PCI && ATM && BROKEN_ON_64BIT
 	help
 	  Driver for the Fujitsu FireStream 155 (MB86697) and
 	  FireStream 50 (MB86695) ATM PCI chips.
diff --git a/drivers/char/ftape/Kconfig b/drivers/char/ftape/Kconfig
index 0d65189..13c9460 100644
--- a/drivers/char/ftape/Kconfig
+++ b/drivers/char/ftape/Kconfig
@@ -56,7 +56,7 @@ comment "The compressor will be built as
 
 config ZFT_COMPRESSOR
 	tristate
-	depends on FTAPE!=n && ZFTAPE!=n
+	depends on FTAPE!=n && ZFTAPE!=n && BROKEN_ON_64BIT
 	default m
 
 config FT_NR_BUFFERS
diff --git a/drivers/isdn/capi/Kconfig b/drivers/isdn/capi/Kconfig
index 8b6c9a4..064b7bb 100644
--- a/drivers/isdn/capi/Kconfig
+++ b/drivers/isdn/capi/Kconfig
@@ -21,7 +21,7 @@ config ISDN_CAPI_MIDDLEWARE
 
 config ISDN_CAPI_CAPI20
 	tristate "CAPI2.0 /dev/capi support"
-	depends on ISDN_CAPI
+	depends on ISDN_CAPI && BROKEN_ON_64BIT
 	help
 	  This option will provide the CAPI 2.0 interface to userspace
 	  applications via /dev/capi20. Applications should use the
@@ -44,7 +44,7 @@ config ISDN_CAPI_CAPIFS
 
 config ISDN_CAPI_CAPIDRV
 	tristate "CAPI2.0 capidrv interface support"
-	depends on ISDN_CAPI && ISDN_I4L
+	depends on ISDN_CAPI && ISDN_I4L && BROKEN_ON_64BIT
 	help
 	  This option provides the glue code to hook up CAPI driven cards to
 	  the legacy isdn4linux link layer.  If you have a card which is
diff --git a/drivers/isdn/hardware/eicon/Kconfig b/drivers/isdn/hardware/eicon/Kconfig
index 51e66bc..d41e99d 100644
--- a/drivers/isdn/hardware/eicon/Kconfig
+++ b/drivers/isdn/hardware/eicon/Kconfig
@@ -32,7 +32,7 @@ config ISDN_DIVAS_PRIPCI
 
 config ISDN_DIVAS_DIVACAPI
 	tristate "DIVA CAPI2.0 interface support"
-	depends on ISDN_DIVAS && ISDN_CAPI
+	depends on ISDN_DIVAS && ISDN_CAPI && BROKEN_ON_64BIT
 	help
 	  You need this to provide the CAPI interface
 	  for DIVA Server cards.
diff --git a/drivers/isdn/hisax/Kconfig b/drivers/isdn/hisax/Kconfig
index 6dfc941..b78abd8 100644
--- a/drivers/isdn/hisax/Kconfig
+++ b/drivers/isdn/hisax/Kconfig
@@ -4,6 +4,7 @@ menu "Passive cards"
 
 config ISDN_DRV_HISAX
 	tristate "HiSax SiemensChipSet driver support"
+	depends on BROKEN_ON_64BIT
 	select CRC_CCITT
 	---help---
 	  This is a driver supporting the Siemens chipset on various
diff --git a/drivers/message/i2o/Kconfig b/drivers/message/i2o/Kconfig
index 6443392..0e135ce 100644
--- a/drivers/message/i2o/Kconfig
+++ b/drivers/message/i2o/Kconfig
@@ -56,7 +56,7 @@ config I2O_EXT_ADAPTEC_DMA64
 
 config I2O_CONFIG
 	tristate "I2O Configuration support"
-	depends on I2O
+	depends on I2O && BROKEN_ON_64BIT
 	---help---
 	  Say Y for support of the configuration interface for the I2O adapters.
 	  If you have a RAID controller from Adaptec and you want to use the
diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
index 7c8ccc0..f8cf8e1 100644
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -145,7 +145,7 @@ comment "Old SIR device drivers"
 
 config IRPORT_SIR
 	tristate "IrPORT (IrDA serial driver)"
-	depends on IRDA && BROKEN_ON_SMP
+	depends on IRDA && BROKEN_ON_SMP && BROKEN_ON_64BIT
 	---help---
 	  Say Y here if you want to build support for the IrPORT IrDA device
 	  driver.  To compile it as a module, choose M here: the module will be
diff --git a/drivers/scsi/megaraid/Kconfig.megaraid b/drivers/scsi/megaraid/Kconfig.megaraid
index 17419e3..6227125 100644
--- a/drivers/scsi/megaraid/Kconfig.megaraid
+++ b/drivers/scsi/megaraid/Kconfig.megaraid
@@ -66,7 +66,7 @@ config MEGARAID_MAILBOX
 
 config MEGARAID_LEGACY
 	tristate "LSI Logic Legacy MegaRAID Driver"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && BROKEN_ON_64BIT
 	help
 	This driver supports the LSI MegaRAID 418, 428, 438, 466, 762, 490
 	and 467 SCSI host adapters. This driver also support the all U320
diff --git a/drivers/usb/misc/sisusbvga/Kconfig b/drivers/usb/misc/sisusbvga/Kconfig
index 7603cbe..b6cc15c 100644
--- a/drivers/usb/misc/sisusbvga/Kconfig
+++ b/drivers/usb/misc/sisusbvga/Kconfig
@@ -1,7 +1,7 @@
 
 config USB_SISUSBVGA
 	tristate "USB 2.0 SVGA dongle support (Net2280/SiS315)"
-	depends on USB && USB_EHCI_HCD
+	depends on USB && USB_EHCI_HCD && BROKEN_ON_64BIT
         ---help---
 	  Say Y here if you intend to attach a USB2VGA dongle based on a
 	  Net2280 and a SiS315 chip.
diff --git a/init/Kconfig b/init/Kconfig
index f7a04d0..6bd3dc3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -47,6 +47,11 @@ config BROKEN_ON_SMP
 	depends on BROKEN || !SMP
 	default y
 
+config BROKEN_ON_64BIT
+	bool
+	depends on BROKEN || !64BIT
+	default y
+
 config LOCK_KERNEL
 	bool
 	depends on SMP || PREEMPT
diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
index 97e38b6..724a3db 100644
--- a/sound/oss/Kconfig
+++ b/sound/oss/Kconfig
@@ -63,7 +63,7 @@ config MIDI_EMU10K1
 
 config SOUND_FUSION
 	tristate "Crystal SoundFusion (CS4280/461x)"
-	depends on SOUND_PRIME && PCI && OSS_OBSOLETE_DRIVER
+	depends on SOUND_PRIME && PCI && OSS_OBSOLETE_DRIVER && BROKEN_ON_64BIT
 	help
 	  This module drives the Crystal SoundFusion devices (CS4280/46xx
 	  series) when wired as native sound drivers with AC97 codecs.  If
@@ -509,7 +509,7 @@ config SOUND_CS4232
 
 config SOUND_SSCAPE
 	tristate "Ensoniq SoundScape support"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && BROKEN_ON_64BIT
 	help
 	  Answer Y if you have a sound card based on the Ensoniq SoundScape
 	  chipset. Such cards are being manufactured at least by Ensoniq, Spea
@@ -584,7 +584,7 @@ config SOUND_MSS
 
 config SOUND_MPU401
 	tristate "MPU-401 support (NOT for SB16)"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && BROKEN_ON_64BIT
 	---help---
 	  Be careful with this question.  The MPU401 interface is supported by
 	  all sound cards.  However, some natively supported cards have their
@@ -634,7 +634,7 @@ config PAS_JOYSTICK
 
 config SOUND_PSS
 	tristate "PSS (AD1848, ADSP-2115, ESC614) support"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && BROKEN_ON_64BIT
 	help
 	  Answer Y or M if you have an Orchid SW32, Cardinal DSP16, Beethoven
 	  ADSP-16 or some other card based on the PSS chipset (AD1848 codec +
@@ -720,7 +720,7 @@ config SOUND_YM3812
 
 config SOUND_OPL3SA2
 	tristate "Yamaha OPL3-SA2 and SA3 based PnP cards"
-	depends on SOUND_OSS && OSS_OBSOLETE_DRIVER
+	depends on SOUND_OSS && OSS_OBSOLETE_DRIVER && BROKEN_ON_64BIT
 	help
 	  Say Y or M if you have a card based on one of these Yamaha sound
 	  chipsets or the "SAx", which is actually a SA3. Read
