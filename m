Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153928-8316>; Thu, 10 Sep 1998 02:34:35 -0400
Received: from 3dyn66.delft.casema.net ([195.96.104.66]:12929 "EHLO rosie.BitWizard.nl" ident: "root") by vger.rutgers.edu with ESMTP id <154389-8316>; Thu, 10 Sep 1998 01:59:12 -0400
Message-Id: <199809100836.KAA00899@cave.BitWizard.nl>
Subject: Re: GPS Leap Second Scheduled!
In-Reply-To: <19980910114515.A20254@caffeine.ix.net.nz> from Chris Wedgwood at "Sep 10, 98 11:45:15 am"
To: chris@cybernet.co.nz (Chris Wedgwood)
Date: Thu, 10 Sep 1998 10:36:12 +0200 (MEST)
Cc: colin@nyx.net, tytso@MIT.EDU, andrejp@luz.fe.uni-lj.si, linux-kernel@vger.rutgers.edu
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Chris Wedgwood wrote:
> On Wed, Sep 09, 1998 at 02:13:42PM -0600, Colin Plumb wrote:
> 
> > - gettimeofday() never returns the same value twice (documented BSD
> >   behaviour)
> 
> Ouch... gettimeofday(2) only presently has usec resolution. I suspect
> we can make this report the same value twice on really high end boxes
> (667MHz Alpha maybe, 400Mhz Sparcs?), if not now, in a year or so.
> Even a P.ii 600 or so can probably manage it.

This is defined behaviour. On processors where gettimeofday can be
called more than once in a microsecond (SMP systems, and fast
systems), the kernel is required to keep a last-time-returned, and
increment it and return that if the value calculated is below the
stored value.

If you have the results from two gettimeofday calls, you can always
subtract them and divide by the result without checking for zero.
That's what the spec says.

A kernel will get into trouble if you keep on calling gettimeofday
more than a million times a second..... 

					Roger. 

-- 
| The secret of success is sincerity. Once you can |R.E.Wolff@BitWizard.nl 
| fake that, you've got it made. -- Jean Giraudoux | phone: +31-15-2137555 
We write Linux device drivers for any device you may have! fax: ..-2138217

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
