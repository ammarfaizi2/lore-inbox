Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316240AbSEVQXU>; Wed, 22 May 2002 12:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316239AbSEVQXT>; Wed, 22 May 2002 12:23:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19217 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316235AbSEVQXS>; Wed, 22 May 2002 12:23:18 -0400
Date: Wed, 22 May 2002 09:23:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <20020522121929.A16934@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0205220919220.7580-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Russell King wrote:
>
> We seem to have inconsistent cache handling in the new TLB shootdown stuff.

Not surprising - I've worried only about changing the TLB architecture on
x86, where the caches do not matter.

> I think we have two options - either leave the cache handling up to
> tlb_start_vma() (in which case, flush_cache_range and flush_cache_mm
> are redundant and should be removed) or let it be up to the caller
> of tlb_gather_mmu to call the right cache handling function.

I think I'd prefer the "let the tlb functions handle caches too" approach.

For many architectures, that means "tlb_start/end_vma()". Others can do it
in "tlb_remove_tlb_entry()".

There's another issue: I think we should aim to get rid of the old
"flush_tlb_xxxx()" functions, and aim to rely entirely on the TLB
gathering. vmalloc/vfree might be the one special case (and I suspect
vfree() is going to get a lot slower to make sure it does the right thing
wrt TLB's).

		Linus

