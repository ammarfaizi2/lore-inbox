Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbRE0T4F>; Sun, 27 May 2001 15:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262099AbRE0Tz4>; Sun, 27 May 2001 15:55:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21040 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262084AbRE0Tzt>; Sun, 27 May 2001 15:55:49 -0400
Date: Sun, 27 May 2001 21:55:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5
Message-ID: <20010527215528.A731@athlon.random>
In-Reply-To: <20010527195619.K676@athlon.random> <Pine.LNX.4.33.0105272101480.5852-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105272101480.5852-100000@localhost.localdomain>; from mingo@elte.hu on Sun, May 27, 2001 at 09:05:50PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 09:05:50PM +0200, Ingo Molnar wrote:
> 
> On Sun, 27 May 2001, Andrea Arcangeli wrote:
> 
> > I mean everything is fine until the same softirq is marked active
> > again under do_softirq, in such case neither the do_softirq in do_IRQ
> > will run it (because we are in the critical section and we hold the
		 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > per-cpu locks), nor we will run it again ourself from the underlying
    ^^^^^^^^^^^^^
> > do_softirq to avoid live locking into do_softirq.
> 
> if you mean the stock kernel, this scenario you describe is not how it

Yes the stock kernel.

> behaves, because only IRQ contexts can mark a softirq active again. And
> those IRQ contexts will run do_IRQ() naturally, so while *this*
> do_softirq() invocation wont run those reactivated softirqs, the IRQ
> context that just triggered the softirq will do so.

it won't because the underlying do_softirq did local_bh_disable() and
the in_interrupt() check will cause the do_softirq from do_IRQ to return
immediatly.

Andrea
