Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVEXDse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVEXDse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 23:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEXDsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 23:48:33 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:58635 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261178AbVEXDsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 23:48:23 -0400
Date: Tue, 24 May 2005 13:47:44 +1000
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com
Subject: Re: [CRYPTO]: Only reschedule if !in_atomic()
Message-ID: <20050524034744.GA29699@gondor.apana.org.au>
References: <200505232300.j4NN07lE012726@hera.kernel.org> <20050523162806.0e70ae4f.akpm@osdl.org> <20050524022106.GA29081@gondor.apana.org.au> <20050523.193612.08320356.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523.193612.08320356.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 07:36:12PM -0700, David S. Miller wrote:
> 
> See how ugly this stuff gets once you start letting some people call
> this stuff with locks and some not?

But we already do that anyway.  For example, IPsec calls the crypto
functions with a spin lock on the xfrm_state.  As it is, you're
allowed to call crypto functions while holding spin locks if and
only if you're in softirq context.

Incidentally, that is something I intend on changing.  There is no
reason why we can't do away with that spin lock on the fast path
for IPsec.

> Crypto operations, especially the software operations, are extremely
> expensive compute bound tasks.  It is very desirable, as a result, for
> them to be allowed to relinquish the cpu from time to time.

Agreed.

> That being said, I guess a flag isn't so bad.

The other thing we could do with a flag is to use it to set GFP
flags for memory allocation.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
