Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <155480-18252>; Wed, 18 Nov 1998 02:15:24 -0500
Received: from [207.181.251.162] ([207.181.251.162]:29760 "EHLO bitmover.com" ident: "TIMEDOUT2") by vger.rutgers.edu with ESMTP id <155519-18252>; Tue, 17 Nov 1998 12:39:31 -0500
Message-Id: <199811171832.KAA25953@bitmover.com>
To: linux-kernel@vger.rutgers.edu
Subject: Useful work vs Elevator sort
From: lm@bitmover.com (Larry McVoy)
Date: Tue, 17 Nov 1998 10:32:11 -0800
Sender: owner-linux-kernel@vger.rutgers.edu

Another thought on all of this discussion about disk sort.  Something that
I think would make a far greater /perceived/ difference would be some sort
of priority based sorting.  The problem that should be solved is to have
page faults for bash/emacs/whatever be "right now" and page faults for
other stuff be "later".  It's an open issue as to how you distinguish.
The first pass is that reads get higher priority than writes and that
is obviously wrong - you'll end up with all of memory being full of
dirty pages.

The next pass is to bump the priority on pages with the execute bit on;
that will handle the instructions nicely, I don't see a down side to it,
maybe someone else does.

The next pass is to bump the priority on pages that are in the swap
partition and associated with the data segment.  This is a little dicey
- if we ever go to the one-swap-file-per-process idea that I've posted
here about a year ago, then this gets easier.

Anyway, the bottom line is that you want the system to do two things

	a) have reasonable latency and great throughput for most stuff
	b) have really good latency for some stuff

I believe that you'll never accomplish that with disk sorting algs.
The disk sort routine isn't given all the information it needs to
accomplish those goals.  So, if we agree that we want something like
I'm describing, then messing about with disk sort, while interesting and
something that every real OS guy does at some point, is a futile exercise.

My point here is to encourage people not to stop if they decide that disk
sorting doesn't really help that much.  I think there is some performance
win that can happen if you think past the confines of the disk sort alg
and go up to a higher level and look at the problem you're really trying
to solve.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
