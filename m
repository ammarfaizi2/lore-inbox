Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVCaCWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVCaCWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 21:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVCaCWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 21:22:50 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:3596 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262508AbVCaCWA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 21:22:00 -0500
Date: Thu, 31 Mar 2005 12:19:10 +1000
To: "Artem B. Bityuckiy" <dedekind@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050331021909.GA27095@gondor.apana.org.au>
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru> <20050326044421.GA24358@gondor.apana.org.au> <1112030556.17983.35.camel@sauron.oktetlabs.ru> <20050329103504.GA19468@gondor.apana.org.au> <Pine.LNX.4.58.0503291252030.22838@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503291252030.22838@phoenix.infradead.org>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem:

On Tue, Mar 29, 2005 at 12:55:11PM +0100, Artem B. Bityuckiy wrote:
>
> I'm not sure. David Woodhouse (the author) said that this is probably 
> enough in any case but a lot of time has gone since the code was written 
> and he doesn't remember for sure. I have also seen some magic number "12" 
> somewhere in zlib, but I'm not sure.
> 
> At least my practice shows that 12 is Ok for JFFS2 where we compress fewer 
> then 4K a a time. I'll explore this.

The crypto API needs to operate on buffers that's bigger than that so
we need to have a correct upper bound the maximum expansion.

> > We normally put the operator on the preceding line, i.e.,
> >
> > while (foo &&
> >        bar) {
> If this is the the common practice for Linux, then OK. My argument is the 
> GNU Coding style which recommends:

The GNU coding style is completely different from Linux.
 
> Ok. This is not the final patch but more like RFC and I can re-format and 
> re-send it. :-) Please, feel free to re-format it as you would like 
> yourself.

Please reformat it when you fix up the overhead calculation.

> And one more thing I wanted to offer. In the 
> deflate_[compress|uncompress|pcompress] functions we call the 
> zlib_[in|de]flateReset function at the beginning. This is OK. But when we 
> unload the deflate module we don't call zlib_[in|de]flateEnd to free all 
> the zlib internal data. It looks like a bug for me. Please, consider the 
> attached patch.

Good catch.  I'll apply this one.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
