Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUKIWYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUKIWYC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbUKIWYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:24:02 -0500
Received: from mx1.elte.hu ([157.181.1.137]:236 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261711AbUKIWXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:23:53 -0500
Date: Wed, 10 Nov 2004 00:26:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Message-ID: <20041109232600.GB14503@elte.hu>
References: <OFC1C59379.C97F0CF1-ON86256F47.00720C09@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFC1C59379.C97F0CF1-ON86256F47.00720C09@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >i have released the -V0.7.23 Real-Time Preemption patch, which can be
> >downloaded from the usual place:
> >
> >    http://redhat.com/~mingo/realtime-preempt/
> 
> A few notes on results from running with this patch (well, actually
> -EA that Ingo provided separately).
> 
> [1] Build problems, separately reported to Ingo with CONFIG_PREEMPT_RT
> enabled on x86 and you have modules using kunmap_atomic. Fix by adding
> kunmap_virt and kmap_to_page to the list of exports.

these should be fixed in -V0.7.24 which i uploaded shortly after
-V0.7.23, based on your reports. In any case, the export problems
trigger with CONFIG_HIGHMEM and the affected subsystems compiled as
modules.

> [2] The live lock that I was having seems to have been killed based on
> an hour of testing (I could usually cause it in 5 minutes or less).

great!

> [4] Application level latencies are OK but not great.
>  X test - only 90% of CPU loops are within 100 usec of nominal value.
> In previous RT kernels I got > 99% with 100 usec.

this might be a side-effect of the chrt-ing of events/[0|1] and/or
ksoftirqd (which we did to debug the 'freeze' problems) - are those
still chrt-ed? Please review and double-check all SCHED_FIFO tasks in
the system and keep only those that are absolutely necessary for
latencytest's operation [i.e. the soundcard IRQ and latencytest itself]
- everything else should be SCHED_OTHER. Do latencies get any better if
you do this?

	Ingo
