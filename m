Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288731AbSA3HMS>; Wed, 30 Jan 2002 02:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288732AbSA3HMH>; Wed, 30 Jan 2002 02:12:07 -0500
Received: from waste.org ([209.173.204.2]:1428 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S288731AbSA3HMB>;
	Wed, 30 Jan 2002 02:12:01 -0500
Date: Wed, 30 Jan 2002 01:11:44 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Hans Reiser <reiser@namesys.com>
cc: Chris Mason <mason@suse.com>, Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under
 high memory pressure
In-Reply-To: <3C570FD0.3080206@namesys.com>
Message-ID: <Pine.LNX.4.44.0201300106020.25123-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Hans Reiser wrote:

> Chris Mason wrote:
>
> >>I don't mean to suggest that the dentry cache locking is an easy problem to solve, but the problem discussed is a real one, and it is sufficient to illustrate that the unified cache is fundamentally flawed as an algorithm compared to using subcache plugins.
> >>
> >
> >It isn't just dentries.  If a subcache object is in use, it can't be moved
> >to a warmer page without invalidating all existing pointers to it.
> >
> >If it isn't in use, it can be migrated when the VM asks for the page to
> >be flushed.
> >
> garbage collection is a lot of work to implement --- there are a lot of
> good reasons why ext2 doesn't shrink directories.....;-)
>
> really guys, you can get me to agree that it is more work to code, you
> can even get me to agree to skip it for now because we are all busy, but
> the design principle remains valid  --- using per page aging of subpage
> objects that do not correlate in accesses leads to diffused hot sets,
> and that means that the cache will perform as though it was much smaller
> than it is.

Can we get you to agree that basically all subpage objects are immovable?
And as a consequence that garbage collecting at subpage levels doesn't
guarantee freeing up any pages that can then be given up to other
subsystems in response to VM pressure? The GC must think in terms of pages
to actually make progress.

One of the design goals of slab by the way is that objects of a similar
type will end up having similar lifetimes, avoiding some of the worst
cases of sub-page allocations.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

