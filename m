Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVAHGtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVAHGtP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVAHGsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:48:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:6022 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261910AbVAHFsj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:39 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627761117@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:36 -0800
Message-Id: <11051627764199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.445.8, 2004/12/21 11:08:03-08:00, khali@linux-fr.org

[PATCH] I2C: Use PCI_DEVICE in bus drivers

> Hint, the PCI_DEVICE() macro makes this a lot simpler :)

What about this cleanup patch then? It generalizes the use of
PCI_DEVICE() among i2c/busses drivers (with some pci ids cleanups for
free).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-ali1535.c   |    7 ---
 drivers/i2c/busses/i2c-ali1563.c   |    7 ---
 drivers/i2c/busses/i2c-ali15x3.c   |    7 ---
 drivers/i2c/busses/i2c-amd756.c    |   15 +++++--
 drivers/i2c/busses/i2c-amd8111.c   |    2 -
 drivers/i2c/busses/i2c-hydra.c     |    7 ---
 drivers/i2c/busses/i2c-i801.c      |   56 ++++------------------------
 drivers/i2c/busses/i2c-nforce2.c   |   12 ++----
 drivers/i2c/busses/i2c-piix4.c     |   54 ++++++---------------------
 drivers/i2c/busses/i2c-prosavage.c |    7 ---
 drivers/i2c/busses/i2c-sis96x.c    |   12 ------
 drivers/i2c/busses/i2c-viapro.c    |   72 ++++++++-----------------------------
 include/linux/pci_ids.h            |    6 +++
 13 files changed, 62 insertions(+), 202 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	2005-01-07 14:55:28 -08:00
+++ b/drivers/i2c/busses/i2c-ali1535.c	2005-01-07 14:55:28 -08:00
@@ -487,12 +487,7 @@
 };
 
 static struct pci_device_id ali1535_ids[] = {
-	{
-		.vendor =	PCI_VENDOR_ID_AL,
-		.device =	PCI_DEVICE_ID_AL_M7101,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101) },
 	{ },
 };
 
diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	2005-01-07 14:55:28 -08:00
+++ b/drivers/i2c/busses/i2c-ali1563.c	2005-01-07 14:55:28 -08:00
@@ -385,12 +385,7 @@
 }
 
 static struct pci_device_id __devinitdata ali1563_id_table[] = {
-	{
-		.vendor		= PCI_VENDOR_ID_AL,
-		.device		= PCI_DEVICE_ID_AL_M1563,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1563) },
 	{},
 };
 
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	2005-01-07 14:55:28 -08:00
+++ b/drivers/i2c/busses/i2c-ali15x3.c	2005-01-07 14:55:28 -08:00
@@ -477,12 +477,7 @@
 };
 
 static struct pci_device_id ali15x3_ids[] = {
-	{
-	.vendor =	PCI_VENDOR_ID_AL,
-	.device =	PCI_DEVICE_ID_AL_M7101,
-	.subvendor =	PCI_ANY_ID,
-	.subdevice =	PCI_ANY_ID,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101) },
 	{ 0, }
 };
 
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	2005-01-07 14:55:28 -08:00
+++ b/drivers/i2c/busses/i2c-amd756.c	2005-01-07 14:55:28 -08:00
@@ -316,11 +316,16 @@
 };
 
 static struct pci_device_id amd756_ids[] = {
-	{PCI_VENDOR_ID_AMD, 0x740B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD756 },
-	{PCI_VENDOR_ID_AMD, 0x7413, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD766 },
-	{PCI_VENDOR_ID_AMD, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD768 },
-	{PCI_VENDOR_ID_AMD, 0x746B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD8111 },
-	{PCI_VENDOR_ID_NVIDIA, 0x01B4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_740B),
+	  .driver_data = AMD756 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7413),
+	  .driver_data = AMD766 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_OPUS_7443),
+	  .driver_data = AMD768 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_SMBUS),
+	  .driver_data = AMD8111 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS),
+	  .driver_data = NFORCE },
 	{ 0, }
 };
 
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	2005-01-07 14:55:28 -08:00
+++ b/drivers/i2c/busses/i2c-amd8111.c	2005-01-07 14:55:28 -08:00
@@ -332,7 +332,7 @@
 
 
 static struct pci_device_id amd8111_ids[] = {
-	{ 0x1022, 0x746a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_SMBUS2) },
 	{ 0, }
 };
 
diff -Nru a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
--- a/drivers/i2c/busses/i2c-hydra.c	2005-01-07 14:55:28 -08:00
+++ b/drivers/i2c/busses/i2c-hydra.c	2005-01-07 14:55:28 -08:00
@@ -111,12 +111,7 @@
 };
 
 static struct pci_device_id hydra_ids[] = {
-	{
-		.vendor		= PCI_VENDOR_ID_APPLE,
-		.device		= PCI_DEVICE_ID_APPLE_HYDRA,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_HYDRA) },
 	{ 0, }
 };
 
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	2005-01-07 14:55:28 -08:00
+++ b/drivers/i2c/busses/i2c-i801.c	2005-01-07 14:55:28 -08:00
@@ -548,54 +548,14 @@
 };
 
 static struct pci_device_id i801_ids[] = {
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801AA_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801AB_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801BA_2,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801CA_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801DB_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82801EB_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_ESB_4,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice = 	PCI_ANY_ID,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_ICH6_16,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_16) },
 	{ 0, }
 };
 
diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	2005-01-07 14:55:28 -08:00
+++ b/drivers/i2c/busses/i2c-nforce2.c	2005-01-07 14:55:28 -08:00
@@ -291,14 +291,10 @@
 
 
 static struct pci_device_id nforce2_ids[] = {
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS,
-	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SMBUS,
-	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS,
-	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS,
-	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS) },
 	{ 0 }
 };
 
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	2005-01-07 14:55:28 -08:00
+++ b/drivers/i2c/busses/i2c-piix4.c	2005-01-07 14:55:28 -08:00
@@ -414,48 +414,18 @@
 };
 
 static struct pci_device_id piix4_ids[] = {
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82371AB_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-		.driver_data =	3
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
-		.device =	PCI_DEVICE_ID_SERVERWORKS_OSB4,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-		.driver_data =	0,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
-		.device =	PCI_DEVICE_ID_SERVERWORKS_CSB5,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-		.driver_data =	0,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
-		.device =	PCI_DEVICE_ID_SERVERWORKS_CSB6,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-		.driver_data =	0,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_INTEL,
-		.device =	PCI_DEVICE_ID_INTEL_82443MX_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-		.driver_data =	3,
-	},
-	{
-		.vendor =	PCI_VENDOR_ID_EFAR,
-		.device =	PCI_DEVICE_ID_EFAR_SLC90E66_3,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-		.driver_data =	0,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3),
+	  .driver_data = 3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4),
+	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5),
+	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6),
+	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3),
+	  .driver_data = 3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3),
+	  .driver_data = 0 },
 	{ 0, }
 };
 
diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c	2005-01-07 14:55:28 -08:00
+++ b/drivers/i2c/busses/i2c-prosavage.c	2005-01-07 14:55:28 -08:00
@@ -96,13 +96,6 @@
 /* 
  * S3/VIA 8365/8375 registers
  */
-#ifndef PCI_DEVICE_ID_S3_SAVAGE4
-#define PCI_DEVICE_ID_S3_SAVAGE4	0x8a25
-#endif
-#ifndef PCI_DEVICE_ID_S3_PROSAVAGE8
-#define PCI_DEVICE_ID_S3_PROSAVAGE8	0x8d04
-#endif
-
 #define VGA_CR_IX	0x3d4
 #define VGA_CR_DATA	0x3d5
 
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	2005-01-07 14:55:28 -08:00
+++ b/drivers/i2c/busses/i2c-sis96x.c	2005-01-07 14:55:28 -08:00
@@ -51,9 +51,6 @@
 */
 #define SIS96x_VERSION "1.0.0"
 
-/* SiS96x SMBus PCI device ID */
-#define PCI_DEVICE_ID_SI_SMBUS 0x16
-
 /* base address register in PCI config space */
 #define SIS96x_BAR 0x04
 
@@ -267,14 +264,7 @@
 };
 
 static struct pci_device_id sis96x_ids[] = {
-
-	{
-		.vendor	=	PCI_VENDOR_ID_SI,
-		.device =	PCI_DEVICE_ID_SI_SMBUS,
-		.subvendor =	PCI_ANY_ID,
-		.subdevice =	PCI_ANY_ID,
-	},
-
+	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_SMBUS) },
 	{ 0, }
 };
 
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	2005-01-07 14:55:28 -08:00
+++ b/drivers/i2c/busses/i2c-viapro.c	2005-01-07 14:55:28 -08:00
@@ -395,62 +395,22 @@
 }
 
 static struct pci_device_id vt596_ids[] = {
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_82C596_3,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA1,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device		= PCI_DEVICE_ID_VIA_82C596B_3,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA1,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_82C686_4,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA1,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_8233_0,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA3
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_8233A,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA3,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_8235,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA3
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_8237,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA3
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device 	= PCI_DEVICE_ID_VIA_8231_4,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SMBBA1,
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596_3),
+	  .driver_data = SMBBA1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596B_3),
+	  .driver_data = SMBBA1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4),
+	  .driver_data = SMBBA1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_0),
+	  .driver_data = SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233A),
+	  .driver_data = SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8235),
+	  .driver_data = SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237),
+	  .driver_data = SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231_4),
+	  .driver_data = SMBBA1 },
 	{ 0, }
 };
 
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-01-07 14:55:28 -08:00
+++ b/include/linux/pci_ids.h	2005-01-07 14:55:28 -08:00
@@ -496,6 +496,8 @@
 #	define PCI_DEVICE_ID_AMD_VIPER_7449	PCI_DEVICE_ID_AMD_OPUS_7449
 #define PCI_DEVICE_ID_AMD_8111_LAN	0x7462
 #define PCI_DEVICE_ID_AMD_8111_IDE	0x7469
+#define PCI_DEVICE_ID_AMD_8111_SMBUS2	0x746a
+#define PCI_DEVICE_ID_AMD_8111_SMBUS	0x746b
 #define PCI_DEVICE_ID_AMD_8111_AUDIO	0x746d
 #define PCI_DEVICE_ID_AMD_8151_0	0x7454
 #define PCI_DEVICE_ID_AMD_8131_APIC     0x7450
@@ -585,6 +587,7 @@
 #define PCI_DEVICE_ID_SI_6202		0x0002
 #define PCI_DEVICE_ID_SI_503		0x0008
 #define PCI_DEVICE_ID_SI_ACPI		0x0009
+#define PCI_DEVICE_ID_SI_SMBUS		0x0016
 #define PCI_DEVICE_ID_SI_LPC		0x0018
 #define PCI_DEVICE_ID_SI_5597_VGA	0x0200
 #define PCI_DEVICE_ID_SI_6205		0x0205
@@ -1133,6 +1136,7 @@
 #define PCI_DEVICE_ID_NVIDIA_IGEFORCE2		0x01a0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE		0x01a4
 #define PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO		0x01b1
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS	0x01b4
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_IDE		0x01bc
 #define PCI_DEVICE_ID_NVIDIA_NVENET_1		0x01c3
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2		0x01e0
@@ -2048,9 +2052,11 @@
 #define PCI_DEVICE_ID_S3_PLATO_PXG	0x8902
 #define PCI_DEVICE_ID_S3_ViRGE_DXGX	0x8a01
 #define PCI_DEVICE_ID_S3_ViRGE_GX2	0x8a10
+#define PCI_DEVICE_ID_S3_SAVAGE4	0x8a25
 #define PCI_DEVICE_ID_S3_ViRGE_MX	0x8c01
 #define PCI_DEVICE_ID_S3_ViRGE_MXP	0x8c02
 #define PCI_DEVICE_ID_S3_ViRGE_MXPMV	0x8c03
+#define PCI_DEVICE_ID_S3_PROSAVAGE8	0x8d04
 #define PCI_DEVICE_ID_S3_SONICVIBES	0xca00
 
 #define PCI_VENDOR_ID_DUNORD		0x5544

