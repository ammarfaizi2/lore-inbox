Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267902AbTBVNfo>; Sat, 22 Feb 2003 08:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267901AbTBVNe1>; Sat, 22 Feb 2003 08:34:27 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:20131 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267900AbTBVNeS>; Sat, 22 Feb 2003 08:34:18 -0500
Date: Sat, 22 Feb 2003 14:43:46 +0100
From: malware@t-online.de (Malware)
Message-Id: <200302221343.h1MDhkF8029238@debian.malware.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sonic: Compile fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.757.40.3 -> 1.757.40.4
#	 drivers/net/sonic.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/22	malware@debian.malware.de	1.757.40.4
# sonic.c:
#   Fix: Commented out reference to dev->tbusy.
#   Fix: Use the interrupt save version of dev_kfree_skb{_irq} within the interrupt handler.
# --------------------------------------------
#
diff -Nru a/drivers/net/sonic.c b/drivers/net/sonic.c
--- a/drivers/net/sonic.c	Sat Feb 22 13:29:28 2003
+++ b/drivers/net/sonic.c	Sat Feb 22 13:29:28 2003
@@ -113,6 +113,7 @@
 	if (sonic_debug > 2)
 		printk("sonic_send_packet: skb=%p, dev=%p\n", skb, dev);
 
+#if 0
 	/* 
 	 * Block a timer-based transmit from overlapping.  This could better be
 	 * done with atomic_swap(1, dev->tbusy), but set_bit() works as well.
@@ -121,6 +122,7 @@
 		printk("%s: Transmitter access conflict.\n", dev->name);
 		return 1;
 	}
+#endif
 
 	/*
 	 * Map the packet data into the logical DMA address space
@@ -232,7 +234,7 @@
 
 			/* We must free the original skb */
 			if (lp->tx_skb[entry]) {
-				dev_kfree_skb(lp->tx_skb[entry]);
+				dev_kfree_skb_irq(lp->tx_skb[entry]);
 				lp->tx_skb[entry] = 0;
 			}
 			/* and the VDMA address */
