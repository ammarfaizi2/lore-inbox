Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266282AbUANATE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbUANATD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:19:03 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:41192 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266282AbUANATA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:19:00 -0500
From: Jim Houston <jhouston@new.localdomain>
To: mpm@selenic.com
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, amitkale@emsyssoft.com
Subject: netpoll bug - kgdboe on x86_64
Message-Id: <20040114001830.60F5DC60FC@h00e098094f32.ne.client2.attbi.com>
Date: Tue, 13 Jan 2004 19:18:30 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matt,

I'm trying to get kgdboe working on x86_64.  I noticed that
netpoll_rx is calling the rx_hook with negative values for the length.
The attached patch fixes the problem. 

Jim Houston - Concurrent Computer Corp.

---

--- 2.6.1-rc1-mm2.orig/net/core/netpoll.c	2004-01-05 13:15:31.000000000 -0500
+++ 2.6.1-rc1-mm2/net/core/netpoll.c	2004-01-13 18:58:09.311479928 -0500
@@ -400,7 +400,7 @@ int netpoll_rx(struct sk_buff *skb)
 
 		if (np->rx_hook)
 			np->rx_hook(np, ntohs(uh->source),
-				    (char *)(uh+1), ulen-sizeof(uh)-4);
+				    (char *)(uh+1), ulen-sizeof(struct udphdr));
 
 		return 1;
 	}
