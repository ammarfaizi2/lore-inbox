Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVCZTEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVCZTEa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 14:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVCZTE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 14:04:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52229 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261227AbVCZTEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 14:04:14 -0500
Date: Sat, 26 Mar 2005 20:04:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: tulip-users@lists.sourceforge.net, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/tulip/dmfe.c: remove a check after use
Message-ID: <20050326190412.GD3237@stusta.de>
References: <20050325010315.GL3966@stusta.de> <42437E53.5060708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42437E53.5060708@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 09:58:27PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >This patch fixes a check after use found by the Coverity checker.
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> >--- linux-2.6.12-rc1-mm1-full/drivers/net/tulip/dmfe.c.old	2005-03-23 
> >05:05:36.000000000 +0100
> >+++ linux-2.6.12-rc1-mm1-full/drivers/net/tulip/dmfe.c	2005-03-23 
> >05:06:00.000000000 +0100
> >@@ -736,20 +736,22 @@
> > 
> > static irqreturn_t dmfe_interrupt(int irq, void *dev_id, struct pt_regs 
> > *regs)
> > {
> > 	struct DEVICE *dev = dev_id;
> > 	struct dmfe_board_info *db = netdev_priv(dev);
> >-	unsigned long ioaddr = dev->base_addr;
> >+	unsigned long ioaddr;
> > 	unsigned long flags;
> > 
> > 	DMFE_DBUG(0, "dmfe_interrupt()", 0);
> > 
> > 	if (!dev) {
> > 		DMFE_DBUG(1, "dmfe_interrupt() without DEVICE arg", 0);
> > 		return IRQ_NONE;
> > 	}
> 
> I would prefer to remove the "if (!dev)" test, since it shouldn't ever 
> succeed.

Patch below.

> 	Jeff

cu
Adrian



<--  snip  -->


This patch removes a NULL check that was useles because it happened 
after the first dereference of the variable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm3-full/drivers/net/tulip/dmfe.c.old	2005-03-26 19:06:46.000000000 +0100
+++ linux-2.6.12-rc1-mm3-full/drivers/net/tulip/dmfe.c	2005-03-26 19:07:03.000000000 +0100
@@ -744,11 +744,6 @@
 
 	DMFE_DBUG(0, "dmfe_interrupt()", 0);
 
-	if (!dev) {
-		DMFE_DBUG(1, "dmfe_interrupt() without DEVICE arg", 0);
-		return IRQ_NONE;
-	}
-
 	spin_lock_irqsave(&db->lock, flags);
 
 	/* Got DM910X status */

