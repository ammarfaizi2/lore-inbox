Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154485AbQAXTeK>; Mon, 24 Jan 2000 14:34:10 -0500
Received: by vger.rutgers.edu id <S154234AbQAXTZa>; Mon, 24 Jan 2000 14:25:30 -0500
Received: from fxiod04.extra.daimlerchrysler.com ([204.189.94.73]:49822 "EHLO fxiod04.is.chrysler.com") by vger.rutgers.edu with ESMTP id <S154836AbQAXSoX>; Mon, 24 Jan 2000 13:44:23 -0500
From: dg50@daimlerchrysler.com
Subject: SMP Theory (was: Re: Interesting analysis of linux kernel threading by IBM)
To: linux-kernel@vger.rutgers.edu
Date: Mon, 24 Jan 2000 17:46:55 -0500
Message-ID: <OFC8E00C6C.FBE80B06-ON85256870.007B8178@notes.chrysler.com>
X-MIMETrack: Serialize by Router on lngshc01.notes.chrysler.com/SVR/Chrysler(Release 5.0.2b |December 16, 1999) at 01/24/2000 05:47:00 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-kernel@vger.rutgers.edu

I've been reading the SMP thread and this is a truly educational and
fascinating discussion. How SMP works, and how much of a benefit it
provides has always been a bit of a mystery to me - and I think the light
is slowly coming on.

But I have a couple of (perhaps dumb) questions.

OK, if you have an n-way SMP box, then you have n processors with n (local)
caches sharing a single block of main system memory. If you then run a
threaded program (like a renderer) with a thread per processor, you wind up
with n threads all looking at a single block of shared memory - right?

OK, if a thread accesses (I assume writes, reading isn't destructive, is
it?) a memory location that another processor is "interested" in, then
you've invalidated that processor's local cache - so it has to be flushed
and refreshed. Have enough cross-talk between threads, and you can achieve
the worst-case scenario where every memory access flushes the cache of
every processor, totally defeating the purpose of the cache, and perhaps
even adding nontrivial cache-flushing overhead.

If this is indeed the case (please correct any misconceptions I have) then
it strikes me that perhaps the hardware design of SMP is broken. That
instead of sharing main memory, each processor should have it's own main
memory. You connect the various main memory chunks to the "primary" CPU via
some sort of very wide, very fast memory bus, and then when you spawn a
thread, you instead do something more like a fork - copy the relevent
process and data to the child cpu's private main memory (perhaps via some
sort of blitter) over this bus, and then let that CPU go play in its own
sandbox for a while.

Which really is more like the "array of uni-processor boxen joined by a
network" model than it is current SMP - just with a REALLY fast&wide
network pipe that just happens to be in the same physical box.

Comments? Please feel free to reply private-only if this is just too
entry-level for general discussuion.

DG


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
