Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVILPCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVILPCw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVILO7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:59:00 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:23303 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751356AbVILO6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:58:48 -0400
Date: Mon, 12 Sep 2005 10:48:57 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: shemminger@osdl.org, jgarzik@pobox.com, Jon_Wetzel@Dell.com
Subject: [patch 2.6.13 13/16] skge: support ETHTOOL_GPERMADDR
Message-ID: <09122005104857.32541@bilbo.tuxdriver.com>
In-Reply-To: <09122005104857.32477@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ETHTOOL_GPERMADDR to skge.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/skge.c |    2 ++
 1 files changed, 2 insertions(+)

diff --git a/drivers/net/skge.c b/drivers/net/skge.c
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -743,6 +743,7 @@ static struct ethtool_ops skge_ethtool_o
 	.phys_id	= skge_phys_id,
 	.get_stats_count = skge_get_stats_count,
 	.get_ethtool_stats = skge_get_ethtool_stats,
+	.get_perm_addr	= ethtool_op_get_perm_addr,
 };
 
 /*
@@ -3080,6 +3081,7 @@ static struct net_device *skge_devinit(s
 
 	/* read the mac address */
 	memcpy_fromio(dev->dev_addr, hw->regs + B2_MAC_1 + port*8, ETH_ALEN);
+	memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 
 	/* device is off until link detection */
 	netif_carrier_off(dev);
