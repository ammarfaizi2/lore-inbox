Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267988AbRHFLYx>; Mon, 6 Aug 2001 07:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267986AbRHFLYn>; Mon, 6 Aug 2001 07:24:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:10840 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267982AbRHFLY2>; Mon, 6 Aug 2001 07:24:28 -0400
Date: Mon, 6 Aug 2001 13:25:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010806132503.A20837@athlon.random>
In-Reply-To: <997080081.3938.28.camel@typhaon> <20010806105904.A28792@athlon.random> <20010806063003.H3862@devserv.devel.redhat.com> <20010806124952.G15925@athlon.random> <20010806070124.J3862@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010806070124.J3862@devserv.devel.redhat.com>; from jakub@redhat.com on Mon, Aug 06, 2001 at 07:01:24AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 07:01:24AM -0400, Jakub Jelinek wrote:
> On Mon, Aug 06, 2001 at 12:49:52PM +0200, Andrea Arcangeli wrote:
> > On Mon, Aug 06, 2001 at 06:30:03AM -0400, Jakub Jelinek wrote:
> > > On Mon, Aug 06, 2001 at 10:59:04AM +0200, Andrea Arcangeli wrote:
> > > > On Mon, Aug 06, 2001 at 04:41:21PM +1000, David Luyer wrote:
> > > > > crashes for no apparent reason every 6 hours or so.. unless that could
> > > > > be when
> > > > > it hits some 'limit' on the number of mappings allowed? 
> > > > 
> > > > there's no limit, this is _only_ a performance issue, functionality is
> > > > not compromised in any way [except possibly wasting some memory
> > > > resources that could lead to running out of memory earlier].
> > > 
> > > There is a limit, /proc/sys/vm/max_map_count.
> > 
> > in mainline it's not a sysctl, btw.
> 
> Even worse, it means people not using -ac kernels cannot malloc a lot of
> memory but by recompiling the kernel.

Not that I consider the -ac situation optimal either (however certainly
it's better): if you don't have root privilegies you are screwed. And
this is again not related to merge_segments, the same problem can arise
with the merge_segments in place (but with merge_segments in place it
would probably trigger legally only on 64bit boxes with some dozen
gigabytes of ram). (this is why I didn't liked that limit ;)

The downside of dropping the limit is that we allow the user to allocate
an unlimited amount of unswappable ram per-process (and the current oom
killer will do the very wrong thing since it has no idea of the ram
allocated in the vmas of the process). Nothing compared to `cp /dev/zero
/dev/shm` though...

Andrea
