Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268141AbUH2AVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268141AbUH2AVQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 20:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268142AbUH2AVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 20:21:16 -0400
Received: from gizmo12ps.bigpond.com ([144.140.71.43]:47323 "HELO
	gizmo12ps.bigpond.com") by vger.kernel.org with SMTP
	id S268141AbUH2AVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 20:21:12 -0400
Message-ID: <41312174.40707@bigpond.net.au>
Date: Sun, 29 Aug 2004 10:21:08 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: spaminos-ker@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and
 others)
References: <20040828015937.50607.qmail@web13902.mail.yahoo.com>
In-Reply-To: <20040828015937.50607.qmail@web13902.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spaminos-ker@yahoo.com wrote:
> --- Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
>>A (gzipped) combined ZAPHOD and P9 voluntary preempt patch for 2.6.8.1 
>>is available at:
>>
>>
> 
> <http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-zaphod-vp-v5.0.1.gz?download>
> 
>>This patch has had minimal testing so use with care and please let me 
>>know if there are any problems.
>>
> 
> 
> I tried this patch, and I get a pretty high latency in "sub_preempt_count"
> 00000001 0.730ms (+0.730ms): sub_preempt_count (_mmx_memcpy)
> 
> I am not sure if that makes sense and what it means.
> 
> Nicolas
> 
> 
> Here are the full messages:
> 
> Aug 27 18:42:11 localhost kernel: (events/0/4): new 730 us maximum-latency
> critical section.
> Aug 27 18:42:11 localhost kernel:  => started at: <kernel_fpu_begin+0x21/0x60>
> Aug 27 18:42:11 localhost kernel:  => ended at:   <_mmx_memcpy+0x131/0x180>
> Aug 27 18:42:11 localhost kernel:  [<c014106a>]
> check_preempt_timing+0x1aa/0x240
> Aug 27 18:42:11 localhost kernel:  [<c0225751>] _mmx_memcpy+0x131/0x180
> Aug 27 18:42:11 localhost kernel:  [<c0225751>] _mmx_memcpy+0x131/0x180
> Aug 27 18:42:11 localhost kernel:  [<c0141244>] sub_preempt_count+0x54/0x60
> Aug 27 18:42:11 localhost kernel:  [<c0141244>] sub_preempt_count+0x54/0x60
> Aug 27 18:42:11 localhost kernel:  [<c0225751>] _mmx_memcpy+0x131/0x180
> Aug 27 18:42:11 localhost kernel:  [<c02dd9fe>] vgacon_save_screen+0x7e/0x80
> Aug 27 18:42:11 localhost kernel:  [<c0267d32>] do_blank_screen+0x182/0x2b0
> Aug 27 18:42:11 localhost kernel:  [<c0122fa4>] acquire_console_sem+0x44/0x70
> Aug 27 18:42:11 localhost kernel:  [<c0266ab2>] console_callback+0x72/0xf0
> Aug 27 18:42:11 localhost kernel:  [<c0134dcb>] worker_thread+0x1eb/0x2d0
> Aug 27 18:42:11 localhost kernel:  [<c0266a40>] console_callback+0x0/0xf0
> Aug 27 18:42:11 localhost kernel:  [<c011c000>] default_wake_function+0x0/0x20
> Aug 27 18:42:11 localhost kernel:  [<c011c000>] default_wake_function+0x0/0x20
> Aug 27 18:42:11 localhost kernel:  [<c013963c>] kthread+0xbc/0xd0
> Aug 27 18:42:11 localhost kernel:  [<c0134be0>] worker_thread+0x0/0x2d0
> Aug 27 18:42:11 localhost kernel:  [<c0139580>] kthread+0x0/0xd0
> Aug 27 18:42:11 localhost kernel:  [<c0104389>] kernel_thread_helper+0x5/0xc
> 
> preemption latency trace v1.0.2
> -------------------------------
>  latency: 730 us, entries: 4 (4)
>     -----------------
>     | task: events/0/4, uid:0 nice:-10 policy:0 rt_prio:0
>     -----------------
>  => started at: kernel_fpu_begin+0x21/0x60
>  => ended at:   _mmx_memcpy+0x131/0x180
> =======>
> 00000001 0.000ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)
> 00000001 0.730ms (+0.730ms): sub_preempt_count (_mmx_memcpy)
> 00000001 0.730ms (+0.000ms): _mmx_memcpy (check_preempt_timing)
> 00000001 0.730ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)
> 

As far as I can see sub_preempt_count() is part of the latency measuring 
component of the voluntary preempt patch so, like you, I'm not sure 
whether this report makes any sense.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

