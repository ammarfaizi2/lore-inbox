Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVILPCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVILPCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVILPBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:01:36 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:28167 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751358AbVILPBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:01:17 -0400
Date: Mon, 12 Sep 2005 10:48:56 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       ayyappan.veeraiyan@intel.com, jgarzik@pobox.com, Jon_Wetzel@Dell.com
Subject: [patch 2.6.13 9/16] ixgb: support ETHTOOL_GPERMADDR
Message-ID: <09122005104856.32285@bilbo.tuxdriver.com>
In-Reply-To: <09122005104856.32220@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ETHTOOL_GPERMADDR to ixgb.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/ixgb/ixgb_ethtool.c |    1 +
 drivers/net/ixgb/ixgb_main.c    |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ixgb/ixgb_ethtool.c b/drivers/net/ixgb/ixgb_ethtool.c
--- a/drivers/net/ixgb/ixgb_ethtool.c
+++ b/drivers/net/ixgb/ixgb_ethtool.c
@@ -723,6 +723,7 @@ struct ethtool_ops ixgb_ethtool_ops = {
 	.phys_id = ixgb_phys_id,
 	.get_stats_count = ixgb_get_stats_count,
 	.get_ethtool_stats = ixgb_get_ethtool_stats,
+	.get_perm_addr = ethtool_op_get_perm_addr,
 };
 
 void ixgb_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
--- a/drivers/net/ixgb/ixgb_main.c
+++ b/drivers/net/ixgb/ixgb_main.c
@@ -460,8 +460,9 @@ ixgb_probe(struct pci_dev *pdev,
 	}
 
 	ixgb_get_ee_mac_addr(&adapter->hw, netdev->dev_addr);
+	memcpy(netdev->perm_addr, netdev->dev_addr, netdev->addr_len);
 
-	if(!is_valid_ether_addr(netdev->dev_addr)) {
+	if(!is_valid_ether_addr(netdev->perm_addr)) {
 		err = -EIO;
 		goto err_eeprom;
 	}
