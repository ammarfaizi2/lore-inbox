Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbUKPVNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbUKPVNp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbUKPVNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:13:45 -0500
Received: from node-40240c4a.sjc.onnet.us.uu.net ([64.36.12.74]:38743 "EHLO
	ns2.tleibold.net") by vger.kernel.org with ESMTP id S261811AbUKPVNj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:13:39 -0500
Message-ID: <36881.192.168.0.19.1100639614.squirrel@192.168.0.12>
In-Reply-To: <hKBrMfMm.1100605629.3776330.khali@gcu.info>
References: <36129.192.168.0.19.1100598647.squirrel@192.168.0.12>
    <hKBrMfMm.1100605629.3776330.khali@gcu.info>
Date: Tue, 16 Nov 2004 13:13:34 -0800 (PST)
Subject: [PATCH 2.6] i2c-nforce2.c add support for nForce3 Pro 150 MCP
From: "Thomas Leibold" <thomas@plx.com>
To: "Greg KH" <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com, "Jean Delvare" <khali@linux-fr.org>,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041116131334_76696"
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041116131334_76696
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Greg,

This patch applies to linux 2.6.10-RC1. I tried to follow the procedures
in Documentation/SubmittingPatches and I hope I got everything right.

Signed-off-by: Thomas Leibold <thomas@plx.com>

Thanks
	Thomas

>
> Hi Thomas,
>
>> This patch adds recognition of the PCI-Id for the nForce3 Pro 150 MCP
>> to the i2c-nforce2.c bus driver. I have tested this simple patch on
>> ASUS A7N8X-deluxe (nforce2, i386) and ASUS SK8N (nforce3, x86-64).
>>
>> On the ASUS SK8N the hardware monitoring is done with a IT8712F-A chip
>> on the ISA bus, so the only use for accessing the 2 SMBUS interfaces
>> in the nForce3 MCP is to read the SPD eeprom in the memory modules.
>>
>> I don't know if this works for other chips in the nForce3 family.
>
> Patch looks good and simple, I'll apply it this evening.
>
> Would you consider providing a similar patch to Greg for Linux 2.6?
>
> Thanks,
> Jean
>

------=_20041116131334_76696
Content-Type: text/x-diff; name="nforce3_patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="nforce3_patch"

diff -uprN linux-2.6.10-rc1/drivers/i2c/busses/i2c-nforce2.c patched/drivers/i2c/busses/i2c-nforce2.c
--- linux-2.6.10-rc1/drivers/i2c/busses/i2c-nforce2.c	2004-11-16 10:22:09.728664352 -0800
+++ patched/drivers/i2c/busses/i2c-nforce2.c	2004-11-16 11:31:01.957470088 -0800
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
@@ -53,6 +55,10 @@ MODULE_DESCRIPTION("nForce2 SMBus driver
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS   0x0064
 #endif
 
+#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS   0x00D4
+#endif
+
 
 struct nforce2_smbus {
 	struct pci_dev *dev;
@@ -294,6 +300,8 @@ static u32 nforce2_func(struct i2c_adapt
 static struct pci_device_id nforce2_ids[] = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS,
 	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS,
+	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0 }
 };
 
diff -uprN linux-2.6.10-rc1/drivers/i2c/busses/Kconfig patched/drivers/i2c/busses/Kconfig
--- linux-2.6.10-rc1/drivers/i2c/busses/Kconfig	2004-11-16 10:22:09.723665112 -0800
+++ patched/drivers/i2c/busses/Kconfig	2004-11-16 11:01:18.162648120 -0800
@@ -205,6 +205,7 @@ config I2C_NFORCE2
 	help
 	  If you say yes to this option, support will be included for the Nvidia
 	  Nforce2 family of mainboard I2C interfaces.
+	  This driver also supports the nForce3 Pro 150 MCP.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-nforce2.
diff -uprN linux-2.6.10-rc1/include/linux/pci_ids.h patched/include/linux/pci_ids.h
--- linux-2.6.10-rc1/include/linux/pci_ids.h	2004-11-16 10:22:15.000000000 -0800
+++ patched/include/linux/pci_ids.h	2004-11-16 11:21:28.223690880 -0800
@@ -1081,6 +1081,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
 #define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
 #define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
+#define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS	0x0064
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
 #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
@@ -1092,6 +1093,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
 #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S  		0x00e1
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS	0x00d4
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
 #define PCI_DEVICE_ID_NVIDIA_NVENET_3		0x00d6
 #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
------=_20041116131334_76696--

