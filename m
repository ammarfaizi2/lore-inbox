Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUHDOVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUHDOVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 10:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUHDOVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 10:21:16 -0400
Received: from waste.org ([209.173.204.2]:33440 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266034AbUHDOU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 10:20:58 -0400
Date: Wed, 4 Aug 2004 09:20:49 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix netpoll cleanup on abort without dev
Message-ID: <20040804142049.GL16310@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If netpoll attempts to use a device without polling support, it will
oops when shutting down. This adds a check that we've actually
attached to a device.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: np/net/core/netpoll.c
===================================================================
--- np.orig/net/core/netpoll.c	2004-08-04 08:50:56.000000000 -0500
+++ np/net/core/netpoll.c	2004-08-04 09:02:50.000000000 -0500
@@ -614,7 +614,8 @@
 		spin_lock_irqsave(&rx_list_lock, flags);
 		list_del(&np->rx_list);
 #ifdef CONFIG_NETPOLL_RX
-		np->dev->netpoll_rx = 0;
+		if (np->dev)
+			np->dev->netpoll_rx = 0;
 #endif
 		spin_unlock_irqrestore(&rx_list_lock, flags);
 	}


-- 
Mathematics is the supreme nostalgia of our time.
