Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293467AbSBZCGn>; Mon, 25 Feb 2002 21:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293468AbSBZCG3>; Mon, 25 Feb 2002 21:06:29 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:33554 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293467AbSBZCFU>;
	Mon, 25 Feb 2002 21:05:20 -0500
Date: Mon, 25 Feb 2002 23:04:58 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Michael Cohen <me@ohdarn.net>
Cc: <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Submssions for 2.4.19-pre [Fibonacci Hashing (William Lee Irwin)]
 [Discuss :) ]
In-Reply-To: <20020225205604.0583595e.me@ohdarn.net>
Message-ID: <Pine.LNX.4.33L.0202252302080.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Michael Cohen wrote:

> This one was given to me by WLI himself;

Are you sure these are the latest bit-sparse primes ?


> +++ linux-patched/include/asm-alpha/param.h	Mon Feb 25 20:44:35 2002

> +/* SPARSE_GOLDEN_RATIO_PRIME ought to be different for non-32bit arches. */
> +
> +#ifndef SPARSE_GOLDEN_RATIO_PRIME
> +#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
> +#endif

> +++ linux-patched/include/asm-arm/param.h	Mon Feb 25 20:43:13 2002
> +#ifndef SPARSE_GOLDEN_RATIO_PRIME
> +#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
> +#endif

Yuck, the fact that you're defining the exact same constant in
many .h files is ugly.  Could you move this to one place ?

(maybe linux/hash.h like Rusty is doing for 2.5?)

> +	unsigned long hash;
> +	hash   = (unsigned long) mapping + index;
> +	hash  *= SPARSE_GOLDEN_RATIO_PRIME;
> +	hash >>= BITS_PER_LONG - PAGE_HASH_BITS;
> +	hash  &= PAGE_HASH_SIZE - 1;
> +	return hash;

For 64-bit systems you'll want:

1) a 64-bit golden ratio prime
2) expanding the bit ops by hand because gcc doesn't do
   it for you


These last 2 points are easy, you can just copy the stuff
from the struct page patch I sent earlier.

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

