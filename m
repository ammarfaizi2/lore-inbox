Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbUJ1GoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbUJ1GoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbUJ1GoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:44:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58306 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262857AbUJ1Gfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:35:30 -0400
Date: Thu, 28 Oct 2004 08:36:30 +0200
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
Message-ID: <20041028063630.GD9781@elte.hu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <5225.195.245.190.94.1098880980.squirrel@195.245.190.94> <20041027135309.GA8090@elte.hu> <12917.195.245.190.94.1098890763.squirrel@195.245.190.94> <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu> <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> >> ok, i've uploaded RT-V0.4.2 which has more of the same: it fixes other
> >> missed preemption checks. Does it make any difference to the xruns on
> >> your UP box?
> >
> > uploaded RT-V0.4.3 - there was a thinko in the latency tracer that
> > caused early boot failures.
> >
> 
> Yes, the xrun rate has decreased, slightly. RT-V0.4.3 is now ranking
> under 10 per 5 min (~2/min), with jackd -R -r44100 -p128 -n2,
> fluidsynth x 6.
> 
> Better still, but not to par as RT-U3, under the very same conditions.

how much idle time do you have in the RT-U3 and in the RT-V0.4 tests,
compared? If it's close to 100% then make sure you have the following
debug options disabled:

 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_PREEMPT_TIMING is not set
 # CONFIG_RWSEM_DEADLOCK_DETECT is not set
 # CONFIG_FRAME_POINTER is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set

RWSEM_DEADLOCK, DEBUG_PREEMPT, PREEMPT_TIMING and LATENCY_TRACE are
especially expensive, so depending on the amount of kernel work done, it
can make or break the total balance of CPU time used and you could get
xruns not only due to kernel latencies but purely due to having not
enough CPU time to generate audio output. (fluidsynth is a software
audio generator?)

	Ingo
