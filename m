Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUIWW7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUIWW7B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUIWW5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:57:10 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:63903 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267410AbUIWW11
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:27:27 -0400
Date: Thu, 23 Sep 2004 15:28:31 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6.9-rc2-mm2] Change cyrix.c driver to use new pci_dev_present
Message-ID: <2770000.1095978511@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was able to compile this but not boot it as I dont have a cyrix processor.

Hanna 

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

diff -Nrup linux-2.6.9-rc2-mm2cln/arch/i386/kernel/cpu/cyrix.c linux-2.6.9-rc2-mm2patch/arch/i386/kernel/cpu/cyrix.c
--- linux-2.6.9-rc2-mm2cln/arch/i386/kernel/cpu/cyrix.c	2004-09-23 11:48:51.835616512 -0700
+++ linux-2.6.9-rc2-mm2patch/arch/i386/kernel/cpu/cyrix.c	2004-09-23 11:58:42.811774480 -0700
@@ -192,7 +192,7 @@ static void __init init_cyrix(struct cpu
 	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
 	char *buf = c->x86_model_id;
 	const char *p = NULL;
-	struct pci_dev *dev;
+	int ret = -1;
 
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
@@ -275,16 +275,12 @@ static void __init init_cyrix(struct cpu
 		/*
 		 *  The 5510/5520 companion chips have a funky PIT.
 		 */  
-		dev = pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510, NULL);
-		if (dev) {
-			pci_dev_put(dev);
+		ret = pci_dev_present(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510, NULL);
+		if (ret) 
 			pit_latch_buggy = 1;
-		}
-		dev =  pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, NULL);
-		if (dev) {
-			pci_dev_put(dev);
+		ret =  pci_dev_present(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, NULL);
+		if (ret) 
 			pit_latch_buggy = 1;
-		}
 
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {

