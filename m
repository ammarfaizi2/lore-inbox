Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162274AbWKPCtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162274AbWKPCtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162273AbWKPCtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:49:11 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:29320 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162270AbWKPCtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:49:04 -0500
Message-Id: <20061116024731.543973000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:51 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Herbert Xu <herbert@gondor.apana.org.au>
Subject: [patch 19/30] NET: Set truesize in pskb_copy
Content-Disposition: inline; filename=net-set-truesize-in-pskb_copy.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

Since pskb_copy tacks on the non-linear bits from the original
skb, it needs to count them in the truesize field of the new skb.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

---
 net/core/skbuff.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.18.2.orig/net/core/skbuff.c
+++ linux-2.6.18.2/net/core/skbuff.c
@@ -638,6 +638,7 @@ struct sk_buff *pskb_copy(struct sk_buff
 	n->csum	     = skb->csum;
 	n->ip_summed = skb->ip_summed;
 
+	n->truesize += skb->data_len;
 	n->data_len  = skb->data_len;
 	n->len	     = skb->len;
 

--
