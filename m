Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132316AbRCZEX4>; Sun, 25 Mar 2001 23:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132317AbRCZEXq>; Sun, 25 Mar 2001 23:23:46 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:26122 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S132316AbRCZEX1>; Sun, 25 Mar 2001 23:23:27 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <Pine.LNX.4.31.0103241932330.6710-100000@penguin.transmeta.com>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Linus Torvalds's message of "Sat, 24 Mar 2001 19:37:17 -0800 (PST)"
Date: 25 Mar 2001 22:22:44 -0600
Message-ID: <vbau24htazv.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> 
> On 24 Mar 2001, Kevin Buhr wrote:
> >
> > A huge win for 2.96 and absolutely no benefit whatsoever for 3.0, even
> > though it obviously had a 10-fold effect on maps counts.  On the
> > positive side, there was no performance *hit* either.
> 
> I don't think the system time in 3.0 has anything to do the the mmap size.
> 
> The 40 seconds of system time you see is probably mostly something else.
> It's not as if gcc _only_ does mmap's.

Yes, that's what I meant.  I was assuming that there was 40sec of
baseline system time in each compilation representing everything
*except* searching lists of unmerged mmaps.

Before doing the pre7 test, I figured that---given Zack's 32-factor
observation---my benchmarks indicated that 2.96 was spending 2m14-40 =
214sec doing unmerged mmaps while 3.0 was spending 49-40 = 9 sec doing
unmerged mmaps.  This ratio is more or less in line with a 32-fold
difference in number of maps predicted by Zack plus or minus a couple
seconds.

That is, I was assuming that the total time wasted because of unmerged
mmaps was roughly linear in the number of vmas.  Actually, it'll be
O(n log n)---the number of maps times the O(log n) search time once
the AVL tree gets big enough to matter.  Anyway, the factor should
still be around 30-50 or so.

When I did the test and 2.96 fell right in line with 2.95.3, I was
disappointed that 3.0 *didn't* fall right in line with the other
two---I thought I'd get those extra 8 seconds back.

> Do a kernel profile, and I bet that the mmap stuff is pretty low in the
> noise,

I'll bet your right---that's why I was disappointed.  I thought 3.0's
mmap overhead would be higher than it turned out to be.

As it is, it looks like only the most extreme cases (thousands or ten
of thousands of mergeable maps) will benefit from the patch.

Kevin <buhr@stat.wisc.edu>
