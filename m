Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVCYBu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVCYBu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVCYBFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:05:01 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21777 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261335AbVCYBD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:03:27 -0500
Date: Fri, 25 Mar 2005 02:03:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: tulip-users@lists.sourceforge.net, jgarzik@pobox.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/tulip/dmfe.c: fix check after use
Message-ID: <20050325010315.GL3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/net/tulip/dmfe.c.old	2005-03-23 05:05:36.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/net/tulip/dmfe.c	2005-03-23 05:06:00.000000000 +0100
@@ -736,20 +736,22 @@
 
 static irqreturn_t dmfe_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct DEVICE *dev = dev_id;
 	struct dmfe_board_info *db = netdev_priv(dev);
-	unsigned long ioaddr = dev->base_addr;
+	unsigned long ioaddr;
 	unsigned long flags;
 
 	DMFE_DBUG(0, "dmfe_interrupt()", 0);
 
 	if (!dev) {
 		DMFE_DBUG(1, "dmfe_interrupt() without DEVICE arg", 0);
 		return IRQ_NONE;
 	}
 
+	ioaddr = dev->base_addr;
+
 	spin_lock_irqsave(&db->lock, flags);
 
 	/* Got DM910X status */
 	db->cr5_data = inl(ioaddr + DCR5);
 	outl(db->cr5_data, ioaddr + DCR5);

