Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbUKQOCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbUKQOCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 09:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUKQOCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 09:02:05 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:19522 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S262321AbUKQOB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 09:01:59 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Date: Wed, 17 Nov 2004 08:01:07 -0600
Message-ID: <OF85CEFE0B.FA9C5653-ON86256F4F.004D01CB-86256F4F.004D01EA@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/17/2004 08:01:13 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>great. The current release is meanwhile at -V0.7.27-10, which includes
>other minor updates:

A kernel built with -V0.7.27-10 had the following BUG early in the
boot sequence. All boot messages prior to this point were basically
the same as I sent in the previous report.
  --Mark


[this is where -4 died...]
testing NMI watchdog ... OK.
checking TSC synchronization across 2 CPUs: passed.
IRQ#0 thread RT prio: 49.
BUG at kernel/softirq.c:514!
------------[ cut here ]------------
kernel BUG at kernel/softirq.c:514!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c012751e>]    Not tainted VLI
EFLAGS: 00010286   (2.6.10-rc2-mm1-RT-V0.7.27-10)
EIP is at cpu_callback+0xfe/0x130
eax: 0000001d   ebx: 00000000   ecx: c032ab6e   edx: dff82000
esi: 00000000   edi: 00000000   ebp: dff83fb0   esp: dff83f98
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process swapper (pid: 1, threadinfo=dff82000 task=dff81460)
Stack: c033cefe c033f16e 00000202 c013b924 00000000 00000000 dff83fc8
c03eb7ee
       c037843c 00000003 00000000 c0100350 dff83fd0 c0100302 dff83fec
c0100387
       00000008 00000000 0000007b c0100350 00000000 00000000 c0102019
00000000
Call Trace:
 [<c0104e3f>] show_stack+0x8f/0xb0 (28)
 [<c0104fff>] show_registers+0x16f/0x1e0 (56)
 [<c0105236>] die+0x106/0x190 (64)
 [<c0105810>] do_invalid_op+0x130/0x140 (192)
 [<c0104a7f>] error_code+0x2b/0x30 (84)
 [<c03eb7ee>] spawn_ksoftirqd+0x2e/0x60 (24)
 [<c0100302>] do_pre_smp_initcalls+0x12/0x20 (8)
 [<c0100387>] init+0x37/0x1b0 (28)
 [<c0102019>] kernel_thread_helper+0x5/0xc (537378836)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c032c702>] .... _raw_spin_lock_irqsave+0x22/0x90
.....[<c0105174>] ..   ( <= die+0x44/0x190)
.. [<c013dfbd>] .... print_traces+0x1d/0x60
.....[<c0104e3f>] ..   ( <= show_stack+0x8f/0xb0)

Code: 0f 0b 03 02 6e f1 33 c0 e9 77 ff ff ff c7 04 24 fe ce 33 c0 b8 02 02
00 00 89 44 24 08 b8 6e f1 33 c0 89 44 24 04 e8 62 9c ff ff <0f> 0b 02 02
6e f1 33 c0 8b 14 b5 20 20 41 c0 e9 39 ff ff ff 8b
 <0>Kernel panic - not syncing: Attempted to kill init!

