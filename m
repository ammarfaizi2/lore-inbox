Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbUKWNv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUKWNv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 08:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbUKWNv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 08:51:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:28605 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261243AbUKWNvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 08:51:50 -0500
Date: Tue, 23 Nov 2004 15:53:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Florian Schmidt <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041123145345.GA21429@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20041122020741.5d69f8bf@mango.fruits.de> <20041122094602.GA6817@elte.hu> <56781.195.245.190.93.1101119801.squirrel@195.245.190.93> <20041122132459.GB19577@elte.hu> <20041122142744.0a29aceb@mango.fruits.de> <65529.195.245.190.94.1101133129.squirrel@195.245.190.94> <20041122154516.GC2036@elte.hu> <9182.195.245.190.93.1101142412.squirrel@195.245.190.93> <20041123144622.GA20085@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123144622.GA20085@elte.hu>
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


> since the client runs as SCHED_OTHER, doesnt this mean that simple
> delays between SCHED_OTHER tasks could cause xruns in jackd too? A
> SCHED_OTHER task can be delayed indefinitely at any stage. So shouldnt
> the test-clients have RT priority as well, to guarantee xrun-less
> jackd?

if SCHED_OTHER is the goal, then the xruns you are seeing in the
fluidsynth test are likely the result of random fluctuations in
scheduling of SCHED_OTHER tasks.

The way to find out whether that's the main source of xruns would be the
following test: start each fluidsynth instance as "nice -19 fluidsynth
..." to renice it to +19. Nice +19 gives the smoothest timeslices to
CPU-bound tasks (such as fluidsynth), and should give the smallest
global fluctuations. (The system must be idle during the test of course,
a nice +19 task is easily preempted.)

	Ingo
