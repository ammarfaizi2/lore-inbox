Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWHXUXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWHXUXX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbWHXUXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:23:23 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:23523 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422637AbWHXUXX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:23:23 -0400
Subject: 2.6.18-rc4 panic in fs/buffer.c: 2791
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
Cc: ext2-devel <Ext2-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 13:26:28 -0700
Message-Id: <1156451188.5392.3.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get following panic while running fsx tests on 2.6.18-rc4
(randomly). 

This is the check in submit_bh()

        BUG_ON(!buffer_mapped(bh));

Has anyone seen this before ?

Thanks,
Badari

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/buffer.c:2791
invalid opcode: 0000 [1] SMP
CPU 0
Modules linked in: autofs4 hidp rfcomm l2cap bluetooth sunrpc af_packet xt_state ip_conntrack nfnetlink xt_tcpudp ip6table_filter ip6_tables x_tables ipv6 acpi_cpufreq freq_table processor binfmt_misc parport_pc lp parport ide_cd cdrom generic floppy shpchp e752x_edac edac_mc piix serio_raw ehci_hcd pci_hotplug i2c_i801 i2c_core uhci_hcd usbcore dm_snapshot dm_zero dm_mirror dm_mod ide_disk ide_core
Pid: 2450, comm: kjournald Not tainted 2.6.18-rc4-smp #7
RIP: 0010:[<ffffffff80280d11>]  [<ffffffff80280d11>] submit_bh+0x1f/0x111
RSP: 0018:ffff810103f33db8  EFLAGS: 00010246
RAX: 0000000000000005 RBX: ffff8100d05e9a90 RCX: ffff81012274b918
RDX: ffff8100d004f0b0 RSI: ffff8100d05e9a90 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffff8100d004f0b0 R09: 00000000004614ee
R10: ffff810122cf33b8 R11: ffffffff8032db73 R12: 0000000000000003
R13: 0000000000000054 R14: 0000000000000080 R15: ffff810105105a40
FS:  0000000000000000(0000) GS:ffffffff8060b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002ab0bf346000 CR3: 0000000102fd1000 CR4: 00000000000006e0
Process kjournald (pid: 2450, threadinfo ffff810103f32000, task ffff8101183ac7a0)
Stack:  ffff8100d05e9a90 ffff810105105770 0000000000000003 ffffffff80281e4f
 ffff8100d00a16d0 ffff8101051058e8 ffff810103c76c70 ffff81011a3af818
 0000000000000080 ffffffff802fbd68 000000000000000a ffff8101051054d0
Call Trace:
 [<ffffffff80281e4f>] ll_rw_block+0x9d/0xc0
 [<ffffffff802fbd68>] journal_commit_transaction+0x554/0x1464
 [<ffffffff80242d3a>] autoremove_wake_function+0x0/0x2e
 [<ffffffff80300d11>] kjournald+0x13c/0x378
 [<ffffffff80242d3a>] autoremove_wake_function+0x0/0x2e
 [<ffffffff8024297c>] keventd_create_kthread+0x0/0x66
 [<ffffffff80300bd5>] kjournald+0x0/0x378
 [<ffffffff8024297c>] keventd_create_kthread+0x0/0x66
 [<ffffffff80242c1c>] kthread+0xec/0x120
 [<ffffffff8020a562>] child_rip+0x8/0x12
 [<ffffffff8024297c>] keventd_create_kthread+0x0/0x66
 [<ffffffff80242b30>] kthread+0x0/0x120
 [<ffffffff8020a55a>] child_rip+0x0/0x12


Code: 0f 0b 68 dc c3 48 80 c2 e7 0a 48 83 7b 38 00 75 0a 0f 0b 68
RIP  [<ffffffff80280d11>] submit_bh+0x1f/0x111
 RSP <ffff810103f33db8>
 <0>general protection fault: 0000 [2] SMP
CPU 1
Modules linked in: autofs4 hidp rfcomm l2cap bluetooth sunrpc af_packet xt_state ip_conntrack nfnetlink xt_tcpudp ip6table_filter ip6_tables x_tables ipv6 acpi_cpufreq freq_table processor binfmt_misc parport_pc lp parport ide_cd cdrom generic floppy shpchp e752x_edac edac_mc piix serio_raw ehci_hcd pci_hotplug i2c_i801 i2c_core uhci_hcd usbcore dm_snapshot dm_zero dm_mirror dm_mod ide_disk ide_core
Pid: 2454, comm: fsx-linux Not tainted 2.6.18-rc4-smp #7
RIP: 0010:[<ffffffff802273b5>]  [<ffffffff802273b5>] task_rq_lock+0x26/0x6f
RSP: 0000:ffff81012348fe60  EFLAGS: 00010086
RAX: 6b6b6b6b6b6b6b6b RBX: ffffffff8066a380 RCX: ffff810105105b38
RDX: 0000000000000000 RSI: ffff81012348fed8 RDI: ffff8101183ac7a0
RBP: ffff81012348fe80 R08: 0000000000000003 R09: 0000000000000004
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8066a380
R13: ffff81012348fed8 R14: ffff8101183ac7a0 R15: 0000000000000000
FS:  00002b2b19908200(0000) GS:ffff8101234636d0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002b2b19997000 CR3: 0000000103e35000 CR4: 00000000000006e0
Process fsx-linux (pid: 2454, threadinfo ffff810103e0c000, task ffff81012201f0c0)
Stack:  000000000000000f ffff8101183ac7a0 ffffffff80300574 0000000000000000
 ffff81012348ff10 ffffffff8022887d 0000000100000002 0000000000000001
 0000000000000000 0000000000000001 0000000000000000 00000000000013a4
Call Trace:
 <IRQ> [<ffffffff80300574>] commit_timeout+0x0/0x5
 [<ffffffff8022887d>] try_to_wake_up+0x24/0x3ec
 [<ffffffff80300574>] commit_timeout+0x0/0x5
 [<ffffffff80238ab8>] run_timer_softirq+0x13b/0x1be
 [<ffffffff80229b44>] scheduler_tick+0x323/0x34d
 [<ffffffff802355ab>] __do_softirq+0x5e/0xd5
 [<ffffffff8020a8b0>] call_softirq+0x1c/0x28
 [<ffffffff8020bc83>] do_softirq+0x2c/0x7d
 [<ffffffff8020a24e>] apic_timer_interrupt+0x66/0x6c
 <EOI>

Code: 8b 40 18 48 8b 04 c5 40 6b 62 80 4c 03 60 08 4c 89 e7 e8 c0
RIP  [<ffffffff802273b5>] task_rq_lock+0x26/0x6f
 RSP <ffff81012348fe60>
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():1, irqs_disabled():1

Call Trace:
 <IRQ> [<ffffffff802454f9>] down_read+0x15/0x24
 [<ffffffff8023cd57>] blocking_notifier_call_chain+0x13/0x36
 [<ffffffff80232d28>] do_exit+0x20/0x8cc
 [<ffffffff8020aec0>] kernel_math_error+0x0/0x90
 [<ffffffff80278df8>] cache_free_debugcheck+0x1e7/0x1f6
 [<ffffffff80458ec0>] do_general_protection+0xfe/0x107
 [<ffffffff8020a3a9>] error_exit+0x0/0x84
 [<ffffffff802273b5>] task_rq_lock+0x26/0x6f
 [<ffffffff80300574>] commit_timeout+0x0/0x5
 [<ffffffff8022887d>] try_to_wake_up+0x24/0x3ec
 [<ffffffff80300574>] commit_timeout+0x0/0x5
 [<ffffffff80238ab8>] run_timer_softirq+0x13b/0x1be
 [<ffffffff80229b44>] scheduler_tick+0x323/0x34d
 [<ffffffff802355ab>] __do_softirq+0x5e/0xd5
 [<ffffffff8020a8b0>] call_softirq+0x1c/0x28
 [<ffffffff8020bc83>] do_softirq+0x2c/0x7d
 [<ffffffff8020a24e>] apic_timer_interrupt+0x66/0x6c
 <EOI>
Kernel panic - not syncing: Aiee, killing interrupt handler!






