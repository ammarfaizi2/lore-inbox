Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbVJDTz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVJDTz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVJDTz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:55:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:6344 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964945AbVJDTz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:55:29 -0400
Date: Wed, 5 Oct 2005 01:33:26 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051004200326.GC5072@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <43427AD9.9060104@cybsft.com> <20051004130009.GB31466@elte.hu> <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain> <20051004142718.GA3195@elte.hu> <20051004151635.GA8866@in.ibm.com> <1128442180.4252.0.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20051004175842.GA5072@in.ibm.com> <1128448471.4252.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20051004181125.GB5072@in.ibm.com> <1128450466.4252.15.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128450466.4252.15.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 11:27:46AM -0700, Daniel Walker wrote:
> 
> This patch should handle both cases . I would think if this doesn't
> silence it, then it's something else..


Daniel, This works for me !
Thanks for fixing this

	-Dinakar


> 
> Index: linux-2.6.13/arch/i386/kernel/apic.c
> ===================================================================
> --- linux-2.6.13.orig/arch/i386/kernel/apic.c
> +++ linux-2.6.13/arch/i386/kernel/apic.c
> @@ -1153,6 +1153,14 @@ fastcall notrace void smp_apic_timer_ipi
>  #if 0
>  	profile_tick(CPU_PROFILING, regs);
>  #endif
> +	/*
> +	 * If the task is currently running in user mode, don't
> +	 * detect soft lockups.  If CONFIG_DETECT_SOFTLOCKUP is not
> +	 * configured, this should be optimized out.
> +	 */
> +	if (user_mode(regs))
> +		touch_light_softlockup_watchdog();
> +
>  	update_process_times(user_mode_vm(regs));
>  	irq_exit();
>  
> @@ -1247,6 +1255,14 @@ inline void smp_local_timer_interrupt(st
>  						per_cpu(prof_counter, cpu);
>  		}
>  #ifdef CONFIG_SMP
> +		/*
> +		 * If the task is currently running in user mode, don't
> +		 * detect soft lockups.  If CONFIG_DETECT_SOFTLOCKUP is not
> +		 * configured, this should be optimized out.
> +		 */
> +		if (user_mode(regs))
> +			touch_light_softlockup_watchdog();
> +
>  		update_process_times(user_mode_vm(regs));
>  #endif
>  	}
> 
> 
