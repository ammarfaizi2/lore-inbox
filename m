Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVILO6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVILO6Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVILO6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:58:23 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:17415 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751330AbVILO6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:58:05 -0400
Date: Mon, 12 Sep 2005 10:48:58 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, Jon_Wetzel@Dell.com
Subject: [patch 2.6.13 14/16] sundance: support ETHTOOL_GPERMADDR
Message-ID: <09122005104858.32604@bilbo.tuxdriver.com>
In-Reply-To: <09122005104857.32541@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ETHTOOL_GPERMADDR to sundance.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/sundance.c |    2 ++
 1 files changed, 2 insertions(+)

diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -549,6 +549,7 @@ static int __devinit sundance_probe1 (st
 	for (i = 0; i < 3; i++)
 		((u16 *)dev->dev_addr)[i] =
 			le16_to_cpu(eeprom_read(ioaddr, i + EEPROM_SA_OFFSET));
+	memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 
 	dev->base_addr = (unsigned long)ioaddr;
 	dev->irq = irq;
@@ -1619,6 +1620,7 @@ static struct ethtool_ops ethtool_ops = 
 	.get_link = get_link,
 	.get_msglevel = get_msglevel,
 	.set_msglevel = set_msglevel,
+	.get_perm_addr = ethtool_op_get_perm_addr,
 };
 
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
