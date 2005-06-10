Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVFJO1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVFJO1S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 10:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVFJO1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 10:27:18 -0400
Received: from apollo.tuxdriver.com ([24.172.12.2]:9734 "EHLO
	apollo.tuxdriver.com") by vger.kernel.org with ESMTP
	id S261570AbVFJO1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 10:27:14 -0400
Date: Fri, 10 Jun 2005 10:27:02 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jgarzik@pobox.com
Subject: [patch 2.6.12-rc6] 3c59x: remove superfluous vortex_debug test from boomerang_start_xmit
Message-ID: <20050610142702.GC10449@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	akpm@osdl.org, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the superfluous test of "if (vortex_debug > 3)" inside the
"if (vortex_debug > 6)" clause early in boomerang_start_xmit.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
I stumbled across this while looking at something else...

 drivers/net/3c59x.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -2202,9 +2202,8 @@ boomerang_start_xmit(struct sk_buff *skb
 
 	if (vortex_debug > 6) {
 		printk(KERN_DEBUG "boomerang_start_xmit()\n");
-		if (vortex_debug > 3)
-			printk(KERN_DEBUG "%s: Trying to send a packet, Tx index %d.\n",
-				   dev->name, vp->cur_tx);
+		printk(KERN_DEBUG "%s: Trying to send a packet, Tx index %d.\n",
+			   dev->name, vp->cur_tx);
 	}
 
 	if (vp->cur_tx - vp->dirty_tx >= TX_RING_SIZE) {
-- 
John W. Linville
linville@tuxdriver.com
