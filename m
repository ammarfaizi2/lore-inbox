Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270410AbUJUIdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270410AbUJUIdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 04:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270722AbUJUIb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 04:31:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:35503 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270688AbUJUIRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 04:17:12 -0400
Date: Thu, 21 Oct 2004 10:18:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021081805.GA21537@elte.hu>
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <4176403B.5@stud.feec.vutbr.cz> <20041020105630.GB2614@elte.hu> <417645A4.7000802@stud.feec.vutbr.cz> <20041020120434.GA6297@elte.hu> <4176D9CC.5010107@stud.feec.vutbr.cz> <20041021081215.GA21073@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021081215.GA21073@elte.hu>
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

> ah, indeed. Note that this is still not enough - please try to add a
> local_irq_enable() to netconsole.c's console-write function - does
> that fix it equally well for you?
> 
> the reason is that if we crash within an irqs-off section then
> netconsole will still be called with interrupts disabled and will
> trigger the assert.

i've added your patch to my tree, plus the extra local_irq_enable(),
this should also fix fbcon - so no changes needed to netconsole.c. All
of these problems will go away if/when the console code goes away from
raw spinlocks.

	Ingo
