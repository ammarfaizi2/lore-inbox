Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278279AbRJMISt>; Sat, 13 Oct 2001 04:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278280AbRJMISk>; Sat, 13 Oct 2001 04:18:40 -0400
Received: from viper.haque.net ([66.88.179.82]:30082 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S278279AbRJMISY>;
	Sat, 13 Oct 2001 04:18:24 -0400
Message-ID: <3BC7F8F0.1ABF82A0@haque.net>
Date: Sat, 13 Oct 2001 04:18:56 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] i2o struct change updates 
Content-Type: multipart/mixed;
 boundary="------------1F82B0D9067C38235DD21823"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1F82B0D9067C38235DD21823
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

i2o struct change updates  to make i2o compile once again

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
--------------1F82B0D9067C38235DD21823
Content-Type: text/plain; charset=us-ascii;
 name="i2o-struct-2413p2-updates.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-struct-2413p2-updates.diff"

--- linux/drivers/i2o/i2o_pci.c.orig	Sun Aug 12 14:16:18 2001
+++ linux/drivers/i2o/i2o_pci.c	Sat Oct 13 04:02:57 2001
@@ -162,7 +162,7 @@
 	c->bus.pci.queue_buggy = 0;
 	c->bus.pci.dpt = 0;
 	c->bus.pci.short_req = 0;
-	c->bus.pci.pdev = dev;
+	c->pdev = dev;
 
 	c->irq_mask = (volatile u32 *)(mem+0x34);
 	c->post_port = (volatile u32 *)(mem+0x40);
--- linux/drivers/i2o/i2o_core.c.orig	Thu Aug 16 12:50:24 2001
+++ linux/drivers/i2o/i2o_core.c	Sat Oct 13 04:06:08 2001
@@ -1924,12 +1924,12 @@
 		if(iop->status_block->current_mem_size < iop->status_block->desired_mem_size)
 		{
 			struct resource *res = &iop->mem_resource;
-			res->name = iop->bus.pci.pdev->bus->name;
+			res->name = iop->pdev->bus->name;
 			res->flags = IORESOURCE_MEM;
 			res->start = 0;
 			res->end = 0;
 			printk("%s: requires private memory resources.\n", iop->name);
-			root = pci_find_parent_resource(iop->bus.pci.pdev, res);
+			root = pci_find_parent_resource(iop->pdev, res);
 			if(root==NULL)
 				printk("Can't find parent resource!\n");
 			if(root && allocate_resource(root, res, 
@@ -1950,12 +1950,12 @@
 		if(iop->status_block->current_io_size < iop->status_block->desired_io_size)
 		{
 			struct resource *res = &iop->io_resource;
-			res->name = iop->bus.pci.pdev->bus->name;
+			res->name = iop->pdev->bus->name;
 			res->flags = IORESOURCE_IO;
 			res->start = 0;
 			res->end = 0;
 			printk("%s: requires private memory resources.\n", iop->name);
-			root = pci_find_parent_resource(iop->bus.pci.pdev, res);
+			root = pci_find_parent_resource(iop->pdev, res);
 			if(root==NULL)
 				printk("Can't find parent resource!\n");
 			if(root &&  allocate_resource(root, res, 
--- linux/include/linux/i2o.h.orig	Sat Oct 13 03:40:03 2001
+++ linux/include/linux/i2o.h	Sat Oct 13 04:13:23 2001
@@ -30,6 +30,7 @@
 
 #include <asm/semaphore.h>	/* Needed for MUTEX init macros */
 #include <linux/config.h>
+#include <linux/ioport.h>
 #include <linux/notifier.h>
 #include <asm/atomic.h>
 
--- linux/drivers/i2o/i2o_block.c.orig	Mon Sep 10 15:42:31 2001
+++ linux/drivers/i2o/i2o_block.c	Sat Oct 13 04:15:18 2001
@@ -1989,7 +1989,6 @@
 
 void cleanup_module(void)
 {
-	struct gendisk *gdp;
 	int i;
 	
 	if(evt_running) {

--------------1F82B0D9067C38235DD21823--

