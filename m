Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWFIDuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWFIDuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 23:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWFIDuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 23:50:23 -0400
Received: from xenotime.net ([66.160.160.81]:61383 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965122AbWFIDuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 23:50:22 -0400
Date: Thu, 8 Jun 2006 20:41:02 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: axboe@suse.de, akpm <akpm@osdl.org>, iss_storagedev@hp.com
Subject: [PATCH] cpqarray: section fixups
Message-Id: <20060608204102.1c2cce56.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Priority: not critical.
Makes cpqarray_register_ctlr() __init.  Saves a little memory.

Fix section mismatch warning:
WARNING: drivers/block/cpqarray.o - Section mismatch: reference to .init.text: from .text between 'cpqarray_register_ctlr' (at offset 0x682) and 'alloc_cpqarray_hba'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/block/cpqarray.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2617-rc6.orig/drivers/block/cpqarray.c
+++ linux-2617-rc6/drivers/block/cpqarray.c
@@ -392,7 +392,7 @@ static void __devexit cpqarray_remove_on
 }
 
 /* pdev is NULL for eisa */
-static int cpqarray_register_ctlr( int i, struct pci_dev *pdev)
+static int __init cpqarray_register_ctlr( int i, struct pci_dev *pdev)
 {
 	request_queue_t *q;
 	int j;
@@ -745,7 +745,7 @@ __setup("smart2=", cpqarray_setup);
 /*
  * Find an EISA controller's signature.  Set up an hba if we find it.
  */
-static int cpqarray_eisa_detect(void)
+static int __init cpqarray_eisa_detect(void)
 {
 	int i=0, j;
 	__u32 board_id;


---
