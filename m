Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268285AbTBMUu2>; Thu, 13 Feb 2003 15:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268289AbTBMUu2>; Thu, 13 Feb 2003 15:50:28 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:29854 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268285AbTBMUu0>;
	Thu, 13 Feb 2003 15:50:26 -0500
Date: Thu, 13 Feb 2003 20:56:08 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.60-bk pdflush oops.
Message-ID: <20030213205608.GB24109@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bitkeeper pull from ~5 hrs ago.

Something went splat just after booting.
I think this may have happened as I mounted an NFS mount.
Hard to tell, but the box booted at 20:30, this happened
at 20:37, and I started NFS testing at 20:40 which was
when I noticed it.

Feb 13 20:37:41 mesh kernel:  printing eip:
Feb 13 20:37:41 mesh kernel: c012e276
Feb 13 20:37:41 mesh kernel: Oops: 0002
Feb 13 20:37:41 mesh kernel: CPU:    0
Feb 13 20:37:41 mesh kernel: EIP:    0060:[<c012e276>]    Not tainted
Feb 13 20:37:41 mesh kernel: EFLAGS: 00010046
Feb 13 20:37:41 mesh kernel: EIP is at mod_timer+0x96/0x7e0
Feb 13 20:37:41 mesh kernel: eax: 00000000   ebx: c0147440   ecx: 00000007   edx: 00001388
Feb 13 20:37:41 mesh kernel: esi: 850fc085   edi: c06436c0   ebp: c11c7ed0   esp: c11c7ea0
Feb 13 20:37:41 mesh kernel: ds: 007b   es: 007b   ss: 0068
Feb 13 20:37:41 mesh kernel: Process pdflush (pid: 5, threadinfo=c11c6000 task=c113d980)
Feb 13 20:37:41 mesh kernel: Stack: c11c7ec0 c0146229 c11c7f04 00000000 00000080 c0147320 c11c7ee4 00000000 
Feb 13 20:37:41 mesh kernel:        00000297 000733cf c11c7ee4 00000000 c11c7f90 c0147426 c06436c0 000733cf 
Feb 13 20:37:41 mesh kernel:        0006ab17 00000000 00000000 c11c7ee0 00000000 00000001 00000000 00000001 
Feb 13 20:37:41 mesh kernel: Call Trace:
Feb 13 20:37:41 mesh kernel:  [<c0146229>] __get_page_state+0x29/0x90
Feb 13 20:37:41 mesh kernel:  [<c0147320>] wb_kupdate+0x0/0x120
Feb 13 20:37:41 mesh kernel:  [<c0147426>] wb_kupdate+0x106/0x120
Feb 13 20:37:41 mesh kernel:  [<c0147320>] wb_kupdate+0x0/0x120
Feb 13 20:37:41 mesh kernel:  [<c0147cf9>] __pdflush+0x259/0x5b0
Feb 13 20:37:41 mesh kernel:  [<c011e5fc>] schedule_tail+0x9c/0xe0
Feb 13 20:37:41 mesh kernel:  [<c0107d98>] __switch_to+0x148/0x150
Feb 13 20:37:41 mesh kernel:  [<c0148050>] pdflush+0x0/0x20
Feb 13 20:37:41 mesh kernel:  [<c0148061>] pdflush+0x11/0x20
Feb 13 20:37:41 mesh kernel:  [<c0147320>] wb_kupdate+0x0/0x120
Feb 13 20:37:41 mesh kernel:  [<c01075cd>] kernel_thread_helper+0x5/0x18
Feb 13 20:37:41 mesh kernel: 
Feb 13 20:37:41 mesh kernel: Code: 1c 52 fb 50 c0 c7 47 20 e1 00 00 00 8d b4 26 00 00 00 00 8d 
Feb 13 20:37:41 mesh kernel:  <6>note: pdflush[5] exited with preempt_count 1


Looking back through the logs, this also this bizarre snippet during boot:-

Feb 13 20:30:24 mesh kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb 13 20:30:24 mesh kernel: Call Trace:
Feb 13 20:30:24 mesh kernel:  [<c014a8b4>] kmem_cache_alloc+0x134/0x140
Feb 13 20:30:24 mesh kernel:  [<c014916f>] kmem_cache_create+0xbf/0x5a0
Feb 13 20:30:24 mesh kernel:  [<c0105000>] _stext+0x0/0x30
Feb 13 20:30:24 mesh kernel: 
Feb 13 20:30:24 mesh kernel: Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)

Looks like part of 'something', but the other bit is nowhere to be seen. Odd.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
