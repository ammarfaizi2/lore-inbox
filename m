Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWDOLAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWDOLAe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 07:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWDOLAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 07:00:33 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:7177 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932483AbWDOLAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 07:00:32 -0400
Date: Sat, 15 Apr 2006 13:00:25 +0200
From: Willy TARREAU <willy@w.ods.org>
To: jesse.brandeburg@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Cc: rol@as2917.net
Subject: [PATCH-2.6] e1000: fix media_type <-> phy_type thinko
Message-ID: <20060415110025.GA6266@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recent patch cb764326dff0ee51aca0d450e1a292de65661055 introduced
a thinko in e1000_main.c : e1000_media_type_copper is compared
to hw.phy_type instead of hw.media_type. Original patch proposed
by Jesse Brandeburg was correct, but what has been merged is not.

---

 drivers/net/e1000/e1000_main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

3df8a180d50c89a72c28abf37151e38ffda75f39
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index add8dc4..590a456 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -4156,7 +4156,7 @@ e1000_mii_ioctl(struct net_device *netde
 			spin_unlock_irqrestore(&adapter->stats_lock, flags);
 			return -EIO;
 		}
-		if (adapter->hw.phy_type == e1000_media_type_copper) {
+		if (adapter->hw.media_type == e1000_media_type_copper) {
 			switch (data->reg_num) {
 			case PHY_CTRL:
 				if (mii_reg & MII_CR_POWER_DOWN)
-- 
1.2.4

