Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVBKJBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVBKJBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVBKJAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:00:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:8582 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262043AbVBKI7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:59:53 -0500
Date: Fri, 11 Feb 2005 09:59:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211085942.GB3980@elte.hu>
References: <a075431a050210125145d51e8c@mail.gmail.com> <20050211000425.GC2474@waste.org> <20050210164727.M24171@build.pdx.osdl.net> <20050211020956.GC15058@waste.org> <20050211081422.GB2287@elte.hu> <20050211084107.GG15058@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211084107.GG15058@waste.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Mackall <mpm@selenic.com> wrote:

> > i disagree that desktop performance tomorrow will necessarily have to
> > utilize SCHED_FIFO. Today's desktop audio applications perform quite
> > good at SCHED_NORMAL priorities [with the 2.6.11 kernel that has more
> > interactivity/latency fixes such as PREEMPT_BKL].
> 
> Desktop performance tomorrow will want realtime audio AND video. 
> Think simultaneous record and playback of multiple high-definition
> video streams. There's a demand for this; my company already sells it.

Tomorrow's hardware will have enough buffering as today's hardware has
for simpler tasks. Repeat after me: it likely _wont_ _need_ SCHED_FIFO.
Running tomorrow's hardware on today's boxes indeed pushes the system to
its limits, but torrows hardware will be well-balanced just as much as
today's is - if nothing else then due to kernel drivers providing a
buffering guarantee.

think of SCHED_FIFO on the desktop as an ugly wart, a hammer, that
destroys the careful balance of priorities of SCHED_OTHER tasks. Yes, it
can be useful if you _need_ a scheduling guarantee due to physical
constraints, and it can be useful if the hardware (or the kernel) cannot
buffer enough, but otherwise, it only causes problems.

> I'm very suspicious about being able to rip out RT-LSM once it's
> introduced. [...]

yeah, i somewhat share that view. (despite all the promises from the
audio folks - if they are just half as agressive resisting removal as
they were pushing integration then it will never be removed ;-)

but i'm not sure how rlimits will contain the whole problem - can
rlimits be restricted to a single app (jackd)? The most canonical use of
rlimits is per-user (per-group), so the rlimit could end up _widening_
the effects of the hack ...

> > > The rlimit stuff is not perfect, but it's a much better fit for the
> > > UNIX model generally, which is a fairly big win. [...]
> > 
> > a 'locked up box' is as far away from the UNIX model as it gets.
> 
> Rlimits are already the favored tool for dealing with the classic UNIX
> DoS: the fork bomb. Turn off process limits, tada, locked up box.

the big difference is that process limits are finegrained and it has a
single value (unlimited) that allows the DoS - while the RT-rlimits have
_one_ value that is safe, all the other values are unsafe!

	Ingo
