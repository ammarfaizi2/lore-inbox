Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbUKSWFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbUKSWFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbUKSWDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:03:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:23962 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261640AbUKSWB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:01:29 -0500
Date: Fri, 19 Nov 2004 14:01:00 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
Message-ID: <20041119220100.GF15956@kroah.com>
References: <20041119215935.GA15956@kroah.com> <20041119220001.GB15956@kroah.com> <20041119220015.GC15956@kroah.com> <20041119220030.GD15956@kroah.com> <20041119220048.GE15956@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119220048.GE15956@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2168, 2004/11/19 09:14:38-08:00, thomas@plx.com

[PATCH] I2C: i2c-nforce2.c add support for nForce3 Pro 150 MCP

This is the all new and improved version of the patch:
- following the advise from Jean Delvare I removed the redundant definition
  of the PCI IDs from the driver and just add them to the pci_ids.h file.
- the patch is now created against linux 2.6.10-RC2.

Signed-off-by: Thomas Leibold <thomas@plx.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/Kconfig       |    1 +
 drivers/i2c/busses/i2c-nforce2.c |    9 ++++-----
 include/linux/pci_ids.h          |    2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2004-11-19 11:40:32 -08:00
+++ b/drivers/i2c/busses/Kconfig	2004-11-19 11:40:32 -08:00
@@ -218,6 +218,7 @@
 	help
 	  If you say yes to this option, support will be included for the Nvidia
 	  Nforce2 family of mainboard I2C interfaces.
+	  This driver also supports the nForce3 Pro 150 MCP.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-nforce2.
diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	2004-11-19 11:40:32 -08:00
+++ b/drivers/i2c/busses/i2c-nforce2.c	2004-11-19 11:40:32 -08:00
@@ -1,6 +1,7 @@
 /*
     SMBus driver for nVidia nForce2 MCP
 
+    Added nForce3 Pro 150  Thomas Leibold <thomas@plx.com>,
 	Ported to 2.5 Patrick Dreker <patrick@dreker.de>,
     Copyright (c) 2003  Hans-Frieder Vogt <hfvogt@arcor.de>,
     Based on
@@ -25,6 +26,7 @@
 /*
     SUPPORTED DEVICES	PCI ID
     nForce2 MCP		0064
+    nForce3 Pro150 MCP	00D4
 
     This driver supports the 2 SMBuses that are included in the MCP2 of the
     nForce2 chipset.
@@ -49,11 +51,6 @@
 MODULE_DESCRIPTION("nForce2 SMBus driver");
 
 
-#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS
-#define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS   0x0064
-#endif
-
-
 struct nforce2_smbus {
 	struct pci_dev *dev;
 	struct i2c_adapter adapter;
@@ -293,6 +290,8 @@
 
 static struct pci_device_id nforce2_ids[] = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS,
+	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS,
 	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0 }
 };
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2004-11-19 11:40:32 -08:00
+++ b/include/linux/pci_ids.h	2004-11-19 11:40:32 -08:00
@@ -1082,6 +1082,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
 #define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
 #define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
+#define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS	0x0064
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
 #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
@@ -1093,6 +1094,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
 #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S  		0x00e1
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS	0x00d4
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
 #define PCI_DEVICE_ID_NVIDIA_NVENET_3		0x00d6
 #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
