Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbWB0Wut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWB0Wut (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWB0Wus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:50:48 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:8321 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751787AbWB0Wur
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:50:47 -0500
Message-Id: <20060227223321.042696000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:04 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Bernard Pidoux <pidoux@ccr.jussieu.fr>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Horms <horms@verge.net.au>, wensong@linux-vs.org,
       netdev@vger.kernel.org, ja@ssi.bg,
       "David S. Miller" <davem@davemloft.net>,
       Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 04/39] [PATCH] [BRIDGE]: netfilter missing symbol has_bridge_parent
Content-Disposition: inline; filename=netfilter-missing-symbol.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

5dce971acf2ae20c80d5e9d1f6bbf17376870911 in Linus' tree,
otherwise known as bridge-netfilter-races-on-device-removal.patch in
2.5.15.4 removed has_bridge_parent, however this symbol is still
called with NETFILTER_DEBUG is enabled.

This patch uses the already seeded realoutdev value to detect if a parent
exists, and if so, the value of the parent.

Signed-Off-By: Horms <horms@verge.net.au>
Acked-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 net/bridge/br_netfilter.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15.4.orig/net/bridge/br_netfilter.c
+++ linux-2.6.15.4/net/bridge/br_netfilter.c
@@ -794,8 +794,8 @@ static unsigned int br_nf_post_routing(u
 print_error:
 	if (skb->dev != NULL) {
 		printk("[%s]", skb->dev->name);
-		if (has_bridge_parent(skb->dev))
-			printk("[%s]", bridge_parent(skb->dev)->name);
+		if (realoutdev)
+			printk("[%s]", realoutdev->name);
 	}
 	printk(" head:%p, raw:%p, data:%p\n", skb->head, skb->mac.raw,
 					      skb->data);

--
