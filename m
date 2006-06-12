Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWFLFJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWFLFJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 01:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWFLFJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 01:09:26 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:18100 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id S1751331AbWFLFJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 01:09:26 -0400
Mime-Version: 1.0
Message-Id: <a06230917c0b15c73a4c5@[129.98.90.227]>
Date: Mon, 12 Jun 2006 01:09:00 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Soft lockup on CPU 0 possibly related to threads in kernel
 2.6.16.1
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A dual amd64-based computer is running kernel 2.6.16.1 and reports 
the following spontaneously:


99516.921354] BUG: soft lockup detected on CPU#0!
[99516.921359] CPU 0:
[99516.921361] Modules linked in: drbd xt_limit bonding appletalk 
psnap llc xt_state nfnetlink_log ipt_LOG ip_conntrack_ftp 
xt_conntrack ip_conntrack iptable_filter nfnetlink xt_tcpudp 
ip_tables x_tables r8169 tg3 mptspi mptscsih mptbase sym53c8xx 
dm_mirror
[99516.921377] Pid: 16, comm: kblockd/0 Tainted: G   M  2.6.16.1 #3
[99516.921380] RIP: 0010:[<ffffffff8035fecb>] 
<ffffffff8035fecb>{_spin_unlock_irqrestore+17}
[99516.921390] RSP: 0018:ffff810037ecbe28  EFLAGS: 00000247
[99516.921393] RAX: 0000000000000000 RBX: 0000000000000247 RCX: 
0000000000000247
[99516.921396] RDX: ffff810037fe0ba0 RSI: 0000000000000247 RDI: 
ffff810037fe0b78
[99516.921400] RBP: ffff810037ecbe38 R08: ffff810037fe0bf0 R09: 
0000000300000000
[99516.921403] R10: 0000000300000000 R11: ffff8100f7eb7238 R12: 
ffff8100f7eb7370
[99516.921407] R13: ffff810037fe0b78 R14: 0000000000000247 R15: 
ffff8100f7ef2ed8
[99516.921411] FS:  00002ad040b7e6d0(0000) GS:ffffffff80527000(0000) 
knlGS:0000000000000000
[99516.921414] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[99516.921417] CR2: 00002b7ab1af6e90 CR3: 00000000f4ddd000 CR4: 
00000000000006e0
[99516.921419]
[99516.921420] Call Trace: <ffffffff8013f4ac>{run_workqueue+138} 
<ffffffff80235569>{cfq_kick_queue+0}
[99516.921432]        <ffffffff8013f511>{worker_thread+0} 
<ffffffff8013f60d>{worker_thread+252}
[99516.921439]        <ffffffff80128c18>{default_wake_function+0} 
<ffffffff80128c18>{default_wake_function+0}
[99516.921448]        <ffffffff8013f511>{worker_thread+0} 
<ffffffff80142d94>{kthread+208}
[99516.921456]        <ffffffff8010b9fe>{child_rip+8} 
<ffffffff80142cc4>{kthread+0}
[99516.921464]        <ffffffff8010b9f6>{child_rip+0}

-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
