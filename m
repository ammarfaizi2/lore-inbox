Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVFGUbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVFGUbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVFGUbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:31:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44785 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261974AbVFGUbi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:31:38 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-29
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20050607194119.GA11185@elte.hu>
References: <20050607194119.GA11185@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 07 Jun 2005 13:31:30 -0700
Message-Id: <1118176290.18629.29.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 21:41 +0200, Ingo Molnar wrote:
> ere are more microoptimizations to the spin_lock/unlock hotpath:
> 
>  - the caching of mutex_getprio() priority in p->normal_prio
> 
>  - the mutex lock/unlock paths are now all fall-through. (Found a gcc
>    bug, it mishandles __builtin_expect() in certain cases and produces 
>    correct but suboptimal code - we are working it around now.)
> 
>  - reduced the amount of recursive preemption-counter bumps via the use 
>    of raw spinlocks
> 
>  - rely on the preemption-counter instead of IRQs-off sections

There is a local_irq_enable missing someplace in UP ..

BUG: scheduling with irqs disabled: khelper/0x00000000/5
caller is __down_mutex+0x276/0x440
 [<c03a88d6>] __down_mutex+0x276/0x440 (4)
 [<c03a75cc>] schedule+0xec/0x100 (4)
 [<c03a88d6>] __down_mutex+0x276/0x440 (12)
 [<c012b290>] remove_wait_queue+0x10/0x40 (64)
 [<c0130e02>] __spin_lock+0x22/0x40 (32)
 [<c012b290>] remove_wait_queue+0x10/0x40 (8)
 [<c0130e8c>] _spin_lock_irqsave+0xc/0x20 (12)
 [<c012b290>] remove_wait_queue+0x10/0x40 (8)
 [<c012b290>] remove_wait_queue+0x10/0x40 (4)
 [<c0126a2b>] worker_thread+0x14b/0x280 (20)
 [<c01265a0>] __call_usermodehelper+0x0/0x60 (16)
 [<c0112d20>] default_wake_function+0x0/0x40 (28)
 [<c0112d20>] default_wake_function+0x0/0x40 (32)
 [<c01268e0>] worker_thread+0x0/0x280 (36)
 [<c012af24>] kthread+0x84/0xc0 (4)
 [<c012aea0>] kthread+0x0/0xc0 (20)
 [<c010132d>] kernel_thread_helper+0x5/0x18 (16)




