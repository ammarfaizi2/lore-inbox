Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946014AbWGOKeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946014AbWGOKeo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 06:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946015AbWGOKeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 06:34:44 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:56591 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1946014AbWGOKeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 06:34:44 -0400
Date: Sat, 15 Jul 2006 20:34:38 +1000
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm2
Message-ID: <20060715103438.GA17818@gondor.apana.org.au>
References: <20060715002623.GE9334@gondor.apana.org.au> <20060714173517.cdd58097.akpm@osdl.org> <20060715010645.GB11515@gondor.apana.org.au> <20060714.224001.71089810.davem@davemloft.net> <20060715103207.GA17727@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715103207.GA17727@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 08:32:07PM +1000, herbert wrote:
> 
> Sure, in fact there was a name clash as well with __ret and
> I forgot to update the arch-specific versions.
> 
> [PATCH] Let WARN_ON/WARN_ON_ONCE return the condition

Here's a patch to make dev.c use this.

[NET]: Use WARN_ON_ONCE for checksum checks

Use the WARN_ON_ONCE macro rather than open-coding it.

Signed-off-by: Herbert Xu herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/net/core/dev.c b/net/core/dev.c
index 4d2b516..2ea983a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1165,12 +1165,7 @@ int skb_checksum_help(struct sk_buff *sk
 	if (inward)
 		goto out_set_summed;
 
-	if (unlikely(skb_shinfo(skb)->gso_size)) {
-		static int warned;
-
-		WARN_ON(!warned);
-		warned = 1;
-
+	if (WARN_ON_ONCE(skb_shinfo(skb)->gso_size)) {
 		/* Let GSO fix up the checksum. */
 		goto out_set_summed;
 	}
@@ -1219,12 +1214,7 @@ struct sk_buff *skb_gso_segment(struct s
 	skb->mac_len = skb->nh.raw - skb->data;
 	__skb_pull(skb, skb->mac_len);
 
-	if (unlikely(skb->ip_summed != CHECKSUM_HW)) {
-		static int warned;
-
-		WARN_ON(!warned);
-		warned = 1;
-
+	if (WARN_ON_ONCE(skb->ip_summed != CHECKSUM_HW)) {
 		if (skb_header_cloned(skb) &&
 		    (err = pskb_expand_head(skb, 0, 0, GFP_ATOMIC)))
 			return ERR_PTR(err);
