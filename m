Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUAVXIS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 18:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbUAVXIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 18:08:18 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:25080 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S265117AbUAVXIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 18:08:16 -0500
Date: Thu, 22 Jan 2004 18:17:51 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: 2.6.1 oops in prune_dcache()
Message-ID: <20040122181751.A2101@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4 AM this morning (during cron run, I suppose) a box running 2.6.1
hit the oops below. It locked solid, had to hit the reset button to
reboot it. The machine had been running 2.6.1 for about a week prior
with no problems.

Hardware is single Pentium Pro 200, 128 MB RAM (extensively
memtest86'ed). Kernel is no-SMP, no-preempt, and (obviously) no-highmem.

Feel free to ask for more details if I can help. This is the first oops
I've seen since mid 2.5.x on this machine.

--Adam


Jan 21 04:06:32 print kernel: Unable to handle kernel paging request at virtual address 00008014
Jan 21 04:06:32 print kernel:  printing eip:
Jan 21 04:06:32 print kernel: c01570e5
Jan 21 04:06:32 print kernel: *pde = 00000000
Jan 21 04:06:32 print kernel: Oops: 0000 [#1]
Jan 21 04:06:32 print kernel: CPU:    0
Jan 21 04:06:32 print kernel: EIP:    0060:[<c01570e5>]    Not tainted
Jan 21 04:06:32 print kernel: EFLAGS: 00010206
Jan 21 04:06:32 print kernel: EIP is at prune_dcache+0xe5/0x130
Jan 21 04:06:32 print kernel: eax: 00008000   ebx: c1dc83e0   ecx: c577da74   edx: c577da74
Jan 21 04:06:32 print kernel: esi: c577da64   edi: c1dc83e0   ebp: 00000072   esp: c11d7e70
Jan 21 04:06:32 print kernel: ds: 007b   es: 007b   ss: 0068
Jan 21 04:06:32 print kernel: Process kswapd0 (pid: 7, threadinfo=c11d6000 task=c11db2f0)
Jan 21 04:06:37 print kernel: Stack: c11d6000 c11d7eac c0114641 00000202 c11db2f0 c11db310 000658fc 9b6c7589
Jan 21 04:06:37 print kernel:        00000080 0000031b c11d6000 00000080 c0157445 00000080 c0134689 00000080
Jan 21 04:06:37 print kernel:        000000d0 000031d4 000000a8 01620ff0 00000000 00000001 c7ffeb80 000000a8
Jan 21 04:06:37 print kernel: Call Trace:
Jan 21 04:06:37 print kernel:  [<c0114641>] schedule+0x41/0x4c0
Jan 21 04:06:37 print kernel:  [<c0157445>] shrink_dcache_memory+0x15/0x20
Jan 21 04:06:37 print kernel:  [<c0134689>] shrink_slab+0x109/0x160
Jan 21 04:06:37 print kernel:  [<c01356cf>] balance_pgdat+0x13f/0x1f0
Jan 21 04:06:37 print kernel:  [<c013588b>] kswapd+0x10b/0x110
Jan 21 04:06:37 print kernel:  [<c0115d00>] autoremove_wake_function+0x0/0x40
Jan 21 04:06:37 print kernel:  [<c0115d00>] autoremove_wake_function+0x0/0x40
Jan 21 04:06:37 print kernel:  [<c0135780>] kswapd+0x0/0x110
Jan 21 04:06:37 print kernel:  [<c0106fb5>] kernel_thread_helper+0x5/0x10
Jan 21 04:06:37 print kernel:
Jan 21 04:06:37 print kernel: Code: 8b 40 14 85 c0 74 08 56 53 ff d0 5a 59 eb 07 56 e8 66 20 00

