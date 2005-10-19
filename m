Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVJSBdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVJSBdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVJSBdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:33:36 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:772 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932444AbVJSBdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:33:31 -0400
Date: Tue, 18 Oct 2005 21:31:01 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: [patch 2.6.14-rc3 1/3] sundance: remove if (1) { ... } block in sundance_probe1
Message-ID: <10182005213101.12750@bilbo.tuxdriver.com>
In-Reply-To: <10182005213101.12694@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an if (1) { ... } block in sundance_probe1.  Its purpose seems
to be only to allow for delaring some extra local variables.  But, it also
adds ugly indentation without adding any meaning to the code.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/sundance.c |   48 +++++++++++++++++++++++-------------------------
 1 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -518,6 +518,7 @@ static int __devinit sundance_probe1 (st
 #else
 	int bar = 1;
 #endif
+	int phy, phy_idx = 0;
 
 
 /* when built into the kernel, we only print version if device is found */
@@ -605,33 +606,30 @@ static int __devinit sundance_probe1 (st
 			printk("%2.2x:", dev->dev_addr[i]);
 	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], irq);
 
-	if (1) {
-		int phy, phy_idx = 0;
-		np->phys[0] = 1;		/* Default setting */
-		np->mii_preamble_required++;
-		for (phy = 1; phy < 32 && phy_idx < MII_CNT; phy++) {
-			int mii_status = mdio_read(dev, phy, MII_BMSR);
-			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
-				np->phys[phy_idx++] = phy;
-				np->mii_if.advertising = mdio_read(dev, phy, MII_ADVERTISE);
-				if ((mii_status & 0x0040) == 0)
-					np->mii_preamble_required++;
-				printk(KERN_INFO "%s: MII PHY found at address %d, status "
-					   "0x%4.4x advertising %4.4x.\n",
-					   dev->name, phy, mii_status, np->mii_if.advertising);
-			}
-		}
-		np->mii_preamble_required--;
-
-		if (phy_idx == 0) {
-			printk(KERN_INFO "%s: No MII transceiver found, aborting.  ASIC status %x\n",
-				   dev->name, ioread32(ioaddr + ASICCtrl));
-			goto err_out_unregister;
-		}
-
-		np->mii_if.phy_id = np->phys[0];
+	np->phys[0] = 1;		/* Default setting */
+	np->mii_preamble_required++;
+	for (phy = 1; phy < 32 && phy_idx < MII_CNT; phy++) {
+		int mii_status = mdio_read(dev, phy, MII_BMSR);
+		if (mii_status != 0xffff  &&  mii_status != 0x0000) {
+			np->phys[phy_idx++] = phy;
+			np->mii_if.advertising = mdio_read(dev, phy, MII_ADVERTISE);
+			if ((mii_status & 0x0040) == 0)
+				np->mii_preamble_required++;
+			printk(KERN_INFO "%s: MII PHY found at address %d, status "
+				   "0x%4.4x advertising %4.4x.\n",
+				   dev->name, phy, mii_status, np->mii_if.advertising);
+		}
+	}
+	np->mii_preamble_required--;
+
+	if (phy_idx == 0) {
+		printk(KERN_INFO "%s: No MII transceiver found, aborting.  ASIC status %x\n",
+			   dev->name, ioread32(ioaddr + ASICCtrl));
+		goto err_out_unregister;
 	}
 
+	np->mii_if.phy_id = np->phys[0];
+
 	/* Parse override configuration */
 	np->an_enable = 1;
 	if (card_idx < MAX_UNITS) {
