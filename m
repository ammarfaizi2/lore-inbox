Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbTLPXt0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264387AbTLPXt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:49:26 -0500
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:11013 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S264386AbTLPXtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:49:24 -0500
Date: Tue, 16 Dec 2003 17:50:25 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de, marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, mike.miller@hp.com, scott.benesh@hp.com
Subject: cciss updates for 2.4.24-pre1, 1 of 2
Message-ID: <Pine.LNX.4.58.0312161742220.30010@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under certain conditions if the cciss driver fails to load the pointer to
the hba may be null when trying to free the I/O memory. This patch fixes
that problem and removes a no longer valid comment.
This is #1 of 2 and should be applied first. Please consider this patch
for inclusion in the 2.4.24 kernel.

Thanks,
mikem
mike.miller@hp.com
------------------------------------------------------------------------------
diff -burN lx2424pre1.orig/drivers/block/cciss.c lx2424pre1/drivers/block/cciss.c
--- lx2424pre1.orig/drivers/block/cciss.c	2003-11-28 12:26:19.000000000 -0600
+++ lx2424pre1/drivers/block/cciss.c	2003-12-16 17:25:50.000000000 -0600
@@ -2612,7 +2612,6 @@

 	/* get the address index number */
 	cfg_base_addr = readl(c->vaddr + SA5_CTCFG_OFFSET);
-	/* I am not prepared to deal with a 64 bit address value */
 	cfg_base_addr &= (__u32) 0x0000ffff;
 #ifdef CCISS_DEBUG
 	printk("cfg base address = %x\n", cfg_base_addr);
@@ -2624,7 +2623,7 @@
 #endif /* CCISS_DEBUG */
 	if (cfg_base_addr_index == -1) {
 		printk(KERN_WARNING "cciss: Cannot find cfg_base_addr_index\n");
-		release_io_mem(hba[i]);
+		release_io_mem(c);
 		return -1;
 	}

-------------------------------------------------------------------------------
