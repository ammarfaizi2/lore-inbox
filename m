Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSGLTiu>; Fri, 12 Jul 2002 15:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSGLTit>; Fri, 12 Jul 2002 15:38:49 -0400
Received: from holomorphy.com ([66.224.33.161]:41374 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316795AbSGLTit>;
	Fri, 12 Jul 2002 15:38:49 -0400
Date: Fri, 12 Jul 2002 12:40:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Minutes from LSE Con Call
Message-ID: <20020712194028.GR25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <29610000.1026499086@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <29610000.1026499086@w-hlinder>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 11:38:06AM -0700, Hanna Linder wrote:
> 8. Daniel asked about seeing results of rmap on a numaq.
> Martin got distracted but will get back to getting some
> results.

On elm3b17 I found more 2.5.25 vs. NUMA-Q issues and got workarounds
for booting while doing work on stuffing pte_chains into highmem:

(1) cpu_init() heisenbug that goes away when adding printk's
	I just added the extra printk's and moved on
(2) in_interrupt() is racy and needs to disable preemption
	while checking per-cpu counters. The trivial fix.
(3) CONFIG_PREEMPT calls preempt_schedule() on secondaries
	before they're ready, and the exception is flagged as
	no vm86_info: BAD
	Didn't want to go to deep into it at 3AM and disabled preempt.

The usual ioremap()/smp_call_function() deadlock, irqbalance
plugging unreachable cpu's into ioapics, bio splitting to make
qlogicisp happy, and MAX_IO_APICS things are still needed.

So I guess the "real fixes" need to get found at some point and
propagated out to maintainers. hpa and mochel are on cpu_init(),
and rml should be on preempt vs. printk and in_interrupt(). axboe
has already got bio splitting ready and no idea about the MAX_IO_APICS
and getting irqbalance fixes past mingo doesn't look easy.


Cheers,
Bill
