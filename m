Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbUKMWM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUKMWM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 17:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbUKMWM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 17:12:57 -0500
Received: from mail8.spymac.net ([195.225.149.8]:6855 "EHLO mail8")
	by vger.kernel.org with ESMTP id S261183AbUKMWMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 17:12:54 -0500
Message-ID: <419694EC.7090701@spymac.com>
Date: Sun, 14 Nov 2004 00:12:44 +0100
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041113)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <41951380.2080801@spymac.com> <20041112201936.GA15133@elte.hu>
In-Reply-To: <20041112201936.GA15133@elte.hu>
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
>>I cant use my pcmcia wireless network card with this version, i can
>>use it with V0.7.25-0. dhcpcd and ifconfig lock when i try to use
>>them.  config attached.
>>    
>>
>
>extremely weird - there simply was no change between -0 and -1 that
>could have affected it. If you do this on the -1 kernel:
>
>	echo 0 > /proc/sys/kernel/preempt_wakeup_timing
>	echo 1 > /proc/sys/kernel/debug_direct_keyboard
>
>then you'll get precisely the -0 kernel, bit for bit. (plus the symbol
>export fix in rtc.ko, which should have zero relevance to your setup.)
>
>[note that debug_direct_keyboard is dangerous.]
>
>so i believe the explanation has to be something else:
>
> - are you sure the build is correct?
>
> - are you sure it still works with the -0 kernel, maybe the bug is 
>   transient?
>
>	Ingo
>
>  
>
this bug i got with .26
wget:12388 BUG: lock held at task exit time!
 [c03ec764] {kernel_sem.lock}
.. held by:              wget:12388 [c87d2680, 116]
... acquired at:  __lock_text_start+0x2c/0x63
wget/12388: BUG in __up_mutex at kernel/rt.c:1076
 [<c01395b0>] __up_mutex+0x2a3/0x509 (8)
 [<c037f3b0>] __sched_text_start+0x508/0x64b (36)
 [<c013a637>] up+0xef/0x104 (24)
 [<c037f3b0>] __sched_text_start+0x508/0x64b (12)
 [<c037f3b0>] __sched_text_start+0x508/0x64b (20)
 [<c012480d>] do_exit+0x2d8/0x515 (8)
 [<c0138126>] printk_lock+0x7f/0xc1 (4)
 [<c0381136>] __lock_text_start+0x2c/0x63 (36)
 [<c012480d>] do_exit+0x2d8/0x515 (32)
 [<c012ea47>] get_signal_to_deliver+0x21e/0x379 (16)
 [<c0124ab8>] do_group_exit+0x3f/0xcc (28)
 [<c012ea47>] get_signal_to_deliver+0x21e/0x379 (8)
 [<c012ea73>] get_signal_to_deliver+0x24a/0x379 (24)
 [<c0105f88>] do_signal+0xa4/0x174 (44)
 [<c014725b>] free_hot_page+0x20/0x24 (112)
 [<c0177541>] poll_freewait+0x38/0x40 (12)
 [<c0178254>] sys_poll+0x18b/0x21f (16)
 [<c0177549>] __pollwait+0x0/0xc6 (36)
 [<c010608d>] do_notify_resume+0x35/0x38 (24)
 [<c010620e>] work_notifysig+0x13/0x15 (8)
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c037eef2>] .... __sched_text_start+0x4a/0x64b
.....[<00000000>] ..   ( <= 0x0)
.. [<c013a5f1>] .... up+0xa9/0x104
.....[<00000000>] ..   ( <= 0x0)
.. [<c0139665>] .... __up_mutex+0x358/0x509
.....[<00000000>] ..   ( <= 0x0)
.. [<c013b1fe>] .... print_traces+0x14/0x44
.....[<00000000>] ..   ( <= 0x0)

