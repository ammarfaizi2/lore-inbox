Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289928AbSAQQgm>; Thu, 17 Jan 2002 11:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289817AbSAQQgc>; Thu, 17 Jan 2002 11:36:32 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31795 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289867AbSAQQgV>; Thu, 17 Jan 2002 11:36:21 -0500
Date: Thu, 17 Jan 2002 17:37:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Rohland <cr@sap.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
Message-ID: <20020117173701.R4847@athlon.random>
In-Reply-To: <20020116185814.I22791@athlon.random> <m3u1tll6pb.fsf@linux.local> <20020117163021.L4847@athlon.random> <m3bsft7ygd.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <m3bsft7ygd.fsf@linux.local>; from cr@sap.com on Thu, Jan 17, 2002 at 05:11:48PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 05:11:48PM +0100, Christoph Rohland wrote:
> Hi Andrea,
> 
> On Thu, 17 Jan 2002, Andrea Arcangeli wrote:
> > (btw, I suspect allocating one page at offset 4G in every shmfs file
> > could make the overhead per page of shm to increase)
> 
> Nearly: A sparse file with the only page at 4G is the worst case: You
> need three extra pages to hold the swap entry. The ratio goes fown as
> soon as you add more pages somewhere.

Agreed.

> 
> > But in real life I really don't expect problems here, one left page
> > of the vector holds 1024 swap entries, so the overhead is of the
> > order of 1/1000. On the top of my head (without any precise
> > calculation) 64G of shm would generate stuff of the order of some
> > houndred mbytes of ram 
> 
> Ok, 64GB shm allocate roughly 64MB swap entries, so this case should
> not bother too much. I was still at the 390x case where we have 512
> entries per page. But they do not need highmem.

agreed.

> Another case are smaller machines with big tmpfs instances: They get
> killed by the swap entries. But you cannot hinder that without
> swapping the swap entries themselves.

yes, same can happen with pagetables, if you've an huge amount of swap
and only a few mbytes of ram, that's another kind of problem that we
always ignored so far (mostly because it is possible to solve it very
efficiently by throwing money into some more ram :).

Andrea
