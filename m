Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUHNMUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUHNMUL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 08:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUHNMUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 08:20:00 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:8 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S261234AbUHNMTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 08:19:47 -0400
Message-ID: <411E0361.9020407@superbug.demon.co.uk>
Date: Sat, 14 Aug 2004 13:19:45 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
References: <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <411DF776.6090102@superbug.demon.co.uk> <20040814115139.GB9705@elte.hu>
In-Reply-To: <20040814115139.GB9705@elte.hu>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just for info, now that we have a nice latency testing tool, we 
might as well collect some useful traces that we can later work on.

Here is a trace showing a latency of 39034us. 
http://www.superbug.demon.co.uk/kernel/

The interesting parts of it are:
0.002ms (+0.000ms): __preempt_spin_lock (schedule)
0.523ms (+0.520ms): do_IRQ (common_interrupt)
...
0.532ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
0.763ms (+0.230ms): smp_apic_timer_interrupt (apic_timer_interrupt)
...
0.768ms (+0.000ms): preempt_schedule (try_to_wake_up)
1.523ms (+0.754ms): do_IRQ (common_interrupt)
...
1.533ms (+0.000ms): __do_softirq (do_softirq)
1.763ms (+0.229ms): smp_apic_timer_interrupt (apic_timer_interrupt)
...
1.765ms (+0.000ms): __do_softirq (do_softirq)
2.523ms (+0.757ms): do_IRQ (common_interrupt)
...
2.533ms (+0.000ms): do_softirq (do_IRQ)
2.533ms (+0.000ms): __do_softirq (do_softirq)
2.763ms (+0.230ms): smp_apic_timer_interrupt (apic_timer_interrupt)
...

This looks to me to be a bug somewhere. Either in the O7 patch, or in 
the kernel. Surely, do_IRQ should happen quickly, and not take 39ms.


