Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270781AbUJUSaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270781AbUJUSaZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270798AbUJUS0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:26:54 -0400
Received: from mail8.spymac.net ([195.225.149.8]:50343 "EHLO mail8")
	by vger.kernel.org with ESMTP id S270794AbUJUSWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:22:05 -0400
Message-ID: <41781A65.9040004@spymac.com>
Date: Thu, 21 Oct 2004 22:21:57 +0200
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
References: <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <4177FAB0.6090406@spymac.com> <20041021164018.GA11560@elte.hu>
In-Reply-To: <20041021164018.GA11560@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Gunther Persoons <gunther_persoons@spymac.com> wrote:
>
>  
>
>>The kernel booted now with my firewire card plugged in. However when i
>>try to mount my reiser4 partition i get following error
>>
>>BUG: semaphore recursion deadlock detected!
>>.. current task mount/10514 is already holding ccb5bb4c.
>>    
>>
>
>  
>
>>[<c0344760>] down_write+0x103/0x1a6 (48)
>>[<d0b26a08>] kcond_wait+0xaa/0xac [reiser4] (36)
>>[<d0b280b0>] start_ktxnmgrd+0x98/0x9a [reiser4] (36)
>>[<d0b33716>] reiser4_fill_super+0x3b/0x71 [reiser4] (28)
>>[<d0b2d569>] reiser4_get_sb+0x2f/0x33 [reiser4] (68)
>>[<c016061a>] do_kern_mount+0x4f/0xc0 (4)
>>[<c0175945>] do_new_mount+0x9c/0xe1 (36)
>>[<c0175feb>] do_mount+0x145/0x194 (44)
>>[<c0176459>] sys_mount+0x9f/0xe0 (32)
>>[<c01060b1>] sysenter_past_esp+0x52/0x71 (44)
>>    
>>
>
>reiser4 has some pretty ugly locking abstraction called kcond, i took a
>look but it doesnt seem simple to convert it. Reiserfs should really use
>a normal Linux waitqueue and nothing more...
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
Got a second error, while compiling a new kernel my network connection 
got down

BUG: semaphore recursion deadlock detected!
.. current task eth0/10202 is already holding cc9345ac.
cc9345ac c03433b7 cfe51260 ccb5e000 cc9345ac cd11c740 ccb5ff8c ffffe000
       c034490c cc9345ac 000001d9 cc9345b0 cc9345b0 cd11c740 00000002 
cc9343e0
       ccb5e000 cc934644 ffffe000 d0a7a136 c5fcd280 cc934000 ccb5e000 
c0105fda
Call Trace:
 [<c03433b7>] __sched_text_start+0x2e3/0x5e2 (8)
 [<c034490c>] down_write_interruptible+0x109/0x243 (28)
 [<d0a7a136>] airo_thread+0x82/0x2a0 [airo] (44)
 [<c0105fda>] ret_from_fork+0x6/0x14 (16)
 [<c011d046>] default_wake_function+0x0/0x12 (12)
 [<d0a7a0b4>] airo_thread+0x0/0x2a0 [airo] (24)
 [<c01042a9>] kernel_thread_helper+0x5/0xb (16)
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: down_write_interruptible+0x23e/0x243 / (0x0)
.. entry 2: down_write_interruptible+0x6c/0x243 / (0x0)
.. entry 3: print_traces+0x17/0x50 / (0x0)


