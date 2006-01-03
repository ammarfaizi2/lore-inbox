Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWACV3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWACV3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWACV3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:29:33 -0500
Received: from ns1.coraid.com ([65.14.39.133]:58057 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751483AbWACV33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:29:29 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-rc7] aoe [1/7]: zero packet data after skb allocation
From: "Ed L. Cashin" <ecashin@coraid.com>
Date: Tue, 03 Jan 2006 16:05:03 -0500
Message-ID: <87hd8l2fb4.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Zero the data in new socket buffers to prevent leaking information.

Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoecmd.c
===================================================================
--- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoecmd.c	2006-01-02 13:35:13.000000000 -0500
+++ 2.6.15-rc7-aoe/drivers/block/aoe/aoecmd.c	2006-01-02 13:35:13.000000000 -0500
@@ -28,6 +28,7 @@
 		skb->protocol = __constant_htons(ETH_P_AOE);
 		skb->priority = 0;
 		skb_put(skb, len);
+		memset(skb->head, 0, len);
 		skb->next = skb->prev = NULL;
 
 		/* tell the network layer not to perform IP checksums


-- 
  Ed L. Cashin <ecashin@coraid.com>

