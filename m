Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbUKDUGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbUKDUGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbUKDTjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:39:22 -0500
Received: from mail8.spymac.net ([195.225.149.8]:8614 "EHLO mail8")
	by vger.kernel.org with ESMTP id S262444AbUKDTe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:34:29 -0500
Message-ID: <418A8439.2000003@spymac.com>
Date: Thu, 04 Nov 2004 20:34:17 +0100
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu>
In-Reply-To: <20041103105840.GA3992@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>i have released the -V0.7.1 Real-Time Preemption patch, which can be
>downloaded from:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
>this release is mainly a merge of -V0.6.9 to 2.6.10-rc2-mm2.
>
>I havent done a proper changelog for a couple of days so here is a list
>of bigger changes since -V0.4:
>
> - implemented a first version of the priority inheritance handling and
>   priority inversion avoidance logic. This feature, after some initial
>   stability problems, solved the jackd and rtc_wakeup latencies that
>   were introduced by the ultra-finegrained locking in the -V series.
>
>   (the -T/U series had a coarser locking scheme triggered much lower
>   levels of priority inversion scenarios. The locking in the -V series
>   was clearly the tipping point.)
>
>   The new PI code covers all synchronization objects in Linux (on
>   PREEMPT_REALTIME): spinlocks, rwlocks, semaphores and rwsems. 
>   Feedback on the design of this code would be welcome, and patches as
>   well, if you have a better scheme. The code is pretty modular so feel 
>   free to experiment with alternative schemes.
>
> - completely reworked the debugging framework. All lock types
>   (spinlocks, rwlocks, semaphores and rwsems) are now tracked, both
>   their symbolic name and their place of acquire are traced and printed
>   out upon detection of a deadlock. More and better information is
>   printed upon a deadlock. Got rid of the 'semaphore owners array' in
>   debugging mode, this reduces the footprint of semaphores quite
>   significantly and speeds up deadlock detection.
>
> - got rid of the separate 'counted semaphores' implementation, it was
>   too intrusive. Made the core 'generic semaphores' implementation
>   compatible with vanilla Linux counted semaphore semantics. This also
>   enabled the unrolling of the completion-handling cleanups which,
>   while being very nice, were getting intrusive as well.
>
> - countless build and driver related reports/fixes from lots of people
>
> - more latency breaks in the remaining critical sections. A
>   particularly important one was the irqs-off latency bugfix from
>   Thomas Gleixner.
>
> - sped up the i8259 PIC and the PIT timer hardirq handling routines -
>   these are now in the path of the longest latency.
>
> - cleaned up IRQ and signal preemption - there were missed
>   check-rescheds and possibilities for IRQ recursion.
>
> - made ALSA's ioctl()s not use the BKL - this fixes more jackd
>   latencies.
>
>to create a -V0.7.1 tree from scratch, the patching order is:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc1.bz2
>   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/2.6.10-rc1-mm2.bz2
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc1-mm2-V0.7.1
>
>	Ingo
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hey,
I get a lock up with my wireless pcmcia cisco card. When i try to run to 
dhcpcd command or iwconfig it just hangs. Also when
i insert my card at boot time it hangs when running the net init 
scripts. I had this with version V0.7.8 and V0.7.10, have tested any 
other RT patches, i didn't have this problem with VP-T3. Also i can now 
mount and use my reiser4 partition.
