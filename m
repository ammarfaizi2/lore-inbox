Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVC0UpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVC0UpR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVC0UpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:45:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28944 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261551AbVC0Uox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:44:53 -0500
Date: Sun, 27 Mar 2005 22:44:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/pcmcia/nmclan_cs.c: fix a check after use
Message-ID: <20050327204447.GA4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

