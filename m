Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUH1B74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUH1B74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 21:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUH1B7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 21:59:55 -0400
Received: from web13902.mail.yahoo.com ([216.136.175.28]:5178 "HELO
	web13902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266139AbUH1B7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 21:59:39 -0400
Message-ID: <20040828015937.50607.qmail@web13902.mail.yahoo.com>
Date: Fri, 27 Aug 2004 18:59:37 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and others)
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <412DA1C3.6020505@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Peter Williams <pwil3058@bigpond.net.au> wrote:
> A (gzipped) combined ZAPHOD and P9 voluntary preempt patch for 2.6.8.1 
> is available at:
> 
>
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-zaphod-vp-v5.0.1.gz?download>
> 
> This patch has had minimal testing so use with care and please let me 
> know if there are any problems.
> 

I tried this patch, and I get a pretty high latency in "sub_preempt_count"
00000001 0.730ms (+0.730ms): sub_preempt_count (_mmx_memcpy)

I am not sure if that makes sense and what it means.

Nicolas


Here are the full messages:

Aug 27 18:42:11 localhost kernel: (events/0/4): new 730 us maximum-latency
critical section.
Aug 27 18:42:11 localhost kernel:  => started at: <kernel_fpu_begin+0x21/0x60>
Aug 27 18:42:11 localhost kernel:  => ended at:   <_mmx_memcpy+0x131/0x180>
Aug 27 18:42:11 localhost kernel:  [<c014106a>]
check_preempt_timing+0x1aa/0x240
Aug 27 18:42:11 localhost kernel:  [<c0225751>] _mmx_memcpy+0x131/0x180
Aug 27 18:42:11 localhost kernel:  [<c0225751>] _mmx_memcpy+0x131/0x180
Aug 27 18:42:11 localhost kernel:  [<c0141244>] sub_preempt_count+0x54/0x60
Aug 27 18:42:11 localhost kernel:  [<c0141244>] sub_preempt_count+0x54/0x60
Aug 27 18:42:11 localhost kernel:  [<c0225751>] _mmx_memcpy+0x131/0x180
Aug 27 18:42:11 localhost kernel:  [<c02dd9fe>] vgacon_save_screen+0x7e/0x80
Aug 27 18:42:11 localhost kernel:  [<c0267d32>] do_blank_screen+0x182/0x2b0
Aug 27 18:42:11 localhost kernel:  [<c0122fa4>] acquire_console_sem+0x44/0x70
Aug 27 18:42:11 localhost kernel:  [<c0266ab2>] console_callback+0x72/0xf0
Aug 27 18:42:11 localhost kernel:  [<c0134dcb>] worker_thread+0x1eb/0x2d0
Aug 27 18:42:11 localhost kernel:  [<c0266a40>] console_callback+0x0/0xf0
Aug 27 18:42:11 localhost kernel:  [<c011c000>] default_wake_function+0x0/0x20
Aug 27 18:42:11 localhost kernel:  [<c011c000>] default_wake_function+0x0/0x20
Aug 27 18:42:11 localhost kernel:  [<c013963c>] kthread+0xbc/0xd0
Aug 27 18:42:11 localhost kernel:  [<c0134be0>] worker_thread+0x0/0x2d0
Aug 27 18:42:11 localhost kernel:  [<c0139580>] kthread+0x0/0xd0
Aug 27 18:42:11 localhost kernel:  [<c0104389>] kernel_thread_helper+0x5/0xc

preemption latency trace v1.0.2
-------------------------------
 latency: 730 us, entries: 4 (4)
    -----------------
    | task: events/0/4, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: kernel_fpu_begin+0x21/0x60
 => ended at:   _mmx_memcpy+0x131/0x180
=======>
00000001 0.000ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)
00000001 0.730ms (+0.730ms): sub_preempt_count (_mmx_memcpy)
00000001 0.730ms (+0.000ms): _mmx_memcpy (check_preempt_timing)
00000001 0.730ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

