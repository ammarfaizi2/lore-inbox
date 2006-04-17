Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWDQQvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWDQQvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 12:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWDQQvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 12:51:44 -0400
Received: from fmr19.intel.com ([134.134.136.18]:11162 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751090AbWDQQvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 12:51:43 -0400
Date: Mon, 17 Apr 2006 09:51:20 -0700 (Pacific Daylight Time)
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: Willy TARREAU <willy@w.ods.org>, jgarzik@pobox.com
cc: jesse.brandeburg@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, rol@as2917.net
Subject: Re: [PATCH-2.6] e1000: fix media_type <-> phy_type thinko
In-Reply-To: <20060415110025.GA6266@w.ods.org>
Message-ID: <Pine.WNT.4.63.0604170912240.3848@jbrandeb-desk.amr.corp.intel.com>
References: <20060415110025.GA6266@w.ods.org>
ReplyTo: "Jesse Brandeburg" <jesse.brandeburg@intel.com>
X-X-Sender: jesse.brandeburg@intel.com@imap.glb.intel.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Apr 2006, Willy TARREAU wrote:
> Recent patch cb764326dff0ee51aca0d450e1a292de65661055 introduced
> a thinko in e1000_main.c : e1000_media_type_copper is compared
> to hw.phy_type instead of hw.media_type. Original patch proposed
> by Jesse Brandeburg was correct, but what has been merged is not.

Yes, this fix makes the code how it should have been.

Ack.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

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
