Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbUKOPv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUKOPv7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 10:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUKOPv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 10:51:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:37080 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261627AbUKOPv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 10:51:57 -0500
Date: Mon, 15 Nov 2004 17:46:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041115164604.GA1456@elte.hu>
References: <OF201B61B1.F0A7806E-ON86256F4A.005D427B-86256F4A.005D4299@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF201B61B1.F0A7806E-ON86256F4A.005D427B-86256F4A.005D4299@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

>  [1] major network delays while latencytest is running (ping drops
> packets or they get delayed by minutes). I did not see this on some
> previous tests where I made more of the /0 and /1 tasks RT. May have
> to do that again.

i think this is directly related to what priority the ksoftirqd threads
have.

>  [6] the latency trace may have some SMP race conditions where the
> entries displayed do not match the header. Examples are a 100 usec
> trace header followed by 8 entries that last about 4 usec.

i think i fixed a related bug in the latest kernel(s):
touch_preempt_timing() was mistakenly 'touching' a live user-triggered
trace and could interfere in a similar fashion. Please re-report if this
still happens with -V0.7.26-3-ish or later kernels.

>  [8] Some samples of /proc/loadavg during my big test showed some
> extremely large numbers. For example:
> 5.07 402.44 0.58 5/120 4448

i'm currently trying to track down this one. The rq->nr_uninterruptible
count got out of sync during one of the scheduler changes - and this
causes large negative task counts, messing up the load-average.

	Ingo
