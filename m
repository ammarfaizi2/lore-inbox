Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSETBKx>; Sun, 19 May 2002 21:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315618AbSETBKv>; Sun, 19 May 2002 21:10:51 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:44557 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315617AbSETBKt>; Sun, 19 May 2002 21:10:49 -0400
Date: Mon, 20 May 2002 03:10:44 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <Pine.LNX.4.44.0205191736420.10180-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.21.0205200245381.23394-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 19 May 2002, Linus Torvalds wrote:

> > - freed is never incremented, callers of tlb_remove_page have to do the
> >   rss update themselves?
> 
> No, that's just a missed thing (for a while I thought I could use "nr" for
> "freed", so I changed the code and forgot to add back the free'd).

If I see it correctly, tlb_remove_page() can't be called with a swap page,
does it make sense to use free_page_and_swap_cache()?

> > - will a non smp version later be added again?
> 
> Not likely, at least not in the form it was before of having two
> completely different paths.
> 
> But I was thinking of doing a one-source thing that the compiler can
> statically optimize, with something like
> 
> 	#ifdef CONFIG_SMP
> 	#define fast_case(tlb) ((tlb)->nr == ~0UL)
> 	#else
> 	#define fast_case(tlb) (1)
> 	#endif
> 
> which allows us to have one set of sources for both UP and SMP, but the UP
> case gets optimized by the compiler.

I was thinking about this and I agree, but this is needed as well

#define FREE_PTE_NR 1

otherwise we waste 2KB. :)

> Do you want to do the freed and the above and test it?

Sure.

bye, Roman

