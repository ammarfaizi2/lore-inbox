Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVILPAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVILPAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVILPAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:00:55 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:27655 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751377AbVILPAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:00:36 -0400
Date: Mon, 12 Sep 2005 10:48:56 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       jesse.brandeburg@intel.com, jgarzik@pobox.com, Jon_Wetzel@Dell.com
Subject: [patch 2.6.13 7/16] e100: support ETHTOOL_GPERMADDR
Message-ID: <09122005104856.32157@bilbo.tuxdriver.com>
In-Reply-To: <09122005104855.32092@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ETHTOOL_GPERMADDR to e100.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/e100.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/e100.c b/drivers/net/e100.c
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -2391,6 +2391,7 @@ static struct ethtool_ops e100_ethtool_o
 	.phys_id		= e100_phys_id,
 	.get_stats_count	= e100_get_stats_count,
 	.get_ethtool_stats	= e100_get_ethtool_stats,
+	.get_perm_addr		= ethtool_op_get_perm_addr,
 };
 
 static int e100_do_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
@@ -2541,7 +2542,8 @@ static int __devinit e100_probe(struct p
 	e100_phy_init(nic);
 
 	memcpy(netdev->dev_addr, nic->eeprom, ETH_ALEN);
-	if(!is_valid_ether_addr(netdev->dev_addr)) {
+	memcpy(netdev->perm_addr, nic->eeprom, ETH_ALEN);
+	if(!is_valid_ether_addr(netdev->perm_addr)) {
 		DPRINTK(PROBE, ERR, "Invalid MAC address from "
 			"EEPROM, aborting.\n");
 		err = -EAGAIN;
