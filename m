Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268688AbUILLkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268688AbUILLkC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUILLjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:39:04 -0400
Received: from aun.it.uu.se ([130.238.12.36]:65277 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268704AbUILLdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:33:14 -0400
Date: Sun, 12 Sep 2004 13:32:59 +0200 (MEST)
Message-Id: <200409121132.i8CBWxqK015266@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo@cyclades.com, shmulik.hen@intel.com
Subject: [PATCH][2.4.28-pre3] bonding "alb" driver gcc-3.4 fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a gcc-3.4 cast-as-lvalue warning in the 2.4.28-pre3
kernel's ethernet bonding "alb" driver. The change is a backport
from the 2.6 kernel.

/Mikael

--- linux-2.4.28-pre3/drivers/net/bonding/bond_alb.c.~1~	2004-04-14 20:22:20.000000000 +0200
+++ linux-2.4.28-pre3/drivers/net/bonding/bond_alb.c	2004-09-12 01:56:20.000000000 +0200
@@ -1275,7 +1275,7 @@
 int bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
 {
 	struct bonding *bond = bond_dev->priv;
-	struct ethhdr *eth_data = (struct ethhdr *)skb->mac.raw = skb->data;
+	struct ethhdr *eth_data;
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
 	struct slave *tx_slave = NULL;
 	static u32 ip_bcast = 0xffffffff;
@@ -1285,6 +1285,9 @@
 	u8 *hash_start = NULL;
 	int res = 1;
 
+	skb->mac.raw = (unsigned char *)skb->data;
+	eth_data = (struct ethhdr *)skb->data;
+
 	/* make sure that the curr_active_slave and the slaves list do
 	 * not change during tx
 	 */
