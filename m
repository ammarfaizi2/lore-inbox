Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVAYLap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVAYLap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 06:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVAYLaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 06:30:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54278 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261905AbVAYL2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 06:28:08 -0500
Date: Tue, 25 Jan 2005 12:28:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, iss_storagedev@hp.com
Subject: [2.6 patch] drivers/block/cpqarray.c: small cleanups
Message-ID: <20050125112805.GI30909@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make cpqarray_pci_device_id static
- merge cpqarray_init_step2 into cpqarray_init and make it static

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/cpqarray.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

This patch was already sent on:
- 29 Nov 2004

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

