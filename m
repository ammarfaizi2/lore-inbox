Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293434AbSBZCLD>; Mon, 25 Feb 2002 21:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293468AbSBZCK4>; Mon, 25 Feb 2002 21:10:56 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:41346 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S293434AbSBZCKc>;
	Mon, 25 Feb 2002 21:10:32 -0500
Date: Mon, 25 Feb 2002 21:10:34 -0500
From: Michael Cohen <me@ohdarn.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Submssions for 2.4.19-pre [Fibonacci Hashing (William Lee Irwin)] [Discuss :) ]
Message-Id: <20020225211034.0de635cf.me@ohdarn.net>
In-Reply-To: <Pine.LNX.4.33L.0202252302080.7820-100000@imladris.surriel.com>
In-Reply-To: <20020225205604.0583595e.me@ohdarn.net>
	<Pine.LNX.4.33L.0202252302080.7820-100000@imladris.surriel.com>
Organization: OhDarn.net
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002 23:04:58 -0300 (BRT)
Rik van Riel <riel@conectiva.com.br> wrote:

> On Mon, 25 Feb 2002, Michael Cohen wrote:
> 
> > This one was given to me by WLI himself;
> 
> Are you sure these are the latest bit-sparse primes ?

WLI has yet to update me, and I've yet to see anything new from him in this area.  I could be mistaken.

> > +++ linux-patched/include/asm-alpha/param.h	Mon Feb 25 20:44:35 2002
> 
> > +/* SPARSE_GOLDEN_RATIO_PRIME ought to be different for non-32bit arches. */
> > +
> > +#ifndef SPARSE_GOLDEN_RATIO_PRIME
> > +#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
> > +#endif
> 
> > +++ linux-patched/include/asm-arm/param.h	Mon Feb 25 20:43:13 2002
> > +#ifndef SPARSE_GOLDEN_RATIO_PRIME
> > +#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
> > +#endif
> 
> Yuck, the fact that you're defining the exact same constant in
> many .h files is ugly.  Could you move this to one place ?
 
> (maybe linux/hash.h like Rusty is doing for 2.5?)

Possible.  Take a look at HZ though. It's an arch-specific parameter similar to HZ (different for some arches, but not all) and it looks like it belongs in params.h for that reason.
 
> > +	unsigned long hash;
> > +	hash   = (unsigned long) mapping + index;
> > +	hash  *= SPARSE_GOLDEN_RATIO_PRIME;
> > +	hash >>= BITS_PER_LONG - PAGE_HASH_BITS;
> > +	hash  &= PAGE_HASH_SIZE - 1;
> > +	return hash;
> 
> For 64-bit systems you'll want:
> 
> 1) a 64-bit golden ratio prime
> 2) expanding the bit ops by hand because gcc doesn't do
>    it for you
> These last 2 points are easy, you can just copy the stuff
> from the struct page patch I sent earlier.

Great, thanks :)

> cheers,
> 
> Rik
> -- 
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
> 
> http://www.surriel.com/		http://distro.conectiva.com/
