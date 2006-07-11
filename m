Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbWGKFcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWGKFcR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 01:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWGKFcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 01:32:17 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:62607 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S965073AbWGKFcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 01:32:16 -0400
Date: Tue, 11 Jul 2006 09:31:57 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [ACRYPTO] new release of asynchronous crrypto layer.
Message-ID: <20060711053157.GA6451@2ka.mipt.ru>
References: <20060710091353.GA19863@2ka.mipt.ru> <E1G0AHY-0002BE-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <E1G0AHY-0002BE-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 11 Jul 2006 09:31:58 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 02:55:36PM +1000, Herbert Xu (herbert@gondor.apana.org.au) wrote:
> Hi Evgeniy:

Hi Herbert.

> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > * IPsec ESP4 port to acrypto
> 
> I noticed a bug in the ESP IV processing.  When you do ESP asynchronously,
> you can no longer use the last block of the previous packet as the IV of
> the next.  This is because the next packet may have started processing
> before the last packet has even been finalised.

I cought that bug too, so IV being used is always copied into old_iv variable,
so integrity is stated.

> A simple solution is to generate a random IV.

Yes, it could be done too.
But actually neither random IV, nor IV created from encrypted previous packet, 
nor IV created from unencrypted previous packet are forbidden by spec. 
Initial implementation used constant IV there at all.

-- 
	Evgeniy Polyakov
