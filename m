Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268896AbUI2T52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268896AbUI2T52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 15:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268904AbUI2T52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 15:57:28 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:36550 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268896AbUI2T50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 15:57:26 -0400
Date: Wed, 29 Sep 2004 12:58:29 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, hannal@us.ibm.com, greg@kroah.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, andre@linux-ide.org
Subject: [PATCH 2.6.9-rc2-mm4 alim15x3.c] [3/8] Replace pci_find_device with pci_dev_present
Message-ID: <13230000.1096487909@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The dev returned from pci_find_device was not used so it can be replaced
with pci_dev_present. Has been compile tested.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

diff -Nrup linux-2.6.9-rc2-mm4cln/drivers/ide/pci/alim15x3.c linux-2.6.9-rc2-mm4-patch2/drivers/ide/pci/alim15x3.c
--- linux-2.6.9-rc2-mm4cln/drivers/ide/pci/alim15x3.c	2004-09-28 14:58:26.000000000 -0700
+++ linux-2.6.9-rc2-mm4-patch2/drivers/ide/pci/alim15x3.c	2004-09-29 12:43:49.472236824 -0700
@@ -874,9 +874,14 @@ static ide_pci_device_t ali15x3_chipset 
  
 static int __devinit alim15x3_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	static struct pci_device_id ati_rs100[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS100) },
+		{ },
+	};
+
 	ide_pci_device_t *d = &ali15x3_chipset;
 
-	if(pci_find_device(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS100, NULL))
+	if(pci_dev_present(ati_rs100))
 		printk(KERN_ERR "Warning: ATI Radeon IGP Northbridge is not yet fully tested.\n");
 
 #if defined(CONFIG_SPARC64)

