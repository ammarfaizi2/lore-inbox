Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268311AbTBYVJT>; Tue, 25 Feb 2003 16:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268326AbTBYVJT>; Tue, 25 Feb 2003 16:09:19 -0500
Received: from tapu.f00f.org ([202.49.232.129]:63383 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S268311AbTBYVJR>;
	Tue, 25 Feb 2003 16:09:17 -0500
Date: Tue, 25 Feb 2003 13:19:33 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Scott Robert Ladd <scott@coyotegulch.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225211933.GA21870@f00f.org>
References: <20030225051956.GA18302@f00f.org> <FKEAJLBKJCGBDJJIPJLJMEOOEPAA.scott@coyotegulch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FKEAJLBKJCGBDJJIPJLJMEOOEPAA.scott@coyotegulch.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 02:59:05PM -0500, Scott Robert Ladd wrote:

> HT is not the same thing as SMP; while the chip may appear to be two
> processors, it is actually equivalent 1.1 to 1.3 processors,
> depending on the application.

You can't have non-integer numbers of processors.  HT is a hack that
makes what appears to be two processors using common silicon.

The fact it's slower than a really dual CPU box is irrelevant in some
sense, you still need SMP smart to deal with it; it's only important
when you want to know why performance increases aren't apparent or you
loose performance in some cases... (ie. other virtual CPU thrashing
the cache).

> Multicore processors and true SMP systems are unlikely to become
> mainstream consumer items, given the premium price charged for such
> systems.

I overstated things thinking SMP/HT would be in low-end hardware given
two years.

As Alan pointed out, since the 'Walmart' class hardware is 'whatever
is cheapest' then perhaps HT/SMT/whatever won't be common place for
super-low end boxes in two years --- but I would be surprised if it
didn't gain considerable market share elsewhere.

> That given, I see some value in a stripped-down, low-overhead,
> consumer-focused Linux that targets uniprocessor and HT systems, to
> be used in the typical business or gaming PC.

UP != HT

HT is SMP with magic requirements.  For multiple physical CPUs the
requirements become even more complex; you want to try to group tasks
to physical CPUs, not logical ones lest you thrash the cache.

Presumably there are other tweaks possible two, cache-line's don't
bounce between logic CPUs on a physical CPU for example, so some locks
and other data structures will be much faster to access than those
which actually do need cache-lines to migrate between different
physical CPUs.  I'm not sure if these specific property cane be
exploited in the general case though.

> I'm not sure such is achievable with the current config options;
> perhaps I should try to see how small a kernel I can build for a
> simple ia32 system...

Present 2.5.x looks like it will have smarts for HT as a subset of
NUMA.

If HT does become more common and similar things abound, I'm not sure
if it even makes sense to have a UP kernel for certain platforms
and/or CPUs --- since a mere BIOS change will affect what is
'virtually' apparent to the OS.


  --cw
