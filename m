Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWDLPoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWDLPoX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 11:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWDLPoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 11:44:23 -0400
Received: from stinky.trash.net ([213.144.137.162]:42922 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750757AbWDLPoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 11:44:22 -0400
Message-ID: <443D1FB8.6020504@trash.net>
Date: Wed, 12 Apr 2006 17:41:44 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jlt_lk@shamrock.dyndns.org
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netfilter@lists.netfilter.org
Subject: Re: 2.6.17rc1 PANIC related to IP masquerading
References: <20060412152703.GD3405@ranger.ah.taprogge.wh>
In-Reply-To: <20060412152703.GD3405@ranger.ah.taprogge.wh>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------000100090405090706060509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000100090405090706060509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

jlt_lk@shamrock.dyndns.org wrote:
> Kernel 2.6.17-rc1 panics as soon as IP packets are forwarded using the
> below config.  ICMP packets seem to be forwarded fine.
> 
> A photograph of the panic can be found at:
> http://shamrock.dyndns.org/~ln/kernel/2.6.17rc1_panic.jpg .

This is already fixed in Linus' current tree by this patch.


--------------000100090405090706060509
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

commit 8bf4b8a1083694d5aac292f92705ddd3aec29be6
tree a8bbf0bb32b7e286659eae12326c54671430560f
parent 67644726317a8274be4a3d0ef85b9ccebaa90304
author Herbert Xu <herbert@gondor.apana.org.au> Wed, 05 Apr 2006 02:51:05 -0700
committer David S. Miller <davem@sunset.davemloft.net> Mon, 10 Apr 2006 12:25:22 -0700

[IPSEC]: Check x->encap before dereferencing it

We need to dereference x->encap before dereferencing it for encap_type.
If it's absent then the encap_type is zero.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>

 net/ipv4/xfrm4_input.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index e1b8f4b..7a0b952 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -90,7 +90,7 @@ int xfrm4_rcv_encap(struct sk_buff *skb,
 		if (unlikely(x->km.state != XFRM_STATE_VALID))
 			goto drop_unlock;
 
-		if (x->encap->encap_type != encap_type)
+		if ((x->encap ? x->encap->encap_type : 0) != encap_type)
 			goto drop_unlock;
 
 		if (x->props.replay_window && xfrm_replay_check(x, seq))

--------------000100090405090706060509--
