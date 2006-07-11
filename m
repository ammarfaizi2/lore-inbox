Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWGKGCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWGKGCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWGKGCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:02:10 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:23562 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932482AbWGKGCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:02:09 -0400
Date: Tue, 11 Jul 2006 16:01:46 +1000
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [ACRYPTO] new release of asynchronous crrypto layer.
Message-ID: <20060711060146.GA8931@gondor.apana.org.au>
References: <20060710091353.GA19863@2ka.mipt.ru> <E1G0AHY-0002BE-00@gondolin.me.apana.org.au> <20060711053157.GA6451@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711053157.GA6451@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeniy:

On Tue, Jul 11, 2006 at 09:31:57AM +0400, Evgeniy Polyakov wrote:
>
> > I noticed a bug in the ESP IV processing.  When you do ESP asynchronously,
> > you can no longer use the last block of the previous packet as the IV of
> > the next.  This is because the next packet may have started processing
> > before the last packet has even been finalised.
> 
> I cought that bug too, so IV being used is always copied into old_iv variable,
> so integrity is stated.

My point is that it is possible for two packets to use the same IV
under this scheme, which defeats the purpose of IVs.

> > A simple solution is to generate a random IV.
> 
> Yes, it could be done too.
> But actually neither random IV, nor IV created from encrypted previous packet, 
> nor IV created from unencrypted previous packet are forbidden by spec. 
> Initial implementation used constant IV there at all.

True.  However, using the same IV more than once is definitely not a good
idea.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
