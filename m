Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264824AbUEQCNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264824AbUEQCNd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 22:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264835AbUEQCNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 22:13:33 -0400
Received: from taco.zianet.com ([216.234.192.159]:50188 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S264824AbUEQCN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 22:13:27 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Sun, 16 May 2004 20:12:56 -0600
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, adi@bitmover.com,
       scole@lanl.gov, support@bitmover.com, linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <200405161611.17688.elenstev@mesatop.com> <20040516235310.GZ3044@dualathlon.random>
In-Reply-To: <20040516235310.GZ3044@dualathlon.random>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405162012.57066.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 May 2004 05:53 pm, Andrea Arcangeli wrote:
> On Sun, May 16, 2004 at 04:11:16PM -0600, Steven Cole wrote:
> > On Sunday 16 May 2004 03:29 pm, Andrew Morton wrote:
> > > Steven Cole <elenstev@mesatop.com> wrote:
> > > >
> > > > Anyway, although the regression for my particular machine for this
> > > >  particular load may be interesting, the good news is that I've seen
> > > >  none of the failures which started this whole thread, which are relatively
> > > >  easily reproduceable with PREEMPT set.  
> > > 
> > > So...  would it be correct to say that with CONFIG_PREEMPT, ppp or its
> > > underlying driver stack
> > > 
> > > a) screws up the connection and hangs and
> > > 
> > > b) scribbles on pagecache?
> > > 
> > > Because if so, the same will probably happen on SMP.
> > > 
> > Perhaps someone has the hardware to test this.
> > 
> > To summarize my experience with the past 24 hours of testing:
> > Without PREEMPT , everything is rock solid. 
> 
> so we've two separate problems: the first is the ppp instability with
> preempt, the second is a regresion in the vm heuristics between 2.6.3
> and 2.6.5.
Yes, that is correct.
The instability was first noticed about one month ago when doing
a bk pull from linus' repository.  I've been updating my kernel via
bk almost nightly, and around the time of 2.6.6-rc1 (IIRC), I got the
Assertion `s && s->tree' failed message from bk.  At first it was thought
to be related to using an older version (3.0.1) of bk, so that was updated.
A few days later, the problem recurred.  Since it only happened about
15% to 20% of the time, and was easy to recover from, I didn't scream
too loudly or too often to bitmover.  But then, the problem started becoming
more persistent about a week ago, so I began complaining again.  I managed
to get a bitkeeper-generated file to bitmover, who discovered that a very
odd (or even in this case) number of NUL bytes existed where they 
should not exist.  Hence this thread.

Then during the course of testing, I noticed the significant difference
in time it took to run a test script supplied by bitkeeper for current kernels
versus an older vendor kernel.  Hence your being cc'ed.


> 
> > and I (cringes at the thought) may repeat some bk pulls with
> > PREEMPT set.
> 
> I've heard other reports of preempt being unstable with some sound
> stuff, just in case are you using sound drivers at all during that
> workload?
> 
> 
Yes, mea culpa.  CONFIG_SND_ENS1371=y.  

Steven
