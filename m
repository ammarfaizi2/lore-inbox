Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbVCXPaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVCXPaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVCXP3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:29:00 -0500
Received: from geode.he.net ([216.218.230.98]:47375 "HELO noserose.net")
	by vger.kernel.org with SMTP id S262794AbVCXPVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:21:33 -0500
From: ecashin@noserose.net
Message-Id: <1111677688.29912@geode.he.net>
Date: Thu, 24 Mar 2005 07:21:28 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] aoe [7/12]: support configuration of AOE_PARTITIONS from Kconfig
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


support configuration of AOE_PARTITIONS from Kconfig

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/drivers/block/Kconfig b/drivers/block/Kconfig
--- a/drivers/block/Kconfig	2005-03-07 17:37:58.000000000 -0500
+++ b/drivers/block/Kconfig	2005-03-10 12:19:54.000000000 -0500
@@ -506,4 +506,19 @@ config ATA_OVER_ETH
 	This driver provides Support for ATA over Ethernet block
 	devices like the Coraid EtherDrive (R) Storage Blade.
 
+config AOE_PARTITIONS
+	int "Partitions per AoE device" if ATA_OVER_ETH
+	default "16"
+	help
+	  The default is to support 16 partitions per aoe device. Some
+	  systems lack good support for devices with large minor
+	  numbers.
+
+	  Such systems will be able to use more aoe disks when
+	  AOE_PARTITIONS is set to one, but you won't be able to
+	  partition the disks, and you must make sure your device
+	  nodes are created to work with the value you select.
+
+	  If unsure, use 16.
+
 endmenu
diff -uprN a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h	2005-03-10 12:19:27.000000000 -0500
+++ b/drivers/block/aoe/aoe.h	2005-03-10 12:19:54.000000000 -0500
@@ -6,8 +6,9 @@
 /* set AOE_PARTITIONS to 1 to use whole-disks only
  * default is 16, which is 15 partitions plus the whole disk
  */
-#ifndef AOE_PARTITIONS
-#define AOE_PARTITIONS 16
+#define AOE_PARTITIONS CONFIG_AOE_PARTITIONS
+#if AOE_PARTITIONS < 1
+#error AOE_PARTITIONS less than one
 #endif
 
 #define SYSMINOR(aoemajor, aoeminor) ((aoemajor) * 10 + (aoeminor))


-- 
  Ed L. Cashin <ecashin@coraid.com>
