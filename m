Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbUKHPxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbUKHPxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 10:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbUKHPxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 10:53:41 -0500
Received: from mx1.elte.hu ([157.181.1.137]:32402 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261892AbUKHOkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:40:41 -0500
Date: Mon, 8 Nov 2004 16:42:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Bill Huey <bhuey@lnxw.com>, Scott Wood <scott@timesys.com>,
       john cooper <john.cooper@timesys.com>, Mark_H_Johnson@raytheon.com,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041108154246.GA32212@elte.hu>
References: <20041105223610.GA3756@nietzsche.lynx.com> <Pine.OSF.4.05.10411081410150.28010-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411081410150.28010-100000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> On a SMP system you don't have these nice properties. You always have
> to take into account that N processes are really running at the same
> time.

not necessarily. In theory we could introduce the notion of
"hyper-high-priority tasks" (e.g. SCHED_HYPER_FIFO), which tasks not
only get preempted on one CPU immediately, but cause the kernel to stop
and loop on all other CPUs as well. That way the same 'nice' properties
of UP kernels get carried over to the SMP system as well, at the cost of
serializing all execution while the hyper-high-prio task is running. 
Once the task stops running, the other CPUs can continue as well.

	Ingo
