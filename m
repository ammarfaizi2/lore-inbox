Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286615AbSAPSe4>; Wed, 16 Jan 2002 13:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285482AbSAPSeq>; Wed, 16 Jan 2002 13:34:46 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:26144 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286311AbSAPSej>; Wed, 16 Jan 2002 13:34:39 -0500
Date: Wed, 16 Jan 2002 19:35:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pte-highmem-5
Message-ID: <20020116193521.C835@athlon.random>
In-Reply-To: <20020116185814.I22791@athlon.random> <Pine.LNX.4.33.0201161002390.2112-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0201161002390.2112-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 16, 2002 at 10:04:37AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 10:04:37AM -0800, Linus Torvalds wrote:
> 
> On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
> >
> > This patch in short will move pagetables into highmem, obviously it
> > breaks all the archs out there.
> 
> Hmm.. Looks ok, although I miss the "obviously". Archs have their own page
> table allocator functions, so by allocating lowmem (and most non-x86 won't
> care) the change _should_ have zero impact on them simply because they
> don't need to unmap. No?

the problem is as usual we need to work with pages or pfn somewhere (see
pte_alloc), we cannot work with virtual addresses or we'll overflow...
the pte_t * virtual address is always the result of the kmap, so the
changes required are the minimal as possible in most places, and I made
a pte_kunmap smart enough to be able to unmap any kind of kmap so the
common code changes are as simple as possible, but still pmd_populate
needs to know the whole thing (struct page * actually) and probably some
other bit of the same kind with the pmd breaks too.

Andrea
