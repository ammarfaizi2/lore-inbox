Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWFNXLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWFNXLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWFNXLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:11:17 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:47566 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S965006AbWFNXLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:11:16 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Mike Miller <mike.miller@hp.com>
Subject: [PATCH 4/7] CCISS: use ARRAY_SIZE without intermediates
Date: Wed, 14 Jun 2006 17:10:57 -0600
User-Agent: KMail/1.8.3
Cc: iss_storagedev@hp.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <200606141707.27404.bjorn.helgaas@hp.com>
In-Reply-To: <200606141707.27404.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606141710.58041.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's easier to verify loop bounds if the array name is mentioned
the for() statement that steps through the array.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: rc5-mm3/drivers/block/cciss.c
===================================================================
--- rc5-mm3.orig/drivers/block/cciss.c	2006-06-14 15:15:28.000000000 -0600
+++ rc5-mm3/drivers/block/cciss.c	2006-06-14 15:16:13.000000000 -0600
@@ -104,8 +104,6 @@
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
 
-#define NR_PRODUCTS ARRAY_SIZE(products)
-
 /*  board_id = Subsystem Device ID & Vendor ID
  *  product = Marketing Name for the board
  *  access = Address of the struct of function pointers 
@@ -2831,14 +2829,14 @@
 	print_cfg_table(c->cfgtable);
 #endif /* CCISS_DEBUG */
 
-	for(i=0; i<NR_PRODUCTS; i++) {
+	for(i=0; i<ARRAY_SIZE(products); i++) {
 		if (board_id == products[i].board_id) {
 			c->product_name = products[i].product_name;
 			c->access = *(products[i].access);
 			break;
 		}
 	}
-	if (i == NR_PRODUCTS) {
+	if (i == ARRAY_SIZE(products)) {
 		printk(KERN_WARNING "cciss: Sorry, I don't know how"
 			" to access the Smart Array controller %08lx\n", 
 				(unsigned long)board_id);
