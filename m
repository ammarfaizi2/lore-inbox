Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131463AbRC0RYx>; Tue, 27 Mar 2001 12:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131464AbRC0RYn>; Tue, 27 Mar 2001 12:24:43 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:41770 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131463AbRC0RY2>; Tue, 27 Mar 2001 12:24:28 -0500
Message-ID: <3AC0CC38.467F4401@sgi.com>
Date: Tue, 27 Mar 2001 09:22:00 -0800
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> Are you being deliberately insulting, "L", or are you one of those users
> who bitch and scream for features they *need* at *any cost*, and who
> have never even opened up the book for Computer Architecture 101?
---
        Sorry, I was borderline insulting.  I'm getting pressure on
personal fronts other than just here.  But my degree is in computer
science and I've had almost 20 years experience programming things
as small as 8080's w/ 4K ram on up.  I'm familiar with 'cost' of
emulation.

> Let's try to keep the discussion civilized, shall we?
---
        Certainly.
> 
> Compile option or not, 64-bit arithmetic is unacceptable on IA32. The
> introduction of LFS was bad enough, we don't need yet another proof that
> IA32 sucks. Especially when there *are* better alternatives.
===
        So if it is a compile option -- the majority of people
wouldn't be affected, is that in agreement?  Since the default would
be to use the same arithmetic as we use  now.

        In fact, I posit that if anything, the majority of the people
might be helped as the block_nr becomes a a 'typed' value -- and
perhaps the sector_nr as well.  They remain the same size, but as
a typed value the kernel gains increased integrity from the increased
type checking.  At worst, it finds no new bugs and there is no impact
in speed.  Are we in agreement so far?

        Now lets look at the sites want to process terabytes of
data -- perhaps files systems up into the Pentabyte range.  Often I
can see these being large multi-node (think 16-1024 clusters as 
are in use today for large super-clusters).  If I was to characterize
the performance of them, I'd likely see the CPU pegged at 100% 
with 99% usage in user space.  Let's assume that increasing the
block size decreases disk accesses by as much as 10% (you'll have
to admit -- using a 64bit quantity vs. 32bit quantity isn't going
to even come close to increasing disk access times by 1 millisecond,
really, so it really is going to be a much smaller fraction when
compared to the actual disk latency).  

        Ok...but for the sake of
argument using 10% -- that's still only 10% of 1% spent in the system.
or a slowdown of .1%.  Now that's using a really liberal figure
of 10%.  If you look at the actual speed of 64 bit arithmatic vs.
32, we're likely talking -- upper bound, 10x the clocks for 
disk block arithmetic.  Disk block arithmetic is a small fraction
of time spent in the kernel.  We have to be looking at *maximum*
slowdowns in the range of a few hundred maybe a few thousand extra clocks.
A 1000 extra clocks on a 1G machine is 1 microsecond, or approx
1/5000th your average seek latency on a *fast* hard disk.  So
instead of 10% slowdown we are talking slowdowns in the 1/1000 range
or less.  Now that's a slowdown in the 1% that was being spent in
the kernel, so now we've slowdown the total program speed by .001%
at the increase benefit (to that site) of being able to process
those mega-gig's (Pentabytes) of information.  For a hit that is
not noticable to human perception, they go from not being able to
use super-clusters of IA32 machines (for which HW and SW is cheap), 
to being able to use it.  That's quite a cost savings for them.

        Is there some logical flaw in the above reasoning?

-linda
-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
