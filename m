Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154349-18252>; Thu, 19 Nov 1998 11:02:15 -0500
Received: from HANS.MATH.UPENN.EDU ([130.91.49.156]:48678 "EHLO hans.math.upenn.edu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <155524-18252>; Thu, 19 Nov 1998 06:47:54 -0500
Date: Thu, 19 Nov 1998 07:43:42 -0500 (EST)
From: Vladimir Dergachev <vladimid@blue.seas.upenn.edu>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: Useful work vs Elevator sort
In-Reply-To: <199811171832.KAA25953@bitmover.com>
Message-ID: <Pine.GSO.4.02A.9811190735370.6255-100000@blue.seas.upenn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


I was actually thinking about making a "smart" userspace algorithm to do
that. The thing is you can sometimes predict what will happen next, so 
while user is inputting commands you can preload something (if you have
memory) and if you are wrong - well you lose nothing. 

However I am not very good with the kernel yet and am stuck trying to do
sector I/O. The thing is this algorithm would would want to have
transparent sector <-> inode <-> filename translation, and kernel have
arrows going only one way (left).

In particular there are certain tasks (loading KDE, emacs, other big
programs) that involve an unusual amount of seeking (configuration files)
but the program is not usable until it's loaded. If we reorder them (and
this we can do since you don't often change location of emacs and it's 
Lisp code) and load them all sequentially this should speed up process a
lot. (I don't have UDMA for nothing).

For an unfinished work look at http://www.math.upenn.edu/~vdergach/Linux
(this is a program that speeds up booting. It doesn't sort sectors, but
it does sort things by inode - and what do you think ? - it speeds up
booting by several seconds. The reason for this is Linux's load on demand
feature. Executable is not loaded right away, but only when a page fault 
occurs. Now this is faster then loading entire executables (I checked),
but if we load right away only pages that we need we get further speedup).

                       Vladimir Dergachev

On Tue, 17 Nov 1998, Larry McVoy wrote:

> Another thought on all of this discussion about disk sort.  Something that
> I think would make a far greater /perceived/ difference would be some sort
> of priority based sorting.  The problem that should be solved is to have
> page faults for bash/emacs/whatever be "right now" and page faults for
> other stuff be "later".  It's an open issue as to how you distinguish.
> The first pass is that reads get higher priority than writes and that
> is obviously wrong - you'll end up with all of memory being full of
> dirty pages.
> 
> The next pass is to bump the priority on pages with the execute bit on;
> that will handle the instructions nicely, I don't see a down side to it,
> maybe someone else does.
> 
> The next pass is to bump the priority on pages that are in the swap
> partition and associated with the data segment.  This is a little dicey
> - if we ever go to the one-swap-file-per-process idea that I've posted
> here about a year ago, then this gets easier.
> 
> Anyway, the bottom line is that you want the system to do two things
> 
> 	a) have reasonable latency and great throughput for most stuff
> 	b) have really good latency for some stuff
> 
> I believe that you'll never accomplish that with disk sorting algs.
> The disk sort routine isn't given all the information it needs to
> accomplish those goals.  So, if we agree that we want something like
> I'm describing, then messing about with disk sort, while interesting and
> something that every real OS guy does at some point, is a futile exercise.
> 
> My point here is to encourage people not to stop if they decide that disk
> sorting doesn't really help that much.  I think there is some performance
> win that can happen if you think past the confines of the disk sort alg
> and go up to a higher level and look at the problem you're really trying
> to solve.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
