Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVILPH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVILPH5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVILPHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:07:55 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:20743 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751335AbVILO6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:58:24 -0400
Date: Mon, 12 Sep 2005 10:48:57 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: tsbogend@alpha.franken.de, jgarzik@pobox.com, Jon_Wetzel@Dell.com
Subject: [patch 2.6.13 11/16] pcnet32: support ETHTOOL_GPERMADDR
Message-ID: <09122005104857.32412@bilbo.tuxdriver.com>
In-Reply-To: <09122005104857.32349@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ETHTOOL_GPERMADDR to pcnet32.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/pcnet32.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcnet32.c b/drivers/net/pcnet32.c
--- a/drivers/net/pcnet32.c
+++ b/drivers/net/pcnet32.c
@@ -957,6 +957,7 @@ static struct ethtool_ops pcnet32_ethtoo
     .phys_id		= pcnet32_phys_id,
     .get_regs_len	= pcnet32_get_regs_len,
     .get_regs		= pcnet32_get_regs,
+    .get_perm_addr	= ethtool_op_get_perm_addr,
 };
 
 /* only probes for non-PCI devices, the rest are handled by
@@ -1185,9 +1186,10 @@ pcnet32_probe1(unsigned long ioaddr, int
 	    memcpy(dev->dev_addr, promaddr, 6);
 	}
     }
+    memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 
     /* if the ethernet address is not valid, force to 00:00:00:00:00:00 */
-    if (!is_valid_ether_addr(dev->dev_addr))
+    if (!is_valid_ether_addr(dev->perm_addr))
 	memset(dev->dev_addr, 0, sizeof(dev->dev_addr));
 
     if (pcnet32_debug & NETIF_MSG_PROBE) {
