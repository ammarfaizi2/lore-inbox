Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbRDUOaO>; Sat, 21 Apr 2001 10:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132658AbRDUOaF>; Sat, 21 Apr 2001 10:30:05 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8799 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132655AbRDUO3z>; Sat, 21 Apr 2001 10:29:55 -0400
Date: Sat, 21 Apr 2001 16:29:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "D . W . Howells" <dhowells@astarte.free-online.co.uk>,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: x86 rwsem in 2.4.4pre[234] are still buggy [was Re: rwsem benchmarks [Re: generic rwsem [Re: Alpha "process table hang"]]]
Message-ID: <20010421162926.D17757@athlon.random>
In-Reply-To: <20010420191710.A32159@athlon.random> <Pine.LNX.4.31.0104201639070.6299-100000@penguin.transmeta.com> <20010421160327.A17757@athlon.random> <20010421151737.A7576@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010421151737.A7576@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Apr 21, 2001 at 03:17:37PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 03:17:37PM +0100, Russell King wrote:
> On Sat, Apr 21, 2001 at 04:03:27PM +0200, Andrea Arcangeli wrote:
> > On Fri, Apr 20, 2001 at 04:45:32PM -0700, Linus Torvalds wrote:
> > > I would suggest the following:
> > > 
> > >  - the generic semaphores should use the lock that already exists in the
> > >    wait-queue as the semaphore spinlock.
> > 
> > Ok, that is what my generic code does.
> 
> Erm, spin_lock()?  What if up_read or up_write gets called from interrupt
> context (is this allowed)?

That it is allowed by my generic code that does spin_lock_irq in down_* and
spin_lock_irqsave in up_* but it's disallowed by the weaker semantics of the
generic and x86 semaphores 2.4.4pre[2345] (or + David's last patch).

> If these are now allowed, then maybe we should either consider getting
> the Stanford checker to check for this, or else we ought to do a debugging
> if (in_interupt()) BUG(); thing.

Caller bug is the last of my worries. (and I seriously doubt that if somebody
doesn't know the semantics of the rwsem, he will care to enable the debugging
checks during regression testing ;)

Andrea
