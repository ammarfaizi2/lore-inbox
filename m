Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVCOOIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVCOOIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVCOOIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:08:51 -0500
Received: from aun.it.uu.se ([130.238.12.36]:26860 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261247AbVCOOIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:08:45 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16950.60522.906648.922785@alkaid.it.uu.se>
Date: Tue, 15 Mar 2005 15:08:42 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.11] drivers/net/depca.c gcc4 fix
Cc: linux-net@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix

drivers/net/depca.c: In function 'load_packet':
drivers/net/depca.c:1829: warning: operation on 'i' may be undefined

warning from gcc4 in depca.c.

/Mikael

--- linux-2.6.11/drivers/net/depca.c.~1~	2005-03-02 19:24:16.000000000 +0100
+++ linux-2.6.11/drivers/net/depca.c	2005-03-15 14:36:49.000000000 +0100
@@ -1826,7 +1826,7 @@ static int load_packet(struct net_device
 
 		/* set up the buffer descriptors */
 		len = (skb->len < ETH_ZLEN) ? ETH_ZLEN : skb->len;
-		for (i = entry; i != end; i = (++i) & lp->txRingMask) {
+		for (i = entry; i != end; i = (i+1) & lp->txRingMask) {
 			/* clean out flags */
 			writel(readl(&lp->tx_ring[i].base) & ~T_FLAGS, &lp->tx_ring[i].base);
 			writew(0x0000, &lp->tx_ring[i].misc);	/* clears other error flags */
