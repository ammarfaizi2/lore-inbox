Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270757AbUJUPLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270757AbUJUPLz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270756AbUJUPIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:08:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3988 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270747AbUJUPFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:05:37 -0400
Date: Thu, 21 Oct 2004 17:06:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021150655.GA7076@elte.hu>
References: <OFDF180689.447B12FA-ON86256F34.004EF945@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFDF180689.447B12FA-ON86256F34.004EF945@raytheon.com>
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

> >do you have PREEMPT_REALTIME enabled? The above trace is a direct
> >interrupt - only the timer interrupt is allowed to execute directly in
> >the PREEMPT_REALTIME model - things break badly if it happens for any
> >other interrupt (such as the soundcard IRQ).
> Yes I have PREEMPT_REALTIME enabled.
> 
> The thing that comes to mind is I do have a script that does
>   echo 0 > '/proc/irq/10/Esoniq AudioPCI/threaded
>
> as part of ensuring the all the preemption stuff was set right. I may
> have run that script prior to getting those messages. I thought you
> said before that the non threaded IRQ stuff was disabled. Perhaps this
> interface needs to be disabled as well [unless you really decide to
> fix this limitation...].

argh, there was a typo in that change so the 'threaded' flags werent
really disabled. So i ended up only disabling the global hardirq_preempt
flag but not the per-handler 'threaded' flags. Ouch!

I've uploaded the -U9.1 patch that has the fix, does it work any better
than previous kernels?

	Ingo
