Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbULJWX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbULJWX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbULJWVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:21:44 -0500
Received: from mx1.elte.hu ([157.181.1.137]:49051 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261849AbULJWSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:18:06 -0500
Date: Fri, 10 Dec 2004 23:14:20 +0100
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
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Message-ID: <20041210221420.GC7609@elte.hu>
References: <OF581F8361.CB1F4C7B-ON86256F66.00784FA2-86256F66.00784FB8@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF581F8361.CB1F4C7B-ON86256F66.00784FA2-86256F66.00784FB8@raytheon.com>
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

> The code does not quite match either pattern but is perhaps
> more like your second example.
> 
> For reference, the cpu_delay loop looks like this...
> 
>   t1 = mygettime();
>   for(u=0;u<(loops/1000);u++) {
>     t0 = t1;
>     if (do_a_trace) {
>       gettimeofday(0, (struct timezone*)1);
>     }
>     for (v=0;v<1000;v++)
>       k+=1;

If this is the code then on any modern CPU this is a delay on the order
of 2000 cycles - 2-3 usecs on your CPUs. The overhead of kernel entries
plus tracing is likely larger than this, so the window for the timing
race to occur ought to be pretty large.

this also means that the elapsed time of the CPU loop will be quite
variable, it will largely depend on the level and type of
tracing/debugging activated in the kernel. This could perhaps explain
the observed weirdnesses of the 'elapsed time' metric.

> [do some tests...]
> Now I'm 5 for 5 with the revised code. Odd that all the numbers
> are within about 2 or 3 usec (application measured / kernel measured).
> If it was as bad as I was measuring it, I would have expected
> one or two to be really off.

(5 for 5 means no missed latencies by the kernel tracer so far?)

	Ingo
