Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291243AbSAaTPa>; Thu, 31 Jan 2002 14:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291241AbSAaTPL>; Thu, 31 Jan 2002 14:15:11 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23610 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S291244AbSAaTO7>; Thu, 31 Jan 2002 14:14:59 -0500
Date: Thu, 31 Jan 2002 20:14:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Momchil Velikov <velco@fadata.bg>,
        John Stoffel <stoffel@casc.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020131201412.L1309@athlon.random>
In-Reply-To: <20020131190202.I1309@athlon.random> <Pine.LNX.4.33.0201311031180.1637-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0201311031180.1637-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jan 31, 2002 at 10:32:35AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 10:32:35AM -0800, Linus Torvalds wrote:
> 
> On Thu, 31 Jan 2002, Andrea Arcangeli wrote:
> > >
> > > The radix tree is basically O(1), because the maximum depth of a 7-bit
> > > radix tree is just 5. The index is only a 32-bit number.
> >
> > then it will break on archs with more ram than 1<<(32+PAGE_CACHE_SHIFT).
> 
> NO.
> 
> The radix tree is an index lookup mechanism.
> 
> The index is 32 bits.
> 
> That's true regardless of how much RAM you have.

then there must be some collision handling that raise the complexity to
O(N) like with the hashtable, if the depth is fixed and if 32bits of
index are enough regardless of how many entries are in the tree.

I'm confused by the comments I heard so far, but well I don't want to
bother you further until I have clear how this data structure is layed
out exactly. I mainly wanted to give a warning, to be sure some point is
evalulated properly before integration.

> Considering that the radix tree can _remove_ 8 bytes per "struct page", I
> suspect you potentially win more memory than you lose.

of course if we add kmalloc to the pagecache code we can drop such part
from the page structure with the hashtable too.

Andrea
