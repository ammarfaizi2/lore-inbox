Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVAZJUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVAZJUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 04:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVAZJUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 04:20:51 -0500
Received: from mx2.elte.hu ([157.181.151.9]:60136 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262404AbVAZJUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 04:20:45 -0500
Date: Wed, 26 Jan 2005 10:20:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050126092014.GA7003@elte.hu>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <41F6C5CE.9050303@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6C5CE.9050303@bigpond.net.au>
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


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> As I understand this (and I may be wrong), the intention is that if a
> task has its RT_CPU_RATIO rlimit set to a value greater than zero then
> setting its scheduling policy to SCHED_RR or SCHED_FIFO is allowed. 

correct.

> This causes me to ask the following questions:
> 
> 1. Why is current->signal->rlim[RLIMIT_RT_CPU_RATIO].rlim_cur being used 
> in setscheduler() instead of p->signal->rlim[RLIMIT_RT_CPU_RATIO].rlim_cur?
>
> 2. What stops a task that had a non zero RT_CPU_RATIO rlimit and
> changed its policy to SCHED_RR or SCHED_FIFO from then setting
> RT_CPU_RATIO rlimit back to zero and escaping the controls?  As far as
> I can see (and, once again, I may be wrong) the mechanism for setting
> rlimits only requires CAP_SYS_RESOURCE privileges in order to increase
> the value.

you are right, both are bugs.

i've uploaded the -D6 patch that should have both fixed:

  http://redhat.com/~mingo/rt-limit-patches/

thanks,

	Ingo
