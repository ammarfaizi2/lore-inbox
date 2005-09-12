Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVILO7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVILO7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVILO7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:59:05 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:22279 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751319AbVILO6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:58:37 -0400
Date: Mon, 12 Sep 2005 10:48:54 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: akpm@osdl.org, jgarzik@pobox.com, Jon_Wetzel@Dell.com
Subject: [patch 2.6.13 1/16] 3c59x: support ETHTOOL_GPERMADDR
Message-ID: <09122005104854.31772@bilbo.tuxdriver.com>
In-Reply-To: <09122005104853.31717@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ETHTOOL_GPERMADDR to 3c59x.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/3c59x.c |    2 ++
 1 files changed, 2 insertions(+)

diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -1338,6 +1338,7 @@ static int __devinit vortex_probe1(struc
 		printk(" ***INVALID CHECKSUM %4.4x*** ", checksum);
 	for (i = 0; i < 3; i++)
 		((u16 *)dev->dev_addr)[i] = htons(eeprom[i + 10]);
+	memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 	if (print_info) {
 		for (i = 0; i < 6; i++)
 			printk("%c%2.2x", i ? ':' : ' ', dev->dev_addr[i]);
@@ -3047,6 +3048,7 @@ static struct ethtool_ops vortex_ethtool
 	.set_settings           = vortex_set_settings,
 	.get_link               = vortex_get_link,
 	.nway_reset             = vortex_nway_reset,
+	.get_perm_addr		= ethtool_op_get_perm_addr,
 };
 
 #ifdef CONFIG_PCI
