Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbUJ3Rte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUJ3Rte (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 13:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbUJ3Rte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 13:49:34 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55972 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261220AbUJ3Rtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 13:49:32 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041030115808.GA29692@elte.hu>
References: <20041029193303.7d3990b4@mango.fruits.de>
	 <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu>
	 <1099086166.1468.4.camel@krustophenia.net> <20041029214602.GA15605@elte.hu>
	 <1099091566.1461.8.camel@krustophenia.net> <20041030115808.GA29692@elte.hu>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 13:49:29 -0400
Message-Id: <1099158570.1972.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 13:58 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Here is the dmesg output.  It looks like the problem could be related
> > to jackd's printing from the realtime thread.  But, this has to be the
> > kernel's fault on some level, because with an earlier version I get no
> > xruns.
> 
> with the earlier version these spinlocks were simply disabling
> preemption, while now they will schedule away on contention. If that tty
> lock is held for a long time by a lowprio task then that could delay the
> highprio thread. We are starting to see priority inversion problems. 
> But, the core issue is doing tty printouts - does jackd do that
> periodically, or only as a reaction to an already existing latency?
> 

No, this cannot be the whole story, because unless verbose mode is
specified, jackd will only prints anything if there is an xrun.  So
there is something else going on.

This _really_ feels like a kernel bug.  Are you saying that this could
still be a jackd problem, even though T3 works perfectly with the exact
same jackd binary?

Lee

