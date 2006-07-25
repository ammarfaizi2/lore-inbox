Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWGYWgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWGYWgs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWGYWgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:36:48 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:44437 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751539AbWGYWgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:36:47 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] CCISS: Don't print driver version until we actually find a device
Date: Tue, 25 Jul 2006 16:36:42 -0600
User-Agent: KMail/1.8.3
Cc: Mike Miller <mike.miller@hp.com>, iss_storagedev@hp.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607251636.42765.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we don't find any devices, we shouldn't print anything.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm2/drivers/block/cciss.c
===================================================================
--- work-mm2.orig/drivers/block/cciss.c	2006-07-20 16:27:34.000000000 -0600
+++ work-mm2/drivers/block/cciss.c	2006-07-25 16:16:27.000000000 -0600
@@ -3109,12 +3109,16 @@
 static int __devinit cciss_init_one(struct pci_dev *pdev,
 				    const struct pci_device_id *ent)
 {
+	static int cciss_version_printed = 0;
 	request_queue_t *q;
 	int i;
 	int j;
 	int rc;
 	int dac;
 
+	if (cciss_version_printed++ == 0)
+		printk(KERN_INFO DRIVER_NAME "\n");
+
 	i = alloc_cciss_hba();
 	if (i < 0)
 		return -1;
@@ -3370,9 +3374,6 @@
  */
 static int __init cciss_init(void)
 {
-	printk(KERN_INFO DRIVER_NAME "\n");
-
-	/* Register for our PCI devices */
 	return pci_register_driver(&cciss_pci_driver);
 }
 
