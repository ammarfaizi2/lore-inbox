Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVCVJXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVCVJXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVCVJXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:23:45 -0500
Received: from mx1.elte.hu ([157.181.1.137]:23204 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262581AbVCVJXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:23:40 -0500
Date: Tue, 22 Mar 2005 10:23:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-01
Message-ID: <20050322092331.GA21465@elte.hu>
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322072413.GA6149@elte.hu>
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

> > Does the following help with the SMP problem?  This fix and the
> > earlier one make my old patch survive a few rounds of kernbench on a
> > 4-CPU x86 box. [...]
> 
> does not seem to fix my testbox (see the crash log below). [...]

seems to be a true SMP race: when i boot with 1 CPU it doesnt trigger,
the same kernel image and 2 CPUs triggers it on CPU#1. (CPU#0 is the
boot CPU) Note that the timing of the crash is not deterministic
(sometimes i get it during net startup, sometimes during ACPI startup),
but it always crashes within rcu_advance_callbacks().

one difference between your tests and mine is that your kernel is doing
_synchronize_kernel() from preempt-off sections (correct?), while my
kernel with PREEMPT_RT does it on preemptable sections.

	Ingo
