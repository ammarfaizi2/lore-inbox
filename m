Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSGJKR4>; Wed, 10 Jul 2002 06:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSGJKRz>; Wed, 10 Jul 2002 06:17:55 -0400
Received: from mail.spylog.com ([194.67.35.220]:50068 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S314584AbSGJKRx>;
	Wed, 10 Jul 2002 06:17:53 -0400
Date: Wed, 10 Jul 2002 14:20:31 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc1aa2
Message-ID: <20020710102031.GA3107@an.local>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <20020708184149.GL8878@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020708184149.GL8878@dualathlon.random>
User-Agent: Mutt/1.3.28i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea Arcangeli,

1. Hardware: M/B Intel "Tupelo" STL2.
   Network card :

(/proc/pci)

  Bus  0, device   3, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 8).
      IRQ 18.
      Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfb101000 [0xfb101fff].
      I/O at 0x5400 [0x543f].
      Non-prefetchable 32 bit memory at 0xfb000000 [0xfb0fffff].


2. from serial console:

...
Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 2.0.30-k1
Copyright (c) 2002 Intel Corporation

hw init failed
Failed to initialize e100, instance #0
...


3. 2.4.19rc1aa1 - work ok.

4. My .config

...
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
...


Once you wrote about "2.4.19rc1aa2":
> URL:
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc1aa2.gz
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc1aa2/
> 
> Only in 2.4.19rc1aa2: 000_e100-2.0.30-k1.gz
> Only in 2.4.19rc1aa2: 000_e1000-4.2.17-k1.gz
> Only in 2.4.19rc1aa1: 07_e100-1.8.38.gz
> Only in 2.4.19rc1aa1: 08_e100-includes-1
> Only in 2.4.19rc1aa1: 09_e100-compilehack-1
> 
> 	New patch.
> 
> Only in 2.4.19rc1aa2: 00_drop-broken-flock-account-1
> 
> 	per-task flock accounting was broken across tasks sharing the same
> 	files. Removed temporarly. This should fix sendmail. If somebody
> 	wanted to bypass the rlimit he needed simply to use fcntl instead
> 	so it's not going to make much difference for 2.4. Fix from
> 	Matthew Wilcox.
> 
> Only in 2.4.19rc1aa1: 00_o_direct-open-check-1
> Only in 2.4.19rc1aa2: 10_o_direct-open-check-2
> 
> 	Rediffed and changed some check for ->mapping that didn't made much
> 	sense (if either mapping or a_ops are missing we shouldn't let O_DIRECT
> 	to succeed either).
> 
> Only in 2.4.19rc1aa2: 00_parport_pc-compile-1
> 
> 	Compile parport_pc from Eyal Lebedinsky.
> 
> Only in 2.4.19rc1aa2: 00_poll-speedup-1
> 
> 	This allocates some hundred bytes from the stack to handle most
> 	poll common cases, with a small number of fd. At least the stack hungry
> 	places aren't going to be stacked one on top of the other (i.e. poll
> 	cannot run under follow_link etc..). Patch from Andi Kleen.
> 
> Only in 2.4.19rc1aa2: 00_setfl-race-fix-1
> 
> 	Fix race with ->fasync and O_DIRECT fcntl F_SETFL. O_DIRECT
> 	problem noticed by Matthew Wilcox, fasync problem noticed by
> 	Marcus Alanen.
> 
> Only in 2.4.19rc1aa2: 10_o1-sched-updates-A4-3
> Only in 2.4.19rc1aa1: 20_o1-sched-updates-A4-2
> 
> 	Rediffed before rcu_poll.
> 
> Only in 2.4.19rc1aa1: 10_rcu-poll-6
> Only in 2.4.19rc1aa2: 20_rcu-poll-7
> 
> 	Fixed potential starvation if idle task was scheduled by the time
> 	force_cpu_reschedule was executed. Also the original o1
> 	force_cpu_reschedule implementation for 2.5 was not correct. This new
> 	corrected one is getting merged soon into the rcu-poll for 2.5 too.
> 
> Only in 2.4.19rc1aa2: 50_uml-patch-2.4.18-36.gz
> 
> 	New update from Jeff.
> 
> Only in 2.4.19rc1aa1: 90_acpi-2.5.24-1.gz
> 
> 	Dropped, my laptop had an hardware problem so I'm not going to test it
> 	soon. Also it needed the backport of the pci-irq enable callbacks, it
> 	was very near to be finished. If my future laptop will deadlock at boot
> 	again with the 2.4 ACPI I will be willing to finish it :).  If somebody
> 	wants to contine on its own I've an unreleased -2 revision that was a
> 	bit more uptodate than the above one too.
> 
> Only in 2.4.19rc1aa1: 90_init-survive-threaded-race-3
> Only in 2.4.19rc1aa2: 90_init-survive-threaded-race-4
> 
> 	Fixed merging error, good spotting by by Sami Farin.
> 
> Only in 2.4.19rc1aa1: 93_NUMAQ-3
> Only in 2.4.19rc1aa2: 93_NUMAQ-4
> 
> 	Rediffed.
> 
> Only in 2.4.19rc1aa1: 94_numaq-tsc-2
> Only in 2.4.19rc1aa2: 94_numaq-tsc-3
> 
> 	s/==/=/. Apparently menuconfig understand the C like "==" syntax too,
> 	because it worked as expected until somebody tried xconfig.  Fix from
> 	J.A. Magallon. (I use menuconfig so I could hardly notice it :)
> 
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
bye.
Andrey Nekrasov, SpyLOG.
