Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbUCPQvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbUCPQtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:49:47 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:28174 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S261851AbUCPQiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:38:09 -0500
Date: Tue, 16 Mar 2004 10:49:22 -0600
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: cpqarray patches for 2.6 [5 of 5]
Message-ID: <20040316164922.GF21377@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 5 of 5. Please apply patches in order. All patches have been tested against 2.6.5-rc1.

Thanks,
mikem
-------------------------------------------------------------------------------
   * Examines rc of pci_register_driver and returns


 drivers/block/cpqarray.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

--- linux-2.6.1/drivers/block/cpqarray.c~cpqarray_pci_register_rc	2004-02-11 18:12:19.457511024 -0600
+++ linux-2.6.1-root/drivers/block/cpqarray.c	2004-02-11 18:22:06.566256928 -0600
@@ -318,9 +318,7 @@ MODULE_PARM(eisa, "1-8i");
  */
 int __init cpqarray_init(void)
 {
-	if(cpqarray_init_step2() == 0) 	/* all the block dev num already used */
-		return -ENODEV;		/* or no controllers were found */
-	return 0;
+	return (cpqarray_init_step2());
 }
 
 static void release_io_mem(ctlr_info_t *c)
@@ -559,18 +557,21 @@ static struct pci_driver cpqarray_pci_dr
 };
 
 /*
- *  This is it.  Find all the controllers and register them.  I really hate
- *  stealing all these major device numbers.
+ *  This is it.  Find all the controllers and register them. 
  *  returns the number of block devices registered.
  */
 int __init cpqarray_init_step2(void)
 {
 	int num_cntlrs_reg = 0;
 	int i;
+	int rc = 0;
 
 	/* detect controllers */
 	printk(DRIVER_NAME "\n");
-	pci_register_driver(&cpqarray_pci_driver);
+/* TODO: If it's an eisa only system, will rc return negative? */
+	rc = pci_register_driver(&cpqarray_pci_driver);
+	if (rc < 0)
+		return rc;
 	cpqarray_eisa_detect();
 	
 	for (i=0; i < MAX_CTLR; i++) {

_
