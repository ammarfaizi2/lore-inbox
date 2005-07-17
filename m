Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVGQLll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVGQLll (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 07:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVGQLj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 07:39:28 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:62896 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261278AbVGQLis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 07:38:48 -0400
Date: Sun, 17 Jul 2005 13:39:13 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [6/5+1] menu -> menuconfig part 1
In-Reply-To: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507171336490.6041@be1.lrz>
References: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2005, Bodo Eggert wrote:

> These patches change some menus into menuconfig options.
> 
> Reworked to apply to linux-2.6.13-rc3-git3

The Fusion driver is basically a scsi driver (isn't it?). Move it
to the other drivers and above the SCSI debugging driver.

 arch/arm/Kconfig     |    2 --
 arch/sparc64/Kconfig |    4 ----
 arch/v850/Kconfig    |    2 --
 drivers/Kconfig      |    2 --
 drivers/scsi/Kconfig |   30 ++++++++++++++++--------------
 5 files changed, 16 insertions(+), 24 deletions(-)

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>

diff -rNup a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig	2005-07-17 12:03:15.000000000 +0200
+++ b/arch/arm/Kconfig	2005-07-17 12:05:38.000000000 +0200
@@ -724,8 +724,6 @@ source "drivers/scsi/Kconfig"
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
diff -rNup a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig	2005-07-17 08:09:35.000000000 +0200
+++ b/arch/sparc64/Kconfig	2005-07-17 12:05:38.000000000 +0200
@@ -547,10 +547,6 @@ source "drivers/fc4/Kconfig"
 
 source "drivers/md/Kconfig"
 
-if PCI
-source "drivers/message/fusion/Kconfig"
-endif
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/net/Kconfig"
diff -rNup a/arch/v850/Kconfig b/arch/v850/Kconfig
--- a/arch/v850/Kconfig	2005-07-17 08:09:36.000000000 +0200
+++ b/arch/v850/Kconfig	2005-07-17 12:05:38.000000000 +0200
@@ -279,8 +279,6 @@ endmenu
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
diff -rNup a/drivers/Kconfig b/drivers/Kconfig
--- a/drivers/Kconfig	2005-07-17 08:09:37.000000000 +0200
+++ b/drivers/Kconfig	2005-07-17 12:05:38.000000000 +0200
@@ -20,8 +20,6 @@ source "drivers/cdrom/Kconfig"
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
diff -rNup a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig	2005-07-17 11:53:22.000000000 +0200
+++ b/drivers/scsi/Kconfig	2005-07-17 12:05:38.000000000 +0200
@@ -1485,19 +1485,6 @@ config SCSI_NSP32
 	  To compile this driver as a module, choose M here: the
 	  module will be called nsp32.
 
-config SCSI_DEBUG
-	tristate "SCSI debugging host simulator"
-	depends on SCSI
-	help
-	  This is a host adapter simulator that can simulate multiple hosts
-	  each with multiple dummy SCSI devices (disks). It defaults to one
-	  host adapter with one dummy SCSI disk. Each dummy disk uses kernel
-	  RAM as storage (i.e. it is a ramdisk). To save space when multiple
-	  dummy disks are simulated, they share the same kernel RAM for 
-	  their storage. See <http://www.torque.net/sg/sdebug.html> for more
-	  information. This driver is primarily of use to those testing the
-	  SCSI and block subsystems. If unsure, say N.
-
 config SCSI_MESH
 	tristate "MESH (Power Mac internal SCSI) support"
 	depends on PPC32 && PPC_PMAC && SCSI
@@ -1787,6 +1774,21 @@ config ZFCP
           called zfcp. If you want to compile it as a module, say M here
           and read <file:Documentation/modules.txt>.
 
-endmenu
+source "drivers/message/fusion/Kconfig"
 
 source "drivers/scsi/pcmcia/Kconfig"
+
+config SCSI_DEBUG
+	tristate "SCSI debugging host simulator"
+	depends on SCSI
+	help
+	  This is a host adapter simulator that can simulate multiple hosts
+	  each with multiple dummy SCSI devices (disks). It defaults to one
+	  host adapter with one dummy SCSI disk. Each dummy disk uses kernel
+	  RAM as storage (i.e. it is a ramdisk). To save space when multiple
+	  dummy disks are simulated, they share the same kernel RAM for 
+	  their storage. See <http://www.torque.net/sg/sdebug.html> for more
+	  information. This driver is primarily of use to those testing the
+	  SCSI and block subsystems. If unsure, say N.
+
+endmenu

-- 
Top 100 things you don't want the sysadmin to say:
83. Damn, and I just bought that pop...
