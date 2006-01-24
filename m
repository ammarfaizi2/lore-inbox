Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWAXOT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWAXOT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 09:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWAXOT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 09:19:57 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:24775 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932426AbWAXOT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 09:19:56 -0500
Subject: Re: [PATCH RT] kstopmachine has legit preempt_enable_no_resched
	(was: 2.6.15-rt12 bugs)
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <6bffcb0e0601240533h3ba1a01ci@mail.gmail.com>
References: <6bffcb0e0601230521l59b8360et@mail.gmail.com>
	 <1138065822.6695.6.camel@localhost.localdomain>
	 <6bffcb0e0601240533h3ba1a01ci@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 09:19:48 -0500
Message-Id: <1138112388.6695.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 14:33 +0100, Michal Piotrowski wrote:

> Great thanks!
> 
> Now 2.6.15-rt14 works fine (after disabling CONFIG_DEBUG_STACKOVERFLOW).
> 
> I have noticed only one warning
> WARNING: softirq-tasklet/8 changed soft IRQ-flags.
>  [<c0103b1b>] dump_stack+0x1b/0x1f (20)
>  [<c0135218>] illegal_API_call+0x41/0x46 (20)
>  [<c0135267>] local_irq_disable+0x1d/0x1f (8)
>   [<f886dbd5>] skge_extirq+0x117/0x138 [skge] (32)
>  [<c01202d5>] tasklet_action+0x8a/0xf1 (24)
>   [<c01205c1>] ksoftirqd+0x10f/0x19e (32)
>   [<c012d7ca>] kthread+0x7b/0xa9 (36)
>  [<c01010c5>] kernel_thread_helper+0x5/0xb (1047875612)
> ---------------------------
> | preempt count: 00000000 ]
> | 0-level deep critical section nesting:
> ----------------------------------------
> 
> ------------------------------
> | showing all locks held by: |  (softirq-tasklet/8 [c18a97d0,  98]):
> ------------------------------

Yeah, I've seen this too. Since it's just a warning, it's been push to
the back of the TODO list.

> 
> And problems while loading ipv6 module
> Running ntpdate to synchronize clockCould not allocate 4 bytes percpu data
> modprobe: FATAL: Error inserting ipv6
> (/lib/modules/2.6.15-rt14/kernel/net/ipv6/ipv6.ko): Cannot allocate
> memory
> 
> Could not allocate 4 bytes percpu data
> modprobe: FATAL: Error inserting ipv6
> (/lib/modules/2.6.15-rt14/kernel/net/ipv6/ipv6.ko): Cannot allocate
> memory

Is this new with the -rt14? or has this happened before. If it has
happened before, then could you tell us when it started.

Thanks,

-- Steve


