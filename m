Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270643AbUJUKUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270643AbUJUKUD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270378AbUJUKSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:18:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:14997 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270384AbUJUKRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:17:30 -0400
Date: Thu, 21 Oct 2004 12:18:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021101821.GB473@elte.hu>
References: <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021101103.GC10531@suse.de>
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


* Jens Axboe <axboe@suse.de> wrote:

> I didn't look at the USB code, I'm just saying that it's perfectly
> valid use of a semaphore the pattern you describe (process A holding
> it, process B releasing it).

yes, that is perfectly true, and sorry if we gave you the wrong
impression.

the goal of these patches is to do a semaphore->completion conversion in
cases where the semaphore was used for completion purposes. It's a bit
faster and more readable but not a 'bugfix' in any way. (another set of
patches are converting sleep_on() uses to wait_event*() plus waitqueues
- those can in fact be considered bugfixes in some cases.)

typically the cases where semaphores are held by one task and released
by another task happens coincide with this used-for-completion scenario.

[ the different-owner assert that triggers in my PREEMPT_REALTIME tree
is for completely different reasons and has no impact on upstream at
all. (It merely means 'Ingo does some weird stuff again, pester him, not
others'.) ]

	Ingo
