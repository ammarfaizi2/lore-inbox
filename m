Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVEXA5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVEXA5C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVEXA4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:56:38 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:45977 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261284AbVEXAs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:48:29 -0400
Date: Mon, 23 May 2005 19:48:20 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ioc4: CONFIG split
Message-ID: <20050523194449.A75588@chenjesu.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SGI IOC4 I/O controller chip drivers are currently all configured
by CONFIG_BLK_DEV_SGIIOC4.   This is undesirable as not all IOC4
hardware features are needed by all systems.

This patch adds two configuration variables, CONFIG_SGI_IOC4 for
core IOC4 driver support (see patch 1/3 in this series for further
explanation) and CONFIG_SERIAL_SGI_IOC4 to independently enable
serial port support.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>
Acked-by: Pat Gefre <pfg@sgi.com>
Acked-by: Jeremy Higdon <jeremy@sgi.com>

 arch/ia64/configs/sn2_defconfig |    6 ++++++
 arch/ia64/defconfig             |    6 ++++++
 drivers/Kconfig                 |    2 ++
 drivers/Makefile                |    2 +-
 drivers/ide/Kconfig             |    4 ++--
 drivers/serial/Kconfig          |    9 +++++++++
 drivers/serial/Makefile         |    2 +-
 drivers/sn/Kconfig              |   20 ++++++++++++++++++++
 drivers/sn/Makefile             |    2 +-

Index: linux/drivers/ide/Kconfig
===================================================================
--- linux.orig/drivers/ide/Kconfig	2005-05-23 16:02:32.757003419 -0500
+++ linux/drivers/ide/Kconfig	2005-05-23 16:03:49.688752360 -0500
@@ -672,8 +672,8 @@
 	  chipsets.
 
 config BLK_DEV_SGIIOC4
-	tristate "Silicon Graphics IOC4 chipset support"
-	depends on IA64_SGI_SN2 || IA64_GENERIC
+	tristate "Silicon Graphics IOC4 chipset ATA/ATAPI support"
+	depends on (IA64_SGI_SN2 || IA64_GENERIC) && SGI_IOC4
 	help
 	  This driver adds PIO & MultiMode DMA-2 support for the SGI IOC4
 	  chipset, which has one channel and can support two devices.
Index: linux/arch/ia64/configs/sn2_defconfig
===================================================================
--- linux.orig/arch/ia64/configs/sn2_defconfig	2005-05-23 16:02:32.758956521 -0500
+++ linux/arch/ia64/configs/sn2_defconfig	2005-05-23 16:03:49.694611669 -0500
@@ -588,6 +588,7 @@
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_SERIAL_SGI_L1_CONSOLE=y
+CONFIG_SERIAL_SGI_IOC4=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -788,6 +789,11 @@
 # CONFIG_INFINIBAND_IPOIB_DEBUG is not set
 
 #
+# SN Devices
+#
+CONFIG_SGI_IOC4=y
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
Index: linux/drivers/Makefile
===================================================================
--- linux.orig/drivers/Makefile	2005-05-23 16:02:32.757003419 -0500
+++ linux/drivers/Makefile	2005-05-23 16:03:49.695588221 -0500
@@ -61,6 +61,6 @@
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
-obj-$(CONFIG_BLK_DEV_SGIIOC4)	+= sn/
+obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
Index: linux/arch/ia64/defconfig
===================================================================
--- linux.orig/arch/ia64/defconfig	2005-05-23 16:02:32.759933073 -0500
+++ linux/arch/ia64/defconfig	2005-05-23 16:03:49.696564772 -0500
@@ -638,6 +638,7 @@
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_SERIAL_SGI_L1_CONSOLE=y
+CONFIG_SERIAL_SGI_IOC4=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -943,6 +944,11 @@
 # CONFIG_INFINIBAND_IPOIB_DEBUG is not set
 
 #
+# SN Devices
+#
+CONFIG_SGI_IOC4=y
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
Index: linux/drivers/serial/Kconfig
===================================================================
--- linux.orig/drivers/serial/Kconfig	2005-05-23 16:02:32.757979970 -0500
+++ linux/drivers/serial/Kconfig	2005-05-23 16:03:49.697541324 -0500
@@ -843,4 +843,13 @@
           To compile this driver as a module, choose M here: the
           module will be called jsm.
 
+config SERIAL_SGI_IOC4
+	tristate "SGI IOC4 controller serial support"
+	depends on (IA64_GENERIC || IA64_SGI_SN2) && SGI_IOC4
+	select SERIAL_CORE
+	help
+		If you have an SGI Altix with an IOC4 based Base IO card
+		and wish to use the serial ports on this card, say Y.
+		Otherwise, say N.
+
 endmenu
Index: linux/drivers/Kconfig
===================================================================
--- linux.orig/drivers/Kconfig	2005-05-23 16:02:32.757979970 -0500
+++ linux/drivers/Kconfig	2005-05-23 16:03:49.698517875 -0500
@@ -58,4 +58,6 @@
 
 source "drivers/infiniband/Kconfig"
 
+source "drivers/sn/Kconfig"
+
 endmenu
Index: linux/drivers/sn/Kconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/sn/Kconfig	2005-05-23 16:03:49.698517875 -0500
@@ -0,0 +1,20 @@
+#
+# Miscellaneous SN-specific devices
+#
+
+menu "SN Devices"
+
+config SGI_IOC4
+	tristate "SGI IOC4 Base IO support"
+	depends on IA64_GENERIC || IA64_SGI_SN2
+	default m
+	---help---
+	This option enables basic support for the SGI IOC4-based Base IO
+	controller card.  This option does not enable any specific
+	functions on such a card, but provides necessary infrastructure
+	for other drivers to utilize.
+
+	If you have an SGI Altix with an IOC4-based
+	I/O controller say Y.  Otherwise say N.
+
+endmenu
Index: linux/drivers/serial/Makefile
===================================================================
--- linux.orig/drivers/serial/Makefile	2005-05-23 16:02:32.757979970 -0500
+++ linux/drivers/serial/Makefile	2005-05-23 16:03:49.699494426 -0500
@@ -51,4 +51,4 @@
 obj-$(CONFIG_SERIAL_JSM) += jsm/
 obj-$(CONFIG_SERIAL_TXX9) += serial_txx9.o
 obj-$(CONFIG_SERIAL_VR41XX) += vr41xx_siu.o
-obj-$(CONFIG_BLK_DEV_SGIIOC4) += ioc4_serial.o
+obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
Index: linux/drivers/sn/Makefile
===================================================================
--- linux.orig/drivers/sn/Makefile	2005-05-23 16:02:32.758956521 -0500
+++ linux/drivers/sn/Makefile	2005-05-23 16:03:49.699494426 -0500
@@ -3,4 +3,4 @@
 #
 #
 
-obj-$(CONFIG_BLK_DEV_SGIIOC4) += ioc4.o
+obj-$(CONFIG_SGI_IOC4) += ioc4.o

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
