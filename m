Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVAMFJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVAMFJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 00:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVAMFJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 00:09:24 -0500
Received: from bdsl.66.12.153.218.gte.net ([66.12.153.218]:19359 "EHLO
	scottstuff.net") by vger.kernel.org with ESMTP id S261157AbVAMFIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 00:08:24 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <2628963E-6521-11D9-B39A-0030656D1AB0@sigkill.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Scott Laird <scott@sigkill.org>
Subject: TG3 driver dies with "irq 12: nobody cared" on 2.6.10 (x86)
Date: Wed, 12 Jan 2005 21:08:23 -0800
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a huge pile of problems with my home file server.  Since 
upgrading from 2.6.2 to 2.6.10, the box now falls off the network at 
the drop of a hat.  Here's one round of logs:

Jan 12 17:16:49 nfs kernel: irq 12: nobody cared!
Jan 12 17:16:49 nfs kernel:  [<c012a2ea>] __report_bad_irq+0x2a/0x90
Jan 12 17:16:49 nfs kernel:  [<c0129dd0>] handle_IRQ_event+0x30/0x70
Jan 12 17:16:49 nfs kernel:  [<c012a3dc>] note_interrupt+0x6c/0xd0
Jan 12 17:16:49 nfs kernel:  [<c0129eea>] __do_IRQ+0xda/0xf0
Jan 12 17:16:49 nfs kernel:  [<c0103ff9>] do_IRQ+0x19/0x30
Jan 12 17:16:49 nfs kernel:  [<c01026be>] common_interrupt+0x1a/0x20
Jan 12 17:16:49 nfs kernel:  [<c0116130>] __do_softirq+0x30/0x90
Jan 12 17:16:49 nfs kernel:  [<c01161b6>] do_softirq+0x26/0x30
Jan 12 17:16:49 nfs kernel:  [<c0103ffe>] do_IRQ+0x1e/0x30
Jan 12 17:16:49 nfs kernel:  [<c01026be>] common_interrupt+0x1a/0x20
Jan 12 17:16:49 nfs kernel:  [<c012e299>] mempool_free+0x19/0x80
Jan 12 17:16:49 nfs kernel:  [<c014b1b8>] bio_destructor+0x38/0x60
Jan 12 17:16:49 nfs kernel:  [<c014b3b9>] bio_put+0x29/0x40
Jan 12 17:16:49 nfs kernel:  [<c01667e0>] mpage_end_io_read+0x60/0x70
Jan 12 17:16:49 nfs kernel:  [<c0337a9e>] handle_stripe+0x73e/0xc70
Jan 12 17:16:49 nfs kernel:  [<c033d5ae>] md_update_sb+0xae/0xe0
Jan 12 17:16:49 nfs kernel:  [<c03384c0>] raid5d+0x60/0xf0
Jan 12 17:16:49 nfs kernel:  [<c033f913>] md_thread+0x123/0x170
Jan 12 17:16:49 nfs kernel:  [<c0124060>] 
autoremove_wake_function+0x0/0x60
Jan 12 17:16:49 nfs kernel:  [<c010245e>] ret_from_fork+0x6/0x14
Jan 12 17:16:49 nfs kernel:  [<c0124060>] 
autoremove_wake_function+0x0/0x60
Jan 12 17:16:49 nfs kernel:  [<c033f7f0>] md_thread+0x0/0x170
Jan 12 17:16:49 nfs kernel:  [<c0100851>] kernel_thread_helper+0x5/0x14
Jan 12 17:16:49 nfs kernel: handlers:
Jan 12 17:16:49 nfs kernel: [<c0308830>] (usb_hcd_irq+0x0/0x70)
Jan 12 17:16:49 nfs kernel: [<c02aae30>] (tg3_interrupt+0x0/0x130)
Jan 12 17:16:49 nfs kernel: Disabling IRQ #12

I moved cards around to get the TG3 onto its own IRQ, and that didn't 
make any difference.  This box is an Athlon 700.  It's running a 
single-processor non-preempt kernel with 8k stacks.  If anyone cares, 
the full .config is at http://scottstuff.net/misc/config-2.6.10.txt

The last three reboots have only lasted for a minute or two before the 
TG3 interrupt problem pops up.  Once this happens, nothing that I can 
do seems to get the network working again--'ip link set eth0 down ; ip 
link set eth0 up' doesn't help.  I'm not using modules, so I can't try 
unloading and reloading.

The single weirdest part of this is the numbers from /proc/interrupts: 
the last two hangs happened with *exactly* 200,000 TG3 interrupts.  The 
time before that, it was exactly 400,000 interrupts.

I have a second TG3 card that I can swap in, but it's sitting on my 
desk at work, so I won't be able to try until tomorrow.

Does anyone have any suggestions?


Scott

