Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVDMCZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVDMCZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVDMCWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:22:52 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31761 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263056AbVDMCRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 22:17:37 -0400
Date: Wed, 13 Apr 2005 04:17:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/pcmcia/nmclan_cs.c: fix a check after use
Message-ID: <20050413021734.GQ3631@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 27 Mar 2005

--- linux-2.6.12-rc1-mm1-full/drivers/net/pcmcia/nmclan_cs.c.old	2005-03-23 05:04:00.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/net/pcmcia/nmclan_cs.c	2005-03-23 05:04:30.000000000 +0100
@@ -1090,20 +1090,22 @@
 ---------------------------------------------------------------------------- */
 static irqreturn_t mace_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
   struct net_device *dev = (struct net_device *) dev_id;
   mace_private *lp = netdev_priv(dev);
-  kio_addr_t ioaddr = dev->base_addr;
+  kio_addr_t ioaddr;
   int status;
   int IntrCnt = MACE_MAX_IR_ITERATIONS;
 
   if (dev == NULL) {
     DEBUG(2, "mace_interrupt(): irq 0x%X for unknown device.\n",
 	  irq);
     return IRQ_NONE;
   }
 
+  ioaddr = dev->base_addr;
+
   if (lp->tx_irq_disabled) {
     printk(
       (lp->tx_irq_disabled?
        KERN_NOTICE "%s: Interrupt with tx_irq_disabled "
        "[isr=%02X, imr=%02X]\n": 

