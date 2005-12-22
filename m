Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVLVMnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVLVMnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 07:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVLVMns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 07:43:48 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:19164
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932419AbVLVMns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 07:43:48 -0500
Date: Thu, 22 Dec 2005 04:40:27 -0800
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Joe Korty <joe.korty@ccur.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051222124027.GB14633@gnuppy.monkey.org>
References: <1134769269.2806.17.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161339140.3698@g5.osdl.org> <1134770778.2806.31.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161414370.3698@g5.osdl.org> <1134772964.2806.50.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161439330.3698@g5.osdl.org> <20051217002929.GA7151@tsunami.ccur.com> <Pine.LNX.4.64.0512161647570.3698@g5.osdl.org> <Pine.LNX.4.58.0512162211320.6498@gandalf.stny.rr.com> <Pine.LNX.4.64.0512162323140.3698@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512162323140.3698@g5.osdl.org>
User-Agent: Mutt/1.5.11
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 11:34:03PM -0800, Linus Torvalds wrote:
> For example, to make things really concrete, please just name a semaphore 
> that is relevant to a real-time task and that isn't fine enough grain that 
> a careful and controlled environment can't avoid it being a bottle-neck 
> for a real-time task.

Problem here is ownership tracking with a semaphore is an extremely difficult
problem to solve without serializing the entire thing with a single spinlock.
You lose parallelism here and possible create other problems since the
contention window is larger surround critical sections using it.

> The real problems often end up happening in things like memory management, 
> and waiting for IO, where it's not about the locking at all, it's about 
> event scheduling. And you just have to avoid those (through pre-allocation 
> and buffering) in those kinds of real-time situations.
> 
> I really can't think of any blocking kernel lock where priority 
> inheritance would make _any_ sense at all. Please give me an example. 

The current kernel mostly using traditional spinlocks doesn't have locking
complicated enough to warrant it. However, the -rt patch does create a
circumstance where a fully preemptible may sleep task with mutexes held create
and needs resolve priority inversions that results from it. That's of
course assuming that priority is something that needs to be strictly
obeyed in this variant of the kernel with consideration to priority
inheritance.

bill

