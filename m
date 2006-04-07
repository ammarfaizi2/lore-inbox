Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWDGFcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWDGFcw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWDGFcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:32:52 -0400
Received: from [151.97.230.9] ([151.97.230.9]:60336 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932266AbWDGFcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:32:51 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] kzalloc: use in alloc_netdev
Date: Fri, 07 Apr 2006 07:32:05 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060407053204.11316.44763.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Noticed this use, fixed it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 net/core/dev.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 434220d..dfb6299 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3100,12 +3100,11 @@ struct net_device *alloc_netdev(int size
 	alloc_size = (sizeof(*dev) + NETDEV_ALIGN_CONST) & ~NETDEV_ALIGN_CONST;
 	alloc_size += sizeof_priv + NETDEV_ALIGN_CONST;
 
-	p = kmalloc(alloc_size, GFP_KERNEL);
+	p = kzalloc(alloc_size, GFP_KERNEL);
 	if (!p) {
 		printk(KERN_ERR "alloc_dev: Unable to allocate device.\n");
 		return NULL;
 	}
-	memset(p, 0, alloc_size);
 
 	dev = (struct net_device *)
 		(((long)p + NETDEV_ALIGN_CONST) & ~NETDEV_ALIGN_CONST);
