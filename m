Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVIZQpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVIZQpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVIZQpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:45:43 -0400
Received: from ns1.coraid.com ([65.14.39.133]:16292 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932307AbVIZQpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:45:42 -0400
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.14-rc2] aoe [1/2]: explicitly set minimum packet length
 to ETH_ZLEN
From: "Ed L. Cashin" <ecashin@coraid.com>
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Sep 2005 12:43:57 -0400
Message-ID: <87oe6fhj8y.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Explicitly set the minimum packet length to ETH_ZLEN.

Index: 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c
===================================================================
--- 2.6.14-rc2-aoe.orig/drivers/block/aoe/aoecmd.c	2005-09-26 12:20:34.000000000 -0400
+++ 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c	2005-09-26 12:27:49.000000000 -0400
@@ -20,6 +20,9 @@
 {
 	struct sk_buff *skb;
 
+	if (len < ETH_ZLEN)
+		len = ETH_ZLEN;
+
 	skb = alloc_skb(len, GFP_ATOMIC);
 	if (skb) {
 		skb->nh.raw = skb->mac.raw = skb->data;


-- 
  Ed L. Cashin <ecashin@coraid.com>

