Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263365AbRFTDzG>; Tue, 19 Jun 2001 23:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbRFTDy4>; Tue, 19 Jun 2001 23:54:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31522 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261268AbRFTDyj>; Tue, 19 Jun 2001 23:54:39 -0400
Date: Wed, 20 Jun 2001 05:54:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: softirq in pre3 and all linux ports
Message-ID: <20010620055413.A849@athlon.random>
In-Reply-To: <20010619210312.Z11631@athlon.random> <15152.6527.366544.713462@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15152.6527.366544.713462@cargo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Jun 20, 2001 at 01:33:19PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 01:33:19PM +1000, Paul Mackerras wrote:
> Well, I object to the "without thinking" bit. [..]

agreed, apologies.

> BHs disabled is buggy - why would you want to do that?  And if we do

tasklet_schedule

> want to allow that, shouldn't we put the check in raise_softirq or the
> equivalent, to get the minimum latency?

We should release the stack before running the softirq (some place uses
softirqs to release the stack and avoid overflows).

> Soft irqs should definitely not be much heavier than an irq handler,
> if they are then we have implemented them wrongly somehow.

ip + tcp are more intensive than just queueing a packet in a blacklog.
That's why they're not done in irq context in first place.

> ksoftirqd seems like the wrong solution to the problem to me, if we
> really getting starved by softirqs then we need to look at whether
> whatever is doing it should be a kernel thread itself rather than
> doing it in softirqs.  Do you have a concrete example of the
> starvation/live lockup that you can describe to us?

I don't have gigabit ethernet so I cannot flood my boxes to death.
But I think it's real, and a softirq marking itself runnable again is
another case to handle without live lockups or starvation.

Andrea
