Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157321-27300>; Sat, 30 Jan 1999 18:53:20 -0500
Received: by vger.rutgers.edu id <157212-27300>; Sat, 30 Jan 1999 18:53:12 -0500
Received: from [207.181.251.162] ([207.181.251.162]:2056 "EHLO bitmover.com" ident: "root") by vger.rutgers.edu with ESMTP id <157218-27300>; Sat, 30 Jan 1999 18:52:53 -0500
Message-Id: <199901310004.QAA01165@bitmover.com>
To: linux-kernel@vger.rutgers.edu
From: lm@bitmover.com (Larry McVoy)
Subject: Re: Page coloring HOWTO [ans] 
Date: Sat, 30 Jan 1999 16:04:51 -0800
Sender: owner-linux-kernel@vger.rutgers.edu

Richard Gooch <rgooch@atnf.csiro.au>:
: > : >     (a) make sure that each process maps the same virtual addresses to 
: > : >         different locations in the cache, if possible.
: > : 
: > : >     (b) make sure that a contiguous chunk of virtual address space in
: > : >         one process occupies a contiguous chunk of cache, if possible.
: 
: OK, I was reading points (a) and (b) as though they were, in effect,
: the required specificiations for an algorithm to yield the best
: pages. Are they just comments on how the particular algorithm you
: mentioned works?
: 
: I'd like to speparate this into two issues. Firstly, requirements on
: how to lay out physical pages to minimise cache line aliasing.

Huh?  Direct mapped caches are all virtually indexed and physically
tagged, if I remember correctly.  Regardless, the buckets into which the
pages are sorted are set up such that if you were to allocate one page
from each bucket, then all of the pages would land in different chunks
of the cache by definition.   That's why you hash on physical addresses
when sorting the pages.

When looking for a page, you hash on the process' virtual address (plus
pid offset) because you have to have something, and what else are you
going to use?  That's the only deterministic thing you have.

: For the former issue, I'd like to establish whether you are saying
: that points (a) and (b) provide better pages than the simple "add plus
: modulus" scheme of generating goal colours?

It's not a question of "better", it's a question of "correct".  And you
don't generate colors for the physical pages except when you put them
in the buckets.  

I think you are mixing up the virtual addresses and physical addresses in
your thinking.  Do you a copy of Hennessy and Patterson?  I'm sure they 
talk about this or provide a pointer to a paper on it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
