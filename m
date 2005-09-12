Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbVILPC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVILPC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVILO66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:58:58 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:23815 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751359AbVILO6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:58:53 -0400
Date: Mon, 12 Sep 2005 10:48:58 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: mchan@broadcom.com, davem@davemloft.net, jgarzik@pobox.com,
       Jon_Wetzel@Dell.com
Subject: [patch 2.6.13 15/16] tg3: support ETHTOOL_GPERMADDR
Message-ID: <09122005104858.32669@bilbo.tuxdriver.com>
In-Reply-To: <09122005104858.32604@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ETHTOOL_GPERMADDR to tg3.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/tg3.c |    4 ++++
 1 files changed, 4 insertions(+)

diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c
+++ b/drivers/net/tg3.c
@@ -8303,6 +8303,7 @@ static struct ethtool_ops tg3_ethtool_op
 	.get_ethtool_stats	= tg3_get_ethtool_stats,
 	.get_coalesce		= tg3_get_coalesce,
 	.set_coalesce		= tg3_set_coalesce,
+	.get_perm_addr		= ethtool_op_get_perm_addr,
 };
 
 static void __devinit tg3_get_eeprom_size(struct tg3 *tp)
@@ -9781,6 +9782,7 @@ static int __devinit tg3_get_macaddr_spa
 		if (prom_getproplen(node, "local-mac-address") == 6) {
 			prom_getproperty(node, "local-mac-address",
 					 dev->dev_addr, 6);
+			memcpy(dev->perm_addr, dev->dev_addr, 6);
 			return 0;
 		}
 	}
@@ -9792,6 +9794,7 @@ static int __devinit tg3_get_default_mac
 	struct net_device *dev = tp->dev;
 
 	memcpy(dev->dev_addr, idprom->id_ethaddr, 6);
+	memcpy(dev->perm_addr, idprom->id_ethaddr, 6);
 	return 0;
 }
 #endif
@@ -9861,6 +9864,7 @@ static int __devinit tg3_get_device_addr
 #endif
 		return -EINVAL;
 	}
+	memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 	return 0;
 }
 
