Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbUJXNWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbUJXNWL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbUJXNU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:20:59 -0400
Received: from mail8.spymac.net ([195.225.149.8]:41670 "EHLO mail8")
	by vger.kernel.org with ESMTP id S261474AbUJXNTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:19:17 -0400
Message-ID: <417BC7F1.90500@spymac.com>
Date: Sun, 24 Oct 2004 17:19:13 +0200
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
References: <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
In-Reply-To: <20041022175633.GA1864@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>i have released the -U10.2 Real-Time Preemption patch, which can be
>downloaded from:
>
>  http://redhat.com/~mingo/realtime-preempt/
> 
>this is a fixes-only release.
>
>Changes since -U10:
>
> - fixed a big bug present ever since: the BKL got dropped when a
>   spinlock-mutex was acquired and it scheduled away. This reduced the
>   locking efficiency of the BKL. A number of outstanding problems could
>   be affected, in particular this should fix the tty locking breakage
>   reported by Alexander Batyrshin and Adam Heath. UP and SMP systems 
>   are affected too, with SMP systems having a higher chance to trigger
>   this condition.
>
> - tulip.c breakage fix from Thomas Gleixner
>
> - tg3 and 3c59x fixes.
>
> - made the hardirq threads SCHED_FIFO by default. They get priorities 
>   between 25 and 50, depending on the irq #. (this is pretty random but 
>   i found no better scheme.) Made the softirq thread SCHED_FIFO by 
>   default as well, albeit this probably will have to change. These 
>   changes should make it easier to debug a hung system.
>
>to create a -U10.2 tree from scratch, the patching order is:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
> + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/2.6.9-mm1.bz2
> + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-mm1-U10.2
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
I get following error with 10.3 on kernel 2.6.9-mm1

Device 'i823650' does not have a release() function, it is broken and 
must be fixed.
swapper/1: BUG in device_release at drivers/base/core.c:85
 [<c0238aeb>] kobject_cleanup+0x9a/0x9c (8)
 [<c0238b15>] kobject_put+0x1e/0x22 (24)
 [<c0238aed>] kobject_release+0x0/0xa (8)
 [<c045cecf>] init_i82365+0x1f2/0x208 (4)
 [<c02487b6>] pci_register_driver+0x94/0xa6 (8)
 [<c044286c>] do_initcalls+0x54/0xb6 (32)
 [<c010040b>] init+0x0/0x10d (16)
 [<c010043f>] init+0x34/0x10d (12)
 [<c01042a8>] kernel_thread_helper+0x0/0xb (12)
 [<c01042ad>] kernel_thread_helper+0x5/0xb (4)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x14/0x45 [<00000000>] / (0x0 [<00000000>])

