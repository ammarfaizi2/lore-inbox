Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131810AbRCQVcO>; Sat, 17 Mar 2001 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131184AbRCQVcE>; Sat, 17 Mar 2001 16:32:04 -0500
Received: from [194.213.32.137] ([194.213.32.137]:13060 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131768AbRCQVcA>;
	Sat, 17 Mar 2001 16:32:00 -0500
Message-ID: <20010317183408.A137@bug.ucw.cz>
Date: Sat, 17 Mar 2001 18:34:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: nigel@nrg.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <Pine.LNX.4.05.10103141653350.3094-100000@cosmic.nrg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.05.10103141653350.3094-100000@cosmic.nrg.org>; from Nigel Gamble on Wed, Mar 14, 2001 at 05:25:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here is the latest preemptible kernel patch.  It's much cleaner and
> smaller than previous versions, so I've appended it to this mail.  This
> patch is against 2.4.2, although it's not intended for 2.4.  I'd like
> comments from anyone interested in a low-latency Linux kernel solution
> for the 2.5 development tree.
> 
> Kernel preemption is not allowed while spinlocks are held, which means
> that this patch alone cannot guarantee low preemption latencies.  But
> as long held locks (in particular the BKL) are replaced by finer-grained
> locks, this patch will enable lower latencies as the kernel also becomes
> more scalable on large SMP systems.
> 
> Notwithstanding the comments in the Configure.help section for
> CONFIG_PREEMPT, I think this patch has a negligible effect on
> throughput.  In fact, I got better average results from running 'dbench
> 16' on a 750MHz PIII with 128MB with kernel preemption turned on
> (~30MB/s) than on the plain 2.4.2 kernel (~26MB/s).

That is not bad result!

> (I had to rearrange three headers files that are needed in sched.h before
> task_struct is defined, but which include inline functions that cannot
> now be compiled until after task_struct is defined.  I chose not to
> move them into sched.h, like d_path(), as I don't want to make it more
> difficult to apply kernel patches to my kernel source tree.)


> diff -Nur 2.4.2/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
> --- 2.4.2/arch/i386/kernel/traps.c	Wed Mar 14 12:16:46 2001
> +++ linux/arch/i386/kernel/traps.c	Wed Mar 14 12:22:45 2001
> @@ -973,7 +973,7 @@
>  	set_trap_gate(11,&segment_not_present);
>  	set_trap_gate(12,&stack_segment);
>  	set_trap_gate(13,&general_protection);
> -	set_trap_gate(14,&page_fault);
> +	set_intr_gate(14,&page_fault);
>  	set_trap_gate(15,&spurious_interrupt_bug);
>  	set_trap_gate(16,&coprocessor_error);
>  	set_trap_gate(17,&alignment_check);

Are you sure about this piece? Add least add a comment, because it
*looks* strange.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
