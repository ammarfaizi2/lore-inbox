Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbVILPF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbVILPF2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVILPF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:05:27 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:21255 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751328AbVILO61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:58:27 -0400
Date: Mon, 12 Sep 2005 10:48:57 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: romieu@fr.zoreil.com, jgarzik@pobox.com, Jon_Wetzel@Dell.com
Subject: [patch 2.6.13 12/16] r8169: support ETHTOOL_GPERMADDR
Message-ID: <09122005104857.32477@bilbo.tuxdriver.com>
In-Reply-To: <09122005104857.32412@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ETHTOOL_GPERMADDR to r8169.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/r8169.c |    2 ++
 1 files changed, 2 insertions(+)

diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -1028,6 +1028,7 @@ static struct ethtool_ops rtl8169_ethtoo
 	.get_strings		= rtl8169_get_strings,
 	.get_stats_count	= rtl8169_get_stats_count,
 	.get_ethtool_stats	= rtl8169_get_ethtool_stats,
+	.get_perm_addr		= ethtool_op_get_perm_addr,
 };
 
 static void rtl8169_write_gmii_reg_bit(void __iomem *ioaddr, int reg, int bitnum,
@@ -1512,6 +1513,7 @@ rtl8169_init_one(struct pci_dev *pdev, c
 	/* Get MAC address.  FIXME: read EEPROM */
 	for (i = 0; i < MAC_ADDR_LEN; i++)
 		dev->dev_addr[i] = RTL_R8(MAC0 + i);
+	memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 
 	dev->open = rtl8169_open;
 	dev->hard_start_xmit = rtl8169_start_xmit;
