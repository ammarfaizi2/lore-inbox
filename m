Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbUL1V72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbUL1V72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 16:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUL1V72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 16:59:28 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:6317 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261235AbUL1V7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 16:59:25 -0500
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption,
	-RT-2.6.10-rc2-mm3-V0.7.32-15)
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <20041227210614.GA11052@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10412271655270.18818-100000@da410.ifa.au.dk>
	 <1104165560.20042.108.camel@localhost.localdomain>
	 <20041227210614.GA11052@nietzsche.lynx.com>
Content-Type: text/plain
Date: Tue, 28 Dec 2004 16:59:23 -0500
Message-Id: <1104271163.20714.44.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-27 at 13:06 -0800, Bill Huey wrote:
> I was just having a discussion about this last night with a friend
> of mine and I'm going to pose this question to you and others.
> 
> Is a real-time enabled kernel still relevant for high performance
> video even with GPUs being as fast as they are these days ?
>
> The context that I'm working with is that I was told (been out of
> gaming for a long time now) that GPus are so fast these days that
> shortage of frame rate isn't a problem any more. An RTOS would be
> able to deliver a data/instructions to the GPU under a much tighter
> time period and could delivery better, more consistent frame rates.
> 
> Does this assertion still apply or not ? why ? (for either answer)

Yes, an RTOS certainly helps.  Otherwise you cannot guarantee a minimum
frame rate - if a long running disk ISR fires then you are screwed,
because jsut as with low latency audio you have a SCHED_FIFO userspace
process that is feeding data to the GPU at a constant rate.  Its a worse
problem with audio because you absolutely cannot drop a frame or you
will hear it.  With video it's likely to be imperceptible.

Lee

