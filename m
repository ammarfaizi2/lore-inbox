Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWHGVET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWHGVET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWHGVET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:04:19 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35089 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932367AbWHGVES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:04:18 -0400
Date: Mon, 7 Aug 2006 23:04:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Michael Buesch <mb@bu3sch.de>,
       linville@tuxdriver.com, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC: -mm patch] bcm43xx_main.c: remove 3 functions
Message-ID: <20060807210415.GO3691@stusta.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes three no longer used functions (that are even 
generating gcc warnings).

This patch doesn't look right, but it is the result of 
58e5528ee464d38040b9489e10033c9387a10d56 in git-netdev...

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/bcm43xx/bcm43xx_main.c |   33 --------------------
 1 file changed, 33 deletions(-)

--- linux-2.6.18-rc3-mm2-full/drivers/net/wireless/bcm43xx/bcm43xx_main.c.old	2006-08-07 18:21:31.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-08-07 18:23:36.000000000 +0200
@@ -3194,39 +3194,6 @@
 	bcm43xx_clear_keys(bcm);
 }
 
-static int bcm43xx_rng_read(struct hwrng *rng, u32 *data)
-{
-	struct bcm43xx_private *bcm = (struct bcm43xx_private *)rng->priv;
-	unsigned long flags;
-
-	spin_lock_irqsave(&(bcm)->irq_lock, flags);
-	*data = bcm43xx_read16(bcm, BCM43xx_MMIO_RNG);
-	spin_unlock_irqrestore(&(bcm)->irq_lock, flags);
-
-	return (sizeof(u16));
-}
-
-static void bcm43xx_rng_exit(struct bcm43xx_private *bcm)
-{
-	hwrng_unregister(&bcm->rng);
-}
-
-static int bcm43xx_rng_init(struct bcm43xx_private *bcm)
-{
-	int err;
-
-	snprintf(bcm->rng_name, ARRAY_SIZE(bcm->rng_name),
-		 "%s_%s", KBUILD_MODNAME, bcm->net_dev->name);
-	bcm->rng.name = bcm->rng_name;
-	bcm->rng.data_read = bcm43xx_rng_read;
-	bcm->rng.priv = (unsigned long)bcm;
-	err = hwrng_register(&bcm->rng);
-	if (err)
-		printk(KERN_ERR PFX "RNG init failed (%d)\n", err);
-
-	return err;
-}
-
 static int bcm43xx_shutdown_all_wireless_cores(struct bcm43xx_private *bcm)
 {
 	int ret = 0;

