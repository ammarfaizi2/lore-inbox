Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVBQUZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVBQUZc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVBQUZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:25:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32779 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261194AbVBQUZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:25:02 -0500
Date: Thu, 17 Feb 2005 21:24:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ctindel@users.sourceforge.net, fubar@us.ibm.com
Cc: bonding-devel@lists.sourceforge.net, jgarzik@pobox.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/bonding/: make 3 functions static
Message-ID: <20050217202459.GA6194@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes three needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/bonding/bond_3ad.c |    2 +-
 drivers/net/bonding/bond_3ad.h |    1 -
 drivers/net/bonding/bond_alb.c |    4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/bonding/bond_3ad.h.old	2005-02-16 15:23:23.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/bonding/bond_3ad.h	2005-02-16 15:23:29.000000000 +0100
@@ -290,7 +290,6 @@
 int  bond_3ad_bind_slave(struct slave *slave);
 void bond_3ad_unbind_slave(struct slave *slave);
 void bond_3ad_state_machine_handler(struct bonding *bond);
-void bond_3ad_rx_indication(struct lacpdu *lacpdu, struct slave *slave, u16 length);
 void bond_3ad_adapter_speed_changed(struct slave *slave);
 void bond_3ad_adapter_duplex_changed(struct slave *slave);
 void bond_3ad_handle_link_change(struct slave *slave, char link);
--- linux-2.6.11-rc3-mm2-full/drivers/net/bonding/bond_3ad.c.old	2005-02-16 15:23:37.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/bonding/bond_3ad.c	2005-02-16 15:23:45.000000000 +0100
@@ -2175,7 +2175,7 @@
  * received frames (loopback). Since only the payload is given to this
  * function, it check for loopback.
  */
-void bond_3ad_rx_indication(struct lacpdu *lacpdu, struct slave *slave, u16 length)
+static void bond_3ad_rx_indication(struct lacpdu *lacpdu, struct slave *slave, u16 length)
 {
 	struct port *port;
 
--- linux-2.6.11-rc3-mm2-full/drivers/net/bonding/bond_alb.c.old	2005-02-16 15:24:01.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/bonding/bond_alb.c	2005-02-16 15:24:21.000000000 +0100
@@ -275,7 +275,7 @@
 }
 
 /* Caller must hold bond lock for read */
-struct slave *tlb_choose_channel(struct bonding *bond, u32 hash_index, u32 skb_len)
+static struct slave *tlb_choose_channel(struct bonding *bond, u32 hash_index, u32 skb_len)
 {
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
 	struct tlb_client_info *hash_table;
@@ -627,7 +627,7 @@
 }
 
 /* Caller must hold both bond and ptr locks for read */
-struct slave *rlb_choose_channel(struct sk_buff *skb, struct bonding *bond)
+static struct slave *rlb_choose_channel(struct sk_buff *skb, struct bonding *bond)
 {
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
 	struct arp_pkt *arp = (struct arp_pkt *)skb->nh.raw;

