Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264624AbTIDDTa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264616AbTIDDT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:19:29 -0400
Received: from [209.195.52.120] ([209.195.52.120]:53738 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S264624AbTIDDTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:19:21 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org
Date: Wed, 3 Sep 2003 20:16:16 -0700 (PDT)
Subject: Re: Scaling noise
In-Reply-To: <9110000.1062643682@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0309032004120.17581-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Martin J. Bligh wrote:

> >> --Larry McVoy <lm@bitmover.com> wrote (on Wednesday, September 03, 2003 17:36:33 -0700):
> >> > They have to be, CPUs are fast enough
> >> > to handle most problems, clustering has worked for lots of big companies
> >> > like Google, Amazon, Yahoo, and the HPC market has been flat for years.
> >> > So where's the growth?  Nowhere I can see.  If I'm not seeing it, show
> >> > me the data.  I may be a pain in the ass but I'll change my mind instantly
> >> > when you show me data that says something different than what I believe.
> >> > So far, all I've seen is people having fun proving that their ego is
> >> > bigger than the next guys, no real data.  Come on, you'd love nothing
> >> > better than to prove me wrong.  Do it.  Or admit that you can't.
> >>
> >> Not quite sure why the onus is on the rest of us to disprove your pet
> >> theory, rather than you to prove it.
> >
> > Maybe because history has shown over and over again that your pet theory
> > doesn't work.  Mine might be wrong but it hasn't been proven wrong.  Yours
> > has.  Multiple times.
>
> Please, this makes no sense. Why do you think IBM and others make large
> machines? Stupidity? From my experience they're hard assed "if it don't
> make a profit, nor is likely to, then it can piss off" marketeers. Which
> often pisses me off, but still ... if it didn't make money, they wouldn't
> do it. And no, I can't go get you internal confidential sales figures,
> but I'll bet you we're not selling these things at a loss for our own
> general self-flagellating amusement.
>
> I don't think you're stupid, but please ... who do you think has better
> data on this? IBM market research people? or you? I think I'd bet on IBM.

there are some problems that don't scale well to multiple machines/images
(large databases, huge working sets, etc). and there are other cases where
the problem may be able to scale to multiple machines, but the software
was badly written and so the software won't.

in these cases all you can do is to buy a bigger box, however inefficantly
you use the extra processors.

I know one company a couple years ago that looked at buying a 24 CPU IBM
machine but found that it was outperformed by a pair of 4 CPU IBM machines
(all running the same version of AIX, and the same application software).
in this case they hit a AIX limit that more CPU's/RAM couldn't help with,
but more copies of the OS could.

as CPU speeds climb and the relative penalty for going off the chip for
any reason climb even faster the hardware overhead of keeping a SMP
machine coherant becomes more significant. sometimes this can be solved by
changing the algorithm (the O(1) scheduler for example) but other times
you just have to accept the costof bouncing a cache line from one CPU to
another so that you can aquire a lock.

the advantage of multiple images is that the hardware only needs to
maintain full speed consistancy between CPU's in one image, a higher level
(the OS or the partitioning software) can deal with the issues of letting
one image know what it needs to about what the others are doing.

some of these problems can be addressed in hardware (the Opteron could be
called SSI-NUMA that has it's partitioning layer running in hardware
for up to 8 CPU's) but addressing it in hardware runs into scaling
problems becouse you don't want to pay to much at the low end for the
features you need on the high end (which is why the opteron doesn't
directly scale to 128+ CPU's in one image)

David Lang
