Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUKRK2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUKRK2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbUKRK1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:27:11 -0500
Received: from node-40240c4a.sjc.onnet.us.uu.net ([64.36.12.74]:52320 "EHLO
	ns2.tleibold.net") by vger.kernel.org with ESMTP id S262718AbUKRKXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:23:52 -0500
Message-ID: <33599.192.168.0.19.1100773423.squirrel@192.168.0.12>
In-Reply-To: <20041116222506.7c64e122.khali@linux-fr.org>
References: <36129.192.168.0.19.1100598647.squirrel@192.168.0.12><hKBrMfMm.1100605629.3776330.khali@gcu.info><36881.192.168.0.19.1100639614.squirrel@192.168.0.12>
    <20041116222506.7c64e122.khali@linux-fr.org>
Date: Thu, 18 Nov 2004 02:23:43 -0800 (PST)
Subject: Re: [PATCH 2.6] i2c-nforce2.c add support for nForce3 Pro 150 MCP
From: "Thomas Leibold" <thomas@plx.com>
To: greg@kroah.com
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041118022343_51405"
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041118022343_51405
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Greg,

This is the all new and improved version of the patch:
- following the advise from Jean Delvare I removed the redundant definition
of the PCI IDs from the driver and just add them to the pci_ids.h file.
- the patch is now created against linux 2.6.10-RC2.

Signed-off-by: Thomas Leibold <thomas@plx.com>

> (As a side note I applied your 2.4 patch to lm_sensors CVS.)
>
>> This patch applies to linux 2.6.10-RC1. I tried to follow the
>> procedures in Documentation/SubmittingPatches and I hope I got
>> everything right.
>
> Looks good to me except:
>
>> @@ -53,6 +55,10 @@ MODULE_DESCRIPTION("nForce2 SMBus driver
>>  #define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS   0x0064
>>  #endif
>>
>> +#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS
>> +#define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS   0x00D4
>> +#endif
>> +
>> (...)
>> --- linux-2.6.10-rc1/include/linux/pci_ids.h	2004-11-16
>> 10:22:15.000000000 -0800
>> +++ patched/include/linux/pci_ids.h	2004-11-16 11:21:28.223690880 -0800
>> @@ -1081,6 +1081,7 @@
>>  #define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
>>  #define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
>>  #define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
>> +#define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS	0x0064
>>  #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
>>  #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
>>  #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
>> @@ -1092,6 +1093,7 @@
>>  #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
>>  #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
>>  #define PCI_DEVICE_ID_NVIDIA_NFORCE3S  		0x00e1
>> +#define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS	0x00d4
>>  #define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
>>  #define PCI_DEVICE_ID_NVIDIA_NVENET_3		0x00d6
>>  #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
>
>
> You're correct that the IDs are better added to pci_ids.h, but then the
> ifndef blocks in the driver become useless and can be discarded.
>
> Thanks.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/
>

------=_20041118022343_51405
Content-Type: text/x-diff; name="nforce3_patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="nforce3_patch"

diff -urpN linux-2.6.10-rc2/drivers/i2c/busses/i2c-nforce2.c patched/drivers/i2c/busses/i2c-nforce2.c
--- linux-2.6.10-rc2/drivers/i2c/busses/i2c-nforce2.c	2004-11-18 01:13:39.447996576 -0800
+++ patched/drivers/i2c/busses/i2c-nforce2.c	2004-11-18 01:23:36.653207584 -0800
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
@@ -49,11 +51,6 @@ MODULE_AUTHOR ("Hans-Frieder Vogt <hfvog
 MODULE_DESCRIPTION("nForce2 SMBus driver");
 
 
-#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS
-#define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS   0x0064
-#endif
-
-
 struct nforce2_smbus {
 	struct pci_dev *dev;
 	struct i2c_adapter adapter;
@@ -294,6 +291,8 @@ static u32 nforce2_func(struct i2c_adapt
 static struct pci_device_id nforce2_ids[] = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS,
 	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS,
+	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0 }
 };
 
diff -urpN linux-2.6.10-rc2/drivers/i2c/busses/Kconfig patched/drivers/i2c/busses/Kconfig
--- linux-2.6.10-rc2/drivers/i2c/busses/Kconfig	2004-11-18 01:13:39.441997488 -0800
+++ patched/drivers/i2c/busses/Kconfig	2004-11-18 01:22:05.742028184 -0800
@@ -218,6 +218,7 @@ config I2C_NFORCE2
 	help
 	  If you say yes to this option, support will be included for the Nvidia
 	  Nforce2 family of mainboard I2C interfaces.
+	  This driver also supports the nForce3 Pro 150 MCP.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-nforce2.
diff -urpN linux-2.6.10-rc2/include/linux/pci_ids.h patched/include/linux/pci_ids.h
--- linux-2.6.10-rc2/include/linux/pci_ids.h	2004-11-18 01:13:40.940769640 -0800
+++ patched/include/linux/pci_ids.h	2004-11-18 01:22:05.743028032 -0800
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
------=_20041118022343_51405--

