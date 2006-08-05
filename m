Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422815AbWHEKZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbWHEKZC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 06:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422814AbWHEKZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 06:25:01 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:9440 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1422808AbWHEKZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 06:25:01 -0400
Date: Sat, 5 Aug 2006 14:24:36 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Chris Leech <chris.leech@gmail.com>, arnd@arndnet.de, olel@ans.pl,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060805102435.GA15740@2ka.mipt.ru>
References: <41b516cb0608031334s6e159e99tb749240f44ae608d@mail.gmail.com> <E1G8sif-0003oY-00@gondolin.me.apana.org.au> <20060804061513.GB413@2ka.mipt.ru> <41b516cb0608040834o1d433f23v2f2ba1a1b05ccbc6@mail.gmail.com> <20060804194209.GA25167@2ka.mipt.ru> <4807377b0608041402p10149bfbrd9e5f3b8849d3f56@mail.gmail.com> <20060805095846.GA17867@2ka.mipt.ru> <20060805100954.GB20939@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060805100954.GB20939@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 05 Aug 2006 14:24:38 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 08:09:54PM +1000, Herbert Xu (herbert@gondor.apana.org.au) wrote:
> > If you can create several skbs and link them togeter you defenitely can
> > organize pages into frag_list, just get pages from different skb->data
> > and free those skbs.
> 
> Having a more flexible mechanism for managing skb_shared_info->frags
> would definitely be an improvement.  At the moment we can't indicate
> whether the individual frags are writable so we assume every frag to
> be read-only.

Having one page inside frag_list writable does not make a lot of sence,
so we really need either all of them writable, or nothing.
And it is much less error-prone to assume that every page is read-only.

> If we had a flag to indicate writability we could also have a flag to
> indicate that the memory comes from kmalloc rather than alloc_page.

Yes, that would be good, but who will give us a bit in the struct page?
Can we recreate frag_list elements to be a bitmasks and steal couple
of them there, so we would not increase fragment's structure size?

> Cheers,
> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
	Evgeniy Polyakov
