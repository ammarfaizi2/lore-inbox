Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262835AbUJ1I5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbUJ1I5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 04:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUJ1I5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 04:57:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10122 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262835AbUJ1I5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 04:57:32 -0400
Date: Thu, 28 Oct 2004 10:56:56 +0200
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
Message-ID: <20041028085656.GA21535@elte.hu>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <5225.195.245.190.94.1098880980.squirrel@195.245.190.94> <20041027135309.GA8090@elte.hu> <12917.195.245.190.94.1098890763.squirrel@195.245.190.94> <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu> <33083.192.168.1.5.1098919913.squirrel@192.168.1.5> <20041028063630.GD9781@elte.hu> <20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
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

> The following table compares the state between my RT-U3 and RT-V0.4.3
> configurations, regarding only the mentioned options:
> 
>   option                       RT-U3.0    RT-V0.4.3
>   ---------------------------- ---------- ---------
>   CONFIG_DEBUG_SLAB              n          n
>   CONFIG_DEBUG_PREEMPT           y          y
>   CONFIG_DEBUG_SPINLOCK_SLEEP    n          -
>   CONFIG_PREEMPT_TIMING          n          n
>   CONFIG_RWSEM_DEADLOCK_DETECT   -          y
>   CONFIG_FRAME_POINTER           y          y
>   CONFIG_DEBUG_STACKOVERFLOW     y          y
>   CONFIG_DEBUG_STACK_USAGE       n          n
>   CONFIG_DEBUG_PAGEALLOC         n          n
> 
> (dash "-" means that the option is not available in the config).
> 
> As you can see, it can only be CONFIG_RWSEM_DEADLOCK_DETECT, being new
> in RT-V0.4.3, that is probably affecting on RT-V0.4.3. I'll try to
> rebuild and test all over without it, and see if it gets any better.

note that DEBUG_PREEMPT got more expensive in the -V kernels. I'd
suggest to disable all the 'y' ones in both the -U and -V kernel and
compare them then.

but especially the userspace overhead seems to be significantly higher
in the -V kernel so i'm not quite sure it can all be attributed to
debugging overhead. We'll see.

also, how does the context-switching rate compare between the two tests? 
This test is pretty steady when it's running, so the context-switch
rates can be directly compared, correct?

	Ingo
