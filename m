Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272257AbRIVVdK>; Sat, 22 Sep 2001 17:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272264AbRIVVdA>; Sat, 22 Sep 2001 17:33:00 -0400
Received: from [195.223.140.107] ([195.223.140.107]:7671 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S272257AbRIVVcy>;
	Sat, 22 Sep 2001 17:32:54 -0400
Date: Sat, 22 Sep 2001 23:33:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roger Larsson <roger.larsson@norran.net>
Cc: Robert Love <rml@tech9.net>, Andre Pang <ozone@algorithm.com.au>,
        linux-kernel@vger.kernel.org, safemode@speakeasy.net,
        Dieter.Nuetzel@hamburg.de, iafilius@xs4all.nl, ilsensine@inwind.it,
        george@mvista.com
Subject: Re: ksoftirqd? (Was: Re: [PATCH] Preemption Latency Measurement Tool)
Message-ID: <20010922233310.A1788@athlon.random>
In-Reply-To: <1000939458.3853.17.camel@phantasy> <200109221301.f8MD1n129687@mailc.telia.com> <20010922151453.B976@athlon.random> <200109222056.f8MKu8K24322@maile.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109222056.f8MKu8K24322@maile.telia.com>; from roger.larsson@norran.net on Sat, Sep 22, 2001 at 10:51:16PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 10:51:16PM +0200, Roger Larsson wrote:
> On Saturday 22 September 2001 15.14, Andrea Arcangeli wrote:
> > On Sat, Sep 22, 2001 at 02:56:58PM +0200, Roger Larsson wrote:
> > > Hi,
> > >
> > > We have a new kid on the block since we started thinking of a preemptive
> > > kernel.
> > >
> > > ksoftirqd...
> > >
> > > Running with nice 19 (shouldn't it really be -19?)
> 
> I repeat this question - should it be nice 19 and not nice -19 (not nice)?

Being it +19 it is light with respect to the other tasks in the system,
mainly considering there's one for each cpu.

> Sep 22 22:37:38 jeloin logger: *** ./stress_dbench begin ***
> Sep 22 22:37:42 jeloin kernel: ksoftirqd: do_softirq
> Sep 22 22:37:44 jeloin last message repeated 2 times
> Sep 22 22:37:48 jeloin kernel: Latency   8ms PID     7 %% kupdated
> Sep 22 22:37:49 jeloin kernel: ksoftirqd: do_softirq
> Sep 22 22:38:19 jeloin last message repeated 18 times
> Sep 22 22:38:20 jeloin su: (to root) roger on /dev/pts/2
> Sep 22 22:38:20 jeloin PAM-unix2[988]: session started for user root, service 
> su
> Sep 22 22:38:23 jeloin kernel: ksoftirqd: do_softirq
> Sep 22 22:38:24 jeloin modprobe: modprobe: Can't locate module net-pf-10
> Sep 22 22:38:24 jeloin kernel: ksoftirqd: do_softirq
> Sep 22 22:38:58 jeloin last message repeated 20 times
> Sep 22 22:39:05 jeloin last message repeated 4 times
> Sep 22 22:42:03 jeloin kernel: ksoftirqd: do_softirq
> Sep 22 22:43:58 jeloin logger: *** ./stress_dbench end ***

one reschedule every few seconds sounds ok.

> Possibly but the other case is quite common too...

if you try to put a printk also in do_softirq you'll see why it is
not the common case :)

also you may want to put the printk in the schedule() path, ksoftirqd
may just be rescheduled once, and run many of the do_softirq().

Andrea
