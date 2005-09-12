Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVILPDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVILPDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVILO6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:58:36 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:14343 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751317AbVILO5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:57:53 -0400
Date: Mon, 12 Sep 2005 10:48:55 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, Jon_Wetzel@Dell.com
Subject: [patch 2.6.13 4/16] b44: support ETHTOOL_GPERMADDR
Message-ID: <09122005104855.31965@bilbo.tuxdriver.com>
In-Reply-To: <09122005104855.31900@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ETHTOOL_GPERMADDR to b44.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/b44.c |    2 ++
 1 files changed, 2 insertions(+)

diff --git a/drivers/net/b44.c b/drivers/net/b44.c
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -1676,6 +1676,7 @@ static struct ethtool_ops b44_ethtool_op
 	.set_pauseparam		= b44_set_pauseparam,
 	.get_msglevel		= b44_get_msglevel,
 	.set_msglevel		= b44_set_msglevel,
+	.get_perm_addr		= ethtool_op_get_perm_addr,
 };
 
 static int b44_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
@@ -1718,6 +1719,7 @@ static int __devinit b44_get_invariants(
 	bp->dev->dev_addr[3] = eeprom[80];
 	bp->dev->dev_addr[4] = eeprom[83];
 	bp->dev->dev_addr[5] = eeprom[82];
+	memcpy(bp->dev->perm_addr, bp->dev->dev_addr, bp->dev->addr_len);
 
 	bp->phy_addr = eeprom[90] & 0x1f;
 
