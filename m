Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130911AbRBPTB0>; Fri, 16 Feb 2001 14:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130821AbRBPTBQ>; Fri, 16 Feb 2001 14:01:16 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:24850 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130741AbRBPTBH>; Fri, 16 Feb 2001 14:01:07 -0500
Date: Fri, 16 Feb 2001 11:00:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org,
        bcrl@redhat.com
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <3A8D764B.9CD6B3A8@colorfullife.com>
Message-ID: <Pine.LNX.4.10.10102161056250.767-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Feb 2001, Manfred Spraul wrote:
> 
> That leaves msync() - it currently does a flush_tlb_page() for every
> single dirty page.
> Is it possible to integrate that into the mmu gather code?

Not even necessary.

The D bit does not have to be coherent. We need to make sure that we flush
the TLB before we start the IO on the pages which clears the per-physical
D bit (so that no CPU will have done any modifications that didn't show up
in one of the D bits - whther virtual in the page tables or physical in
the memory map), but there are no other real requirements.

So you don't strictly need to gather them at all, although right now with
the type of setup we have I suspect it's hard to actually implement any
other way (because msync doesn't necessarily know when the IO has been
physically started and has no good way of hooking into it..).

		Linus

