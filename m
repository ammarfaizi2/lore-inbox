Return-Path: <linux-kernel-owner+willy=40w.ods.org-S290271AbUKBIGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S290271AbUKBIGy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 03:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S277576AbUKBIGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 03:06:53 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59790 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S275943AbUKBIG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 03:06:28 -0500
Date: Tue, 2 Nov 2004 09:07:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041102080731.GC21359@elte.hu>
References: <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu> <20041101140630.GA20448@elte.hu> <1099324040.3337.32.camel@thomas> <20041101184615.GB32009@elte.hu> <20041101233037.314337c8@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101233037.314337c8@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> > also, there are no "arbitrary load" latency guarantees with
> > DEADLOCK_DETECTION turned on, since we search the list of all held locks
> > during task-exit time - this can generate pretty bad latencies e.g.
> > during hackbench.
> 
> btw: i see the same build failure as Rui with lock debugging disabled.

(just remove the offending call to show_all_locks())

> Since the lock debugging can screw timings, will this be fixed in [one
> of] the next version[s]?

yeah, i think so. Right now i've increased the complexity of the checks
to root out bugs as clearly there's a stability problem. Once things
have calmed down i think we can remove the 'check all locks at exit
time' portion that is the problematic one.

note that you really need some insane loads with thousands of tasks in
the runqueue (hackbench) to really trigger that kind of overhead. Normal
loads are not supposed to trigger any of this, even with full debugging
turned on.

	Ingo
