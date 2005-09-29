Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVI2RDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVI2RDA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVI2RC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:02:59 -0400
Received: from ns1.coraid.com ([65.14.39.133]:41816 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932259AbVI2RC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:02:59 -0400
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.14-rc2] aoe [1/3]: explicitly set minimum packet length
 to ETH_ZLEN
From: "Ed L. Cashin" <ecashin@coraid.com>
Date: Thu, 29 Sep 2005 12:45:44 -0400
Message-ID: <87wtkzbz5z.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Explicitly set the minimum packet length to ETH_ZLEN and zero the
packet data.

diff -u 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c	2005-09-29 12:01:55.000000000 -0400
+++ 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c	2005-09-29 12:01:56.000000000 -0400
@@ -20,6 +20,9 @@
 {
 	struct sk_buff *skb;
 
+	if (len < ETH_ZLEN)
+		len = ETH_ZLEN;
+
 	skb = alloc_skb(len, GFP_ATOMIC);
 	if (skb) {
 		skb->nh.raw = skb->mac.raw = skb->data;
@@ -27,6 +30,7 @@
 		skb->protocol = __constant_htons(ETH_P_AOE);
 		skb->priority = 0;
 		skb_put(skb, len);
+		memset(skb->head, 0, len);
 		skb->next = skb->prev = NULL;
 
 		/* tell the network layer not to perform IP checksums


-- 
  Ed L. Cashin <ecashin@coraid.com>

