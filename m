Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVCRDki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVCRDki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 22:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVCRDki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 22:40:38 -0500
Received: from mail0.lsil.com ([147.145.40.20]:60614 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261448AbVCRDjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 22:39:02 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703662772@exa-atlanta>
From: "Ju, Seokmann" <sju@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "Ju, Seokmann" <sju@lsil.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: RE: [ANNOUNCE][PATCH] drivers/scsi/megaraid/megaraid_{mm,mbox}
Date: Thu, 17 Mar 2005 22:38:43 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 17, 2005 12:28 PM, James wrote:
> This is still rejecting:
> 
> patching file drivers/scsi/megaraid/megaraid_mm.c
> Hunk #2 FAILED at 43.
> Hunk #4 FAILED at 68.
> Hunk #5 FAILED at 1217.
> Hunk #6 FAILED at 1225.
> Hunk #7 FAILED at 1245.
> 5 out of 7 hunks FAILED -- saving rejects to file
> drivers/scsi/megaraid/megaraid_mm.c.rej
Thank you for correction again.
At this time, I've download the source from
BK:/linux.bkbits.net:8080/linux-2.6 and found that the source already
includes 'compat_ioctl' support. Here, I'm sending another patch that has
fix for this issue.
I've verified (also, recreated above error with previous patch) this by
applying the patch to the source from BK.
I'm learning from your great comments and I appreciate your time on this.
Please let me know for any comment.

Thank you.

Sign-off-by: Seokmann Ju <sju@lsil.com>

---
diff -Naur BK/Documentation/scsi/ChangeLog.megaraid
new/Documentation/scsi/ChangeLog.megaraid
--- BK/Documentation/scsi/ChangeLog.megaraid	2005-03-17
18:06:38.115075184 -0500
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
diff -Naur BK/drivers/scsi/megaraid/mega_common.h
new/drivers/scsi/megaraid/mega_common.h
--- BK/drivers/scsi/megaraid/mega_common.h	2005-03-17
20:01:55.774431112 -0500
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
diff -Naur BK/drivers/scsi/megaraid/megaraid_mbox.c
new/drivers/scsi/megaraid/megaraid_mbox.c
--- BK/drivers/scsi/megaraid/megaraid_mbox.c	2005-03-17
20:01:55.782429896 -0500
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
diff -Naur BK/drivers/scsi/megaraid/megaraid_mbox.h
new/drivers/scsi/megaraid/megaraid_mbox.h
--- BK/drivers/scsi/megaraid/megaraid_mbox.h	2005-03-17
20:01:55.784429592 -0500
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
diff -Naur BK/drivers/scsi/megaraid/megaraid_mm.c
new/drivers/scsi/megaraid/megaraid_mm.c
--- BK/drivers/scsi/megaraid/megaraid_mm.c	2005-03-17
20:01:55.786429288 -0500
+++ new/drivers/scsi/megaraid/megaraid_mm.c	2005-03-17
20:22:56.684743608 -0500
@@ -10,13 +10,12 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mm.c
- * Version	: v2.20.2.5 (Jan 21 2005)
+ * Version	: v2.20.2.6 (Mar 7 2005)
  *
  * Common management module
  */
 
 #include "megaraid_mm.h"
-#include <linux/smp_lock.h>
 
 
 // Entry points for char node driver
@@ -61,7 +60,7 @@
 EXPORT_SYMBOL(mraid_mm_adapter_app_handle);
 
 static int majorno;
-static uint32_t drvr_ver	= 0x02200201;
+static uint32_t drvr_ver	= 0x02200206;
 
 static int adapters_count_g;
 static struct list_head adapters_list_g;
@@ -1231,9 +1230,9 @@
 		      unsigned long arg)
 {
 	int err;
-	lock_kernel();
+
 	err = mraid_mm_ioctl(NULL, filep, cmd, arg);
-	unlock_kernel();
+
 	return err;
 }
 #endif
diff -Naur BK/drivers/scsi/megaraid/megaraid_mm.h
new/drivers/scsi/megaraid/megaraid_mm.h
--- BK/drivers/scsi/megaraid/megaraid_mm.h	2005-03-17
20:01:55.786429288 -0500
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
