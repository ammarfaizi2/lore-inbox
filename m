Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVCQQvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVCQQvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 11:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVCQQvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 11:51:49 -0500
Received: from mail0.lsil.com ([147.145.40.20]:61948 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262076AbVCQQsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 11:48:39 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703662770@exa-atlanta>
From: "Ju, Seokmann" <sju@lsil.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "Ju, Seokmann" <sju@lsil.com>
Subject: RE: [ANNOUNCE][PATCH] drivers/scsi/megaraid/megaraid_{mm,mbox}
Date: Thu, 17 Mar 2005 11:48:29 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C52B11.25A75990"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C52B11.25A75990
Content-Type: text/plain;
	charset="iso-8859-1"

On Thursday, March 17, 2005 1:26 AM, Andrew wrote:
> Some of these things have already been done in Linus's 
> post-2.6.11 tree and
> you patch throws lots of rejects.  Please always work against the most
> recent kernel - 2.6.11 is very out of date.
Thank you for correction. I've created NEW patch against 2.6.11.4 which is
latest from kernel.org.

> 
> The patch was severely wordwrapped.  Please fix your email 
> client and send
> a test patch to yourself and ensure that it still applies OK.
Sorry for inconvenience. The patch in here should not have the issue.
Also, I'm including the patch as attachment.

Thank you 

Signed-off-by: Seokmann Ju <sju@lsil.com>
---
diff -Naur old/Documentation/scsi/ChangeLog.megaraid
new/Documentation/scsi/ChangeLog.megaraid
--- old/Documentation/scsi/ChangeLog.megaraid	2005-03-17
09:54:51.780719824 -0500
+++ new/Documentation/scsi/ChangeLog.megaraid	2005-03-17
09:14:03.247953384 -0500
@@ -1,3 +1,69 @@
+Release Date	: Mon Mar 07 12:27:22 EST 2005 - Seokmann Ju <sju@lsil.com>
+Current Version	: 2.20.4.6 (scsi module), 2.20.2.6 (cmm module)
+Older Version	: 2.20.4.5 (scsi module), 2.20.2.5 (cmm module)
+
+1.	Added IOCTL backward compatibility.
+	Convert megaraid_mm driver to new compat_ioctl entry points.
+	I don't have easy access to hardware, so only compile tested.
+		- Signed-off-by:Andi Kleen <ak@muc.de>
+
+2.	megaraid_mbox fix: wrong order of arguments in memset()
+	That, BTW, shows why cross-builds are useful-the only indication of
+	problem had been a new warning showing up in sparse output on alpha
+	build (number of exceeding 256 got truncated).
+		- Signed-off-by: Al Viro
+		<viro@parcelfarce.linux.theplanet.co.uk>
+
+3.	Convert pci_module_init to pci_register_driver
+	Convert from pci_module_init to pci_register_driver
+	(from:http://kerneljanitors.org/TODO)
+		- Signed-off-by: Domen Puncer <domen@coderock.org>
+
+4.	Use the pre defined DMA mask constants from dma-mapping.h
+	Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h when
calling
+	pci_set_dma_mask() or pci_set_consistend_dma_mask(). See
+	http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for more
+	details.
+		Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
+		Signed-off-by: Domen Puncer <domen@coderock.org>
+
+5.	Remove SSID checking for Dobson, Lindsay, and Verde based products.
+	Checking the SSVID/SSID for controllers which have Dobson, Lindsay,
+	and Verde is unnecessary because device ID has been assigned by LSI
+	and it is unique value. So, all controllers with these IOPs have to
be
+	supported by the driver regardless SSVID/SSID.
+
+6.	Date Thu, 27 Jan 2005 04:31:09 +0100 
+	From Herbert Poetzl <> 
+	Subject RFC: assert_spin_locked() for 2.6 
+
+	Greetings!
+
+	overcautious programming will kill your kernel ;)
+	ever thought about checking a spin_lock or even
+	asserting that it must be held (maybe just for
+	spinlock debugging?) ...
+
+	there are several checks present in the kernel
+	where somebody does a variation on the following:
+
+	  BUG_ON(!spin_is_locked(&some_lock));
+
+	so what's wrong about that? nothing, unless you
+	compile the code with CONFIG_DEBUG_SPINLOCK but 
+	without CONFIG_SMP ... in which case the BUG()
+	will kill your kernel ...
+
+	maybe it's not advised to make such assertions, 
+	but here is a solution which works for me ...
+	(compile tested for sh, x86_64 and x86, boot/run
+	tested for x86 only)
+
+	best,
+	Herbert
+
+		- Herbert Poetzl <herbert@13thfloor.at>, Thu, 27 Jan 2005
+
 Release Date	: Thu Feb 03 12:27:22 EST 2005 - Seokmann Ju <sju@lsil.com>
 Current Version	: 2.20.4.5 (scsi module), 2.20.2.5 (cmm module)
 Older Version	: 2.20.4.4 (scsi module), 2.20.2.4 (cmm module)
diff -Naur old/drivers/scsi/megaraid/mega_common.h
new/drivers/scsi/megaraid/mega_common.h
--- old/drivers/scsi/megaraid/mega_common.h	2005-03-17
08:37:00.147915960 -0500
+++ new/drivers/scsi/megaraid/mega_common.h	2005-03-17
07:16:21.209546408 -0500
@@ -27,6 +27,7 @@
 #include <linux/list.h>
 #include <linux/version.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <asm/semaphore.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.c
new/drivers/scsi/megaraid/megaraid_mbox.c
--- old/drivers/scsi/megaraid/megaraid_mbox.c	2005-03-17
08:37:00.110921584 -0500
+++ new/drivers/scsi/megaraid/megaraid_mbox.c	2005-03-17
09:03:41.275507568 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.4.5 (Feb 03 2005)
+ * Version	: v2.20.4.6 (Mar 07 2005)
  *
  * Authors:
  * 	Atul Mukker		<Atul.Mukker@lsil.com>
@@ -202,7 +202,7 @@
  * ### global data ###
  */
 static uint8_t megaraid_mbox_version[8] =
-	{ 0x02, 0x20, 0x04, 0x05, 2, 3, 20, 5 };
+	{ 0x02, 0x20, 0x04, 0x06, 3, 7, 20, 5 };
 
 
 /*
@@ -229,9 +229,9 @@
 	},
 	{
 		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_PERC4_QC,
-		PCI_VENDOR_ID_DELL,
-		PCI_SUBSYS_ID_PERC4_QC,
+		PCI_DEVICE_ID_VERDE,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
 	},
 	{
 		PCI_VENDOR_ID_DELL,
@@ -271,15 +271,9 @@
 	},
 	{
 		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_PERC4E_DC_320_2E,
-		PCI_VENDOR_ID_DELL,
-		PCI_SUBSYS_ID_PERC4E_DC_320_2E,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_PERC4E_SC_320_1E,
-		PCI_VENDOR_ID_DELL,
-		PCI_SUBSYS_ID_PERC4E_SC_320_1E,
+		PCI_DEVICE_ID_DOBSON,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
 	},
 	{
 		PCI_VENDOR_ID_AMI,
@@ -331,36 +325,6 @@
 	},
 	{
 		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_0x,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_0x,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_2x,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_2x,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_4x,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_4x,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_1E,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_1E,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_2E,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_2E,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
 		PCI_DEVICE_ID_MEGARAID_I4_133_RAID,
 		PCI_VENDOR_ID_LSI_LOGIC,
 		PCI_SUBSYS_ID_MEGARAID_I4_133_RAID,
@@ -379,21 +343,9 @@
 	},
 	{
 		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SATA_300_4x,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SATA_300_4x,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SATA_300_8x,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SATA_300_8x,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_INTEL_RAID_SRCU42X,
-		PCI_VENDOR_ID_INTEL,
-		PCI_SUBSYS_ID_INTEL_RAID_SRCU42X,
+		PCI_DEVICE_ID_LINDSAY,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
 	},
 	{
 		PCI_VENDOR_ID_LSI_LOGIC,
@@ -403,58 +355,10 @@
 	},
 	{
 		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_INTEL_RAID_SRCU42E,
-		PCI_VENDOR_ID_INTEL,
-		PCI_SUBSYS_ID_INTEL_RAID_SRCU42E,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_INTEL_RAID_SRCZCRX,
-		PCI_VENDOR_ID_INTEL,
-		PCI_SUBSYS_ID_INTEL_RAID_SRCZCRX,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_INTEL_RAID_SRCS28X,
-		PCI_VENDOR_ID_INTEL,
-		PCI_SUBSYS_ID_INTEL_RAID_SRCS28X,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_INTEL_RAID_SROMBU42E_ALIEF,
-		PCI_VENDOR_ID_INTEL,
-		PCI_SUBSYS_ID_INTEL_RAID_SROMBU42E_ALIEF,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_INTEL_RAID_SROMBU42E_HARWICH,
-		PCI_VENDOR_ID_INTEL,
-		PCI_SUBSYS_ID_INTEL_RAID_SROMBU42E_HARWICH,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
 		PCI_DEVICE_ID_INTEL_RAID_SRCU41L_LAKE_SHETEK,
 		PCI_VENDOR_ID_INTEL,
 		PCI_SUBSYS_ID_INTEL_RAID_SRCU41L_LAKE_SHETEK,
 	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_FSC_MEGARAID_PCI_EXPRESS_ROMB,
-		PCI_SUBSYS_ID_FSC,
-		PCI_SUBSYS_ID_FSC_MEGARAID_PCI_EXPRESS_ROMB,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_ACER_ROMB_2E,
-		PCI_VENDOR_ID_AI,
-		PCI_SUBSYS_ID_MEGARAID_ACER_ROMB_2E,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_NEC_ROMB_2E,
-		PCI_VENDOR_ID_NEC,
-		PCI_SUBSYS_ID_MEGARAID_NEC_ROMB_2E,
-	},
 	{0}	/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, pci_id_table_g);
@@ -539,7 +443,8 @@
 
 
 	// register as a PCI hot-plug driver module
-	if ((rval = pci_module_init(&megaraid_pci_driver_g))) {
+	rval = pci_register_driver(&megaraid_pci_driver_g);
+	if (rval < 0) {
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid: could not register hotplug support.\n"));
 	}
@@ -619,7 +524,7 @@
 
 	// Setup the default DMA mask. This would be changed later on
 	// depending on hardware capabilities
-	if (pci_set_dma_mask(adapter->pdev, 0xFFFFFFFF) != 0) {
+	if (pci_set_dma_mask(adapter->pdev, DMA_32BIT_MASK) != 0) {
 
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid: pci_set_dma_mask failed:%d\n",
__LINE__));
@@ -1031,7 +936,7 @@
 
 	// Set the DMA mask to 64-bit. All supported controllers as capable
of
 	// DMA in this range
-	if (pci_set_dma_mask(adapter->pdev, 0xFFFFFFFFFFFFFFFFULL) != 0) {
+	if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK) != 0) {
 
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid: could not set DMA mask for 64-bit.\n"));
diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.h
new/drivers/scsi/megaraid/megaraid_mbox.h
--- old/drivers/scsi/megaraid/megaraid_mbox.h	2005-03-17
08:37:00.110921584 -0500
+++ new/drivers/scsi/megaraid/megaraid_mbox.h	2005-03-17
07:16:21.183550360 -0500
@@ -21,8 +21,8 @@
 #include "megaraid_ioctl.h"
 
 
-#define MEGARAID_VERSION	"2.20.4.5"
-#define MEGARAID_EXT_VERSION	"(Release Date: Thu Feb 03 12:27:22 EST
2005)"
+#define MEGARAID_VERSION	"2.20.4.6"
+#define MEGARAID_EXT_VERSION	"(Release Date: Mon Mar 07 12:27:22 EST
2005)"
 
 
 /*
@@ -37,8 +37,7 @@
 #define PCI_DEVICE_ID_PERC4_DC				0x1960
 #define PCI_SUBSYS_ID_PERC4_DC				0x0518
 
-#define PCI_DEVICE_ID_PERC4_QC				0x0407
-#define PCI_SUBSYS_ID_PERC4_QC				0x0531
+#define PCI_DEVICE_ID_VERDE				0x0407
 
 #define PCI_DEVICE_ID_PERC4_DI_EVERGLADES		0x000F
 #define PCI_SUBSYS_ID_PERC4_DI_EVERGLADES		0x014A
@@ -58,11 +57,7 @@
 #define PCI_DEVICE_ID_PERC4E_DI_GUADALUPE		0x0013
 #define PCI_SUBSYS_ID_PERC4E_DI_GUADALUPE		0x0170
 
-#define PCI_DEVICE_ID_PERC4E_DC_320_2E			0x0408
-#define PCI_SUBSYS_ID_PERC4E_DC_320_2E			0x0002
-
-#define PCI_DEVICE_ID_PERC4E_SC_320_1E			0x0408
-#define PCI_SUBSYS_ID_PERC4E_SC_320_1E			0x0001
+#define PCI_DEVICE_ID_DOBSON				0x0408
 
 #define PCI_DEVICE_ID_MEGARAID_SCSI_320_0		0x1960
 #define PCI_SUBSYS_ID_MEGARAID_SCSI_320_0		0xA520
@@ -73,21 +68,6 @@
 #define PCI_DEVICE_ID_MEGARAID_SCSI_320_2		0x1960
 #define PCI_SUBSYS_ID_MEGARAID_SCSI_320_2		0x0518
 
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_0x		0x0407
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_0x		0x0530
-
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_2x		0x0407
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_2x		0x0532
-
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_4x		0x0407
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_4x		0x0531
-
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_1E		0x0408
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_1E		0x0001
-
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_2E		0x0408
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_2E		0x0002
-
 #define PCI_DEVICE_ID_MEGARAID_I4_133_RAID		0x1960
 #define PCI_SUBSYS_ID_MEGARAID_I4_133_RAID		0x0522
 
@@ -97,52 +77,18 @@
 #define PCI_DEVICE_ID_MEGARAID_SATA_150_6		0x1960
 #define PCI_SUBSYS_ID_MEGARAID_SATA_150_6		0x0523
 
-#define PCI_DEVICE_ID_MEGARAID_SATA_300_4x		0x0409
-#define PCI_SUBSYS_ID_MEGARAID_SATA_300_4x		0x3004
-
-#define PCI_DEVICE_ID_MEGARAID_SATA_300_8x		0x0409
-#define PCI_SUBSYS_ID_MEGARAID_SATA_300_8x		0x3008
-
-#define PCI_DEVICE_ID_INTEL_RAID_SRCU42X		0x0407
-#define PCI_SUBSYS_ID_INTEL_RAID_SRCU42X		0x0532
+#define PCI_DEVICE_ID_LINDSAY				0x0409
 
 #define PCI_DEVICE_ID_INTEL_RAID_SRCS16			0x1960
 #define PCI_SUBSYS_ID_INTEL_RAID_SRCS16			0x0523
 
-#define PCI_DEVICE_ID_INTEL_RAID_SRCU42E		0x0408
-#define PCI_SUBSYS_ID_INTEL_RAID_SRCU42E		0x0002
-
-#define PCI_DEVICE_ID_INTEL_RAID_SRCZCRX		0x0407
-#define PCI_SUBSYS_ID_INTEL_RAID_SRCZCRX		0x0530
-
-#define PCI_DEVICE_ID_INTEL_RAID_SRCS28X		0x0409
-#define PCI_SUBSYS_ID_INTEL_RAID_SRCS28X		0x3008
-
-#define PCI_DEVICE_ID_INTEL_RAID_SROMBU42E_ALIEF	0x0408
-#define PCI_SUBSYS_ID_INTEL_RAID_SROMBU42E_ALIEF	0x3431
-
-#define PCI_DEVICE_ID_INTEL_RAID_SROMBU42E_HARWICH	0x0408
-#define PCI_SUBSYS_ID_INTEL_RAID_SROMBU42E_HARWICH	0x3499
-
 #define PCI_DEVICE_ID_INTEL_RAID_SRCU41L_LAKE_SHETEK	0x1960
 #define PCI_SUBSYS_ID_INTEL_RAID_SRCU41L_LAKE_SHETEK	0x0520
 
-#define PCI_DEVICE_ID_FSC_MEGARAID_PCI_EXPRESS_ROMB	0x0408
-#define PCI_SUBSYS_ID_FSC_MEGARAID_PCI_EXPRESS_ROMB	0x1065
-
-#define PCI_DEVICE_ID_MEGARAID_ACER_ROMB_2E		0x0408
-#define PCI_SUBSYS_ID_MEGARAID_ACER_ROMB_2E		0x004D
-
 #define PCI_SUBSYS_ID_PERC3_QC				0x0471
 #define PCI_SUBSYS_ID_PERC3_DC				0x0493
 #define PCI_SUBSYS_ID_PERC3_SC				0x0475
 
-#define PCI_DEVICE_ID_MEGARAID_NEC_ROMB_2E		0x0408
-#define PCI_SUBSYS_ID_MEGARAID_NEC_ROMB_2E		0x8287
-
-#ifndef PCI_SUBSYS_ID_FSC
-#define PCI_SUBSYS_ID_FSC				0x1734
-#endif
 
 #define MBOX_MAX_SCSI_CMDS	128	// number of cmds reserved for
kernel
 #define MBOX_MAX_USER_CMDS	32	// number of cmds for applications
diff -Naur old/drivers/scsi/megaraid/megaraid_mm.c
new/drivers/scsi/megaraid/megaraid_mm.c
--- old/drivers/scsi/megaraid/megaraid_mm.c	2005-03-17
08:37:00.147915960 -0500
+++ new/drivers/scsi/megaraid/megaraid_mm.c	2005-03-17
07:16:21.196548384 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mm.c
- * Version	: v2.20.2.5 (Jan 21 2005)
+ * Version	: v2.20.2.6 (Mar 7 2005)
  *
  * Common management module
  */
@@ -43,8 +43,7 @@
 static void mraid_mm_teardown_dma_pools(mraid_mmadp_t *);
 
 #ifdef CONFIG_COMPAT
-static int mraid_mm_compat_ioctl(unsigned int, unsigned int, unsigned long,
-		struct file *);
+static long mraid_mm_compat_ioctl(struct file *, unsigned int, unsigned
long);
 #endif
 
 MODULE_AUTHOR("LSI Logic Corporation");
@@ -61,7 +60,7 @@
 EXPORT_SYMBOL(mraid_mm_adapter_app_handle);
 
 static int majorno;
-static uint32_t drvr_ver	= 0x02200201;
+static uint32_t drvr_ver	= 0x02200206;
 
 static int adapters_count_g;
 static struct list_head adapters_list_g;
@@ -69,9 +68,12 @@
 static wait_queue_head_t wait_q;
 
 static struct file_operations lsi_fops = {
-	.open	= mraid_mm_open,
-	.ioctl	= mraid_mm_ioctl,
-	.owner	= THIS_MODULE,
+	.open		= mraid_mm_open,
+	.ioctl		= mraid_mm_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= mraid_mm_compat_ioctl, 
+#endif
+	.owner		= THIS_MODULE,
 };
 
 /**
@@ -1215,8 +1217,6 @@
 
 	INIT_LIST_HEAD(&adapters_list_g);
 
-	register_ioctl32_conversion(MEGAIOCCMD, mraid_mm_compat_ioctl);
-
 	return 0;
 }
 
@@ -1225,13 +1225,14 @@
  * mraid_mm_compat_ioctl	: 32bit to 64bit ioctl conversion routine
  */
 #ifdef CONFIG_COMPAT
-static int
-mraid_mm_compat_ioctl(unsigned int fd, unsigned int cmd,
-			unsigned long arg, struct file *filep)
+static long
+mraid_mm_compat_ioctl(struct file *filep, unsigned int cmd, unsigned long
arg)
 {
-	struct inode *inode = filep->f_dentry->d_inode;
+	int err;
+
+	err = mraid_mm_ioctl(NULL, filep, cmd, arg);
 
-	return mraid_mm_ioctl(inode, filep, cmd, arg);
+	return err;
 }
 #endif
 
@@ -1244,7 +1245,6 @@
 	con_log(CL_DLEVEL1 , ("exiting common mod\n"));
 
 	unregister_chrdev(majorno, "megadev");
-	unregister_ioctl32_conversion(MEGAIOCCMD);
 }
 
 module_init(mraid_mm_init);
diff -Naur old/drivers/scsi/megaraid/megaraid_mm.h
new/drivers/scsi/megaraid/megaraid_mm.h
--- old/drivers/scsi/megaraid/megaraid_mm.h	2005-03-17
08:37:00.147915960 -0500
+++ new/drivers/scsi/megaraid/megaraid_mm.h	2005-03-17
07:16:21.203547320 -0500
@@ -29,9 +29,9 @@
 #include "megaraid_ioctl.h"
 
 
-#define LSI_COMMON_MOD_VERSION	"2.20.2.5"
+#define LSI_COMMON_MOD_VERSION	"2.20.2.6"
 #define LSI_COMMON_MOD_EXT_VERSION	\
-		"(Release Date: Fri Jan 21 00:01:03 EST 2005)"
+		"(Release Date: Mon Mar 7 00:01:03 EST 2005)"
 
 
 #define LSI_DBGLVL			dbglevel
---


------_=_NextPart_000_01C52B11.25A75990
Content-Type: application/octet-stream;
	name="megaraid.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="megaraid.patch"

diff -Naur old/Documentation/scsi/ChangeLog.megaraid =
new/Documentation/scsi/ChangeLog.megaraid=0A=
--- old/Documentation/scsi/ChangeLog.megaraid	2005-03-17 =
09:54:51.780719824 -0500=0A=
+++ new/Documentation/scsi/ChangeLog.megaraid	2005-03-17 =
09:14:03.247953384 -0500=0A=
@@ -1,3 +1,69 @@=0A=
+Release Date	: Mon Mar 07 12:27:22 EST 2005 - Seokmann Ju =
<sju@lsil.com>=0A=
+Current Version	: 2.20.4.6 (scsi module), 2.20.2.6 (cmm module)=0A=
+Older Version	: 2.20.4.5 (scsi module), 2.20.2.5 (cmm module)=0A=
+=0A=
+1.	Added IOCTL backward compatibility.=0A=
+	Convert megaraid_mm driver to new compat_ioctl entry points.=0A=
+	I don't have easy access to hardware, so only compile tested.=0A=
+		- Signed-off-by:Andi Kleen <ak@muc.de>=0A=
+=0A=
+2.	megaraid_mbox fix: wrong order of arguments in memset()=0A=
+	That, BTW, shows why cross-builds are useful-the only indication =
of=0A=
+	problem had been a new warning showing up in sparse output on =
alpha=0A=
+	build (number of exceeding 256 got truncated).=0A=
+		- Signed-off-by: Al Viro=0A=
+		<viro@parcelfarce.linux.theplanet.co.uk>=0A=
+=0A=
+3.	Convert pci_module_init to pci_register_driver=0A=
+	Convert from pci_module_init to pci_register_driver=0A=
+	(from:http://kerneljanitors.org/TODO)=0A=
+		- Signed-off-by: Domen Puncer <domen@coderock.org>=0A=
+=0A=
+4.	Use the pre defined DMA mask constants from dma-mapping.h=0A=
+	Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h when =
calling=0A=
+	pci_set_dma_mask() or pci_set_consistend_dma_mask(). See=0A=
+	http://marc.theaimsgroup.com/?t=3D108001993000001&r=3D1&w=3D2 for =
more=0A=
+	details.=0A=
+		Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>=0A=
+		Signed-off-by: Domen Puncer <domen@coderock.org>=0A=
+=0A=
+5.	Remove SSID checking for Dobson, Lindsay, and Verde based =
products.=0A=
+	Checking the SSVID/SSID for controllers which have Dobson, =
Lindsay,=0A=
+	and Verde is unnecessary because device ID has been assigned by =
LSI=0A=
+	and it is unique value. So, all controllers with these IOPs have to =
be=0A=
+	supported by the driver regardless SSVID/SSID.=0A=
+=0A=
+6.	Date Thu, 27 Jan 2005 04:31:09 +0100 =0A=
+	From Herbert Poetzl <> =0A=
+	Subject RFC: assert_spin_locked() for 2.6 =0A=
+=0A=
+	Greetings!=0A=
+=0A=
+	overcautious programming will kill your kernel ;)=0A=
+	ever thought about checking a spin_lock or even=0A=
+	asserting that it must be held (maybe just for=0A=
+	spinlock debugging?) ...=0A=
+=0A=
+	there are several checks present in the kernel=0A=
+	where somebody does a variation on the following:=0A=
+=0A=
+	  BUG_ON(!spin_is_locked(&some_lock));=0A=
+=0A=
+	so what's wrong about that? nothing, unless you=0A=
+	compile the code with CONFIG_DEBUG_SPINLOCK but =0A=
+	without CONFIG_SMP ... in which case the BUG()=0A=
+	will kill your kernel ...=0A=
+=0A=
+	maybe it's not advised to make such assertions, =0A=
+	but here is a solution which works for me ...=0A=
+	(compile tested for sh, x86_64 and x86, boot/run=0A=
+	tested for x86 only)=0A=
+=0A=
+	best,=0A=
+	Herbert=0A=
+=0A=
+		- Herbert Poetzl <herbert@13thfloor.at>, Thu, 27 Jan 2005=0A=
+=0A=
 Release Date	: Thu Feb 03 12:27:22 EST 2005 - Seokmann Ju =
<sju@lsil.com>=0A=
 Current Version	: 2.20.4.5 (scsi module), 2.20.2.5 (cmm module)=0A=
 Older Version	: 2.20.4.4 (scsi module), 2.20.2.4 (cmm module)=0A=
diff -Naur old/drivers/scsi/megaraid/mega_common.h =
new/drivers/scsi/megaraid/mega_common.h=0A=
--- old/drivers/scsi/megaraid/mega_common.h	2005-03-17 =
08:37:00.147915960 -0500=0A=
+++ new/drivers/scsi/megaraid/mega_common.h	2005-03-17 =
07:16:21.209546408 -0500=0A=
@@ -27,6 +27,7 @@=0A=
 #include <linux/list.h>=0A=
 #include <linux/version.h>=0A=
 #include <linux/moduleparam.h>=0A=
+#include <linux/dma-mapping.h>=0A=
 #include <asm/semaphore.h>=0A=
 #include <scsi/scsi.h>=0A=
 #include <scsi/scsi_cmnd.h>=0A=
diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.c =
new/drivers/scsi/megaraid/megaraid_mbox.c=0A=
--- old/drivers/scsi/megaraid/megaraid_mbox.c	2005-03-17 =
08:37:00.110921584 -0500=0A=
+++ new/drivers/scsi/megaraid/megaraid_mbox.c	2005-03-17 =
09:03:41.275507568 -0500=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mbox.c=0A=
- * Version	: v2.20.4.5 (Feb 03 2005)=0A=
+ * Version	: v2.20.4.6 (Mar 07 2005)=0A=
  *=0A=
  * Authors:=0A=
  * 	Atul Mukker		<Atul.Mukker@lsil.com>=0A=
@@ -202,7 +202,7 @@=0A=
  * ### global data ###=0A=
  */=0A=
 static uint8_t megaraid_mbox_version[8] =3D=0A=
-	{ 0x02, 0x20, 0x04, 0x05, 2, 3, 20, 5 };=0A=
+	{ 0x02, 0x20, 0x04, 0x06, 3, 7, 20, 5 };=0A=
 =0A=
 =0A=
 /*=0A=
@@ -229,9 +229,9 @@=0A=
 	},=0A=
 	{=0A=
 		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_PERC4_QC,=0A=
-		PCI_VENDOR_ID_DELL,=0A=
-		PCI_SUBSYS_ID_PERC4_QC,=0A=
+		PCI_DEVICE_ID_VERDE,=0A=
+		PCI_ANY_ID,=0A=
+		PCI_ANY_ID,=0A=
 	},=0A=
 	{=0A=
 		PCI_VENDOR_ID_DELL,=0A=
@@ -271,15 +271,9 @@=0A=
 	},=0A=
 	{=0A=
 		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_PERC4E_DC_320_2E,=0A=
-		PCI_VENDOR_ID_DELL,=0A=
-		PCI_SUBSYS_ID_PERC4E_DC_320_2E,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_PERC4E_SC_320_1E,=0A=
-		PCI_VENDOR_ID_DELL,=0A=
-		PCI_SUBSYS_ID_PERC4E_SC_320_1E,=0A=
+		PCI_DEVICE_ID_DOBSON,=0A=
+		PCI_ANY_ID,=0A=
+		PCI_ANY_ID,=0A=
 	},=0A=
 	{=0A=
 		PCI_VENDOR_ID_AMI,=0A=
@@ -331,36 +325,6 @@=0A=
 	},=0A=
 	{=0A=
 		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_0x,=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_0x,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_2x,=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_2x,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_4x,=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_4x,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_1E,=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_1E,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_2E,=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_2E,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
 		PCI_DEVICE_ID_MEGARAID_I4_133_RAID,=0A=
 		PCI_VENDOR_ID_LSI_LOGIC,=0A=
 		PCI_SUBSYS_ID_MEGARAID_I4_133_RAID,=0A=
@@ -379,21 +343,9 @@=0A=
 	},=0A=
 	{=0A=
 		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_MEGARAID_SATA_300_4x,=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_SUBSYS_ID_MEGARAID_SATA_300_4x,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_MEGARAID_SATA_300_8x,=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_SUBSYS_ID_MEGARAID_SATA_300_8x,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_INTEL_RAID_SRCU42X,=0A=
-		PCI_VENDOR_ID_INTEL,=0A=
-		PCI_SUBSYS_ID_INTEL_RAID_SRCU42X,=0A=
+		PCI_DEVICE_ID_LINDSAY,=0A=
+		PCI_ANY_ID,=0A=
+		PCI_ANY_ID,=0A=
 	},=0A=
 	{=0A=
 		PCI_VENDOR_ID_LSI_LOGIC,=0A=
@@ -403,58 +355,10 @@=0A=
 	},=0A=
 	{=0A=
 		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_INTEL_RAID_SRCU42E,=0A=
-		PCI_VENDOR_ID_INTEL,=0A=
-		PCI_SUBSYS_ID_INTEL_RAID_SRCU42E,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_INTEL_RAID_SRCZCRX,=0A=
-		PCI_VENDOR_ID_INTEL,=0A=
-		PCI_SUBSYS_ID_INTEL_RAID_SRCZCRX,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_INTEL_RAID_SRCS28X,=0A=
-		PCI_VENDOR_ID_INTEL,=0A=
-		PCI_SUBSYS_ID_INTEL_RAID_SRCS28X,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_INTEL_RAID_SROMBU42E_ALIEF,=0A=
-		PCI_VENDOR_ID_INTEL,=0A=
-		PCI_SUBSYS_ID_INTEL_RAID_SROMBU42E_ALIEF,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_INTEL_RAID_SROMBU42E_HARWICH,=0A=
-		PCI_VENDOR_ID_INTEL,=0A=
-		PCI_SUBSYS_ID_INTEL_RAID_SROMBU42E_HARWICH,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
 		PCI_DEVICE_ID_INTEL_RAID_SRCU41L_LAKE_SHETEK,=0A=
 		PCI_VENDOR_ID_INTEL,=0A=
 		PCI_SUBSYS_ID_INTEL_RAID_SRCU41L_LAKE_SHETEK,=0A=
 	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_FSC_MEGARAID_PCI_EXPRESS_ROMB,=0A=
-		PCI_SUBSYS_ID_FSC,=0A=
-		PCI_SUBSYS_ID_FSC_MEGARAID_PCI_EXPRESS_ROMB,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_MEGARAID_ACER_ROMB_2E,=0A=
-		PCI_VENDOR_ID_AI,=0A=
-		PCI_SUBSYS_ID_MEGARAID_ACER_ROMB_2E,=0A=
-	},=0A=
-	{=0A=
-		PCI_VENDOR_ID_LSI_LOGIC,=0A=
-		PCI_DEVICE_ID_MEGARAID_NEC_ROMB_2E,=0A=
-		PCI_VENDOR_ID_NEC,=0A=
-		PCI_SUBSYS_ID_MEGARAID_NEC_ROMB_2E,=0A=
-	},=0A=
 	{0}	/* Terminating entry */=0A=
 };=0A=
 MODULE_DEVICE_TABLE(pci, pci_id_table_g);=0A=
@@ -539,7 +443,8 @@=0A=
 =0A=
 =0A=
 	// register as a PCI hot-plug driver module=0A=
-	if ((rval =3D pci_module_init(&megaraid_pci_driver_g))) {=0A=
+	rval =3D pci_register_driver(&megaraid_pci_driver_g);=0A=
+	if (rval < 0) {=0A=
 		con_log(CL_ANN, (KERN_WARNING=0A=
 			"megaraid: could not register hotplug support.\n"));=0A=
 	}=0A=
@@ -619,7 +524,7 @@=0A=
 =0A=
 	// Setup the default DMA mask. This would be changed later on=0A=
 	// depending on hardware capabilities=0A=
-	if (pci_set_dma_mask(adapter->pdev, 0xFFFFFFFF) !=3D 0) {=0A=
+	if (pci_set_dma_mask(adapter->pdev, DMA_32BIT_MASK) !=3D 0) {=0A=
 =0A=
 		con_log(CL_ANN, (KERN_WARNING=0A=
 			"megaraid: pci_set_dma_mask failed:%d\n", __LINE__));=0A=
@@ -1031,7 +936,7 @@=0A=
 =0A=
 	// Set the DMA mask to 64-bit. All supported controllers as capable =
of=0A=
 	// DMA in this range=0A=
-	if (pci_set_dma_mask(adapter->pdev, 0xFFFFFFFFFFFFFFFFULL) !=3D 0) =
{=0A=
+	if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK) !=3D 0) {=0A=
 =0A=
 		con_log(CL_ANN, (KERN_WARNING=0A=
 			"megaraid: could not set DMA mask for 64-bit.\n"));=0A=
diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.h =
new/drivers/scsi/megaraid/megaraid_mbox.h=0A=
--- old/drivers/scsi/megaraid/megaraid_mbox.h	2005-03-17 =
08:37:00.110921584 -0500=0A=
+++ new/drivers/scsi/megaraid/megaraid_mbox.h	2005-03-17 =
07:16:21.183550360 -0500=0A=
@@ -21,8 +21,8 @@=0A=
 #include "megaraid_ioctl.h"=0A=
 =0A=
 =0A=
-#define MEGARAID_VERSION	"2.20.4.5"=0A=
-#define MEGARAID_EXT_VERSION	"(Release Date: Thu Feb 03 12:27:22 EST =
2005)"=0A=
+#define MEGARAID_VERSION	"2.20.4.6"=0A=
+#define MEGARAID_EXT_VERSION	"(Release Date: Mon Mar 07 12:27:22 EST =
2005)"=0A=
 =0A=
 =0A=
 /*=0A=
@@ -37,8 +37,7 @@=0A=
 #define PCI_DEVICE_ID_PERC4_DC				0x1960=0A=
 #define PCI_SUBSYS_ID_PERC4_DC				0x0518=0A=
 =0A=
-#define PCI_DEVICE_ID_PERC4_QC				0x0407=0A=
-#define PCI_SUBSYS_ID_PERC4_QC				0x0531=0A=
+#define PCI_DEVICE_ID_VERDE				0x0407=0A=
 =0A=
 #define PCI_DEVICE_ID_PERC4_DI_EVERGLADES		0x000F=0A=
 #define PCI_SUBSYS_ID_PERC4_DI_EVERGLADES		0x014A=0A=
@@ -58,11 +57,7 @@=0A=
 #define PCI_DEVICE_ID_PERC4E_DI_GUADALUPE		0x0013=0A=
 #define PCI_SUBSYS_ID_PERC4E_DI_GUADALUPE		0x0170=0A=
 =0A=
-#define PCI_DEVICE_ID_PERC4E_DC_320_2E			0x0408=0A=
-#define PCI_SUBSYS_ID_PERC4E_DC_320_2E			0x0002=0A=
-=0A=
-#define PCI_DEVICE_ID_PERC4E_SC_320_1E			0x0408=0A=
-#define PCI_SUBSYS_ID_PERC4E_SC_320_1E			0x0001=0A=
+#define PCI_DEVICE_ID_DOBSON				0x0408=0A=
 =0A=
 #define PCI_DEVICE_ID_MEGARAID_SCSI_320_0		0x1960=0A=
 #define PCI_SUBSYS_ID_MEGARAID_SCSI_320_0		0xA520=0A=
@@ -73,21 +68,6 @@=0A=
 #define PCI_DEVICE_ID_MEGARAID_SCSI_320_2		0x1960=0A=
 #define PCI_SUBSYS_ID_MEGARAID_SCSI_320_2		0x0518=0A=
 =0A=
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_0x		0x0407=0A=
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_0x		0x0530=0A=
-=0A=
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_2x		0x0407=0A=
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_2x		0x0532=0A=
-=0A=
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_4x		0x0407=0A=
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_4x		0x0531=0A=
-=0A=
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_1E		0x0408=0A=
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_1E		0x0001=0A=
-=0A=
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_2E		0x0408=0A=
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_2E		0x0002=0A=
-=0A=
 #define PCI_DEVICE_ID_MEGARAID_I4_133_RAID		0x1960=0A=
 #define PCI_SUBSYS_ID_MEGARAID_I4_133_RAID		0x0522=0A=
 =0A=
@@ -97,52 +77,18 @@=0A=
 #define PCI_DEVICE_ID_MEGARAID_SATA_150_6		0x1960=0A=
 #define PCI_SUBSYS_ID_MEGARAID_SATA_150_6		0x0523=0A=
 =0A=
-#define PCI_DEVICE_ID_MEGARAID_SATA_300_4x		0x0409=0A=
-#define PCI_SUBSYS_ID_MEGARAID_SATA_300_4x		0x3004=0A=
-=0A=
-#define PCI_DEVICE_ID_MEGARAID_SATA_300_8x		0x0409=0A=
-#define PCI_SUBSYS_ID_MEGARAID_SATA_300_8x		0x3008=0A=
-=0A=
-#define PCI_DEVICE_ID_INTEL_RAID_SRCU42X		0x0407=0A=
-#define PCI_SUBSYS_ID_INTEL_RAID_SRCU42X		0x0532=0A=
+#define PCI_DEVICE_ID_LINDSAY				0x0409=0A=
 =0A=
 #define PCI_DEVICE_ID_INTEL_RAID_SRCS16			0x1960=0A=
 #define PCI_SUBSYS_ID_INTEL_RAID_SRCS16			0x0523=0A=
 =0A=
-#define PCI_DEVICE_ID_INTEL_RAID_SRCU42E		0x0408=0A=
-#define PCI_SUBSYS_ID_INTEL_RAID_SRCU42E		0x0002=0A=
-=0A=
-#define PCI_DEVICE_ID_INTEL_RAID_SRCZCRX		0x0407=0A=
-#define PCI_SUBSYS_ID_INTEL_RAID_SRCZCRX		0x0530=0A=
-=0A=
-#define PCI_DEVICE_ID_INTEL_RAID_SRCS28X		0x0409=0A=
-#define PCI_SUBSYS_ID_INTEL_RAID_SRCS28X		0x3008=0A=
-=0A=
-#define PCI_DEVICE_ID_INTEL_RAID_SROMBU42E_ALIEF	0x0408=0A=
-#define PCI_SUBSYS_ID_INTEL_RAID_SROMBU42E_ALIEF	0x3431=0A=
-=0A=
-#define PCI_DEVICE_ID_INTEL_RAID_SROMBU42E_HARWICH	0x0408=0A=
-#define PCI_SUBSYS_ID_INTEL_RAID_SROMBU42E_HARWICH	0x3499=0A=
-=0A=
 #define PCI_DEVICE_ID_INTEL_RAID_SRCU41L_LAKE_SHETEK	0x1960=0A=
 #define PCI_SUBSYS_ID_INTEL_RAID_SRCU41L_LAKE_SHETEK	0x0520=0A=
 =0A=
-#define PCI_DEVICE_ID_FSC_MEGARAID_PCI_EXPRESS_ROMB	0x0408=0A=
-#define PCI_SUBSYS_ID_FSC_MEGARAID_PCI_EXPRESS_ROMB	0x1065=0A=
-=0A=
-#define PCI_DEVICE_ID_MEGARAID_ACER_ROMB_2E		0x0408=0A=
-#define PCI_SUBSYS_ID_MEGARAID_ACER_ROMB_2E		0x004D=0A=
-=0A=
 #define PCI_SUBSYS_ID_PERC3_QC				0x0471=0A=
 #define PCI_SUBSYS_ID_PERC3_DC				0x0493=0A=
 #define PCI_SUBSYS_ID_PERC3_SC				0x0475=0A=
 =0A=
-#define PCI_DEVICE_ID_MEGARAID_NEC_ROMB_2E		0x0408=0A=
-#define PCI_SUBSYS_ID_MEGARAID_NEC_ROMB_2E		0x8287=0A=
-=0A=
-#ifndef PCI_SUBSYS_ID_FSC=0A=
-#define PCI_SUBSYS_ID_FSC				0x1734=0A=
-#endif=0A=
 =0A=
 #define MBOX_MAX_SCSI_CMDS	128	// number of cmds reserved for =
kernel=0A=
 #define MBOX_MAX_USER_CMDS	32	// number of cmds for applications=0A=
diff -Naur old/drivers/scsi/megaraid/megaraid_mm.c =
new/drivers/scsi/megaraid/megaraid_mm.c=0A=
--- old/drivers/scsi/megaraid/megaraid_mm.c	2005-03-17 =
08:37:00.147915960 -0500=0A=
+++ new/drivers/scsi/megaraid/megaraid_mm.c	2005-03-17 =
07:16:21.196548384 -0500=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mm.c=0A=
- * Version	: v2.20.2.5 (Jan 21 2005)=0A=
+ * Version	: v2.20.2.6 (Mar 7 2005)=0A=
  *=0A=
  * Common management module=0A=
  */=0A=
@@ -43,8 +43,7 @@=0A=
 static void mraid_mm_teardown_dma_pools(mraid_mmadp_t *);=0A=
 =0A=
 #ifdef CONFIG_COMPAT=0A=
-static int mraid_mm_compat_ioctl(unsigned int, unsigned int, unsigned =
long,=0A=
-		struct file *);=0A=
+static long mraid_mm_compat_ioctl(struct file *, unsigned int, =
unsigned long);=0A=
 #endif=0A=
 =0A=
 MODULE_AUTHOR("LSI Logic Corporation");=0A=
@@ -61,7 +60,7 @@=0A=
 EXPORT_SYMBOL(mraid_mm_adapter_app_handle);=0A=
 =0A=
 static int majorno;=0A=
-static uint32_t drvr_ver	=3D 0x02200201;=0A=
+static uint32_t drvr_ver	=3D 0x02200206;=0A=
 =0A=
 static int adapters_count_g;=0A=
 static struct list_head adapters_list_g;=0A=
@@ -69,9 +68,12 @@=0A=
 static wait_queue_head_t wait_q;=0A=
 =0A=
 static struct file_operations lsi_fops =3D {=0A=
-	.open	=3D mraid_mm_open,=0A=
-	.ioctl	=3D mraid_mm_ioctl,=0A=
-	.owner	=3D THIS_MODULE,=0A=
+	.open		=3D mraid_mm_open,=0A=
+	.ioctl		=3D mraid_mm_ioctl,=0A=
+#ifdef CONFIG_COMPAT=0A=
+	.compat_ioctl	=3D mraid_mm_compat_ioctl, =0A=
+#endif=0A=
+	.owner		=3D THIS_MODULE,=0A=
 };=0A=
 =0A=
 /**=0A=
@@ -1215,8 +1217,6 @@=0A=
 =0A=
 	INIT_LIST_HEAD(&adapters_list_g);=0A=
 =0A=
-	register_ioctl32_conversion(MEGAIOCCMD, mraid_mm_compat_ioctl);=0A=
-=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -1225,13 +1225,14 @@=0A=
  * mraid_mm_compat_ioctl	: 32bit to 64bit ioctl conversion routine=0A=
  */=0A=
 #ifdef CONFIG_COMPAT=0A=
-static int=0A=
-mraid_mm_compat_ioctl(unsigned int fd, unsigned int cmd,=0A=
-			unsigned long arg, struct file *filep)=0A=
+static long=0A=
+mraid_mm_compat_ioctl(struct file *filep, unsigned int cmd, unsigned =
long arg)=0A=
 {=0A=
-	struct inode *inode =3D filep->f_dentry->d_inode;=0A=
+	int err;=0A=
+=0A=
+	err =3D mraid_mm_ioctl(NULL, filep, cmd, arg);=0A=
 =0A=
-	return mraid_mm_ioctl(inode, filep, cmd, arg);=0A=
+	return err;=0A=
 }=0A=
 #endif=0A=
 =0A=
@@ -1244,7 +1245,6 @@=0A=
 	con_log(CL_DLEVEL1 , ("exiting common mod\n"));=0A=
 =0A=
 	unregister_chrdev(majorno, "megadev");=0A=
-	unregister_ioctl32_conversion(MEGAIOCCMD);=0A=
 }=0A=
 =0A=
 module_init(mraid_mm_init);=0A=
diff -Naur old/drivers/scsi/megaraid/megaraid_mm.h =
new/drivers/scsi/megaraid/megaraid_mm.h=0A=
--- old/drivers/scsi/megaraid/megaraid_mm.h	2005-03-17 =
08:37:00.147915960 -0500=0A=
+++ new/drivers/scsi/megaraid/megaraid_mm.h	2005-03-17 =
07:16:21.203547320 -0500=0A=
@@ -29,9 +29,9 @@=0A=
 #include "megaraid_ioctl.h"=0A=
 =0A=
 =0A=
-#define LSI_COMMON_MOD_VERSION	"2.20.2.5"=0A=
+#define LSI_COMMON_MOD_VERSION	"2.20.2.6"=0A=
 #define LSI_COMMON_MOD_EXT_VERSION	\=0A=
-		"(Release Date: Fri Jan 21 00:01:03 EST 2005)"=0A=
+		"(Release Date: Mon Mar 7 00:01:03 EST 2005)"=0A=
 =0A=
 =0A=
 #define LSI_DBGLVL			dbglevel=0A=

------_=_NextPart_000_01C52B11.25A75990--
