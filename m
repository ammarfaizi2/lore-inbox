Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbUK2M2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbUK2M2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbUK2M1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:27:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41490 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261699AbUK2M0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:26:32 -0500
Date: Mon, 29 Nov 2004 13:26:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org, iss_storagedev@hp.com
Subject: [2.6 patch] drivers/block/cpqarray.c: small cleanups
Message-ID: <20041129122630.GH9722@stusta.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125101220.GC29539@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following cleanups:
- make cpqarray_pci_device_id static
- merge cpqarray_init_step2 into cpqarray_init and make it static


 drivers/block/cpqarray.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/block/cpqarray.c.old	2004-11-06 19:51:42.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/cpqarray.c	2004-11-06 19:53:16.000000000 +0100
@@ -97,7 +97,7 @@
 };
 
 /* define the PCI info for the PCI cards this driver can control */
-const struct pci_device_id cpqarray_pci_device_id[] =
+static const struct pci_device_id cpqarray_pci_device_id[] =
 {
 	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_COMPAQ_42XX,
 		0x0E11, 0x4058, 0, 0, 0},       /* SA431 */
@@ -135,7 +135,6 @@
 /* Debug Extra Paranoid... */
 #define DBGPX(s) do { } while(0)
 
-int cpqarray_init_step2(void);
 static int cpqarray_pci_init(ctlr_info_t *c, struct pci_dev *pdev);
 static void __iomem *remap_pci_mem(ulong base, ulong size);
 static int cpqarray_eisa_detect(void);
@@ -312,14 +311,6 @@
 
 module_param_array(eisa, int, NULL, 0);
 
-/* This is a bit of a hack,
- * necessary to support both eisa and pci
- */
-int __init cpqarray_init(void)
-{
-	return (cpqarray_init_step2());
-}
-
 static void release_io_mem(ctlr_info_t *c)
 {
 	/* if IO mem was not protected do nothing */
@@ -560,7 +551,7 @@
  *  This is it.  Find all the controllers and register them.
  *  returns the number of block devices registered.
  */
-int __init cpqarray_init_step2(void)
+static int __init cpqarray_init(void)
 {
 	int num_cntlrs_reg = 0;
 	int i;

