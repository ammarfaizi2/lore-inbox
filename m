Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947523AbWLHX76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947523AbWLHX76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 18:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947536AbWLHX7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:59:40 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37455 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947523AbWLHX7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:59:01 -0500
Message-Id: <20061209000100.788198000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:09 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: [patch 18/32] TOKENRING: Remote memory corruptor in ibmtr.c
Content-Disposition: inline; filename=tokenring-remote-memory-corruptor-in-ibmtr.c.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

ip_summed changes last summer had missed that one.  As the result,
we have ip_summed interpreted as CHECKSUM_PARTIAL now.  IOW,
->csum is interpreted as offset of checksum in the packet.  net/core/*
will both read and modify the value as that offset, with obvious
reasons.  At the very least it's a remote memory corruptor.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
commit b1875feda8c1735915e12d953acba85d96129f6a
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Dec 4 19:37:42 2006 -0800

 drivers/net/tokenring/ibmtr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.orig/drivers/net/tokenring/ibmtr.c
+++ linux-2.6.19/drivers/net/tokenring/ibmtr.c
@@ -1826,7 +1826,7 @@ static void tr_rx(struct net_device *dev
 	skb->protocol = tr_type_trans(skb, dev);
 	if (IPv4_p) {
 		skb->csum = chksum;
-		skb->ip_summed = 1;
+		skb->ip_summed = CHECKSUM_COMPLETE;
 	}
 	netif_rx(skb);
 	dev->last_rx = jiffies;

--
