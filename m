Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVILPCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVILPCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVILPBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:01:34 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:28935 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751149AbVILPBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:01:23 -0400
Date: Mon, 12 Sep 2005 10:48:59 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: akpm@osdl.org, jgarzik@pobox.com
Subject: [patch 2.6.13 1/5] 3c59x: correct rx_dropped counting
Message-ID: <09122005104859.389@bilbo.tuxdriver.com>
In-Reply-To: <09122005104858.332@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only increment rx_dropped in case of lack of resources (i.e. not for
frames with errors).

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/3c59x.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -2598,8 +2598,8 @@ static int vortex_rx(struct net_device *
 			} else if (vortex_debug > 0)
 				printk(KERN_NOTICE "%s: No memory to allocate a sk_buff of "
 					   "size %d.\n", dev->name, pkt_len);
+			vp->stats.rx_dropped++;
 		}
-		vp->stats.rx_dropped++;
 		issue_and_wait(dev, RxDiscard);
 	}
 
