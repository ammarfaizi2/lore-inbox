Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbVLRAVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVLRAVe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 19:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVLRAVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 19:21:34 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:13289 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S965020AbVLRAVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 19:21:33 -0500
Date: Sat, 17 Dec 2005 17:21:32 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
       Joe Korty <joe.korty@ccur.com>, Thomas Gleixner <tglx@linutronix.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051218002132.GI2361@parisc-linux.org>
References: <1134770778.2806.31.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161414370.3698@g5.osdl.org> <1134772964.2806.50.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161439330.3698@g5.osdl.org> <20051217002929.GA7151@tsunami.ccur.com> <Pine.LNX.4.64.0512161647570.3698@g5.osdl.org> <Pine.LNX.4.58.0512162211320.6498@gandalf.stny.rr.com> <Pine.LNX.4.64.0512162323140.3698@g5.osdl.org> <20051217234305.GH2361@parisc-linux.org> <1134864321.11227.52.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134864321.11227.52.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 07:05:21PM -0500, Lee Revell wrote:
> On Sat, 2005-12-17 at 16:43 -0700, Matthew Wilcox wrote:
> > I have a better example of something we currently get wrong that I
> > haven't heard any RT person worry about yet.  If two tasks are sleeping
> > on the same semaphore, the one to be woken up will be the first one to
> > wait for it, not the highest-priority task.
> > 
> > Obviously, this was introduced by the wake-one semantics.  But how to
> > fix it?  Should we scan the entire queue looking for the best task to
> > wake?  Should we try to maintain the wait list in priority order?  Or
> > should we just not care?  Should we document that we don't care?  ;-)
> 
> It's well known that this is a problem:
> 
> http://developer.osdl.org/dev/robustmutexes/src/fusyn.hg/Documentation/fusyn/fusyn-why.txt

Erm.  That paper is talking about user-space semaphores based on futexes.
I'm talking about kernel semaphores.  At a first glance, fixing futexes
would be a very different job from fixing semaphores.

BTW, fuqueues?  HAHAHAHA.
