Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267613AbUHMWHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267613AbUHMWHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUHMWHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:07:21 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:45585 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id S267613AbUHMWGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:06:54 -0400
Date: Fri, 13 Aug 2004 17:06:09 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [3/5] pci_dev->irq fix
Message-ID: <20040813220609.GC1016@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 3 of 5.
This patch changes our pdev->intr to an unsigned int to match the
declaration in pci.h. Also cleans up the usage.
Applies to 2.4.27. Please consider this for inclusion.

Thanks,
mikem
-----------------------------------------------------------------------------
diff -burNp lx2427-p002/drivers/block/cciss.c lx2427/drivers/block/cciss.c
--- lx2427-p002/drivers/block/cciss.c	2004-08-13 15:51:28.498087560 -0500
+++ lx2427/drivers/block/cciss.c	2004-08-13 15:49:37.062028416 -0500
@@ -2671,7 +2671,7 @@ static int find_PCI_BAR_index(struct pci
 static int cciss_pci_init(ctlr_info_t *c, struct pci_dev *pdev)
 {
 	ushort subsystem_vendor_id, subsystem_device_id, command;
-	unchar irq = pdev->irq, ready = 0;
+	int ready = 0;
 	__u32 board_id, scratchpad;
 	__u64 cfg_offset;
 	__u32 cfg_base_addr;
@@ -2727,11 +2727,11 @@ static int cciss_pci_init(ctlr_info_t *c
 
 #ifdef CCISS_DEBUG
 	printk("command = %x\n", command);
-	printk("irq = %x\n", irq);
+	printk("irq = %x\n", pdev->irq);
 	printk("board_id = %x\n", board_id);
 #endif /* CCISS_DEBUG */ 
 
-	c->intr = irq;
+	c->intr = pdev->irq;
 
 	/*
 	 * Memory base addr is first addr , the second points to the config
diff -burNp lx2427-p002/drivers/block/cciss.h lx2427/drivers/block/cciss.h
--- lx2427-p002/drivers/block/cciss.h	2004-02-18 07:36:31.000000000 -0600
+++ lx2427/drivers/block/cciss.h	2004-08-13 15:49:52.185729264 -0500
@@ -51,7 +51,7 @@ struct ctlr_info 
 	unsigned long io_mem_addr;
 	unsigned long io_mem_length;
 	CfgTable_struct *cfgtable;
-	int	intr;
+	unsigned int	intr;
 	int	interrupts_enabled;
 	int 	max_commands;
 	int	commands_outstanding;
