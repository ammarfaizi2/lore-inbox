Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264886AbUGMLKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbUGMLKX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 07:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264897AbUGMLKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 07:10:23 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:32395 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264886AbUGMLJz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 07:09:55 -0400
Subject: Re: desktop and multimedia as an afterthought?
From: Kasper Sandberg <lkml@metanurb.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>, albert@users.sourceforge.net,
       LKML Mailinglist <linux-kernel@vger.kernel.org>, florin@sgi.com,
       linux-audio-dev@music.columbia.edu
In-Reply-To: <20040712172458.2659db52.akpm@osdl.org>
References: <1089665153.1231.88.camel@cube>
	 <200407122354.i6CNsNqS003382@localhost.localdomain>
	 <20040712172458.2659db52.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 13 Jul 2004 13:09:49 +0200
Message-Id: <1089716989.10973.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 17:24 -0700, Andrew Morton wrote:
> Paul Davis <paul@linuxaudiosystems.com> wrote:
> >
> > >It's too bad that the multimedia community didn't participate
> > >much during the 2.5.xx development leading up to 2.6.0. If they
> > >had done so, the situation might be different today. Fortunately,
> > >fixing up the multimedia problems isn't too risky to do during
> > >the stable 2.6.xx series.
> > 
> > I regret that this description is persisting here. "We" (the audio
> > developer community) did not participate because it was made clear
> > that our needs were not going to be considered. We were told that the
> > preemption patch was sufficient to provide "low latency", and that
> > rescheduling points dotted all over the place was bad engineering
> > (probably true). With this as the pre-rendered verdict, there's not a
> > lot of point in dedicating time to tracking a situation that clearly
> > is not going to work.
> 
> No, this is wrong.  2.6+preempt can satisfy your latency requirements
> without any scheduling points.  All it requires is that the long-held locks
> be addressed.  I've already done a metric ton of work in that area (notably
> removal of the buffer_head LRUs and rewriting the truncate code) but more
> apparently remains to be done.  We know that reiserfs has problems.
> 
> But what can I do?  I set up a preempt-on-ext3 test box, thrash the crap
> out of it and see 300 usecs worst-case latency.  So I am left empty-handed,
> wondering what on earth is happening out there.
> 
> I am deeply skeptical about claims that autoregulated swappiness can make
> any difference.
> 
> I am deeply skeptical about claims that CPU scheduler changes make any
> difference.  A scheduler change shouldn't improve responsiveness of
> !SCHED_OTHER tasks at all, so perhaps there are application priority
> inversion problems, or applications aren't setting SCHED_FIFO/RR correctly.
> I do not know.
sorry to interrupt, and i dont know if i get this right, but i have been
using nick piggins patch for quite some time, and it really does
magic :)
> 
> I am also fairly skeptical about claims that voluntary-preempt helps,
> because it only pops a couple of locks, and I doubt that testers are
> hitting the code paths which those changes address anyway.
> 
> So Something Is Up, and I don't know what it is.
> 
> Please double-check that there are no priority inversion problems and that
> the application is correctly setting the scheduling policy and that it is
> mlocking everything appropriately.
> 
> And please ensure that people are setting xrun_debug, and are sending
> reports.
> 
> > The kernel is not going to provide adequate latency for multimedia
> > needs without either (1) latency issues being front and center in
> > every kernel developer's mind, which seems unlikely and/or (2)
> > conditional rescheduling points added to the kernel, which appears to
> > require non-mainstreamed patches.
> > 
> 
> Nope, the conditional rescheduling points provide zero benefit on a
> preemptible kernel.
> 
> Something weird is happening, I don't know what it is, I cannot reproduce
> it and I need help understanding what it is, OK?  The sooner we can do
> that, the sooner it gets fixed up.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

