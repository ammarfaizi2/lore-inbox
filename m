Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbUKXL0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbUKXL0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 06:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbUKXL0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 06:26:11 -0500
Received: from mx1.elte.hu ([157.181.1.137]:50340 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261352AbUKXL0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 06:26:09 -0500
Date: Wed, 24 Nov 2004 13:28:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-2
Message-ID: <20041124122835.GA12555@elte.hu>
References: <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <1100920963.1424.1.camel@krustophenia.net> <20041120125536.GC8091@elte.hu> <1100971141.6879.18.camel@krustophenia.net> <20041120191403.GA16262@elte.hu> <1100997121.1569.0.camel@krustophenia.net> <20041124121522.GA10110@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124121522.GA10110@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > Yup, !PREEMPT works fine.  Testing PREEMPT next.  So far only
> > PREEMPT_VOLUNTARY fails to boot.
> 
> found a bug that causes !PREEMPT boot failures. The seqlock type was
> wrong for the !RT case, resulting in a subtle bug:
> write_seqlock_irqsave() didnt actually disable interrupts. This
> results in a deadlock scenario in where the timer interrupt interrupts
> update_times (which runs in softirq context). I've uploaded the -31-1
> patch with this fix included to the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> i'm cycling through the various options, but it's looking good so far,
> PREEMPT_NONE, PREEMPT_VOLUNTARY and PREEMPT_DESKTOP all booted up
> fine.

all variations i tried booted up fine. While fixing the non-RT cases a
bug slipped into the PREEMPT_RT branch of seqlock.h though, i fixed that
in the -31-2 patch i just uploaded.

	Ingo
