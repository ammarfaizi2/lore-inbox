Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVCVJcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVCVJcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVCVJcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:32:25 -0500
Received: from mx2.elte.hu ([157.181.151.9]:35032 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262592AbVCVJcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:32:10 -0500
Date: Tue, 22 Mar 2005 10:32:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-01
Message-ID: <20050322093201.GA21945@elte.hu>
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322092331.GA21465@elte.hu>
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

> seems to be a true SMP race: when i boot with 1 CPU it doesnt trigger,
> the same kernel image and 2 CPUs triggers it on CPU#1. (CPU#0 is the
> boot CPU) Note that the timing of the crash is not deterministic
> (sometimes i get it during net startup, sometimes during ACPI
> startup), but it always crashes within rcu_advance_callbacks().
> 
> one difference between your tests and mine is that your kernel is
> doing _synchronize_kernel() from preempt-off sections (correct?),
> while my kernel with PREEMPT_RT does it on preemptable sections.

hm, another thing: i think call_rcu() needs to take the read-lock. Right
now it assumes that it has the data structure private, but that's only
statistically true on PREEMPT_RT: another CPU may have this CPU's RCU
control structure in use. So IRQs-off (or preempt-off) is not a
guarantee to have the data structure, the read lock has to be taken.

	Ingo
