Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUH3JEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUH3JEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 05:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUH3JEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 05:04:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23740 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263795AbUH3JEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 05:04:52 -0400
Date: Mon, 30 Aug 2004 11:06:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040830090608.GA25443@elte.hu>
References: <1093715573.8611.38.camel@krustophenia.net> <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu> <20040828203116.GA29686@elte.hu> <1093727453.8611.71.camel@krustophenia.net> <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829054339.GA16673@elte.hu>
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


i've uploaded -Q5 to:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q5

ontop of:

  http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2

-Q5 should fix the PS2 problems and the early boot problems, and it
might even fix the USB, ACPI and APIC problems some people were
reporting.

There were a number of bugs that led to the PS2 problems:

 - a change to __cond_resched() in the -Q series caused the starvation
   of the IRQ1 and IRQ12 threads during init - causing a silent timeout
   and misdetection in the ps2 driver(s).

 - even with the starvation bug fixed, we must set system_state to
   SCHEDULER_OK only once the init thread has started - otherwise the
   idle thread might hang during bootup.

 - the redirected IRQ handling now matches that of non-redirected IRQs
   better, the outer loop in generic_handle_IRQ has been flattened.

i also re-added the synchronize_irq() fix, it was not causing the PS2
problems.

	Ingo
