Return-Path: <linux-kernel-owner+w=401wt.eu-S932407AbWLMBWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWLMBWP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWLMBWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:22:15 -0500
Received: from ns.netcenter.hu ([195.228.254.57]:55249 "EHLO netcenter.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932407AbWLMBWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:22:13 -0500
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 20:22:12 EST
Message-ID: <00ab01c71e53$942af2f0$0400a8c0@dcccs>
From: =?utf-8?Q?Haar_J=C3=A1nos?= <djani22@netcenter.hu>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Cc: <linux-xfs@oss.sgi.com>, <linux-kernel@vger.kernel.org>
References: <003701c71d78$33ed28d0$0400a8c0@dcccs> <Pine.LNX.4.64.0612120932220.19050@p34.internal.lan>
Subject: Re: xfslogd-spinlock bug?
Date: Wed, 13 Dec 2006 02:11:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Justin,

This is a 64bit system.

But i cannot understand, what is the curious? :-)

I am not a kernel developer, and not a C programmer, but the long pointers
shows me, the 64 bit.
Or am i on the wrong clue? :-)

Anyway, this issue happens for me about daily, or max 2-3 day often.
But i have no idea what cause this exactly.
The 2.6.16.18 was stable for me a long time, and one day starts to tricking
me, and happens more and more often.
Thats why i thinking some bad part of the (14TB) FS on the disks.

(this fs have a lot of errors, what the xfs_repair cannot be corrected, but
anyway this is a productive system, and works well, except this issue.
Some months before i have replaced the parity disk in one of the RAID4
array, and the next day, during the resync process, another one disk died.
I almost lost everything, but thanks to the raid4, and mdadm, i have
successfully recovered a lot of data with the 1 day older parity-only drive.
This was really bad, and leave some scars on the fs. )

This issue looks like for me a race condition between the cpus. (2x Xeon HT)

Am i right? :-)

Thanks,

Janos




----- Original Message ----- 
From: "Justin Piszcz" <jpiszcz@lucidpixels.com>
To: "Haar János" <djani22@netcenter.hu>
Cc: <linux-xfs@oss.sgi.com>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, December 12, 2006 3:32 PM
Subject: Re: xfslogd-spinlock bug?


I'm not sure what is causing this problem but I was curious is this on a
32bit or 64bit platform?

Justin.

On Tue, 12 Dec 2006, Haar János wrote:

> Hello, list,
>
> I am the "big red button men" with the one big 14TB xfs, if somebody can
> remember me. :-)
>
> Now i found something in the 2.6.16.18, and try the 2.6.18.4, and the
> 2.6.19, but the bug still exists:
>
> Dec 11 22:47:21 dy-base BUG: spinlock bad magic on CPU#3, xfslogd/3/317
> Dec 11 22:47:21 dy-base general protection fault: 0000 [1]
> Dec 11 22:47:21 dy-base SMP
> Dec 11 22:47:21 dy-base
> Dec 11 22:47:21 dy-base CPU 3
> Dec 11 22:47:21 dy-base
> Dec 11 22:47:21 dy-base Modules linked in:
> Dec 11 22:47:21 dy-base  nbd
> Dec 11 22:47:21 dy-base  rd
> Dec 11 22:47:21 dy-base  netconsole
> Dec 11 22:47:21 dy-base  e1000
> Dec 11 22:47:21 dy-base  video
> Dec 11 22:47:21 dy-base
> Dec 11 22:47:21 dy-base Pid: 317, comm: xfslogd/3 Not tainted 2.6.19 #1
> Dec 11 22:47:21 dy-base RIP: 0010:[<ffffffff803f3aba>]
> Dec 11 22:47:21 dy-base  [<ffffffff803f3aba>] spin_bug+0x69/0xdf
> Dec 11 22:47:21 dy-base RSP: 0018:ffff81011fb89bc0  EFLAGS: 00010002
> Dec 11 22:47:21 dy-base RAX: 0000000000000033 RBX: 6b6b6b6b6b6b6b6b RCX:
> 0000000000000000
> Dec 11 22:47:21 dy-base RDX: ffffffff808137a0 RSI: 0000000000000082 RDI:
> 0000000100000000
> Dec 11 22:47:21 dy-base RBP: ffff81011fb89be0 R08: 0000000000026a70 R09:
> 000000006b6b6b6b
> Dec 11 22:47:21 dy-base R10: 0000000000000082 R11: ffff81000584d380 R12:
> ffff8100db92ad80
> Dec 11 22:47:21 dy-base R13: ffffffff80642dc6 R14: 0000000000000000 R15:
> 0000000000000003
> Dec 11 22:47:21 dy-base FS:  0000000000000000(0000)
> GS:ffff81011fc76b90(0000) knlGS:0000000000000000
> Dec 11 22:47:21 dy-base CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> Dec 11 22:47:21 dy-base CR2: 00002ba007700000 CR3: 0000000108c05000 CR4:
> 00000000000006e0
> Dec 11 22:47:21 dy-base Process xfslogd/3 (pid: 317, threadinfo
> ffff81011fb88000, task ffff81011fa7f830)
> Dec 11 22:47:21 dy-base Stack:
> Dec 11 22:47:21 dy-base  ffff81011fb89be0
> Dec 11 22:47:21 dy-base  ffff8100db92ad80
> Dec 11 22:47:21 dy-base  0000000000000000
> Dec 11 22:47:21 dy-base  0000000000000000
> Dec 11 22:47:21 dy-base
> Dec 11 22:47:21 dy-base  ffff81011fb89c10
> Dec 11 22:47:21 dy-base  ffffffff803f3bdc
> Dec 11 22:47:21 dy-base  0000000000000282
> Dec 11 22:47:21 dy-base  0000000000000000
> Dec 11 22:47:21 dy-base
> Dec 11 22:47:21 dy-base  0000000000000000
> Dec 11 22:47:21 dy-base  0000000000000000
> Dec 11 22:47:21 dy-base  ffff81011fb89c30
> Dec 11 22:47:21 dy-base  ffffffff805e7f2b
> Dec 11 22:47:21 dy-base
> Dec 11 22:47:21 dy-base Call Trace:
> Dec 11 22:47:21 dy-base  [<ffffffff803f3bdc>] _raw_spin_lock+0x23/0xf1
> Dec 11 22:47:21 dy-base  [<ffffffff805e7f2b>] _spin_lock_irqsave+0x11/0x18
> Dec 11 22:47:21 dy-base  [<ffffffff80222aab>] __wake_up+0x22/0x50
> Dec 11 22:47:21 dy-base  [<ffffffff803c97f9>] xfs_buf_unpin+0x21/0x23
> Dec 11 22:47:21 dy-base  [<ffffffff803970a4>] xfs_buf_item_unpin+0x2e/0xa6
> Dec 11 22:47:21 dy-base  [<ffffffff803bc460>]
> xfs_trans_chunk_committed+0xc3/0xf7
> Dec 11 22:47:21 dy-base  [<ffffffff803bc4dd>]
xfs_trans_committed+0x49/0xde
> Dec 11 22:47:21 dy-base  [<ffffffff803b1bde>]
> xlog_state_do_callback+0x185/0x33f
> Dec 11 22:47:21 dy-base  [<ffffffff803b1e9c>] xlog_iodone+0x104/0x131
> Dec 11 22:47:22 dy-base  [<ffffffff803c9dae>]
xfs_buf_iodone_work+0x1a/0x3e
> Dec 11 22:47:22 dy-base  [<ffffffff802399d8>] worker_thread+0x0/0x134
> Dec 11 22:47:22 dy-base  [<ffffffff8023937e>] run_workqueue+0xa8/0xf8
> Dec 11 22:47:22 dy-base  [<ffffffff803c9d94>] xfs_buf_iodone_work+0x0/0x3e
> Dec 11 22:47:22 dy-base  [<ffffffff802399d8>] worker_thread+0x0/0x134
> Dec 11 22:47:22 dy-base  [<ffffffff80239ad3>] worker_thread+0xfb/0x134
> Dec 11 22:47:22 dy-base  [<ffffffff80223f6c>]
default_wake_function+0x0/0xf
> Dec 11 22:47:22 dy-base  [<ffffffff802399d8>] worker_thread+0x0/0x134
> Dec 11 22:47:22 dy-base  [<ffffffff8023c6e5>] kthread+0xd8/0x10b
> Dec 11 22:47:22 dy-base  [<ffffffff802256ac>] schedule_tail+0x45/0xa6
> Dec 11 22:47:22 dy-base  [<ffffffff8020a6a8>] child_rip+0xa/0x12
> Dec 11 22:47:22 dy-base  [<ffffffff802399d8>] worker_thread+0x0/0x134
> Dec 11 22:47:22 dy-base  [<ffffffff8023c60d>] kthread+0x0/0x10b
> Dec 11 22:47:22 dy-base  [<ffffffff8020a69e>] child_rip+0x0/0x12
> Dec 11 22:47:22 dy-base
> Dec 11 22:47:22 dy-base
> Dec 11 22:47:22 dy-base Code:
> Dec 11 22:47:22 dy-base 8b
> Dec 11 22:47:22 dy-base 83
> Dec 11 22:47:22 dy-base 0c
> Dec 11 22:47:22 dy-base 01
> Dec 11 22:47:22 dy-base 00
> Dec 11 22:47:22 dy-base 00
> Dec 11 22:47:22 dy-base 48
> Dec 11 22:47:22 dy-base 8d
> Dec 11 22:47:22 dy-base 8b
> Dec 11 22:47:22 dy-base 98
> Dec 11 22:47:22 dy-base 02
> Dec 11 22:47:22 dy-base 00
> Dec 11 22:47:22 dy-base 00
> Dec 11 22:47:22 dy-base 41
> Dec 11 22:47:22 dy-base 8b
> Dec 11 22:47:22 dy-base 54
> Dec 11 22:47:22 dy-base 24
> Dec 11 22:47:22 dy-base 04
> Dec 11 22:47:22 dy-base 41
> Dec 11 22:47:22 dy-base 89
> Dec 11 22:47:22 dy-base
> Dec 11 22:47:22 dy-base RIP
> Dec 11 22:47:22 dy-base  [<ffffffff803f3aba>] spin_bug+0x69/0xdf
> Dec 11 22:47:22 dy-base  RSP <ffff81011fb89bc0>
> Dec 11 22:47:22 dy-base
> Dec 11 22:47:22 dy-base Kernel panic - not syncing: Fatal exception
> Dec 11 22:47:22 dy-base
> Dec 11 22:47:22 dy-base Rebooting in 5 seconds..
>
> After this, sometimes the server reboots normally, but sometimes hangs, no
> console, no sysreq, no nothing.
>
> This is a "simple" crash, no "too much" data lost, or else.
>
> Can somebody help me to tracking down the problem?
>
> Thanks,
> Janos Haar
>
>
>
>

