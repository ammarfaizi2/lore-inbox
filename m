Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291212AbSAaSBZ>; Thu, 31 Jan 2002 13:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291213AbSAaSBF>; Thu, 31 Jan 2002 13:01:05 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14382 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S291212AbSAaSBC>; Thu, 31 Jan 2002 13:01:02 -0500
Date: Thu, 31 Jan 2002 19:02:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Momchil Velikov <velco@fadata.bg>,
        John Stoffel <stoffel@casc.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020131190202.I1309@athlon.random>
In-Reply-To: <20020131153607.C1309@athlon.random> <Pine.LNX.4.33.0201310942210.1537-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0201310942210.1537-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jan 31, 2002 at 09:46:52AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 09:46:52AM -0800, Linus Torvalds wrote:
> On Thu, 31 Jan 2002, Andrea Arcangeli wrote:
> >
> > but with the radix tree (please correct me if I'm wrong) the height will
> > increase eventually, no matter what (so it won't be an effective O(1)
> > like the hashtable provides in real life, not the worst case, the common
> > case). With the hashtable the height won't increase instead.
> 
> No.
> 
> The radix tree is basically O(1), because the maximum depth of a 7-bit
> radix tree is just 5. The index is only a 32-bit number.

then it will break on archs with more ram than 1<<(32+PAGE_CACHE_SHIFT).

Also there must be some significant memory overhead that can be
triggered with a certain layout of pages, in some configuration it
should take much more ram than the hashtable if I understood well how it
works.

Also its O(1) may be slower than the O(N) of the hashtable in the 99% of
the cases.

> 
> We could, in fact, make all page caches use a fixed-depth tree, which is
> clearly O(1). But the radix tree is slightly faster and tends to use less
> memory under common loads, so..
> 
> Remember: you must NOT ignore the constant part of a "O(x)" equation.
> Hashes tend to be effectively O(1) under most loads, but they have cache
> costs, and they have scalability costs that a radix tree doesn't have.

the scalability cost I obviously agree :) (however on some workload with
all tasks on the same inode, the scalability cost remains the same).

Andrea
