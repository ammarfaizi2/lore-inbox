Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWHDGPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWHDGPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 02:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWHDGPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 02:15:47 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:20403 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751251AbWHDGPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 02:15:46 -0400
Date: Fri, 4 Aug 2006 10:15:13 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Chris Leech <chris.leech@gmail.com>, arnd@arndnet.de, olel@ans.pl,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060804061513.GB413@2ka.mipt.ru>
References: <41b516cb0608031334s6e159e99tb749240f44ae608d@mail.gmail.com> <E1G8sif-0003oY-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <E1G8sif-0003oY-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 04 Aug 2006 10:15:14 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 03:59:37PM +1000, Herbert Xu (herbert@gondor.apana.org.au) wrote:
> Chris Leech <chris.leech@gmail.com> wrote:
> > 
> > We could try and only use page allocations for older e1000 devices,
> > putting headers and payload into skb->frags and copying the headers
> > out into the skb->data area as needed for processing.  That would do
> > away with large allocations, but in Jesse's experiments calling
> > alloc_page() is slower than kmalloc(), so there can actually be a
> > performance hit from trying to use page allocations all the time.
> 
> Interesting.  Could you guys post figures on alloc_page speed vs. kmalloc?

They probalby measured kmalloc cache access, which only falls to
alloc_pages when cache is refilled, so it will be faster for some short
period of time, but in general (especially for such big-sized
allocations) it is essencially the same.

> Also, getting memory slower is better than not getting them at all :)

Sure.

> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
	Evgeniy Polyakov
