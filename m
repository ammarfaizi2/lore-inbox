Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUIHM5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUIHM5P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUIHM4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:56:48 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:2786 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267454AbUIHMs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:48:57 -0400
Date: Wed, 8 Sep 2004 08:53:21 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] preempt-smp.patch, 2.6.9-rc1-bk14
In-Reply-To: <20040908111751.GA11507@elte.hu>
Message-ID: <Pine.LNX.4.53.0409080814570.15087@montezuma.fsmlabs.com>
References: <20040908111751.GA11507@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, Ingo Molnar wrote:

> to solve this problem i've introduced a new spinlock field,
> lock->break_lock, which signals towards the holding CPU that a
> spinlock-break is requested by another CPU. This field is only set if a
> CPU is spinning in a spinlock function [at any locking depth], so the
> default overhead is zero. I've extended cond_resched_lock() to check for
> this flag - in this case we can also save a reschedule. I've added the
> lock_need_resched(lock) and need_lockbreak(lock) methods to check for
> the need to break out of a critical section.

Doesn't having break_lock within the same cacheline as lock bounce the 
line around more?

> In addition to the preemption latency problems, the _irq() variants in
> the above list didnt do any IRQ-enabling while spinning - possibly
> resulting in excessive irqs-off sections of code!

I had a patch for this 
http://www.ussg.iu.edu/hypermail/linux/kernel/0405.3/0578.html and it has 
been running for about 3 months now on a heavily used 4 processor box. 
It's all a matter of whether Andrew is feeling brave ;)

Thanks,
	Zwane
