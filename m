Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWDQOsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWDQOsZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWDQOsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:48:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26379 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751044AbWDQOsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:48:24 -0400
Date: Mon, 17 Apr 2006 16:48:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org,
       linux-mtd@lists.infradead.org
Subject: [RFC: 2.6 patch] let arm use drivers/Kconfig
Message-ID: <20060417144823.GC7429@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch lets arm use drivers/Kconfig.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/arm/Kconfig    |   75 --------------------------------------------
 drivers/Kconfig     |    2 +
 drivers/mtd/Kconfig |    1 
 3 files changed, 4 insertions(+), 74 deletions(-)

--- linux-2.6.17-rc1-mm2-arm/arch/arm/Kconfig.old	2006-04-17 14:25:08.000000000 +0200
+++ linux-2.6.17-rc1-mm2-arm/arch/arm/Kconfig	2006-04-17 14:54:15.000000000 +0200
@@ -794,80 +794,7 @@
 
 source "net/Kconfig"
 
-menu "Device Drivers"
-
-source "drivers/base/Kconfig"
-
-source "drivers/connector/Kconfig"
-
-if ALIGNMENT_TRAP
-source "drivers/mtd/Kconfig"
-endif
-
-source "drivers/parport/Kconfig"
-
-source "drivers/pnp/Kconfig"
-
-source "drivers/block/Kconfig"
-
-source "drivers/acorn/block/Kconfig"
-
-if PCMCIA || ARCH_CLPS7500 || ARCH_IOP3XX || ARCH_IXP4XX \
-	|| ARCH_L7200 || ARCH_LH7A40X || ARCH_PXA || ARCH_RPC \
-	|| ARCH_S3C2410 || ARCH_SA1100 || ARCH_SHARK || FOOTBRIDGE \
-	|| ARCH_IXP23XX
-source "drivers/ide/Kconfig"
-endif
-
-source "drivers/scsi/Kconfig"
-
-source "drivers/md/Kconfig"
-
-source "drivers/message/fusion/Kconfig"
-
-source "drivers/ieee1394/Kconfig"
-
-source "drivers/message/i2o/Kconfig"
-
-source "drivers/net/Kconfig"
-
-source "drivers/isdn/Kconfig"
-
-# input before char - char/joystick depends on it. As does USB.
-
-source "drivers/input/Kconfig"
-
-source "drivers/char/Kconfig"
-
-source "drivers/i2c/Kconfig"
-
-source "drivers/spi/Kconfig"
-
-source "drivers/w1/Kconfig"
-
-source "drivers/hwmon/Kconfig"
-
-#source "drivers/l3/Kconfig"
-
-source "drivers/misc/Kconfig"
-
-source "drivers/mfd/Kconfig"
-
-source "drivers/leds/Kconfig"
-
-source "drivers/media/Kconfig"
-
-source "drivers/video/Kconfig"
-
-source "sound/Kconfig"
-
-source "drivers/usb/Kconfig"
-
-source "drivers/mmc/Kconfig"
-
-source "drivers/rtc/Kconfig"
-
-endmenu
+source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
--- linux-2.6.17-rc1-mm2-arm/drivers/mtd/Kconfig.old	2006-04-17 14:32:35.000000000 +0200
+++ linux-2.6.17-rc1-mm2-arm/drivers/mtd/Kconfig	2006-04-17 15:00:57.000000000 +0200
@@ -1,6 +1,7 @@
 # $Id: Kconfig,v 1.11 2005/11/07 11:14:19 gleixner Exp $
 
 menu "Memory Technology Devices (MTD)"
+	depends on (ALIGNMENT_TRAP || !ARM)
 
 config MTD
 	tristate "Memory Technology Device (MTD) support"
--- linux-2.6.17-rc1-mm2-arm/drivers/Kconfig.old	2006-04-17 14:51:25.000000000 +0200
+++ linux-2.6.17-rc1-mm2-arm/drivers/Kconfig	2006-04-17 14:51:38.000000000 +0200
@@ -14,6 +14,8 @@
 
 source "drivers/block/Kconfig"
 
+source "drivers/acorn/block/Kconfig"
+
 source "drivers/ide/Kconfig"
 
 source "drivers/scsi/Kconfig"

