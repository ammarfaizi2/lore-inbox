Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbUCTXMi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 18:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUCTXMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 18:12:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:59799 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263300AbUCTXMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 18:12:35 -0500
Date: Sat, 20 Mar 2004 15:12:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: hch@infradead.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu hotplug fix
Message-Id: <20040320151230.7527914a.akpm@osdl.org>
In-Reply-To: <1079780351.18972.48.camel@bach>
References: <20040320063642.GF1153@krispykreme>
	<20040320074033.A21586@infradead.org>
	<1079780351.18972.48.camel@bach>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> Name: Remove Strange start_cpu_timer Code
>  Status: Untested
> 
>  Why is start_cpu_timer checking for fn being NULL?  And why isn't
>  every CPU's reap_timer initialized in cpucache_init (which is an
>  __init function).
> 
>  Clean up this mess by just starting the timer in start_cpu_timer.

oy.

Program received signal SIGTRAP, Trace/breakpoint trap.
0xc0128e32 in add_timer_on (timer=0xc120d880, cpu=1) at kernel/timer.c:225
225             BUG_ON(timer_pending(timer) || !timer->function);
(gdb) bt
#0  0xc0128e32 in add_timer_on (timer=0xc120d880, cpu=1) at kernel/timer.c:225
#1  0xc01446b5 in cpuup_callback (nfb=0xc0472800, action=4, hcpu=0x1) at mm/slab.c:595
#2  0xc012dc67 in notifier_call_chain (n=0x4, val=2, v=0x1) at kernel/sys.c:169
#3  0xc0134b63 in cpu_up (cpu=1) at kernel/cpu.c:192
#4  0xc05e0650 in smp_init () at init/main.c:364
#5  0xc0103161 in init (unused=0x0) at init/main.c:626
#6  0xc010728d in kernel_thread_helper () at arch/i386/kernel/process.c:246
(gdb) p timer->function
$1 = (void (*)(long unsigned int)) 0


I'll simply mark start_cpu_timer() as __devinit.
