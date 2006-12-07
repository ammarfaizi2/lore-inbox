Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937942AbWLGBsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937942AbWLGBsV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937943AbWLGBsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:48:20 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:27607 "HELO
	smtp103.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937942AbWLGBrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:47:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=c7yFF3uI0YM6xOuwzhZBZyVKzMvsC3gpc5L7LKGRE8HxckJPdqi2lbHjjn5/UXVpkKzerkgIMymusOOnlRoBYXBrs8qLwDGaOLFbdb9CEIoe0xCZ8+0nHSCB9xPxJrHcLb9f9dtg0CQp0SUfIkTKyvw+1k/Ad9h+33eRatuzHtg=  ;
X-YMail-OSG: ASZWBJMVM1lWGleMc1xDbCnyOiW4sSts6WWtIuos5Z8Pd0qRB6Dt5a0MrqFsYos1bCsFAJslNWD7g2o1tdCMOB3foQsTcPJKUy3OtcUsHprMGascVMSd7oqe2ApRkXFqvpl_Sd6x43_Ffck-
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.19-git] RTC Kconfig sorted by type
Date: Wed, 6 Dec 2006 16:52:44 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612061652.45242.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This reorders the RTC driver menu into separate sections, splitting out
the SOC, I2C, and SPI support to help make the menu easier to navigate.
(We got some feedback a while ago that it was "a mess" and hard to make
sense of...)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
Assumes the rtc-omap patch has been merged, and no other RTC drivers
have been added to this Kconfig menu.

Index: at91/drivers/rtc/Kconfig
===================================================================
--- at91.orig/drivers/rtc/Kconfig	2006-12-05 03:25:20.000000000 -0800
+++ at91/drivers/rtc/Kconfig	2006-12-05 03:46:53.000000000 -0800
@@ -1,4 +1,4 @@
-\#
+#
 # RTC class/drivers configuration
 #
 
@@ -20,6 +20,8 @@ config RTC_CLASS
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-class.
 
+if RTC_CLASS != n
+
 config RTC_HCTOSYS
 	bool "Set system time from RTC on startup"
 	depends on RTC_CLASS = y
@@ -45,11 +47,10 @@ config RTC_DEBUG
 	  and individual RTC drivers.
 
 comment "RTC interfaces"
-	depends on RTC_CLASS
 
 config RTC_INTF_SYSFS
 	tristate "sysfs"
-	depends on RTC_CLASS && SYSFS
+	depends on SYSFS
 	default RTC_CLASS
 	help
 	  Say yes here if you want to use your RTCs using sysfs interfaces,
@@ -60,7 +61,7 @@ config RTC_INTF_SYSFS
 
 config RTC_INTF_PROC
 	tristate "proc"
-	depends on RTC_CLASS && PROC_FS
+	depends on PROC_FS
 	default RTC_CLASS
 	help
 	  Say yes here if you want to use your first RTC through the proc
@@ -72,7 +73,6 @@ config RTC_INTF_PROC
 
 config RTC_INTF_DEV
 	tristate "dev"
-	depends on RTC_CLASS
 	default RTC_CLASS
 	help
 	  Say yes here if you want to use your RTCs using the /dev
@@ -92,129 +92,121 @@ config RTC_INTF_DEV_UIE_EMUL
 	  driver does not expose RTC_UIE ioctls.  Those requests generate
 	  once-per-second update interrupts, used for synchronization.
 
+##########################################################################
+
 comment "RTC drivers"
-	depends on RTC_CLASS
 
-config RTC_DRV_X1205
-	tristate "Xicor/Intersil X1205"
-	depends on RTC_CLASS && I2C
+config RTC_DRV_DS1553
+	tristate "Dallas DS1553"
 	help
 	  If you say yes here you get support for the
-	  Xicor/Intersil X1205 RTC chip.
+	  Dallas DS1553 timekeeping chip.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called rtc-x1205.
+	  will be called rtc-ds1553.
 
-config RTC_DRV_DS1307
-	tristate "Dallas/Maxim DS1307 and similar I2C RTC chips"
-	depends on RTC_CLASS && I2C
+config RTC_DRV_DS1742
+	tristate "Dallas DS1742"
 	help
-	  If you say yes here you get support for various compatible RTC
-	  chips (often with battery backup) connected with I2C.  This driver
-	  should handle DS1307, DS1337, DS1338, DS1339, DS1340, ST M41T00,
-	  and probably other chips.  In some cases the RTC must already
-	  have been initialized (by manufacturing or a bootloader).
-
-	  The first seven registers on these chips hold an RTC, and other
-	  registers may add features such as NVRAM, a trickle charger for
-	  the RTC/NVRAM backup power, and alarms.  This driver may not
-	  expose all those available chip features.
+	  If you say yes here you get support for the
+	  Dallas DS1742 timekeeping chip.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called rtc-ds1307.
+	  will be called rtc-ds1742.
 
-config RTC_DRV_DS1553
-	tristate "Dallas DS1553"
-	depends on RTC_CLASS
+config RTC_DRV_V3020
+	tristate "EM Microelectronic V3020"
 	help
-	  If you say yes here you get support for the
-	  Dallas DS1553 timekeeping chip.
+	  If you say yes here you will get support for the
+	  EM Microelectronic v3020 RTC chip.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called rtc-ds1553.
+	  will be called rtc-v3020.
 
-config RTC_DRV_ISL1208
-	tristate "Intersil 1208"
-	depends on RTC_CLASS && I2C
+config RTC_DRV_M48T86
+	tristate "ST M48T86/Dallas DS12887"
 	help
-	  If you say yes here you get support for the
-	  Intersil 1208 RTC chip.
+	  If you say Y here you will get support for the
+	  ST M48T86 and Dallas DS12887 RTC chips.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called rtc-isl1208.
+	  will be called rtc-m48t86.
 
-config RTC_DRV_DS1672
-	tristate "Dallas/Maxim DS1672"
-	depends on RTC_CLASS && I2C
+config RTC_DRV_TEST
+	tristate "Test driver/device"
 	help
 	  If you say yes here you get support for the
-	  Dallas/Maxim DS1672 timekeeping chip.
+	  RTC test driver. It's a software RTC which can be
+	  used to test the RTC subsystem APIs. It gets
+	  the time from the system clock.
+	  You want this driver only if you are doing development
+	  on the RTC subsystem. Please read the source code
+	  for further details.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called rtc-ds1672.
+	  will be called rtc-test.
 
-config RTC_DRV_DS1742
-	tristate "Dallas DS1742"
-	depends on RTC_CLASS
+##########################################################################
+
+comment "System-on-Chip Integrated RTC controller drivers"
+
+config RTC_DRV_PL031
+	tristate "ARM AMBA PL031 RTC"
+	depends on ARM_AMBA
 	help
-	  If you say yes here you get support for the
-	  Dallas DS1742 timekeeping chip.
+	  If you say Y here you will get access to ARM AMBA
+	  PrimeCell PL031 UART found on certain ARM SOCs.
 
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-ds1742.
+	  To compile this driver as a module, choose M here: the
+	  module will be called rtc-pl031.
 
-config RTC_DRV_OMAP
-	tristate "TI OMAP1"
-	depends on RTC_CLASS && ( \
-		ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 )
+config RTC_DRV_AT91
+	tristate "Atmel AT91RM9200"
+	depends on ARCH_AT91RM9200
 	help
-	  Say "yes" here to support the real time clock on TI OMAP1 chips.
-	  This driver can also be built as a module called rtc-omap.
+	  Driver for the Atmel AT91RM9200's internal RTC (Realtime Clock).
 
-config RTC_DRV_PCF8563
-	tristate "Philips PCF8563/Epson RTC8564"
-	depends on RTC_CLASS && I2C
+config RTC_DRV_EP93XX
+	tristate "Cirrus Logic EP93XX"
+	depends on ARCH_EP93XX
 	help
 	  If you say yes here you get support for the
-	  Philips PCF8563 RTC chip. The Epson RTC8564
-	  should work as well.
+	  RTC embedded in the Cirrus Logic EP93XX processors.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called rtc-pcf8563.
+	  will be called rtc-ep93xx.
 
-config RTC_DRV_PCF8583
-	tristate "Philips PCF8583"
-	depends on RTC_CLASS && I2C
+config RTC_DRV_SA1100
+	tristate "Intel SA11x0/PXA2xx"
+	depends on (ARCH_SA1100 || ARCH_PXA)
 	help
-	  If you say yes here you get support for the
-	  Philips PCF8583 RTC chip.
+	  If you say Y here you will get access to the real time clock
+	  built into your SA11x0 or PXA2xx CPU.
 
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-pcf8583.
+	  To compile this driver as a module, choose M here: the
+	  module will be called rtc-sa1100.
 
-config RTC_DRV_RS5C348
-	tristate "Ricoh RS5C348A/B"
-	depends on RTC_CLASS && SPI
+config RTC_DRV_VR41XX
+	tristate "NEC VR41XX"
+	depends on CPU_VR41XX
 	help
-	  If you say yes here you get support for the
-	  Ricoh RS5C348A and RS5C348B RTC chips.
+	  If you say Y here you will get access to the real time clock
+	  built into your NEC VR41XX CPU.
 
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-rs5c348.
+	  To compile this driver as a module, choose M here: the
+	  module will be called rtc-vr41xx.
 
-config RTC_DRV_RS5C372
-	tristate "Ricoh RS5C372A/B"
-	depends on RTC_CLASS && I2C
+config RTC_DRV_OMAP
+	tristate "TI OMAP1"
+	depends on ( \
+		ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 )
 	help
-	  If you say yes here you get support for the
-	  Ricoh RS5C372A and RS5C372B RTC chips.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-rs5c372.
+	  Say "yes" here to support the real time clock on TI OMAP1 chips.
+	  This driver can also be built as a module called rtc-omap.
 
 config RTC_DRV_S3C
 	tristate "Samsung S3C series SoC RTC"
-	depends on RTC_CLASS && ARCH_S3C2410
+	depends on ARCH_S3C2410
 	help
 	  RTC (Realtime Clock) driver for the clock inbuilt into the
 	  Samsung S3C24XX series of SoCs. This can provide periodic
@@ -228,90 +220,105 @@ config RTC_DRV_S3C
 	  This driver can also be build as a module. If so, the module
 	  will be called rtc-s3c.
 
-config RTC_DRV_M48T86
-	tristate "ST M48T86/Dallas DS12887"
-	depends on RTC_CLASS
+config RTC_DRV_SH
+	tristate "SuperH"
+	depends on SUPERH
 	help
-	  If you say Y here you will get support for the
-	  ST M48T86 and Dallas DS12887 RTC chips.
+	  Say Y here to enable support for the on-chip RTC found in
+	  most SuperH processors.
 
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-m48t86.
+ 	  To compile this driver as a module, choose M here: the
+	  module will be called rtc-sh.
 
-config RTC_DRV_EP93XX
-	tristate "Cirrus Logic EP93XX"
-	depends on RTC_CLASS && ARCH_EP93XX
+
+##########################################################################
+
+if I2C
+
+comment "I2C based RTC chip drivers"
+
+config RTC_DRV_DS1307
+	tristate "Dallas/Maxim DS1307 and similar I2C RTC chips"
 	help
-	  If you say yes here you get support for the
-	  RTC embedded in the Cirrus Logic EP93XX processors.
+	  If you say yes here you get support for various compatible RTC
+	  chips (often with battery backup) connected with I2C.  This driver
+	  should handle DS1307, DS1337, DS1338, DS1339, DS1340, ST M41T00,
+	  and probably other chips.  In some cases the RTC must already
+	  have been initialized (by manufacturing or a bootloader).
+
+	  The first seven registers on these chips hold an RTC, and other
+	  registers may add features such as NVRAM, a trickle charger for
+	  the RTC/NVRAM backup power, and alarms.  This driver may not
+	  expose all those available chip features.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called rtc-ep93xx.
+	  will be called rtc-ds1307.
 
-config RTC_DRV_SA1100
-	tristate "SA11x0/PXA2xx"
-	depends on RTC_CLASS && (ARCH_SA1100 || ARCH_PXA)
+config RTC_DRV_DS1672
+	tristate "Dallas/Maxim DS1672"
 	help
-	  If you say Y here you will get access to the real time clock
-	  built into your SA11x0 or PXA2xx CPU.
+	  If you say yes here you get support for the
+	  Dallas/Maxim DS1672 timekeeping chip.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called rtc-sa1100.
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ds1672.
 
-config RTC_DRV_SH
-	tristate "SuperH On-Chip RTC"
-	depends on RTC_CLASS && SUPERH
+config RTC_DRV_ISL1208
+	tristate "Intersil 1208"
 	help
-	  Say Y here to enable support for the on-chip RTC found in
-	  most SuperH processors.
+	  If you say yes here you get support for the
+	  Intersil 1208 RTC chip.
 
- 	  To compile this driver as a module, choose M here: the
-	  module will be called rtc-sh.
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-isl1208.
 
-config RTC_DRV_VR41XX
-	tristate "NEC VR41XX"
-	depends on RTC_CLASS && CPU_VR41XX
+config RTC_DRV_PCF8563
+	tristate "Philips PCF8563/Epson RTC8564"
 	help
-	  If you say Y here you will get access to the real time clock
-	  built into your NEC VR41XX CPU.
+	  If you say yes here you get support for the
+	  Philips PCF8563 RTC chip. The Epson RTC8564
+	  should work as well.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called rtc-vr41xx.
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pcf8563.
 
-config RTC_DRV_PL031
-	tristate "ARM AMBA PL031 RTC"
-	depends on RTC_CLASS && ARM_AMBA
+config RTC_DRV_PCF8583
+	tristate "Philips PCF8583"
 	help
-	  If you say Y here you will get access to ARM AMBA
-	  PrimeCell PL031 UART found on certain ARM SOCs.
+	  If you say yes here you get support for the
+	  Philips PCF8583 RTC chip.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called rtc-pl031.
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pcf8583.
 
-config RTC_DRV_AT91
-	tristate "AT91RM9200"
-	depends on RTC_CLASS && ARCH_AT91RM9200
+config RTC_DRV_RS5C372
+	tristate "Ricoh RS5C372A/B"
 	help
-	  Driver for the Atmel AT91RM9200's internal RTC (Realtime Clock).
+	  If you say yes here you get support for the
+	  Ricoh RS5C372A and RS5C372B RTC chips.
 
-config RTC_DRV_TEST
-	tristate "Test driver/device"
-	depends on RTC_CLASS
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-rs5c372.
+
+config RTC_DRV_X1205
+	tristate "Xicor/Intersil X1205"
 	help
 	  If you say yes here you get support for the
-	  RTC test driver. It's a software RTC which can be
-	  used to test the RTC subsystem APIs. It gets
-	  the time from the system clock.
-	  You want this driver only if you are doing development
-	  on the RTC subsystem. Please read the source code
-	  for further details.
+	  Xicor/Intersil X1205 RTC chip.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called rtc-test.
+	  will be called rtc-x1205.
+
+endif	# I2C
+
+##########################################################################
+
+if SPI
+
+comment "SPI based RTC chip drivers"
 
 config RTC_DRV_MAX6902
 	tristate "Maxim 6902"
-	depends on RTC_CLASS && SPI
 	help
 	  If you say yes here you will get support for the
 	  Maxim MAX6902 spi RTC chip.
@@ -319,14 +326,19 @@ config RTC_DRV_MAX6902
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-max6902.
 
-config RTC_DRV_V3020
-	tristate "EM Microelectronic V3020"
-	depends on RTC_CLASS
+config RTC_DRV_RS5C348
+	tristate "Ricoh RS5C348A/B"
 	help
-	  If you say yes here you will get support for the
-	  EM Microelectronic v3020 RTC chip.
+	  If you say yes here you get support for the
+	  Ricoh RS5C348A and RS5C348B RTC chips.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called rtc-v3020.
+	  will be called rtc-rs5c348.
+
+endif	# SPI
+
+##########################################################################
+
+endif	# RTC_CLASS
 
 endmenu
