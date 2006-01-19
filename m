Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161153AbWASShj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbWASShj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWASShj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:37:39 -0500
Received: from ns1.coraid.com ([65.14.39.133]:45223 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1030318AbWASShi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:37:38 -0500
Message-ID: <af4ea3ed437649839c3ef9d66d5705d4@coraid.com>
Date: Thu, 19 Jan 2006 12:37:24 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-git9] aoe [1/8]: zero packet data after skb allocation
From: "Ed L. Cashin" <ecashin@coraid.com>
Gcc: nnfolder:Mail/sent-200601
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These eight patches supercede the seven aoe patches sent on January
third for the 2.6.15-rc7 kernel.  A bug existed in the Jan. 3 set of
patches where the retransmit timer for an AoE device AoE timer could
be added twice.  That bug has been fixed in this set of patches.


Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Zero the data in new socket buffers to prevent leaking information.

diff -upr 2.6.15-git9-orig/drivers/block/aoe/aoecmd.c 2.6.15-git9-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.15-git9-orig/drivers/block/aoe/aoecmd.c	2006-01-18 13:22:49.000000000 -0500
+++ 2.6.15-git9-aoe/drivers/block/aoe/aoecmd.c	2006-01-18 13:48:53.000000000 -0500
@@ -28,6 +28,7 @@ new_skb(struct net_device *if_dev, ulong
 		skb->protocol = __constant_htons(ETH_P_AOE);
 		skb->priority = 0;
 		skb_put(skb, len);
+		memset(skb->head, 0, len);
 		skb->next = skb->prev = NULL;
 
 		/* tell the network layer not to perform IP checksums


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
