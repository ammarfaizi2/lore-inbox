Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUKGWVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUKGWVg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 17:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbUKGWVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 17:21:35 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:29006 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261693AbUKGWV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 17:21:29 -0500
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.18
Date: Sun, 7 Nov 2004 23:22:55 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
References: <20041019124605.GA28896@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>
In-Reply-To: <20041106155720.GA14950@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411072322.55884.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag 06 November 2004 16:57 schrieb Ingo Molnar:
> 
> i have released the -V0.7.18 Real-Time Preemption patch, which can be
> downloaded from:
> 

Hi Ingo

got this on a netconsole when I hit <TAB> in bash to complete "cat /proc/acpi":
>>>>>>
BUG: sleeping function called from invalid context bash(5364) at /home/ka/kernel/2.6/linux-2.6.9-rc1-mm3-RT/kernel/rt.c:1322
in_atomic():1 [00000001], irqs_disabled():0
 [<c010803e>] <3>BUG: scheduling while atomic: bash/0x00000001/5364
caller is schedule+0x38/0x12e
 [<c010803e>] dump_stack+0x23/0x25 (20)
 [<c0311096>] __sched_text_start+0x9f6/0xdb4 (124)
 [<c031148c>] schedule+0x38/0x12e (36)
 [<c0312904>] __down_mutex+0x231/0x31a (84)
 [<c013d23a>] __spin_lock+0x46/0x50 (24)
 [<c013d2be>] _spin_lock_irqsave+0x1d/0x21 (16)
 [<c025f03b>] e100_xmit_frame+0x3c/0x2d8 (60)
 [<c02ae6c0>] netpoll_send_skb+0x23/0xb3 (28)
 [<c0263066>] write_msg+0x56/0xfa (52)
 [<c0124099>] __call_console_drivers+0x59/0x6c (32)
 [<c01241c0>] call_console_drivers+0x8c/0x163 (36)
 [<c01245bd>] release_console_sem+0x33/0xde (32)
 [<c01244c3>] vprintk+0x134/0x16d (36)
 [<c012438d>] printk+0x1d/0x1f (16)
 [<c0107f18>] show_trace+0x65/0xcd (36)
 [<c010803e>] dump_stack+0x23/0x25 (20)
 [<c01203ab>] __might_sleep+0xbc/0xcf (36)
 [<c013d228>] __spin_lock+0x34/0x50 (24)
 [<c013d2be>] _spin_lock_irqsave+0x1d/0x21 (16)
 [<c01437cd>] search_module_extables+0x1c/0x87 (32)
 [<c01375d9>] search_exception_tables+0x39/0x3b (24)
 [<c011b5d6>] fixup_exception+0x1a/0x34 (16)
 [<c011ae50>] do_page_fault+0x37e/0x64e (220)
 [<c0107c63>] error_code+0x2b/0x30 (100)
 [<c0199214>] proc_lookup+0x81/0xc9 (52)
 [<c0176318>] real_lookup+0xb2/0xd6 (36)
 [<c017663f>] do_lookup+0x82/0x8d (32)
 [<c0176dbf>] link_path_walk+0x775/0x1071 (108)
 [<c01779e2>] path_lookup+0xa5/0x1b0 (32)
 [<c0177c8f>] __user_walk+0x30/0x4d (32)
 [<c017211b>] vfs_stat+0x1f/0x5a (92)
 [<c01727b4>] sys_stat64+0x1e/0x3d (100)
 [<c0107191>] sysenter_past_esp+0x52/0x71 (-4028)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c031300b>] .... _raw_spin_lock+0x1c/0x73
.....[<c011bb74>] ..   ( <= task_rq_lock+0x32/0x5b)
.. [<c013ec19>] .... print_traces+0x1b/0x52
.....[<c010803e>] ..   ( <= dump_stack+0x23/0x25)
<<<<<<
then follow lots of
>>>>>>
BUG: scheduling while atomic: bash/0x00000001/5364
caller is schedule+0x38/0x12e
 [<c010803e>] dump_stack+0x23/0x25 (20)
 [<c0311096>] __sched_text_start+0x9f6/0xdb4 (124)
 [<c031148c>] schedule+0x38/0x12e (36)
 [<c0312904>] __down_mutex+0x231/0x31a (84)
 [<c013d23a>] __spin_lock+0x46/0x50 (24)
 [<c013d2be>] _spin_lock_irqsave+0x1d/0x21 (16)
 [<c025f03b>] e100_xmit_frame+0x3c/0x2d8 (60)
 [<c02ae6c0>] netpoll_send_skb+0x23/0xb3 (28)
 [<c0263066>] write_msg+0x56/0xfa (52)
 [<c0124099>] __call_console_drivers+0x59/0x6c (32)
 [<c01241e0>] call_console_drivers+0xac/0x163 (36)
 [<c01245bd>] release_console_sem+0x33/0xde (32)
 [<c01244c3>] vprintk+0x134/0x16d (36)
 [<c012438d>] printk+0x1d/0x1f (16)
 [<c0107f18>] show_trace+0x65/0xcd (36)
 [<c010803e>] dump_stack+0x23/0x25 (20)
 [<c01203ab>] __might_sleep+0xbc/0xcf (36)
 [<c013d228>] __spin_lock+0x34/0x50 (24)
 [<c013d2be>] _spin_lock_irqsave+0x1d/0x21 (16)
 [<c01437cd>] search_module_extables+0x1c/0x87 (32)
 [<c01375d9>] search_exception_tables+0x39/0x3b (24)
 [<c011b5d6>] fixup_exception+0x1a/0x34 (16)
 [<c011ae50>] do_page_fault+0x37e/0x64e (220)
 [<c0107c63>] error_code+0x2b/0x30 (100)
 [<c0199214>] proc_lookup+0x81/0xc9 (52)
 [<c0176318>] real_lookup+0xb2/0xd6 (36)
 [<c017663f>] do_lookup+0x82/0x8d (32)
 [<c0176dbf>] link_path_walk+0x775/0x1071 (108)
 [<c01779e2>] path_lookup+0xa5/0x1b0 (32)
 [<c0177c8f>] __user_walk+0x30/0x4d (32)
 [<c017211b>] vfs_stat+0x1f/0x5a (92)
 [<c01727b4>] sys_stat64+0x1e/0x3d (100)
 [<c0107191>] sysenter_past_esp+0x52/0x71 (-4028)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c031300b>] .... _raw_spin_lock+0x1c/0x73
.....[<c011bb74>] ..   ( <= task_rq_lock+0x32/0x5b)
.. [<c013ec19>] .... print_traces+0x1b/0x52
.....[<c010803e>] ..   ( <= dump_stack+0x23/0x25)
<<<<<<

then the machine is frozen.

Best regards,
Karsten
