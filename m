Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTDVMI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 08:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTDVMI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 08:08:59 -0400
Received: from hera.cwi.nl ([192.16.191.8]:54462 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263082AbTDVMI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 08:08:57 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 22 Apr 2003 14:21:01 +0200 (MEST)
Message-Id: <UTC200304221221.h3MCL1H21969.aeb@smtp.cwi.nl>
To: jgarzik@pobox.com
Subject: [PATCH] warning fixes for flags in spin_lock_irqsave
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/net/epic100.c b/drivers/net/epic100.c
--- a/drivers/net/epic100.c	Sat Jan 18 23:54:29 2003
+++ b/drivers/net/epic100.c	Tue Apr 22 13:25:39 2003
@@ -973,7 +973,7 @@
 	struct epic_private *ep = dev->priv;
 	int entry, free_count;
 	u32 ctrl_word;
-	long flags;
+	unsigned long flags;
 	
 	if (skb->len < ETH_ZLEN) {
 		skb = skb_padto(skb, ETH_ZLEN);
@@ -1338,7 +1338,7 @@
 	} else if (dev->mc_count == 0) {
 		outl(0x0004, ioaddr + RxCtrl);
 		return;
-	} else {					/* Never executed, for now. */
+	} else {				/* Never executed, for now. */
 		struct dev_mc_list *mclist;
 
 		memset(mc_filter, 0, sizeof(mc_filter));
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/net/ns83820.c b/drivers/net/ns83820.c
--- a/drivers/net/ns83820.c	Sat Feb 15 20:41:57 2003
+++ b/drivers/net/ns83820.c	Tue Apr 22 13:14:45 2003
@@ -549,7 +549,7 @@
 static inline int rx_refill(struct ns83820 *dev, int gfp)
 {
 	unsigned i;
-	long flags = 0;
+	unsigned long flags = 0;
 
 	if (unlikely(nr_rx_empty(dev) <= 2))
 		return 0;
@@ -763,7 +763,7 @@
 static void ns83820_cleanup_rx(struct ns83820 *dev)
 {
 	unsigned i;
-	long flags;
+	unsigned long flags;
 
 	dprintk("ns83820_cleanup_rx(%p)\n", dev);
 
@@ -820,7 +820,7 @@
 	struct rx_info *info = &dev->rx_info;
 	unsigned next_rx;
 	u32 cmdsts, *desc;
-	long flags;
+	unsigned long flags;
 	int nr = 0;
 
 	dprintk("rx_irq(%p)\n", dev);
@@ -1396,7 +1396,7 @@
 {
 	struct ns83820 *dev = (struct ns83820 *)_dev;
         u32 tx_done_idx, *desc;
-	long flags;
+	unsigned long flags;
 
 	local_irq_save(flags);
 
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/net/sundance.c b/drivers/net/sundance.c
--- a/drivers/net/sundance.c	Sat Jan 18 23:54:39 2003
+++ b/drivers/net/sundance.c	Tue Apr 22 13:24:51 2003
@@ -951,7 +951,7 @@
 {
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
-	long flag;
+	unsigned long flag;
 	
 	netif_stop_queue(dev);
 	tasklet_disable(&np->tx_tasklet);
