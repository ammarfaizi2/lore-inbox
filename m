Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbVLRBWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbVLRBWM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 20:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVLRBWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 20:22:12 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2434 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932659AbVLRBWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 20:22:10 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Lee Revell <rlrevell@joe-job.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
       Joe Korty <joe.korty@ccur.com>, Thomas Gleixner <tglx@linutronix.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com
In-Reply-To: <20051218002132.GI2361@parisc-linux.org>
References: <1134770778.2806.31.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.64.0512161414370.3698@g5.osdl.org>
	 <1134772964.2806.50.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.64.0512161439330.3698@g5.osdl.org>
	 <20051217002929.GA7151@tsunami.ccur.com>
	 <Pine.LNX.4.64.0512161647570.3698@g5.osdl.org>
	 <Pine.LNX.4.58.0512162211320.6498@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.0512162323140.3698@g5.osdl.org>
	 <20051217234305.GH2361@parisc-linux.org>
	 <1134864321.11227.52.camel@mindpipe>
	 <20051218002132.GI2361@parisc-linux.org>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 20:25:21 -0500
Message-Id: <1134869122.11227.68.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 17:21 -0700, Matthew Wilcox wrote:
> On Sat, Dec 17, 2005 at 07:05:21PM -0500, Lee Revell wrote:
> > On Sat, 2005-12-17 at 16:43 -0700, Matthew Wilcox wrote:
> > > I have a better example of something we currently get wrong that I
> > > haven't heard any RT person worry about yet.  If two tasks are sleeping
> > > on the same semaphore, the one to be woken up will be the first one to
> > > wait for it, not the highest-priority task.
> > > 
> > > Obviously, this was introduced by the wake-one semantics.  But how to
> > > fix it?  Should we scan the entire queue looking for the best task to
> > > wake?  Should we try to maintain the wait list in priority order?  Or
> > > should we just not care?  Should we document that we don't care?  ;-)
> > 
> > It's well known that this is a problem:
> > 
> > http://developer.osdl.org/dev/robustmutexes/src/fusyn.hg/Documentation/fusyn/fusyn-why.txt
> 
> Erm.  That paper is talking about user-space semaphores based on futexes.
> I'm talking about kernel semaphores.  At a first glance, fixing futexes
> would be a very different job from fixing semaphores.
> 
> BTW, fuqueues?  HAHAHAHA.
> 

Hmm, interesting, so in fact the scheduler does not always run the
highest priority runnable process?  Do you have a test case where
userspace would experience priority inversion due to this?

Maybe it has not been a problem as all the PI cases would involve two RT
processes that make system calls which end up blocking on a semaphore in
the kernel, which is bad RT design anyway - normally you would separate
the RT parts of the app which carefully avoid possibly blocking system
calls from the non RT parts and communicate via lock free ringbuffers or
a similar mechanism.

Lee

