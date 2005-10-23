Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbVJWHbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbVJWHbW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 03:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbVJWHbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 03:31:22 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:17926 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751423AbVJWHbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 03:31:21 -0400
Date: Sun, 23 Oct 2005 17:31:12 +1000
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       acme@conectiva.com.br, davem@davemloft.net, greearb@candelatech.com
Subject: [1/3] [NEIGH] Print stack trace in neigh_add_timer
Message-ID: <20051023073112.GA17626@gondor.apana.org.au>
References: <43534273.2050106@reub.net> <E1ETaJB-0004a0-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <E1ETaJB-0004a0-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[NEIGH] Print stack trace in neigh_add_timer

Stack traces are very helpful in determining the exact nature of a bug.
So let's print a stack trace when the timer is added twice.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="p1.patch"

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -732,6 +732,7 @@ static inline void neigh_add_timer(struc
 	if (unlikely(mod_timer(&n->timer, when))) {
 		printk("NEIGH: BUG, double timer add, state is %x\n",
 		       n->nud_state);
+		dump_stack();
 	}
 }
 

--pf9I7BMVVzbSWLtt--
