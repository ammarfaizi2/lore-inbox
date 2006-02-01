Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWBADA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWBADA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 22:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWBADA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 22:00:28 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:20263 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030222AbWBADA2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 22:00:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H9vtIeyLGyod0kma75q5FigJF0akeR+jXaxctXas7+dVH7fxegYsfq0YIaUroV1/sZtgofGY2VSZQYKuMEsq+/mmD1+gCFcGzk99inTpb1gZhMP5OBurJmcMXocJnbLJCa6G5xymRdWJtV27ADKsAIrJ5iliEHanp29RXPdfnTw=
Message-ID: <38bdcd1f0601311900n6f081329kb28329b3be6826a5@mail.gmail.com>
Date: Wed, 1 Feb 2006 12:00:26 +0900
From: Masanari Iida <standby24x7@gmail.com>
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: oops rcu_torture_wri on 2.6.16-rc1-git4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System was crashed with oom-killer.
Following "BUG" are logged.

Jan 25 04:03:29 catbert kernel: BUG: spinlock recursion on CPU#1,
rcu_torture_wri/16
Jan 25 04:03:29 catbert kernel:  lock: c0402604, .magic: dead4ead,
.owner: rcu_torture_wri/16, .owner_cpu: 1
Jan 25 04:03:30 catbert kernel:  [<c01036f3>] show_trace+0x20/0x24
Jan 25 04:03:30 catbert kernel:  [<c0103815>] dump_stack+0x1e/0x22
Jan 25 04:03:30 catbert kernel:  [<c01e7dff>] spin_bug+0xaf/0xb9
Jan 25 04:03:30 catbert kernel:  [<c01e7f45>] _raw_spin_lock+0x77/0x8b
Jan 25 04:03:30 catbert kernel:  [<c037a5e3>] _spin_lock+0xe/0x12
Jan 25 04:03:30 catbert kernel:  [<c013c4fb>] rcu_torture_free+0x18/0x3f
Jan 25 04:03:30 catbert kernel:  [<c013c569>] rcu_torture_cb+0x47/0x59
Jan 25 04:03:30 catbert kernel:  [<c012cdc3>] rcu_do_batch+0x23/0x70
Jan 25 04:03:30 catbert kernel:  [<c012cf9d>] __rcu_process_callbacks+0xa3/0xcd
Jan 25 04:03:30 catbert kernel:  [<c012cffa>] rcu_process_callbacks+0x33/0x58
Jan 25 04:03:30 catbert kernel:  [<c01215e9>] tasklet_action+0x70/0xbc
Jan 25 04:03:30 catbert kernel:  [<c01212d2>] __do_softirq+0xc2/0xd7
Jan 25 04:03:30 catbert kernel:  [<c012131d>] do_softirq+0x36/0x38
Jan 25 04:03:30 catbert kernel:  [<c01213d8>] irq_exit+0x38/0x3a
Jan 25 04:03:30 catbert kernel:  [<c010ed62>] smp_apic_timer_interrupt+0x69/0x70
Jan 25 04:03:30 catbert kernel:  [<c010333c>] apic_timer_interrupt+0x1c/0x24
Jan 25 04:03:30 catbert kernel:  [<c013c634>] rcu_torture_writer+0x9b/0x125
Jan 25 04:03:30 catbert kernel:  [<c012f350>] kthread+0xb7/0xbc
Jan 25 04:03:30 catbert kernel:  [<c0100dd1>] kernel_thread_helper+0x5/0xb
Jan 25 04:03:30 catbert kernel:  [<c0100dd1>] kernel_thread_helper+0x5/0xb
Jan 25 04:06:26 catbert kernel: BUG: spinlock lockup on CPU#1,
rcu_torture_wri/16, c0402604
Jan 25 04:06:26 catbert kernel:  [<c01036f3>] show_trace+0x20/0x24
Jan 25 04:06:26 catbert kernel:  [<c0103815>] dump_stack+0x1e/0x22
Jan 25 04:06:26 catbert kernel:  [<c01e7eb7>] __spin_lock_debug+0xae/0xc5
Jan 25 04:06:26 catbert kernel:  [<c01e7f21>] _raw_spin_lock+0x53/0x8b
Jan 25 04:06:26 catbert kernel:  [<c037a5e3>] _spin_lock+0xe/0x12
Jan 25 04:06:27 catbert kernel:  [<c013c4fb>] rcu_torture_free+0x18/0x3f
Jan 25 04:06:27 catbert kernel:  [<c013c569>] rcu_torture_cb+0x47/0x59
Jan 25 04:06:27 catbert kernel:  [<c012cdc3>] rcu_do_batch+0x23/0x70
Jan 25 04:06:27 catbert kernel:  [<c012cf9d>] __rcu_process_callbacks+0xa3/0xcd
Jan 25 04:06:27 catbert kernel:  [<c012cffa>] rcu_process_callbacks+0x33/0x58
Jan 25 04:06:27 catbert kernel:  [<c01215e9>] tasklet_action+0x70/0xbc
Jan 25 04:06:27 catbert kernel:  [<c01212d2>] __do_softirq+0xc2/0xd7
Jan 25 04:06:27 catbert kernel:  [<c012131d>] do_softirq+0x36/0x38
Jan 25 04:06:27 catbert kernel:  [<c01213d8>] irq_exit+0x38/0x3a
Jan 25 04:06:27 catbert kernel:  [<c010ed62>] smp_apic_timer_interrupt+0x69/0x70
Jan 25 04:06:27 catbert kernel:  [<c010333c>] apic_timer_interrupt+0x1c/0x24
Jan 25 04:06:27 catbert kernel:  [<c013c634>] rcu_torture_writer+0x9b/0x125
Jan 25 04:06:27 catbert kernel:  [<c012f350>] kthread+0xb7/0xbc
Jan 25 04:06:27 catbert kernel:  [<c0100dd1>] kernel_thread_helper+0x5/0xb
Jan 25 04:07:34 catbert kernel: oom-killer: gfp_mask=0x201d2, order=0
Jan 25 04:07:35 catbert kernel: Mem-info:
Jan 25 04:07:34 catbert kernel: oom-killer: gfp_mask=0x201d2, order=0
Jan 25 04:07:35 catbert kernel: Mem-info:
Jan 25 04:07:35 catbert kernel: DMA per-cpu:
Jan 25 04:07:35 catbert kernel: cpu 0 hot: high 0, batch 1 used:0
Jan 25 04:07:35 catbert kernel: cpu 0 cold: high 0, batch 1 used:0
Jan 25 04:07:35 catbert kernel: cpu 1 hot: high 0, batch 1 used:0
Jan 25 04:07:35 catbert kernel: cpu 1 cold: high 0, batch 1 used:0
Jan 25 04:07:35 catbert kernel: DMA32 per-cpu: empty
Jan 25 04:07:35 catbert kernel: Normal per-cpu:
Jan 25 04:07:35 catbert kernel: cpu 0 hot: high 186, batch 31 used:16
Jan 25 04:07:35 catbert kernel: cpu 0 cold: high 62, batch 15 used:6
Jan 25 04:07:35 catbert kernel: cpu 1 hot: high 186, batch 31 used:35
Jan 25 04:07:35 catbert kernel: cpu 1 cold: high 62, batch 15 used:56
Jan 25 04:07:39 catbert kernel: HighMem per-cpu: empty
Jan 25 04:07:41 catbert kernel: Free pages:        5884kB (0kB HighMem)
Jan 25 04:07:44 catbert kernel: Active:1064 inactive:1277 dirty:0
writeback:0 unstable:0 free:1471 slab:120604 mapped:1184
pagetables:829
Jan 25 04:07:49 catbert kernel: DMA free:2068kB min:88kB low:108kB
high:132kB active:28kB inactive:4kB present:16384kB pages_scanned:34
all_unreclaimable? yes
Jan 25 04:07:50 catbert kernel: lowmem_reserve[]: 0 0 495 495
Jan 25 04:07:51 catbert kernel: DMA32 free:0kB min:0kB low:0kB
high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0
all_unreclaimable? no
Jan 25 04:07:51 catbert kernel: lowmem_reserve[]: 0 0 495 495
Jan 25 04:07:51 catbert kernel: Normal free:3816kB min:2800kB
low:3500kB high:4200kB active:4228kB inactive:5104kB present:507072kB
pages_scanned:4037 all_unreclaimable? no

Intel P4 2.4Ghz (HT ON)
512MB RAM

Masanari
