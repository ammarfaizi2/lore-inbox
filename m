Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269532AbUHZUJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269532AbUHZUJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269570AbUHZUIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:08:55 -0400
Received: from waste.org ([209.173.204.2]:56476 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269558AbUHZUCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:02:11 -0400
Date: Thu, 26 Aug 2004 15:01:53 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH 4/5] netpoll: increase NAPI budget
Message-ID: <20040826200153.GB31237@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Moyer <jmoyer@redhat.com>

Hi, Matt,

I've upped the poll budget to 16 and added a comment explaining why.  I
definitely ran into this problem when testing netdump.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Matt Mackall <mpm@selenic.com>

--- linux-2.6.7/net/core/netpoll.c.budget	2004-08-16 12:33:10.176533688 -0400
+++ linux-2.6.7/net/core/netpoll.c	2004-08-16 12:37:15.510237296 -0400
@@ -61,7 +61,13 @@ static int checksum_udp(struct sk_buff *
 
 void netpoll_poll(struct netpoll *np)
 {
-	int budget = 1;
+	/*
+	 * In cases where there is bi-directional communications, reading
+	 * only one message at a time can lead to packets being dropped by
+	 * the network adapter, forcing superfluous retries and possibly
+	 * timeouts.  Thus, we set our budget to a more reasonable value.
+	 */
+	int budget = 16;
 
 	if(!np->dev || !netif_running(np->dev) || !np->dev->poll_controller)
 		return;


-- 
Mathematics is the supreme nostalgia of our time.
