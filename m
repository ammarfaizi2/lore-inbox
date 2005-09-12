Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbVILPGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVILPGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVILO6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:58:24 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:16135 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751328AbVILO57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:57:59 -0400
Date: Mon, 12 Sep 2005 10:48:56 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, Jon_Wetzel@Dell.com
Subject: [patch 2.6.13 8/16] forcedeth: support ETHTOOL_GPERMADDR
Message-ID: <09122005104856.32220@bilbo.tuxdriver.com>
In-Reply-To: <09122005104856.32157@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ETHTOOL_GPERMADDR to forcedeth.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/forcedeth.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -2065,6 +2065,7 @@ static struct ethtool_ops ops = {
 	.get_regs_len = nv_get_regs_len,
 	.get_regs = nv_get_regs,
 	.nway_reset = nv_nway_reset,
+	.get_perm_addr = ethtool_op_get_perm_addr,
 };
 
 static int nv_open(struct net_device *dev)
@@ -2377,8 +2378,9 @@ static int __devinit nv_probe(struct pci
 	dev->dev_addr[3] = (np->orig_mac[0] >> 16) & 0xff;
 	dev->dev_addr[4] = (np->orig_mac[0] >>  8) & 0xff;
 	dev->dev_addr[5] = (np->orig_mac[0] >>  0) & 0xff;
+	memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 
-	if (!is_valid_ether_addr(dev->dev_addr)) {
+	if (!is_valid_ether_addr(dev->perm_addr)) {
 		/*
 		 * Bad mac address. At least one bios sets the mac address
 		 * to 01:23:45:67:89:ab
