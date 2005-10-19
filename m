Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVJSBh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVJSBh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVJSBh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:37:27 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:30227 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932394AbVJSBdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:33:00 -0400
Date: Tue, 18 Oct 2005 21:30:58 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, ctindel@users.sourceforge.net, fubar@us.ibm.com,
       bonding-devel@lists.sourceforge.net
Subject: [patch 2.6.14-rc4] bonding: cleanup comment for mode 1 IGMP xmit hack
Message-ID: <10182005213058.12091@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Expand comment explaining MAC address selection for replicated IGMP
frames transmitted in bonding mode 1 (active-backup).  Also, a small
whitespace cleanup.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/bonding/bond_main.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4242,8 +4242,8 @@ out:
 }
 
 static void bond_activebackup_xmit_copy(struct sk_buff *skb,
-                                         struct bonding *bond,
-                                         struct slave *slave)
+                                        struct bonding *bond,
+                                        struct slave *slave)
 {
 	struct sk_buff *skb2 = skb_copy(skb, GFP_ATOMIC);
 	struct ethhdr *eth_data;
@@ -4259,7 +4259,11 @@ static void bond_activebackup_xmit_copy(
 	skb2->mac.raw = (unsigned char *)skb2->data;
 	eth_data = eth_hdr(skb2);
 
-	/* Pick an appropriate source MAC address */
+	/* Pick an appropriate source MAC address
+	 *	-- use slave's perm MAC addr, unless used by bond
+	 *	-- otherwise, borrow active slave's perm MAC addr
+	 *	   since that will not be used
+	 */
 	hwaddr = slave->perm_hwaddr;
 	if (!memcmp(eth_data->h_source, hwaddr, ETH_ALEN))
 		hwaddr = bond->curr_active_slave->perm_hwaddr;
