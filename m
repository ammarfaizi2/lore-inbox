Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbUJ1JcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbUJ1JcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbUJ1JcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:32:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31636 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262848AbUJ1Jbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:31:36 -0400
Date: Thu, 28 Oct 2004 11:32:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041028093215.GA27694@elte.hu>
References: <5225.195.245.190.94.1098880980.squirrel@195.245.190.94> <20041027135309.GA8090@elte.hu> <12917.195.245.190.94.1098890763.squirrel@195.245.190.94> <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu> <33083.192.168.1.5.1098919913.squirrel@192.168.1.5> <20041028063630.GD9781@elte.hu> <20668.195.245.190.93.1098952275.squirrel@195.245.190.93> <20041028085656.GA21535@elte.hu> <26253.195.245.190.93.1098955051.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26253.195.245.190.93.1098955051.squirrel@195.245.190.93>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> OK. That was it. After switching off CONFIG_RWSEM_DEADLOCK_DETECT on
> RT-V0.4.3, I can say that it's now on par to RT-U3.

great!

> Later today, I will conduct some extendeded testing, where I'll able
> to compare the jackd performance between vanilla, RT-U3 and RT-V0.4.3,
> on my UP laptop. All kernel configurations will be stripped off from
> all the debug options.
>
> I will take note of xrun rate, jackd scheduling delay histogram, and
> cpu usage. Context switch rate will be also acquainted.
> 
> Anything else?

yeah, that's good enough. I'd still suggest to first test new kernels
with all the debug options on, to make sure it's stable. For performance
comparisons turn all the debug options off.

i'd also suggest to turn the NMI watchdog off (if enabled), that can
inject a 10-20 usec latency into any critical path. For the absolute
lowest latencies i'd also suggest to turn off all the APIC options
(possible in a UP kernel only, and only if the XT-PIC setup doesnt cause
unacceptable IRQ-line sharing), the IO-APIC mask handling is a bit
expensive compared to the XT-PIC.

If you find (or suspect) larger latencies anywhere then PREEMPT_TIMING +
LATENCY_TRACE + preempt_enable=4 is the preferred variant to use. (right
now it's not possible to do wakeup-timing without LATENCY_TRACE, i'll
fix that.)

	Ingo
