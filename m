Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbTCTWXF>; Thu, 20 Mar 2003 17:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262680AbTCTWWA>; Thu, 20 Mar 2003 17:22:00 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:29189 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262682AbTCTWV2>;
	Thu, 20 Mar 2003 17:21:28 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <10481995631475@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <10481995642207@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.3, 2003/03/18 14:37:20-08:00, greg@kroah.com

[PATCH] i2c i2c-i801.c: fix up the pci id matching, and change to use proper pci ids.


 drivers/i2c/busses/i2c-i801.c |   27 +++++++--------------------
 1 files changed, 7 insertions(+), 20 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Thu Mar 20 12:57:37 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Thu Mar 20 12:57:37 2003
@@ -55,21 +55,6 @@
 #define HAVE_PEC
 #endif
 
-#ifndef PCI_DEVICE_ID_INTEL_82801CA_SMBUS
-#define PCI_DEVICE_ID_INTEL_82801CA_SMBUS	0x2483
-#endif
-
-#ifndef PCI_DEVICE_ID_INTEL_82801DB_SMBUS
-#define PCI_DEVICE_ID_INTEL_82801DB_SMBUS	0x24C3
-#endif
-
-static int supported[] = {PCI_DEVICE_ID_INTEL_82801AA_3,
-                          PCI_DEVICE_ID_INTEL_82801AB_3,
-                          PCI_DEVICE_ID_INTEL_82801BA_2,
-			  PCI_DEVICE_ID_INTEL_82801CA_SMBUS,
-			  PCI_DEVICE_ID_INTEL_82801DB_SMBUS,
-                          0 };
-
 /* I801 SMBus address offsets */
 #define SMBHSTSTS (0 + i801_smba)
 #define SMBHSTCNT (2 + i801_smba)
@@ -135,7 +120,6 @@
 static int i801_setup(struct pci_dev *dev)
 {
 	int error_return = 0;
-	int *num = supported;
 	unsigned char temp;
 
 	/* Note: we keep on searching until we have found 'function 3' */
@@ -143,7 +127,10 @@
 		return -ENODEV;
 
 	I801_dev = dev;
-	isich4 = *num == PCI_DEVICE_ID_INTEL_82801DB_SMBUS;
+	if (dev->device == PCI_DEVICE_ID_INTEL_82801DB_3)
+		isich4 = 1;
+	else
+		isich4 = 0;
 
 /* Determine the address of the SMBus areas */
 	if (force_addr) {
@@ -290,7 +277,7 @@
                                               hostc | SMBHSTCFG_I2C_EN);
                 } else {
                         dev_err(&I801_dev->dev,
-				"I2C_SMBUS_I2C_BLOCK_READ not supported!\n");
+				"I2C_SMBUS_I2C_BLOCK_READ not DB!\n");
                         return -1;
                 }
         }
@@ -607,13 +594,13 @@
 	},
 	{
 		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801CA_SMBUS,
+		.device =	PCI_DEVICE_ID_INTEL_82801CA_3,
 		.subvendor =	PCI_ANY_ID,
 		.subdevice =	PCI_ANY_ID,
 	},
 	{
 		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801DB_SMBUS,
+		.device =	PCI_DEVICE_ID_INTEL_82801DB_3,
 		.subvendor =	PCI_ANY_ID,
 		.subdevice =	PCI_ANY_ID,
 	},

