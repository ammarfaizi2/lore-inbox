Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129996AbRABWib>; Tue, 2 Jan 2001 17:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRABWiW>; Tue, 2 Jan 2001 17:38:22 -0500
Received: from hermes.mixx.net ([212.84.196.2]:56580 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129996AbRABWiP>;
	Tue, 2 Jan 2001 17:38:15 -0500
Message-ID: <3A52508D.72C5419D@innominate.de>
Date: Tue, 02 Jan 2001 23:05:01 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move xchg/cmpxchg to atomic.h
In-Reply-To: <200101021121.DAA14657@pizda.ninka.net> <Pine.GSO.4.10.10101022125570.20383-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> On Tue, 2 Jan 2001, David S. Miller wrote:
> 
> >    We really can't.  We _only_ have load-and-zero.  And it has to be
> >    16-byte aligned.  xchg() is just not something the CPU implements.
> >
> > Oh bugger... you do have real problems.
> 
> For 2.5 we could move all the atomic functions from atomic.h, bitops.h,
> system.h and give them a common interface. We could also give them a new
> argument atomic_spinlock_t, which is a normal spinlock, but only used on
> architectures which need it, everyone else can "optimize" it away. I think
> one such lock per major subsystem should be enough, as the lock is only
> held for a very short time, so contentation should be no problem.
> Anyway, this had the huge advantage that we could use the complete 32/64
> bit of the atomic value, e.g. for pointer operations.

*Yes*, and I could write:
	waiters = xchg(&bdflush_waiters.counter, 0);

instead of:
        waiters = atomic_read(&bdflush_waiters);
        atomic_sub(waiters, &bdflush_waiters);

in my daemon wakeup patch.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
