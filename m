Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154473-8316>; Thu, 10 Sep 1998 10:34:20 -0400
Received: from adsl179.mpls.uswest.net ([209.180.29.179]:4311 "EHLO adsl179.mpls.uswest.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154698-8316>; Thu, 10 Sep 1998 10:27:07 -0400
Date: Thu, 10 Sep 1998 12:05:25 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Chris Wedgwood <chris@cybernet.co.nz>, colin@nyx.net, tytso@MIT.EDU, andrejp@luz.fe.uni-lj.si, linux-kernel@vger.rutgers.edu
Subject: Re: GPS Leap Second Scheduled!
In-Reply-To: <199809100836.KAA00899@cave.BitWizard.nl>
Message-ID: <Pine.LNX.3.96.980910120009.27760F-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 10 Sep 1998, Rogier Wolff wrote:

> Chris Wedgwood wrote:
> > On Wed, Sep 09, 1998 at 02:13:42PM -0600, Colin Plumb wrote:
> > 
> > > - gettimeofday() never returns the same value twice (documented BSD
> > >   behaviour)
> > 
> > Ouch... gettimeofday(2) only presently has usec resolution. I suspect
> > we can make this report the same value twice on really high end boxes
> > (667MHz Alpha maybe, 400Mhz Sparcs?), if not now, in a year or so.
> > Even a P.ii 600 or so can probably manage it.
> 
> This is defined behaviour. On processors where gettimeofday can be
> called more than once in a microsecond (SMP systems, and fast
> systems), the kernel is required to keep a last-time-returned, and
> increment it and return that if the value calculated is below the
> stored value.

Seems wrong to bother the kernel with this at all. Any complexity here
should be put in libc. After all, the problem is largely with the ANSI C
spec.

Also, putting any of this 'hide the leap second' logic in the kernel makes
it more difficult to later add a consistent interface to libc as the
information is now hidden in the kernel. 

Finally, telling the kernel to schedule a leap second seems pretty ugly as
well.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
