Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUJTOct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUJTOct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUJTOby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:31:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64939 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268483AbUJTO3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:29:25 -0400
Date: Wed, 20 Oct 2004 16:18:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020141822.GA16965@elte.hu>
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041020145019.176826cb@mango.fruits.de> <20041020125500.GA8693@elte.hu> <20041020152507.3c167ca8@mango.fruits.de> <20041020162428.7c4c5f53@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020162428.7c4c5f53@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> Hi,
> 
> it seems that the pauses went away with that patch. [...]

great! I've uploaded -U8.1 with this fix included:

  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8.1

> And on this bootup the pauses are still gone, but as soon as i echo'ed
> 1 into trace_enabled the mouse started to become very skippy (update
> freq at about 3hz). Keyboard is fine though.. putting trace_enabled
> back to 0 doesn't fix it. I suppose it's just a matter of time until
> the next lockup. We'll see though..
> 
> Syslog only sees critical section timing reports, no BUG's afaics.

note that the keyboard and USB interrupts are SCHED_OTHER by default, so
they could be delayed quite long depending on the workload. To avoid
that i'd suggest to:

        chrt --fifo --pid 30 `pidof 'IRQ 1'`
        chrt --fifo --pid 30 `pidof 'IRQ 12'`

(do this for every IRQ you have for input devices.) This puts them below
jackd's priority (which is FIFO 50 iirc) but above all SCHED_OTHER
tasks. The soundcard IRQ i guess you have chrt-ed already?

or did you have them on SCHED_FIFO already?

	Ingo
