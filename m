Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUGMA2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUGMA2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUGMA11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:27:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:60375 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264531AbUGMA0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:26:10 -0400
Date: Mon, 12 Jul 2004 17:24:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: albert@users.sourceforge.net, linux-kernel@vger.kernel.org, florin@sgi.com,
       linux-audio-dev@music.columbia.edu
Subject: Re: desktop and multimedia as an afterthought?
Message-Id: <20040712172458.2659db52.akpm@osdl.org>
In-Reply-To: <200407122354.i6CNsNqS003382@localhost.localdomain>
References: <1089665153.1231.88.camel@cube>
	<200407122354.i6CNsNqS003382@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis <paul@linuxaudiosystems.com> wrote:
>
> >It's too bad that the multimedia community didn't participate
> >much during the 2.5.xx development leading up to 2.6.0. If they
> >had done so, the situation might be different today. Fortunately,
> >fixing up the multimedia problems isn't too risky to do during
> >the stable 2.6.xx series.
> 
> I regret that this description is persisting here. "We" (the audio
> developer community) did not participate because it was made clear
> that our needs were not going to be considered. We were told that the
> preemption patch was sufficient to provide "low latency", and that
> rescheduling points dotted all over the place was bad engineering
> (probably true). With this as the pre-rendered verdict, there's not a
> lot of point in dedicating time to tracking a situation that clearly
> is not going to work.

No, this is wrong.  2.6+preempt can satisfy your latency requirements
without any scheduling points.  All it requires is that the long-held locks
be addressed.  I've already done a metric ton of work in that area (notably
removal of the buffer_head LRUs and rewriting the truncate code) but more
apparently remains to be done.  We know that reiserfs has problems.

But what can I do?  I set up a preempt-on-ext3 test box, thrash the crap
out of it and see 300 usecs worst-case latency.  So I am left empty-handed,
wondering what on earth is happening out there.

I am deeply skeptical about claims that autoregulated swappiness can make
any difference.

I am deeply skeptical about claims that CPU scheduler changes make any
difference.  A scheduler change shouldn't improve responsiveness of
!SCHED_OTHER tasks at all, so perhaps there are application priority
inversion problems, or applications aren't setting SCHED_FIFO/RR correctly.
I do not know.

I am also fairly skeptical about claims that voluntary-preempt helps,
because it only pops a couple of locks, and I doubt that testers are
hitting the code paths which those changes address anyway.

So Something Is Up, and I don't know what it is.

Please double-check that there are no priority inversion problems and that
the application is correctly setting the scheduling policy and that it is
mlocking everything appropriately.

And please ensure that people are setting xrun_debug, and are sending
reports.

> The kernel is not going to provide adequate latency for multimedia
> needs without either (1) latency issues being front and center in
> every kernel developer's mind, which seems unlikely and/or (2)
> conditional rescheduling points added to the kernel, which appears to
> require non-mainstreamed patches.
> 

Nope, the conditional rescheduling points provide zero benefit on a
preemptible kernel.

Something weird is happening, I don't know what it is, I cannot reproduce
it and I need help understanding what it is, OK?  The sooner we can do
that, the sooner it gets fixed up.
