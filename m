Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbVLWWyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbVLWWyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbVLWWyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:54:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:46031 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161094AbVLWWtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:23 -0500
Date: Fri, 23 Dec 2005 14:48:02 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net, herbert@gondor.apana.org.au
Subject: [patch 07/19] [GRE]: Fix hardware checksum modification
Message-ID: <20051223224802.GG19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="gre-fix-hardware-checksum-modification.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Herbert Xu <herbert@gondor.apana.org.au>

The skb_postpull_rcsum introduced a bug to the checksum modification.
Although the length pulled is offset bytes, the origin of the pulling
is the GRE header, not the IP header.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/ip_gre.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.4.orig/net/ipv4/ip_gre.c
+++ linux-2.6.14.4/net/ipv4/ip_gre.c
@@ -617,7 +617,7 @@ static int ipgre_rcv(struct sk_buff *skb
 
 		skb->mac.raw = skb->nh.raw;
 		skb->nh.raw = __pskb_pull(skb, offset);
-		skb_postpull_rcsum(skb, skb->mac.raw, offset);
+		skb_postpull_rcsum(skb, skb->h.raw, offset);
 		memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));
 		skb->pkt_type = PACKET_HOST;
 #ifdef CONFIG_NET_IPGRE_BROADCAST

--
