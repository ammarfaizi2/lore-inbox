Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWHHTfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWHHTfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWHHTfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:35:21 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:62162 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030243AbWHHTfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:35:13 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 08 Aug 2006 21:34:36 +0200
Message-Id: <20060808193436.1396.71141.sendpatchset@lappy>
In-Reply-To: <20060808193325.1396.58813.sendpatchset@lappy>
References: <20060808193325.1396.58813.sendpatchset@lappy>
Subject: [RFC][PATCH 7/9] UML eth driver conversion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update the driver to make use of the netdev_alloc_skb() API and the
NETIF_F_MEMALLOC feature.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>

---
 arch/um/drivers/net_kern.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.orig/arch/um/drivers/net_kern.c
+++ linux-2.6/arch/um/drivers/net_kern.c
@@ -43,7 +43,7 @@ static int uml_net_rx(struct net_device 
 	struct sk_buff *skb;
 
 	/* If we can't allocate memory, try again next round. */
-	skb = dev_alloc_skb(dev->mtu);
+	skb = netdev_alloc_skb(dev, dev->mtu);
 	if (skb == NULL) {
 		lp->stats.rx_dropped++;
 		return 0;
@@ -377,6 +377,7 @@ static int eth_configure(int n, void *in
 	dev->ethtool_ops = &uml_net_ethtool_ops;
 	dev->watchdog_timeo = (HZ >> 1);
 	dev->irq = UM_ETH_IRQ;
+	dev->features |= NETIF_F_MEMALLOC;
 
 	rtnl_lock();
 	err = register_netdevice(dev);
