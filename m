Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424804AbWKQAWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424804AbWKQAWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424802AbWKQAWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:22:41 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:45581 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1424793AbWKQAWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:22:40 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jesper.juhl@gmail.com (Jesper Juhl)
Subject: Re: IPv4: ip_options_compile() how can we avoid blowing up on a NULL skb???
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <9a8748490611161434oc393db0o1e1c23ba99b1c796@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GkrUv-00043G-00@gondolin.me.apana.org.au>
Date: Fri, 17 Nov 2006 11:22:25 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
> 
> So if 'skb' is NULL, the only route I see that doesn't cause a NULL
> pointer deref is if  (opt != NULL)  and at the same time
> (opt->is_data != NULL)  .   Is that guaranteed in any way?  If now,
> how come we don't blow up regularly?

Yes that's how it's supposed to be used.  This function either constructs
an opts structure from a packet, or it verifies the validity of a suspect
opts structure (without a packet).  In the latter case, both opt and
opt->is_data should be non-zero.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
