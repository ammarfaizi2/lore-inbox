Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVAJJQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVAJJQS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 04:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVAJJQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 04:16:18 -0500
Received: from mx2.elte.hu ([157.181.151.9]:53719 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262163AbVAJJQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 04:16:15 -0500
Date: Mon, 10 Jan 2005 10:15:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: tglx@linutronix.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-mm2] Fix preemption race [1/3] (Core)
Message-ID: <20050110091559.GB25034@elte.hu>
References: <20050110013508.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110013508.1.patchmail@tglx>
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


* tglx@linutronix.de <tglx@linutronix.de> wrote:

> The idle-thread-preemption-fix.patch introduced a race, which is not
> critical, but might give us an extra turn through the scheduler. When
> interrupts are reenabled in entry.c and an interrupt occures before we
> reach the add_preempt_schedule() in preempt_schedule we get
> rescheduled again in the return from interrupt path.

i agree that there's a race. I solved this in the -RT patchset a couple
of weeks ago, but in a different wasy. I introduced the
preempt_schedule_irq() function and this solves the problem via keeping
the whole IRQ-preemption path irqs-off. This has the advantage that if
an IRQ signals preemption of a task and the kernel is immediately
preemptable then we are able to hit that task atomically without
re-enabling IRQs again. I'll split out this patch - can you see any
problems with the preempt_schedule_irq() approach?

	Ingo
