Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282531AbRKZV6y>; Mon, 26 Nov 2001 16:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282590AbRKZV6m>; Mon, 26 Nov 2001 16:58:42 -0500
Received: from md.hub.gts.cz ([194.213.32.136]:8708 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S282531AbRKZV61>;
	Mon, 26 Nov 2001 16:58:27 -0500
Date: Mon, 26 Nov 2001 22:02:03 +0100
From: Martin Mares <mj@ucw.cz>
To: Robert Love <rml@tech9.net>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] tree-based bootmem
Message-ID: <20011126220203.I215@ucw.cz>
In-Reply-To: <20011117011415.B1180@holomorphy.com> <20011118001657.A467@ucw.cz> <20011117160134.A11913@holomorphy.com> <1006157288.869.0.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1006157288.869.0.camel@phantasy>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The beauty is in the implementation.  With a linked list implementation,
> you have an exhaustive search and and at-worst O(n) insertion and
> searching complexity.  We also don't end up with any clean way to say
> "memory a belongs to x".  This is where the segment tree comes in, a
> segment tree stores intervals: it is a binary tree where each node
> represents an interval from a to b.  We only need to store nodes that
> have allocated intervals of memory, and insertion is O(log n). 
> Searching is even easier as you just walk the intervals until we get to
> what we want.  Searching would be O(log(n+s)) where s is the number of
> segments we had to walk.  OK, you know this, but my point is its is
> quite applicable.  Besides a performance boost, we end up with a nice
> way to interface with other code to work with bootmem and I think that
> is the main benefit here.

Look at it from the other side: Compare a simple 50-line allocator based
on linked lists which is obviously correct and a complex allocator with
several hundreds lines of code which, although very fast and elegant,
is very far from being understandable in a couple of minutes. And believe
me, bugs in memory allocators are some of the worst to find.

On the other hand, well implemented segment trees might be much more useful for
other stuff, like the vm_area_struct lists.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"I don't give a damn for a man that can only spell a word one way." -- M. Twain
