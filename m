Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269917AbUJTLlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269917AbUJTLlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270055AbUJTLFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:05:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8617 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264085AbUJTKzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:55:08 -0400
Date: Wed, 20 Oct 2004 12:56:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020105630.GB2614@elte.hu>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <4176403B.5@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4176403B.5@stud.feec.vutbr.cz>
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


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> I'm getting these BUGs when I use netconsole with Real-Time Preemption
> (but netconsole works):

you are getting them because interrupts get disabled somewhere in the
path. Do your changes perhaps introduce a local_irq_save() or
local_irq_disable()?

(in PREEMPT_REALTIME spin_lock_irq*() does not disable interrupts for
mutex-based spinlocks, so the only way to get irqs disabled is
explicitly.)

	Ingo
