Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbTBTF5n>; Thu, 20 Feb 2003 00:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbTBTF5n>; Thu, 20 Feb 2003 00:57:43 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:51030
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264903AbTBTF5l>; Thu, 20 Feb 2003 00:57:41 -0500
Date: Thu, 20 Feb 2003 01:05:45 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302192039400.1453-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.50.0302200020390.10247-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0302192039400.1453-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, Linus Torvalds wrote:

> +			printk("esi = %08lx, edi = %08lx, %ebp = %08lx\n",
> +				t->esi, t->edi, t->ebp);

Too much AT&T for you ;) '%ebp'

> +			 * We could print out the stack contents here: esp0
> +			 * is the beginning of the stack, we could print out
> +			 * all the code points we can find underneath it or
> +			 * something.. 
> +			 */

Simulator managed to dump stack for me, nothing interesting though

  > +		
> +			/* This might be a point to try to kill the process and clean up */
> +			t->esp = esp0;
> +			t->eip = (unsigned long) do_exit;
> +			asm volatile("iret");
>  		}
>  	}
>  
> 
> 

Here is what i managed to fish out from the sim, not a real call trace, 
i just piped the stack contents through ksymoops.

Trace; c02b97ec <doublefault_stack+fec/1000>
Trace; c02b97ee <doublefault_stack+fee/1000>
Trace; c02b97f0 <doublefault_stack+ff0/1000>
Trace; c02b97f2 <doublefault_stack+ff2/1000>
Trace; c02b97f4 <doublefault_stack+ff4/1000>
Trace; c02b97f6 <doublefault_stack+ff6/1000>
Trace; c02b97f8 <doublefault_stack+ff8/1000>
Trace; c02b97fa <doublefault_stack+ffa/1000>
Trace; c02b97fc <doublefault_stack+ffc/1000>
Trace; c02b97fe <doublefault_stack+ffe/1000>
Trace; c02b9800 <use_tsc+0/4>
Trace; c02b9802 <use_tsc+2/4>
Trace; c02b9804 <delay_at_last_interrupt+0/4>
Trace; c02b9806 <delay_at_last_interrupt+2/4>
Trace; c02b9808 <last_tsc_low+0/4>
Trace; c02b980a <last_tsc_low+2/4>
Trace; c02b980c <fast_gettimeoffset_quotient+0/4>
Trace; c02b980e <fast_gettimeoffset_quotient+2/4>
Trace; c02b9810 <pm_power_off+0/4>
Trace; c02b9812 <pm_power_off+2/4>
Trace; c02b9814 <no_idt+0/8>
Trace; c02b9816 <no_idt+2/8>
Trace; c02b9818 <no_idt+4/8>
Trace; c02b981a <no_idt+6/8>
Trace; c02b981c <reboot_mode+0/4>
Trace; c02b981e <reboot_mode+2/4>
Trace; c02b9820 <reboot_thru_bios+0/4>
Trace; c02b9822 <reboot_thru_bios+2/4>
Trace; c02b9824 <flush_cpumask+0/4>
Trace; c02b9826 <flush_cpumask+2/4>
Trace; c02b9828 <flush_mm+0/4>
Trace; c02b982a <flush_mm+2/4>
Trace; c02b982c <flush_va+0/4>
Trace; c02b982e <flush_va+2/4>
Trace; c02b9830 <call_data+0/8>
Trace; c02b9832 <call_data+2/8>
Trace; c02b9834 <call_data+4/8>
Trace; c02b9836 <call_data+6/8>
Trace; c02b9838 <cacheflush_time+0/8>
Trace; c02b983a <cacheflush_time+2/8>
Trace; c02b983c <cacheflush_time+4/8>
Trace; c02b983e <cacheflush_time+6/8>
Trace; c02b9840 <cpu_online_map+0/4>
Trace; c02b9842 <cpu_online_map+2/4>
Trace; c02b9844 <cpu_callout_map+0/4>
Trace; c02b9846 <cpu_callout_map+2/4>
Trace; c02b9848 <smp_threads_ready+0/4>
Trace; c02b984a <smp_threads_ready+2/4>
Trace; c02b984c <cache_decay_ticks+0/4>
Trace; c02b984e <cache_decay_ticks+2/4>
Trace; c02b9850 <phys_proc_id+0/4>
Trace; c02b9852 <phys_proc_id+2/4>
Trace; c02b9854 <cpu_callin_map+0/4>
Trace; c02b9856 <cpu_callin_map+2/4>
Trace; c02b9858 <smp_commenced_mask+0/4>
Trace; c02b985a <smp_commenced_mask+2/4>
Trace; c02b985c <trampoline_base+0/4>
Trace; c02b985e <trampoline_base+2/4>
Trace; c02b9860 <tsc_values+0/8>
Trace; c02b9862 <tsc_values+2/8>
Trace; c02b9864 <tsc_values+4/8>
Trace; c02b9866 <tsc_values+6/8>
Trace; c02b9868 <init_deasserted+0/4>
Trace; c02b986a <init_deasserted+2/4>

-- 
function.linuxpower.ca
