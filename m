Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUHIUTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUHIUTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUHIUTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:19:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46309 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267195AbUHIUIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:08:55 -0400
Date: Mon, 9 Aug 2004 22:08:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select FW_LOADER -> depends HOTPLUG
Message-ID: <20040809200843.GY26174@fs.tum.de>
References: <20040809195656.GX26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809195656.GX26174@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 09:56:56PM +0200, Adrian Bunk wrote:
> 
> The contract is easy:
> If you select something, you have to ensure the depenencies of the 
> selected option are met.
> 
> This is simple.
> 
> And most people get it wrong.
> 
> The patch below adds dependencies on HOTPLUG for all options that select 
> FW_LOADER.
>...

I missed one more option (an option that selects FW_LOADER was itself 
selected...).

Updated patch below.

diffstat output:
 drivers/bluetooth/Kconfig           |    4 ++--
 drivers/media/dvb/ttpci/Kconfig     |    4 ++--
 drivers/media/dvb/ttusb-dec/Kconfig |    2 +-
 drivers/net/wireless/Kconfig        |    5 ++---
 drivers/scsi/Kconfig                |    2 +-
 5 files changed, 8 insertions(+), 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc3-mm2-full-3.4/drivers/bluetooth/Kconfig.old	2004-08-09 21:48:55.000000000 +0200
+++ linux-2.6.8-rc3-mm2-full-3.4/drivers/bluetooth/Kconfig	2004-08-09 21:49:18.000000000 +0200
@@ -65,7 +65,7 @@
 
 config BT_HCIBCM203X
 	tristate "HCI BCM203x USB driver"
-	depends on USB
+	depends on USB && HOTPLUG
 	select FW_LOADER
 	help
 	  Bluetooth HCI BCM203x USB driver.
@@ -77,7 +77,7 @@
 
 config BT_HCIBFUSB
 	tristate "HCI BlueFRITZ! USB driver"
-	depends on USB
+	depends on USB && HOTPLUG
 	select FW_LOADER
 	help
 	  Bluetooth HCI BlueFRITZ! USB driver.
--- linux-2.6.8-rc3-mm2-full-3.4/drivers/scsi/Kconfig.old	2004-08-09 21:48:20.000000000 +0200
+++ linux-2.6.8-rc3-mm2-full-3.4/drivers/scsi/Kconfig	2004-08-09 21:48:32.000000000 +0200
@@ -1019,7 +1019,7 @@
 
 config SCSI_IPR
 	tristate "IBM Power Linux RAID adapter support"
-	depends on PCI && SCSI && PPC
+	depends on PCI && SCSI && PPC && HOTPLUG
 	select FW_LOADER
 	---help---
 	  This driver supports the IBM Power Linux family RAID adapters.
--- linux-2.6.8-rc3-mm2-full-3.4/drivers/media/dvb/ttusb-dec/Kconfig.old	2004-08-09 21:47:21.000000000 +0200
+++ linux-2.6.8-rc3-mm2-full-3.4/drivers/media/dvb/ttusb-dec/Kconfig	2004-08-09 21:47:52.000000000 +0200
@@ -1,6 +1,6 @@
 config DVB_TTUSB_DEC
 	tristate "Technotrend/Hauppauge USB DEC devices"
-	depends on DVB_CORE && USB
+	depends on DVB_CORE && USB && HOTPLUG
 	select FW_LOADER
 	select CRC32
 	help
--- linux-2.6.8-rc3-mm2-full-3.4/drivers/net/wireless/Kconfig.old	2004-08-09 21:43:19.000000000 +0200
+++ linux-2.6.8-rc3-mm2-full-3.4/drivers/net/wireless/Kconfig	2004-08-09 21:44:10.000000000 +0200
@@ -223,7 +223,7 @@
 
 config ATMEL
       tristate "Atmel at76c50x chipset  802.11b support"
-      depends on NET_RADIO && EXPERIMENTAL
+      depends on NET_RADIO && HOTPLUG && EXPERIMENTAL
       select FW_LOADER
       select CRC32
        ---help---
@@ -293,8 +293,6 @@
 config PCMCIA_ATMEL
 	tristate "Atmel at76c502/at76c504 PCMCIA cards"
 	depends on NET_RADIO && ATMEL && PCMCIA
-	select FW_LOADER
-	select CRC32
 	---help---
 	  Enable support for PCMCIA cards containing the
 	  Atmel at76c502 and at76c504 chips.
@@ -309,6 +307,7 @@
 
 comment "Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support"
 	depends on NET_RADIO && PCI
+
 config PRISM54
 	tristate 'Intersil Prism GT/Duette/Indigo PCI/Cardbus' 
 	depends on PCI && NET_RADIO && EXPERIMENTAL && HOTPLUG
--- linux-2.6.8-rc3-mm2-full-3.4/drivers/media/dvb/ttpci/Kconfig.old	2004-08-09 21:45:32.000000000 +0200
+++ linux-2.6.8-rc3-mm2-full-3.4/drivers/media/dvb/ttpci/Kconfig	2004-08-09 22:00:32.000000000 +0200
@@ -1,6 +1,6 @@
 config DVB_AV7110
 	tristate "AV7110 cards"
-	depends on DVB_CORE
+	depends on DVB_CORE && HOTPLUG
 	select FW_LOADER
 	select VIDEO_DEV
 	select VIDEO_SAA7146_VV
@@ -91,7 +91,7 @@
 
 config DVB_BUDGET_PATCH
 	tristate "AV7110 cards with Budget Patch"
-	depends on DVB_BUDGET
+	depends on DVB_BUDGET && HOTPLUG
 	select DVB_AV7110
 	help
 	  Support for Budget Patch (full TS) modification on 

