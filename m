Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVILPEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVILPEq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVILPED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:04:03 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:22023 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751350AbVILO6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:58:32 -0400
Date: Mon, 12 Sep 2005 10:48:55 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: mchan@broadcom.com, jgarzik@pobox.com, Jon_Wetzel@Dell.com
Subject: [patch 2.6.13 5/16] bnx2: support ETHTOOL_GPERMADDR
Message-ID: <09122005104855.32029@bilbo.tuxdriver.com>
In-Reply-To: <09122005104855.31965@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ETHTOOL_GPERMADDR to bnx2.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/bnx2.c |    2 ++
 1 files changed, 2 insertions(+)

diff --git a/drivers/net/bnx2.c b/drivers/net/bnx2.c
--- a/drivers/net/bnx2.c
+++ b/drivers/net/bnx2.c
@@ -5015,6 +5015,7 @@ static struct ethtool_ops bnx2_ethtool_o
 	.phys_id		= bnx2_phys_id,
 	.get_stats_count	= bnx2_get_stats_count,
 	.get_ethtool_stats	= bnx2_get_ethtool_stats,
+	.get_perm_addr		= ethtool_op_get_perm_addr,
 };
 
 /* Called with rtnl_lock */
@@ -5442,6 +5443,7 @@ bnx2_init_one(struct pci_dev *pdev, cons
 	pci_set_drvdata(pdev, dev);
 
 	memcpy(dev->dev_addr, bp->mac_addr, 6);
+	memcpy(dev->perm_addr, bp->mac_addr, 6);
 	bp->name = board_info[ent->driver_data].name,
 	printk(KERN_INFO "%s: %s (%c%d) PCI%s %s %dMHz found at mem %lx, "
 		"IRQ %d, ",
