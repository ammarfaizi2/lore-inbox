Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153992-8316>; Wed, 9 Sep 1998 18:09:54 -0400
Received: from caffeine.ix.net.nz ([203.97.100.28]:4716 "EHLO caffeine.ix.net.nz" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154985-8316>; Wed, 9 Sep 1998 17:10:07 -0400
Date: Thu, 10 Sep 1998 11:45:15 +1200
From: Chris Wedgwood <chris@cybernet.co.nz>
To: Colin Plumb <colin@nyx.net>, tytso@MIT.EDU
Cc: andrejp@luz.fe.uni-lj.si, linux-kernel@vger.rutgers.edu
Subject: Re: GPS Leap Second Scheduled!
Message-ID: <19980910114515.A20254@caffeine.ix.net.nz>
References: <199809092013.OAA10252@nyx10.nyx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.94.5i
In-Reply-To: <199809092013.OAA10252@nyx10.nyx.net>; from Colin Plumb on Wed, Sep 09, 1998 at 02:13:42PM -0600
X-No-Archive: Yes
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, Sep 09, 1998 at 02:13:42PM -0600, Colin Plumb wrote:

> - gettimeofday() never returns the same value twice (documented BSD
>   behaviour)

Ouch... gettimeofday(2) only presently has usec resolution. I suspect
we can make this report the same value twice on really high end boxes
(667MHz Alpha maybe, 400Mhz Sparcs?), if not now, in a year or so.
Even a P.ii 600 or so can probably manage it.

Sure... this is fixable and not hard to fix, but it requires breaking
binary compatibility.

The attached code on a PPro 200 gives me results of 2 usecs, using a
P.II 300 and SYSENTER semantics, you can probably get this to less
that 1usec.

> I don't know of a pretty way.  What I'd like, as I said, is a
> defined kludge, so that there is a defined mapping between struct
> timeval and struct timespec and UTC in the vicinity of a leap
> second.

I'm not sure about a sane kludge for mapping to/from the semantics we
already have, but how about we just declare the existing API buggy
under some (rare circumstances) and create a new one with flags to
show whether or not a leap second is currently under way, much the
same as is done for daylight savings time with time zones. (You can
have two 2:30ams, only one of which tough is DST, the other is
non-DST).



-Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
