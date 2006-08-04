Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWHDHRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWHDHRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbWHDHRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:17:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:26302 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161076AbWHDHRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:17:06 -0400
From: Andi Kleen <ak@suse.de>
To: mingo@elte.hu
Subject: Futex BUG in 2.6.18rc2-git7
Date: Fri, 4 Aug 2006 09:17:00 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608040917.00690.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One of my test machines (single socket core2 duo) running 2.6.18rc2-git7 over night 
under moderate load threw this, followed by an endless loop of soft lockup timeouts
(one exemplar appended)

I assume it is related to the new PI mutexes.

-Andi

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at ...v2.6/linux-2.6.18-rc2-git7/kernel/rtmutex_common.h:74
invalid opcode: 0000 [1] SMP 
CPU 0 
Modules linked in:
Pid: 23036, comm: ld-linux.so.2 Not tainted 2.6.18-rc2-git7 #7
RIP: 0010:[<ffffffff80247b36>]  [<ffffffff80247b36>] rt_mutex_next_owner+0x1a/0x2c
RSP: 0000:ffff8100033f5d70  EFLAGS: 00010207
RAX: ffff81003dc712d0 RBX: ffff81003dc712c0 RCX: 0000000000000469
RDX: 0000000000000000 RSI: ffff810031f907e0 RDI: ffff81003dc712d0
RBP: ffff810003cabc48 R08: ffffffff807a4e60 R09: 0000000000000000
R10: ffff8100033f4000 R11: 0000000000000002 R12: 00000000800059fc
R13: 000000004013d468 R14: 000000004013d7ac R15: ffff81003dc712d0
FS:  0000000000000000(0000) GS:ffffffff807d5000(0063) knlGS:000000004053dba0
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 000000004000ce80 CR3: 000000002e970000 CR4: 00000000000006e0
Process ld-linux.so.2 (pid: 23036, threadinfo ffff8100033f4000, task ffff810033cf9590)
Stack:  ffffffff80247064 0000000000000009 0000000000000009 7fffffffffffffff
 ffff810040012ff4 00000000033f5ef8 ffffffff807a4e58 0000000000000000
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
Call Trace:
 [<ffffffff80247064>] do_futex+0x95a/0xbf5
 [<ffffffff8024787d>] compat_sys_futex+0xfd/0x11b
 [<ffffffff80220136>] ia32_sysret+0x0/0xa
DWARF2 unwinder stuck at ia32_sysret+0x0/0xa
Leftover inexact backtrace:


Code: 0f 0b 68 9b b8 54 80 c2 4a 00 48 8b 50 50 48 89 d0 c3 48 83 
RIP  [<ffffffff80247b36>] rt_mutex_next_owner+0x1a/0x2c
 RSP <ffff8100033f5d70>
 <3>BUG: soft lockup detected on CPU#1!

Call Trace:
 [<ffffffff8020ae03>] dump_stack+0x12/0x17
 [<ffffffff802520b3>] softlockup_tick+0xdb/0xed
 [<ffffffff802397f1>] update_process_times+0x42/0x68
 [<ffffffff80217e3b>] smp_local_timer_interrupt+0x23/0x47
 [<ffffffff80218522>] smp_apic_timer_interrupt+0x41/0x47
 [<ffffffff8020a215>] apic_timer_interrupt+0x65/0x6c
DWARF2 unwinder stuck at apic_timer_interrupt+0x65/0x6c
Leftover inexact backtrace:

... same soft lockup follows forever...
