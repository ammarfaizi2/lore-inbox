Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269407AbRHLStw>; Sun, 12 Aug 2001 14:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269408AbRHLStm>; Sun, 12 Aug 2001 14:49:42 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2589 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269407AbRHLStg>; Sun, 12 Aug 2001 14:49:36 -0400
Date: Sun, 12 Aug 2001 20:49:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8aa1
Message-ID: <20010812204927.I737@athlon.random>
In-Reply-To: <20010812190202.H737@athlon.random> <Pine.LNX.4.33.0108121003520.15697-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108121003520.15697-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Aug 12, 2001 at 10:21:58AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 10:21:58AM -0700, Linus Torvalds wrote:
> 
> On Sun, 12 Aug 2001, Andrea Arcangeli wrote:
> >
> > virt_to_bus(page_address(pte_page(pte))) actually returns the right bus
> > address on x86 in a range of 4G,
> 
> No it doesn't.
> 
> page_address(page) is (page)->virtual, which is going to be zero for
> non-kmapped pages, and going to ve the virtual mapping of a kmapped page.
> NEITHER of which will translate correctly with "virt_to_bus()".
> 
> In short, "virt_to_bus(page_address(pte_page(pte)))" only works for the
> first 1GB. Always have, always will.

Woops sorry, I was thinking at the 2.2 page_address, the 2.2 virt_to_bus
won't handle the warp around while the 2.4 does, in some bigmem patches
we used the 2.4 virt_to_bus just to allow
virt_to_bus(page_address(pte_page(pte))) to work up to 4G, this is why I
got mistaken. Of course in mainline 2.4 page_address(pte_page(pte)) is
just broken for any highmem page as you said.

Andrea
