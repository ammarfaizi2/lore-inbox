Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWGUPjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWGUPjq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 11:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWGUPjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 11:39:44 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54701 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750912AbWGUPjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 11:39:42 -0400
Date: Fri, 21 Jul 2006 10:39:36 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
cc: linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [PATCH] sgiioc4: Always share IRQ
Message-ID: <20060721103558.F65223@pkunk.americas.sgi.com>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SGI IOC4 IDE device always shares an interrupt with other devices
which are part of IOC4.  As such, IDEPCI_SHARE_IRQ should always be
enabled when BLK_DEV_SGIIOC4 is enabled.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>
---
Resending for inclusion in -mm.

 arch/ia64/configs/sn2_defconfig |    2 +-
 arch/ia64/defconfig             |    2 +-
 drivers/ide/Kconfig             |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)
---
diff --git a/arch/ia64/configs/sn2_defconfig b/arch/ia64/configs/sn2_defconfig
index 9ea3539..0f14a82 100644
--- a/arch/ia64/configs/sn2_defconfig
+++ b/arch/ia64/configs/sn2_defconfig
@@ -363,7 +363,7 @@ # IDE chipset support/bugfixes
 #
 CONFIG_IDE_GENERIC=y
 CONFIG_BLK_DEV_IDEPCI=y
-# CONFIG_IDEPCI_SHARE_IRQ is not set
+CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 # CONFIG_BLK_DEV_GENERIC is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
diff --git a/arch/ia64/defconfig b/arch/ia64/defconfig
index 6cba55d..9001b3f 100644
--- a/arch/ia64/defconfig
+++ b/arch/ia64/defconfig
@@ -366,7 +366,7 @@ #
 # CONFIG_IDE_GENERIC is not set
 # CONFIG_BLK_DEV_IDEPNP is not set
 CONFIG_BLK_DEV_IDEPCI=y
-# CONFIG_IDEPCI_SHARE_IRQ is not set
+CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index d1266fe..556958e 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -682,6 +682,7 @@ config BLK_DEV_SVWKS
 config BLK_DEV_SGIIOC4
 	tristate "Silicon Graphics IOC4 chipset ATA/ATAPI support"
 	depends on (IA64_SGI_SN2 || IA64_GENERIC) && SGI_IOC4
+	select IDEPCI_SHARE_IRQ
 	help
 	  This driver adds PIO & MultiMode DMA-2 support for the SGI IOC4
 	  chipset, which has one channel and can support two devices.
