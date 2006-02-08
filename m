Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbWBHHKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWBHHKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbWBHHKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:10:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39127 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161041AbWBHHKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:10:11 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] arm: fix dependencies for MTD_XIP
Cc: rmk@arm.linux.org.uk
Message-Id: <E1F6jSs-0002SX-UZ@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:10:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1135027679 -0500

MTD_XIP depends on having working asm/mtd-xip.h; it's not just per-architecture
(arm-only, as current Kconfig would have it), but actually per-subarch as
well.  Introduced a new symbol (ARCH_MTD_XIP) set by arch Kconfig; MTD_XIP
depends on it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/arm/Kconfig          |    5 +++++
 drivers/mtd/chips/Kconfig |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

034d2f5af1b97664381c00b827b274c95e22c397
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5959e36..4a63a8e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -69,6 +69,9 @@ config GENERIC_ISA_DMA
 config FIQ
 	bool
 
+config ARCH_MTD_XIP
+	bool
+
 source "init/Kconfig"
 
 menu "System Type"
@@ -136,6 +139,7 @@ config ARCH_L7200
 
 config ARCH_PXA
 	bool "PXA2xx-based"
+	select ARCH_MTD_XIP
 
 config ARCH_RPC
 	bool "RiscPC"
@@ -152,6 +156,7 @@ config ARCH_SA1100
 	bool "SA1100-based"
 	select ISA
 	select ARCH_DISCONTIGMEM_ENABLE
+	select ARCH_MTD_XIP
 
 config ARCH_S3C2410
 	bool "Samsung S3C2410"
diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index effa0d7..205bb70 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -301,7 +301,7 @@ config MTD_JEDEC
 
 config MTD_XIP
 	bool "XIP aware MTD support"
-	depends on !SMP && (MTD_CFI_INTELEXT || MTD_CFI_AMDSTD) && EXPERIMENTAL && ARM
+	depends on !SMP && (MTD_CFI_INTELEXT || MTD_CFI_AMDSTD) && EXPERIMENTAL && ARCH_MTD_XIP
 	default y if XIP_KERNEL
 	help
 	  This allows MTD support to work with flash memory which is also
-- 
0.99.9.GIT

