Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVILO5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVILO5j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVILO5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:57:38 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:13319 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751316AbVILO5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:57:37 -0400
Date: Mon, 12 Sep 2005 10:48:54 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, Jon_Wetzel@Dell.com
Subject: [patch 2.6.13 2/16] 8139cp: support ETHTOOL_GPERMADDR
Message-ID: <09122005104854.31837@bilbo.tuxdriver.com>
In-Reply-To: <09122005104854.31772@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ETHTOOL_GPERMADDR to 8139cp.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/8139cp.c |    2 ++
 1 files changed, 2 insertions(+)

diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -1575,6 +1575,7 @@ static struct ethtool_ops cp_ethtool_ops
 	.set_wol		= cp_set_wol,
 	.get_strings		= cp_get_strings,
 	.get_ethtool_stats	= cp_get_ethtool_stats,
+	.get_perm_addr		= ethtool_op_get_perm_addr,
 };
 
 static int cp_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
@@ -1773,6 +1774,7 @@ static int cp_init_one (struct pci_dev *
 	for (i = 0; i < 3; i++)
 		((u16 *) (dev->dev_addr))[i] =
 		    le16_to_cpu (read_eeprom (regs, i + 7, addr_len));
+	memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 
 	dev->open = cp_open;
 	dev->stop = cp_close;
