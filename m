Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWF2TWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWF2TWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWF2TWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:22:10 -0400
Received: from [141.84.69.5] ([141.84.69.5]:36368 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932283AbWF2TWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:22:06 -0400
Date: Thu, 29 Jun 2006 21:21:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] VIDEO_V4L1 shouldn't be user-visible
Message-ID: <20060629192124.GD19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VIDEO_V4L1 is an implementation detail that shouldn't be user-visible.

This patch changes VIDEO_V4L1 to be no longer user-visible and being 
delect'ed by all drivers requiring it.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/Kconfig                |    9 ---
 drivers/media/dvb/ttpci/Kconfig      |   15 +++--
 drivers/media/radio/Kconfig          |   46 +++++++++++------
 drivers/media/video/Kconfig          |   71 +++++++++++++++++----------
 drivers/media/video/em28xx/Kconfig   |    3 -
 drivers/media/video/et61x251/Kconfig |    3 -
 drivers/media/video/pwc/Kconfig      |    3 -
 drivers/media/video/sn9c102/Kconfig  |    3 -
 drivers/media/video/usbvideo/Kconfig |    9 ++-
 drivers/media/video/zc0301/Kconfig   |    3 -
 10 files changed, 104 insertions(+), 61 deletions(-)

--- linux-2.6.17-mm4-full/drivers/media/Kconfig.old	2006-06-29 20:10:53.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/Kconfig	2006-06-29 20:11:51.000000000 +0200
@@ -25,15 +25,8 @@
 	  module will be called videodev.
 
 config VIDEO_V4L1
-	bool "Enable Video For Linux API 1 (DEPRECATED)"
-	depends on VIDEO_DEV
+	bool
 	select VIDEO_V4L1_COMPAT
-	default y
-	---help---
-	  Enables a compatibility API used by most V4L2 devices to allow
-	  its usage with legacy applications that supports only V4L1 api.
-
-	  If you are unsure as to whether this is required, answer Y.
 
 config VIDEO_V4L1_COMPAT
 	bool "Enable Video For Linux API 1 compatible Layer"
--- linux-2.6.17-mm4-full/drivers/media/dvb/ttpci/Kconfig.old	2006-06-29 20:11:59.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/dvb/ttpci/Kconfig	2006-06-29 20:13:36.000000000 +0200
@@ -1,6 +1,6 @@
 config DVB_AV7110
 	tristate "AV7110 cards"
-	depends on DVB_CORE && PCI && I2C && VIDEO_V4L1
+	depends on DVB_CORE && PCI && I2C && VIDEO_DEV
 	select FW_LOADER
 	select VIDEO_SAA7146_VV
 	select DVB_VES1820
@@ -11,6 +11,7 @@
 	select DVB_STV0297
 	select DVB_L64781
 	select DVB_LNBP21
+	select VIDEO_V4L1
 	help
 	  Support for SAA7146 and AV7110 based DVB cards as produced
 	  by Fujitsu-Siemens, Technotrend, Hauppauge and others.
@@ -59,7 +60,7 @@
 
 config DVB_BUDGET
 	tristate "Budget cards"
-	depends on DVB_CORE && PCI && I2C && VIDEO_V4L1
+	depends on DVB_CORE && PCI && I2C && VIDEO_DEV
 	select VIDEO_SAA7146
 	select DVB_STV0299
 	select DVB_VES1X93
@@ -69,6 +70,7 @@
 	select DVB_TDA10021
 	select DVB_S5H1420
 	select DVB_LNBP21
+	select VIDEO_V4L1
 	help
 	  Support for simple SAA7146 based DVB cards
 	  (so called Budget- or Nova-PCI cards) without onboard
@@ -81,12 +83,13 @@
 
 config DVB_BUDGET_CI
 	tristate "Budget cards with onboard CI connector"
-	depends on DVB_CORE && PCI && I2C && VIDEO_V4L1
+	depends on DVB_CORE && PCI && I2C && VIDEO_DEV
 	select VIDEO_SAA7146
 	select DVB_STV0297
 	select DVB_STV0299
 	select DVB_TDA1004X
 	select DVB_LNBP21
+	select VIDEO_V4L1
 	help
 	  Support for simple SAA7146 based DVB cards
 	  (so called Budget- or Nova-PCI cards) without onboard
@@ -102,12 +105,13 @@
 
 config DVB_BUDGET_AV
 	tristate "Budget cards with analog video inputs"
-	depends on DVB_CORE && PCI && I2C && VIDEO_V4L1
+	depends on DVB_CORE && PCI && I2C && VIDEO_DEV
 	select VIDEO_SAA7146_VV
 	select DVB_STV0299
 	select DVB_TDA1004X
 	select DVB_TDA10021
 	select FW_LOADER
+	select VIDEO_V4L1
 	help
 	  Support for simple SAA7146 based DVB cards
 	  (so called Budget- or Nova-PCI cards) without onboard
@@ -120,11 +124,12 @@
 
 config DVB_BUDGET_PATCH
 	tristate "AV7110 cards with Budget Patch"
-	depends on DVB_CORE && DVB_BUDGET && VIDEO_V4L1
+	depends on DVB_CORE && DVB_BUDGET && VIDEO_DEV
 	select DVB_AV7110
 	select DVB_STV0299
 	select DVB_VES1X93
 	select DVB_TDA8083
+	select VIDEO_V4L1
 	help
 	  Support for Budget Patch (full TS) modification on
 	  SAA7146+AV7110 based cards (DVB-S cards). This
--- linux-2.6.17-mm4-full/drivers/media/radio/Kconfig.old	2006-06-29 20:13:50.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/radio/Kconfig	2006-06-29 20:28:26.000000000 +0200
@@ -3,11 +3,12 @@
 #
 
 menu "Radio Adapters"
-	depends on VIDEO_DEV!=n
+	depends on VIDEO_DEV
 
 config RADIO_CADET
 	tristate "ADS Cadet AM/FM Tuner"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have one of these AM/FM radio cards, and then
 	  fill in the port address below.
@@ -25,7 +26,8 @@
 
 config RADIO_RTRACK
 	tristate "AIMSlab RadioTrack (aka RadioReveal) support"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have one of these FM radio cards, and then fill
 	  in the port address below.
@@ -59,7 +61,8 @@
 
 config RADIO_RTRACK2
 	tristate "AIMSlab RadioTrack II support"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have this FM radio card, and then fill in the
 	  port address below.
@@ -82,7 +85,8 @@
 
 config RADIO_AZTECH
 	tristate "Aztech/Packard Bell Radio"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have one of these FM radio cards, and then fill
 	  in the port address below.
@@ -106,7 +110,8 @@
 
 config RADIO_GEMTEK
 	tristate "GemTek Radio Card support"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have this FM radio card, and then fill in the
 	  port address below.
@@ -131,7 +136,8 @@
 
 config RADIO_GEMTEK_PCI
 	tristate "GemTek PCI Radio Card support"
-	depends on VIDEO_V4L1 && PCI
+	depends on PCI
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have this PCI FM radio card.
 
@@ -145,7 +151,8 @@
 
 config RADIO_MAXIRADIO
 	tristate "Guillemot MAXI Radio FM 2000 radio"
-	depends on VIDEO_V4L1 && PCI
+	depends on PCI
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have this radio card.  This card may also be
 	  found as Gemtek PCI FM.
@@ -160,7 +167,7 @@
 
 config RADIO_MAESTRO
 	tristate "Maestro on board radio"
-	depends on VIDEO_V4L1
+	select VIDEO_V4L1
 	---help---
 	  Say Y here to directly support the on-board radio tuner on the
 	  Maestro 2 or 2E sound card.
@@ -175,7 +182,8 @@
 
 config RADIO_MIROPCM20
 	tristate "miroSOUND PCM20 radio"
-	depends on ISA && VIDEO_V4L1 && SOUND_ACI_MIXER
+	depends on ISA && SOUND_ACI_MIXER
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have this FM radio card. You also need to say Y
 	  to "ACI mixer (miroSOUND PCM1-pro/PCM12/PCM20 radio)" (in "Sound")
@@ -208,7 +216,8 @@
 
 config RADIO_SF16FMI
 	tristate "SF16FMI Radio"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have one of these FM radio cards.  If you
 	  compile the driver into the kernel and your card is not PnP one, you
@@ -225,7 +234,8 @@
 
 config RADIO_SF16FMR2
 	tristate "SF16FMR2 Radio"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have one of these FM radio cards.
 
@@ -239,7 +249,8 @@
 
 config RADIO_TERRATEC
 	tristate "TerraTec ActiveRadio ISA Standalone"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have this FM radio card, and then fill in the
 	  port address below. (TODO)
@@ -268,7 +279,8 @@
 
 config RADIO_TRUST
 	tristate "Trust FM radio card"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA
+	select VIDEO_V4L1
 	help
 	  This is a driver for the Trust FM radio cards. Say Y if you have
 	  such a card and want to use it under Linux.
@@ -286,7 +298,8 @@
 
 config RADIO_TYPHOON
 	tristate "Typhoon Radio (a.k.a. EcoRadio)"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have one of these FM radio cards, and then fill
 	  in the port address and the frequency used for muting below.
@@ -330,7 +343,8 @@
 
 config RADIO_ZOLTRIX
 	tristate "Zoltrix Radio"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA
+	select VIDEO_V4L1
 	---help---
 	  Choose Y here if you have one of these FM radio cards, and then fill
 	  in the port address below.
--- linux-2.6.17-mm4-full/drivers/media/video/Kconfig.old	2006-06-29 20:16:52.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/Kconfig	2006-06-29 20:29:18.000000000 +0200
@@ -44,7 +44,8 @@
 
 config VIDEO_PMS
 	tristate "Mediavision Pro Movie Studio Video For Linux"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA
+	select VIDEO_V4L1
 	help
 	  Say Y if you have such a thing.
 
@@ -53,7 +54,8 @@
 
 config VIDEO_PLANB
 	tristate "PlanB Video-In on PowerMac"
-	depends on PPC_PMAC && VIDEO_V4L1 && BROKEN
+	depends on PPC_PMAC && BROKEN
+	select VIDEO_V4L1
 	help
 	  PlanB is the V4L driver for the PowerMac 7x00/8x00 series video
 	  input hardware. If you want to experiment with this, say Y.
@@ -64,7 +66,8 @@
 
 config VIDEO_BWQCAM
 	tristate "Quickcam BW Video For Linux"
-	depends on PARPORT && VIDEO_V4L1
+	depends on PARPORT
+	select VIDEO_V4L1
 	help
 	  Say Y have if you the black and white version of the QuickCam
 	  camera. See the next option for the color version.
@@ -74,7 +77,8 @@
 
 config VIDEO_CQCAM
 	tristate "QuickCam Colour Video For Linux (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PARPORT && VIDEO_V4L1
+	depends on EXPERIMENTAL && PARPORT
+	select VIDEO_V4L1
 	help
 	  This is the video4linux driver for the colour version of the
 	  Connectix QuickCam.  If you have one of these cameras, say Y here,
@@ -85,7 +89,8 @@
 
 config VIDEO_W9966
 	tristate "W9966CF Webcam (FlyCam Supra and others) Video For Linux"
-	depends on PARPORT_1284 && PARPORT && VIDEO_V4L1
+	depends on PARPORT_1284 && PARPORT
+	select VIDEO_V4L1
 	help
 	  Video4linux driver for Winbond's w9966 based Webcams.
 	  Currently tested with the LifeView FlyCam Supra.
@@ -98,7 +103,7 @@
 
 config VIDEO_CPIA
 	tristate "CPiA Video For Linux"
-	depends on VIDEO_V4L1
+	select VIDEO_V4L1
 	---help---
 	  This is the video4linux driver for cameras based on Vision's CPiA
 	  (Colour Processor Interface ASIC), such as the Creative Labs Video
@@ -135,7 +140,8 @@
 
 config VIDEO_SAA5246A
 	tristate "SAA5246A, SAA5281 Teletext processor"
-	depends on I2C && VIDEO_V4L1
+	depends on I2C
+	select VIDEO_V4L1
 	help
 	  Support for I2C bus based teletext using the SAA5246A or SAA5281
 	  chip. Useful only if you live in Europe.
@@ -162,7 +168,8 @@
 
 config VIDEO_VINO
 	tristate "SGI Vino Video For Linux (EXPERIMENTAL)"
-	depends on I2C && SGI_IP22 && EXPERIMENTAL && VIDEO_V4L1
+	depends on I2C && SGI_IP22 && EXPERIMENTAL
+	select VIDEO_V4L1
 	select I2C_ALGO_SGI
 	help
 	  Say Y here to build in support for the Vino video input system found
@@ -170,7 +177,8 @@
 
 config VIDEO_STRADIS
 	tristate "Stradis 4:2:2 MPEG-2 video driver  (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PCI && VIDEO_V4L1 && !PPC64
+	depends on EXPERIMENTAL && PCI && !PPC64
+	select VIDEO_V4L1
 	help
 	  Say Y here to enable support for the Stradis 4:2:2 MPEG-2 video
 	  driver for PCI.  There is a product page at
@@ -178,7 +186,8 @@
 
 config VIDEO_ZORAN
 	tristate "Zoran ZR36057/36067 Video For Linux"
-	depends on PCI && I2C_ALGOBIT && VIDEO_V4L1 && !PPC64
+	depends on PCI && I2C_ALGOBIT && !PPC64
+	select VIDEO_V4L1
 	help
 	  Say Y for support for MJPEG capture cards based on the Zoran
 	  36057/36067 PCI controller chipset. This includes the Iomega
@@ -226,13 +235,15 @@
 
 config VIDEO_ZORAN_AVS6EYES
 	tristate "AverMedia 6 Eyes support (EXPERIMENTAL)"
-	depends on VIDEO_ZORAN && EXPERIMENTAL && VIDEO_V4L1
+	depends on VIDEO_ZORAN && EXPERIMENTAL
+	select VIDEO_V4L1
 	help
 	  Support for the AverMedia 6 Eyes video surveillance card.
 
 config VIDEO_ZR36120
 	tristate "Zoran ZR36120/36125 Video For Linux"
-	depends on PCI && I2C && VIDEO_V4L1 && BROKEN
+	depends on PCI && I2C && BROKEN
+	select VIDEO_V4L1
 	help
 	  Support for ZR36120/ZR36125 based frame grabber/overlay boards.
 	  This includes the Victor II, WaveWatcher, Video Wonder, Maxi-TV,
@@ -244,7 +255,8 @@
 
 config VIDEO_MEYE
 	tristate "Sony Vaio Picturebook Motion Eye Video For Linux"
-	depends on PCI && SONYPI && VIDEO_V4L1
+	depends on PCI && SONYPI
+	select VIDEO_V4L1
 	---help---
 	  This is the video4linux driver for the Motion Eye camera found
 	  in the Vaio Picturebook laptops. Please read the material in
@@ -260,7 +272,8 @@
 
 config VIDEO_MXB
 	tristate "Siemens-Nixdorf 'Multimedia eXtension Board'"
-	depends on PCI && VIDEO_V4L1
+	depends on PCI
+	select VIDEO_V4L1
 	select VIDEO_SAA7146_VV
 	select VIDEO_TUNER
 	---help---
@@ -272,7 +285,8 @@
 
 config VIDEO_DPC
 	tristate "Philips-Semiconductors 'dpc7146 demonstration board'"
-	depends on PCI && VIDEO_V4L1
+	depends on PCI
+	select VIDEO_V4L1
 	select VIDEO_SAA7146_VV
 	select VIDEO_V4L2
 	---help---
@@ -287,7 +301,8 @@
 
 config VIDEO_HEXIUM_ORION
 	tristate "Hexium HV-PCI6 and Orion frame grabber"
-	depends on PCI && VIDEO_V4L1
+	depends on PCI
+	select VIDEO_V4L1
 	select VIDEO_SAA7146_VV
 	select VIDEO_V4L2
 	---help---
@@ -299,7 +314,8 @@
 
 config VIDEO_HEXIUM_GEMINI
 	tristate "Hexium Gemini frame grabber"
-	depends on PCI && VIDEO_V4L1
+	depends on PCI
+	select VIDEO_V4L1
 	select VIDEO_SAA7146_VV
 	select VIDEO_V4L2
 	---help---
@@ -314,7 +330,8 @@
 
 config VIDEO_M32R_AR
 	tristate "AR devices"
-	depends on M32R && VIDEO_V4L1
+	depends on M32R
+	select VIDEO_V4L1
 	---help---
 	  This is a video4linux driver for the Renesas AR (Artificial Retina)
 	  camera module.
@@ -451,7 +468,8 @@
 
 config USB_DSBR
 	tristate "D-Link USB FM radio support (EXPERIMENTAL)"
-	depends on USB && VIDEO_V4L1 && EXPERIMENTAL
+	depends on USB && EXPERIMENTAL
+	select VIDEO_V4L1
 	---help---
 	  Say Y here if you want to connect this type of radio to your
 	  computer's USB port. Note that the audio is not digital, and
@@ -467,7 +485,8 @@
 
 config VIDEO_OVCAMCHIP
 	tristate "OmniVision Camera Chip support"
-	depends on I2C && VIDEO_V4L1
+	depends on I2C
+	select VIDEO_V4L1
 	---help---
 	  Support for the OmniVision OV6xxx and OV7xxx series of camera chips.
 	  This driver is intended to be used with the ov511 and w9968cf USB
@@ -478,7 +497,8 @@
 
 config USB_W9968CF
 	tristate "USB W996[87]CF JPEG Dual Mode Camera support"
-	depends on USB && VIDEO_V4L1 && I2C
+	depends on USB && I2C
+	select VIDEO_V4L1
 	select VIDEO_OVCAMCHIP
 	---help---
 	  Say Y here if you want support for cameras based on OV681 or
@@ -496,7 +516,8 @@
 
 config USB_OV511
 	tristate "USB OV511 Camera support"
-	depends on USB && VIDEO_V4L1
+	depends on USB
+	select VIDEO_V4L1
 	---help---
 	  Say Y here if you want to connect this type of camera to your
 	  computer's USB port. See <file:Documentation/video4linux/ov511.txt>
@@ -507,7 +528,8 @@
 
 config USB_SE401
 	tristate "USB SE401 Camera support"
-	depends on USB && VIDEO_V4L1
+	depends on USB
+	select VIDEO_V4L1
 	---help---
 	  Say Y here if you want to connect this type of camera to your
 	  computer's USB port. See <file:Documentation/video4linux/se401.txt>
@@ -520,7 +542,8 @@
 
 config USB_STV680
 	tristate "USB STV680 (Pencam) Camera support"
-	depends on USB && VIDEO_V4L1
+	depends on USB
+	select VIDEO_V4L1
 	---help---
 	  Say Y here if you want to connect this type of camera to your
 	  computer's USB port. This includes the Pencam line of cameras.
--- linux-2.6.17-mm4-full/drivers/media/video/em28xx/Kconfig.old	2006-06-29 20:20:15.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/em28xx/Kconfig	2006-06-29 20:20:33.000000000 +0200
@@ -1,6 +1,7 @@
 config VIDEO_EM28XX
 	tristate "Empia EM2800/2820/2840 USB video capture support"
-	depends on VIDEO_V4L1 && USB && I2C
+	depends on USB && I2C
+	select VIDEO_V4L1
 	select VIDEO_BUF
 	select VIDEO_TUNER
 	select VIDEO_TVEEPROM
--- linux-2.6.17-mm4-full/drivers/media/video/et61x251/Kconfig.old	2006-06-29 20:20:42.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/et61x251/Kconfig	2006-06-29 20:20:48.000000000 +0200
@@ -1,6 +1,7 @@
 config USB_ET61X251
 	tristate "USB ET61X[12]51 PC Camera Controller support"
-	depends on USB && VIDEO_V4L1
+	depends on USB
+	select VIDEO_V4L1
 	---help---
 	  Say Y here if you want support for cameras based on Etoms ET61X151
 	  or ET61X251 PC Camera Controllers.
--- linux-2.6.17-mm4-full/drivers/media/video/pwc/Kconfig.old	2006-06-29 20:20:57.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/pwc/Kconfig	2006-06-29 20:21:04.000000000 +0200
@@ -1,6 +1,7 @@
 config USB_PWC
 	tristate "USB Philips Cameras"
-	depends on USB && VIDEO_V4L1
+	depends on USB
+	select VIDEO_V4L1
 	---help---
 	  Say Y or M here if you want to use one of these Philips & OEM
 	  webcams:
--- linux-2.6.17-mm4-full/drivers/media/video/sn9c102/Kconfig.old	2006-06-29 20:21:13.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/sn9c102/Kconfig	2006-06-29 20:21:23.000000000 +0200
@@ -1,6 +1,7 @@
 config USB_SN9C102
 	tristate "USB SN9C10x PC Camera Controller support"
-	depends on USB && VIDEO_V4L1
+	depends on USB 
+	select VIDEO_V4L1
 	---help---
 	  Say Y here if you want support for cameras based on SONiX SN9C101,
 	  SN9C102 or SN9C103 PC Camera Controllers.
--- linux-2.6.17-mm4-full/drivers/media/video/usbvideo/Kconfig.old	2006-06-29 20:21:31.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/usbvideo/Kconfig	2006-06-29 20:21:58.000000000 +0200
@@ -3,7 +3,8 @@
 
 config USB_VICAM
 	tristate "USB 3com HomeConnect (aka vicam) support (EXPERIMENTAL)"
-	depends on USB && VIDEO_V4L1 && EXPERIMENTAL
+	depends on USB && EXPERIMENTAL
+	select VIDEO_V4L1
 	select VIDEO_USBVIDEO
 	---help---
 	  Say Y here if you have 3com homeconnect camera (vicam).
@@ -13,7 +14,8 @@
 
 config USB_IBMCAM
 	tristate "USB IBM (Xirlink) C-it Camera support"
-	depends on USB && VIDEO_V4L1
+	depends on USB
+	select VIDEO_V4L1
 	select VIDEO_USBVIDEO
 	---help---
 	  Say Y here if you want to connect a IBM "C-It" camera, also known as
@@ -28,7 +30,8 @@
 
 config USB_KONICAWC
 	tristate "USB Konica Webcam support"
-	depends on USB && VIDEO_V4L1
+	depends on USB
+	select VIDEO_V4L1
 	select VIDEO_USBVIDEO
 	---help---
 	  Say Y here if you want support for webcams based on a Konica
--- linux-2.6.17-mm4-full/drivers/media/video/zc0301/Kconfig.old	2006-06-29 20:22:19.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/zc0301/Kconfig	2006-06-29 20:22:27.000000000 +0200
@@ -1,6 +1,7 @@
 config USB_ZC0301
 	tristate "USB ZC0301[P] Image Processor and Control Chip support"
-	depends on USB && VIDEO_V4L1
+	depends on USB
+	select VIDEO_V4L1
 	---help---
 	  Say Y here if you want support for cameras based on the ZC0301 or
 	  ZC0301P Image Processors and Control Chips.

