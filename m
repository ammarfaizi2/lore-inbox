Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVCGWx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVCGWx0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVCGWwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:52:55 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:22737
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S261755AbVCGV0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:26:42 -0500
Date: Mon, 7 Mar 2005 13:26:35 -0800 (PST)
From: Christoph Lameter <christoph@graphe.net>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: [PATCH] remove last_rx update from loopback device
Message-ID: <Pine.LNX.4.58.0503071324260.8946@server.graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last_rx field in the loopback driver is updated on every xmit but
is not used otherwise. Accesses to ->last_rx cause unecessary traffic on the
interlink for NUMA systems which limits the performance of the loopback device.

The comment given at include/linux/netdevice.h says that last_rx may be
used for future network-power-down code, which is likely not relevant
for the loopback device (please let me know if it is otherwise ..).

Signed-off-by: Niraj Kumar <nirajk@calsoftinc.com>
Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <Shai@Scalex86.org>

--- linux-2.6.9.clean/drivers/net/loopback.c	2005-02-28 21:54:20.000000000 -0800
+++ linux-2.6.9.clean-loop/drivers/net/loopback.c	2005-03-03 22:59:34.068607608 -0800
@@ -144,8 +144,6 @@ static int loopback_xmit(struct sk_buff
 		return 0;
 	}

-	dev->last_rx = jiffies;
-
 	lb_stats = &per_cpu(loopback_stats, get_cpu());
 	lb_stats->rx_bytes += skb->len;
 	lb_stats->tx_bytes += skb->len;
