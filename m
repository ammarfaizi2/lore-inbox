Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVDUW13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVDUW13 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 18:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVDUW13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 18:27:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:53224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261457AbVDUWXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 18:23:54 -0400
Date: Thu, 21 Apr 2005 15:23:45 -0700
From: cliff white <cliffw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc2 + rc3: reaim with ext3 - system stalls.
Message-ID: <20050421152345.6b87aeae@es175>
Organization: OSDL
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Started seeing some odd behaviour with recent kernels, haven't been able to
run it down, could use some suggestions/help.

Running re-aim7 with 2.6.12-rc2 and rc3, if I use xfs, jfs, or reiserfs things work just fine.

With ext3, the  test stalls, such that:
CPU is 50% idle, 50% waiting IO (top)
vmstat shows one process blocked wio

Routine commands run ( ls, ps, vmstat, top ) 
'sync' never completes
reaim and sync tasks are un-killable. 

Alt-sysrq output appended...
cliffw
------------------------

SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0060:[<c0100be4>] CPU: 0
EIP is at default_idle+0x24/0x30
 EFLAGS: 00000246    Not tainted  (2.6.12-rc2)
EAX: 00000000 EBX: c0100bc0 ECX: 0288cf60 EDX: c2d072e0
ESI: c044c000 EDI: c047a380 EBP: 004d1007 DS: 007b ES: 007b
CR0: 8005003b CR2: 42070710 CR3: 37495000 CR4: 000006d0
 [<c0100ca6>] cpu_idle+0x76/0x80
 [<c044e9c1>] start_kernel+0x161/0x180
 [<c044e390>] unknown_bootoption+0x0/0x200
[halt sent]
SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:     3585648kB (2751616kB HighMem)
Active:20439 inactive:11704 dirty:26 writeback:10 unstable:0 free:896412 slab:7240 mapped:6511 pagetables:180
DMA free:11752kB min:68kB low:84kB high:100kB active:0kB inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 880 3688
Normal free:822280kB min:3756kB low:4692kB high:5632kB active:3164kB inactive:4204kB present:901120kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 22464
HighMem free:2751616kB min:512kB low:640kB high:768kB active:78592kB inactive:42612kB present:2875392kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 14*4kB 12*8kB 11*16kB 11*32kB 7*64kB 7*128kB 4*256kB 3*512kB 3*1024kB 2*2048kB 0*4096kB = 11752kB
Normal: 14*4kB 32*8kB 9*16kB 2*32kB 0*64kB 36*128kB 88*256kB 84*512kB 78*1024kB 60*2048kB 134*4096kB = 822280kB
HighMem: 76*4kB 22*8kB 18*16kB 32*32kB 16*64kB 3*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 671*4096kB = 2751616kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 2097136kB
Total swap = 2097136kB
Free swap:       2097136kB
948224 pages of RAM
718832 pages of HIGHMEM
9297 reserved pages
14606 pages shared
0 pages swap cached
[halt sent]
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S 00000008     0     1      0     2               (NOTLB)
c30a1ea0 00000086 c30a1e90 00000008 00000004 00000000 cd41e000 c3080a60 
       f749c480 f7e2fcc0 00000246 c039c200 f7e4bd80 00000000 000000d0 c0146332 
       c039ca00 c2d20400 00000003 00000be0 1c7df090 00002527 c01248fa c307ba40 
Call Trace:
 [<c0146332>] __alloc_pages+0x2f2/0x410
 [<c01248fa>] __mod_timer+0xca/0x120
 [<c033de23>] schedule_timeout+0x73/0xd0
 [<c01254f0>] process_timeout+0x0/0x10
 [<c0175b73>] do_select+0x1a3/0x2e0
 [<c0175810>] __pollwait+0x0/0xd0
 [<c0175f79>] sys_select+0x299/0x440
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
migration/0   S 00000008     0     2      1             3       (L-TLB)
c30b9f9c 00000046 c30b9f88 00000008 00000001 f4ca8550 00001f40 f7599550 
       f758b800 f758b800 c2d08400 f7599550 c30b9f74 c01144ff f7599550 00000000 
       c2d08d60 c2d08400 00000000 00000286 a1f083aa 000024c5 c2d0843c c3080550 
Call Trace:
 [<c01144ff>] activate_task+0x6f/0xb0
 [<c0117d61>] migration_thread+0x121/0x190
 [<c0117c40>] migration_thread+0x0/0x190
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
ksoftirqd/0   S 00000008     0     3      1             4     2 (L-TLB)
c30bbfa0 00000046 c30bbf90 00000008 00000001 00000000 c033eaef c0396c00 
       f7246b80 e9ecdd40 f71bca80 f7246b80 c30bbf6c c047cf00 c028352b f7246b80 
       c04850e0 c2d08400 00000000 00000335 cf407eb7 0000004d c0448300 c3080040 
Call Trace:
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<c028352b>] scsi_softirq+0xab/0xd0
 [<c01211bc>] ksoftirqd+0xfc/0x130
 [<c01210c0>] ksoftirqd+0x0/0x130
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
migration/1   S 00000008     0     4      1             5     3 (L-TLB)
c30bdf9c 00000046 c30bdf88 00000008 00000002 f74a4590 00001f40 f7482a40 
       cb3fd5a0 cb3fd5a0 c2d10400 f7482a40 c30bdf74 c01144ff f7482a40 00000000 
       c2d10d60 c2d10400 00000001 000002a6 bd6f4b5d 000024c6 c2d108b4 c3082a80 
Call Trace:
 [<c01144ff>] activate_task+0x6f/0xb0
 [<c0117d61>] migration_thread+0x121/0x190
 [<c0117c40>] migration_thread+0x0/0x190
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
ksoftirqd/1   S 00000008     0     5      1             6     4 (L-TLB)
c30bffa0 00000046 c30bff90 00000008 00000002 00000001 c033eaef c307b530 
       f7264cc0 f747c5a0 f71bca80 f7264cc0 c30bff6c c047cf00 c028352b f7264cc0 
       c30be000 c2d10400 00000001 0000031a e1efd664 00000045 c0448300 c3082570 
Call Trace:
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<c028352b>] scsi_softirq+0xab/0xd0
 [<c01211bc>] ksoftirqd+0xfc/0x130
 [<c01210c0>] ksoftirqd+0x0/0x130
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
migration/2   S 00000008     0     6      1             7     5 (L-TLB)
c30c1f9c 00000046 c30c1f88 00000008 00000003 f713ba60 00001f40 f7482a40 
       e9ecd5c0 e9ecd5c0 c2d18400 f7482a40 c30c1f74 c01144ff f7482a40 00000000 
       c2d18d60 c2d18400 00000002 00000264 9e01bef9 000024c5 c2d1843c c3082060 
Call Trace:
 [<c01144ff>] activate_task+0x6f/0xb0
 [<c0117d61>] migration_thread+0x121/0x190
 [<c0117c40>] migration_thread+0x0/0x190
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
ksoftirqd/2   S 00000008     0     7      1             8     6 (L-TLB)
c30c3fa0 00000046 c30c3f90 00000008 00000003 00000002 c033eaef c307b020 
       f709ae80 f747c5a0 f71bca80 f709ae80 c30c3f6c c047cf00 c028352b f709ae80 
       000004e2 c2d18400 00000002 0000082c cefe9f34 0000004d c0448300 c308caa0 
Call Trace:
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<c028352b>] scsi_softirq+0xab/0xd0
 [<c01211bc>] ksoftirqd+0xfc/0x130
 [<c01210c0>] ksoftirqd+0x0/0x130
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
migration/3   S 00000008     0     8      1             9     7 (L-TLB)
c30c5f9c 00000046 c30c5f88 00000008 00000004 f76885b0 00001f40 c307ba40 
       f747c320 f747c320 c2d20400 c307ba40 c30c5f74 c01144ff c307ba40 00000000 
       c2d20d60 c2d20400 00000003 00000287 f7c7e04e 0000251e c2d208b4 c308c590 
Call Trace:
 [<c01144ff>] activate_task+0x6f/0xb0
 [<c0117d61>] migration_thread+0x121/0x190
 [<c0117c40>] migration_thread+0x0/0x190
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
ksoftirqd/3   S 00000008     0     9      1            10     8 (L-TLB)
c30d7fa0 00000046 c30d7f90 00000008 00000004 00000003 c033eaef c3080a60 
       f7246b80 e9ecdd40 f71bca80 f7246b80 c30d7f6c c047cf00 c028352b f7246b80 
       c047a380 c2d20400 00000003 00000352 cf3fe842 0000004d c0448300 c308c080 
Call Trace:
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<c028352b>] scsi_softirq+0xab/0xd0
 [<c01211bc>] ksoftirqd+0xfc/0x130
 [<c01210c0>] ksoftirqd+0x0/0x130
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
events/0      S 00000008     0    10      1            11     9 (L-TLB)
c30ddf40 00000046 c30ddf30 00000008 00000001 c01248fa c2d08e00 c0396c00 
       00000000 f7485d20 c2d09f40 c3097c00 000007d0 00000001 c3097c30 c3097c28 
       00000000 c2d08400 00000000 0000271e 4326a584 00002527 00000001 c3098ac0 
Call Trace:
 [<c01248fa>] __mod_timer+0xca/0x120
 [<c012c645>] worker_thread+0x255/0x280
 [<c014abb0>] cache_reap+0x0/0x1e0
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
events/1      S 00000008     0    11      1            12    10 (L-TLB)
c30f7f40 00000046 c30f7f30 00000008 00000002 c01248fa c2d10e00 c307b530 
       00000000 f74dc040 c2d11f40 c3097c00 000007d1 00000286 c3097c90 c3097c88 
       00000000 c2d10400 00000001 00002571 beeaac6c 00002527 00000001 c30dea40 
Call Trace:
 [<c01248fa>] __mod_timer+0xca/0x120
 [<c012c645>] worker_thread+0x255/0x280
 [<c014abb0>] cache_reap+0x0/0x1e0
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
events/2      S 00000008     0    12      1            13    11 (L-TLB)
c3119f40 00000046 c3119f30 00000008 00000003 c01248fa c2d18e00 c307b020 
       00000000 f7e2fa40 c2d19f40 c3097c00 000007d2 00000286 c3097cf0 c3097ce8 
       00000000 c2d18400 00000002 000020b6 629910a6 00002527 00000001 c30985b0 
Call Trace:
 [<c01248fa>] __mod_timer+0xca/0x120
 [<c012c645>] worker_thread+0x255/0x280
 [<c014abb0>] cache_reap+0x0/0x1e0
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
events/3      S 00000008     0    13      1            14    12 (L-TLB)
c311bf40 00000046 c311bf30 00000008 00000004 c01248fa c2d20e00 c3080a60 
       00000000 f7e2fcc0 c2d21f40 c3097c00 000007d3 00000002 c3097d50 c3097d48 
       00000000 c2d20400 00000003 00001fd8 78c1026d 00002527 00000001 c30de530 
Call Trace:
 [<c01248fa>] __mod_timer+0xca/0x120
 [<c012c645>] worker_thread+0x255/0x280
 [<c014abb0>] cache_reap+0x0/0x1e0
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
khelper       S 00000008     0    14     0000008 00000003 00000000 00000046 c307b020 
       f71b9f44 f756bd00 c3163f18 c0116991 f713b550 00000003 c3130c30 c3130c28 
       00000000 c2d18400 00000002 000006b0 727185f5 0000001e 00000001 c3131a80 
Call Trace:
 [<c0116991>] __wake_up_common+0x41/0x60
 [<c012c645>] worker_thread+0x255/0x280
 [<c0130f20>] keventd_create_kthread+0x0/0x70
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
kblockd/0     S 00000008     0    33     19            34       (L-TLB)
c311ff40 00000046 c311ff30 00000008 00000001 f7c63000 c0257ee8 c0396c00 
       00000000 cb50f7e0 c024e3cb f7c569ec 00000000 f7e21c00 c318e830 c318e828 
       00000000 c2d08400 00000000 00001738 f88b88d6 0000247c 00000001 c309aa60 
Call Trace:
 [<c0257ee8>] as_next_request+0x38/0x50
 [<c024e3cb>] elv_next_request+0x1b/0x160
 [<c012c645>] worker_thread+0x255/0x280
 [<c0258b50>] as_work_handler+0x0/0x50
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
kblockd/1     S 00000008     0    34     19            35    33 (L-TLB)
c3141f40 00000046 c3141f30 00000008 00000002 f7e21c00 c024e3cb c307b530 
       00000000 f7533820 c020db2e f7e21ddc c020db00 c0288f79 c318e890 c318e888 
       00000000 c2d10400 00000001 00000e4a 14977c33 00002525 00000001 c30de020 
Call Trace:
 [<c024e3cb>] elv_next_request+0x1b/0x160
 [<c020db2e>] kobject_put+0x1e/0x30
 [<c020db00>] kobject_release+0x0/0x10
 [<c0288f79>] scsi_request_fn+0x59/0x3c0
 [<c012c645>] worker_thread+0x255/0x280
 [<c0250bf0>] blk_unplug_work+0x0/0x10
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
kblockd/2     S 00000008     0    35     19            36    34 (L-TLB)
c331df40 00000046 c331df30 00000008 00000003 f7c63000 c0257ee8 c307b020 
       00000000 c310c7e0 c024e3cb f7c569ec 00000000 f7e21c00 c318e8f0 c318e8e8 
       00000000 c2d18400 00000002 0000129a b32b8d03 0000009d 00000001 c309a550 
Call Trace:
 [<c0257ee8>] as_next_request+0x38/0x50
 [<c024e3cb>] elv_next_request+0x1b/0x160
 [<c012c645>] worker_thread+0x255/0x280
 [<c0258b50>] as_work_handler+0x0/0x50
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
kblockd/3     S 00000008     0    36     19           122    35 (L-TLB)
c331ff40 00000046 c331ff30 00000008 00000004 f7c63000 c0257ee8 c3080a60 
       00000000 c310c7e0 c024e3cb f7c569ec 00000000 f7e21c00 c318e950 c318e948 
       00000000 c2d20400 00000003 00001681 beaa7d05 0000009d 00000001 c30f0aa0 
Call Trace:
 [<c0257ee8>] as_next_request+0x38/0x50
 [<c024e3cb>] elv_next_request+0x1b/0x160
 [<c012c645>] worker_thread+0x255/0x280
 [<c0258b50>] as_work_handler+0x0/0x50
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
pdflush       S 00000008     0   122     19           123    36 (L-TLB)
c3351f80 00000046 c3351f70 00000008 00000002 000001f4 026b5e4e c307b530 
       c014795a f74dc040 026b5e4e 026ad596 00000000 00000000 c3351f34 000003f5 
       00000000 c2d10400 00000001 00007e7b 680830ca 00002527 c3351fa4 c309a040 
Call Trace:
 [<c014795a>] wb_kupdate+0x15a/0x170
 [<c0148460>] pdflush+0x0/0x30
 [<c0148323>] __pdflush+0x83/0x1c0
 [<c0148488>] pdflush+0x28/0x30
 [<c0148460>] pdflush+0x0/0x30
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
pdflush       S 00000008     0   123     19           125   122 (L-TLB)
c3353f80 00000046 c3353f70 00000008 00000001 c3353f34 c3353f2c c0396c00 
       00000000 f7533820 00057f85 000147ff 00000000 00001937 000009da 00000000 
       00000000 c2d08400 00000000 0000036d 7ee8c344 00000037 00000000 c30f0590 
Call Trace:
 [<c0148460>] pdflush+0x0/0x30
 [<c0148323>] __pdflush+0x83/0x1c0
 [<c0148488>] pdflush+0x28/0x30
 [<c0148460>] pdflush+0x0/0x30
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
kswapd0       S 00000008     0   124      1           717    19 (L-TLB)
c3375f88 00000046 c3375f78 00000008 00000003 00000019 00000000 c307b020 
       00000000 f7e2fa40 00000001 c3375f9c 00000000 00000000 00000001 00000020 
       00000020 c2d18400 00000002 000693bb 0efe6c88 00000031 00000001 c3131570 
Call Trace:
 [<c014df75>] kswapd+0x135/0x140
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c0102ef2>] ret_from_fork+0x6/0x14
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c014de40>] kswapd+0x0/0x140
 [<c0101065>] kernel_thread_helper+0x5/0x10
aio/0         S 00000008     0   125     19           126   123 (L-TLB)
c33c7fc33c7f30 00000008 00000001 c04850a8 00000008 c0396c00 
       c3131a80 c0396980 00000200 00000000 00000000 00000000 c0485080 c0485080 
       00000000 c2d08400 00000000 0000031e 17cad28b 00000000 00010000 c30a6ac0 
Call Trace:
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c012c645>] worker_thread+0x255/0x280
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
aio/1         S 00000008     0   126     19           127   125 (L-TLB)
c33c9f40 00000046 c33c9f30 00000008 00000002 c0485084 00000008 c307b530 
       c3131a80 c0396980 00000200 00000000 00000000 00000000 c048508c c048508c 
       00000000 c2d10400 00000001 00000307 17cbd642 00000000 00010000 c30f0080 
Call Trace:
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c012c645>] worker_thread+0x255/0x280
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
aio/2         S 00000008     0   127     19           128   126 (L-TLB)
c33cbf40 00000046 c33cbf2c 00000008 00000003 c04850a8 00000008 c307ba40 
       c3131a80 c0396980 00000200 c307ba40 00000000 00000000 c307ba40 00000000 
       c2d18d60 c2d18400 00000002 0000032f 17ccd008 00000000 c2d1843c c30a65b0 
Call Trace:
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c012c645>] worker_thread+0x255/0x280
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
aio/3         S 00000008     0   128     19           767   127 (L-TLB)
c33cdf40 00000046 c33cdf30 00000008 00000004 c0103a3c c04482a0 c3080a60 
       c33cc000 c0396980 00000011 c33cdf74 00000001 0000007b c048007b fffffffb 
       c033e740 c2d20400 00000003 000005c7 17ce209f 00000000 00010000 c30f3a40 
Call Trace:
 [<c0103a3c>] call_function_interrupt+0x1c/0x24
 [<c033e740>] _read_lock+0x20/0xa0
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c012c645>] worker_thread+0x255/0x280
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
kseriod       S 00000008     0   717      1           761   124 (L-TLB)
f7c77f88 00000046 f7c77f78 00000008 00000003 c020db2e c04167bc c307b020 
       c024a64d f7e82d00 c03e5df4 00000014 00000014 c0249fa2 00000046 c03e5df4 
       c03e5c14 c2d18400 00000002 000004f3 476c05ce 00000003 00000001 c3131060 
Call Trace:
 [<c020db2e>] kobject_put+0x1e/0x30
 [<c024a64d>] driver_create_file+0x4d/0x50
 [<c0249fa2>] driver_add_attrs+0x42/0xb0
 [<c023a15f>] serio_thread+0xef/0x150
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c0102ef2>] ret_from_fork+0x6/0x14
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c023a070>] serio_thread+0x0/0x150
 [<c0101065>] kernel_thread_helper+0x5/0x10
scsi_eh_0     S 00000008     0   761      1           780   717 (L-TLB)
f7cc9f70 00000046 f7cc9f60 00000008 00000003 00000096 00000000 c307b020 
       f7cc9f68 c0396980 c0114921 00000000 c2d08400 00000000 00000000 00000000 
       c2d18400 c2d18400 00000002 00000791 2325d7d2 00000001 00000002 c30f3020 
Call Trace:
 [<c0114921>] try_to_wake_up+0x81/0x2f0
 [<c033c6d6>] __down_interruptible+0xb6/0x12c
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116b07>] complete+0x47/0x60
 [<c033c75f>] __down_failed_interruptible+0x7/0xc
 [<c0287b46>] .text.lock.scsi_error+0x3b/0x45
 [<c0287560>] scsi_error_handler+0x0/0xe0
 [<c0101065>] kernel_thread_helper+0x5/0x10
ata/0         S 00000008     0   767     19           768   128 (L-TLB)
f7c01f40 00000046 f7c01f30 00000008 00000001 c04850a8 00000008 c0396c00 
       c3131a80 c0396980 00000200 00000000 00000000 00000000 c0485080 c0485080 
       00000000 c2d08400 00000000 0000033f 1fbc5756 00000003 00010000 c30a60a0 
Call Trace:
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c012c645>] worker_thread+0x255/0x280
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
ata/1         S 00000008     0   768     19           769   767 (L-TLB)
f7c75f40 00000046 f7c75f30 00000008 00000002 c0485084 00000008 c307b530 
       c3131a80 c0396980 00000200 00000000 00000000 00000000 c048508c c048508c 
       00000000 c2d10400 00000001 000002fe 1fbd7cb5 00000003 00010000 c30faa80 
Call Trace:
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c012c645>] worker_thread+0x255/0x280
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
ata/2         S 00000008     0   769     19           770   768 (L-TLB)
f7c73f40 00000046 f7c73f30 00000008 00000003 c04850a8 00000008 c307b020 
       c3131a80 c0396980 00000200 00000000 00000000 00000000 c0485080 c0485080 
       00000000 c2d18400 00000002 000005fc 1fbe9b6b 00000003 00010000 c30f3530 
Call Trace:
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c012c645>] worker_thread+0x255/0x280
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
ata/3         S 00000008     0   770     19                 769 (L-TLB)
c33fff40 00000046 c33fff2c 00000008 00000004 c0485084 00000008 c307ba40 
       c3131a80 c0396980 00000200 c307ba40 00000000 00000000 c307ba40 00000000 
       c2d20d60 c2d20400 00000003 0000033b 1fbf776b 00000003 c2d2043c c30fa570 
Call Trace:
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c012c645>] worker_thread+0x255/0x280
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c012c3f0>] worker_thread+0x0/0x280
 [<c0130f1a>] kthread+0xba/0xc0
 [<c0130e60>] kthread+0x0/0xc0
 [<c0101065>] kernel_thread_helper+0x5/0x10
khpsbpkt      S 00000008     0   780      1           795   761 (L-TLB)
f7e5bf94 00000046 f7e5bf84 00000008 00000003 00000008 c0396c00 c307b020 
       00000046 c0396980 00000008 00000001 f7e22aa0 c011ccd9 c0396c00 00000001 
       c0396980 c2d18400 00000002 000005ef 28e4d781 00000003 f7e22aa0 f7c6aac0 
Call Trace:
 [<c011ccd9>] release_task+0xc9/0x150
 [<c033c6d6>] __down_interruptible+0xb6/0x12c
 [<c0116930>] default_wake_function+0x0/0x20
 [<c011d3e2>] daemonize+0xf2/0x100
 [<c033c75f>] __down_failed_interruptible+0x7/0xc
 [<c02a60f5>] .text.lock.ieee1394_core+0x1b/0x26
 [<c02a6010>] hpsbpkt_thread+0x0/0xb0
 [<c0101065>] kernel_thread_helper+0x5/0x10
kirqd         S 00000008     0   795      1          1565   780 (L-TLB)
f7ea3f8c 00000046 f7ea3f7c 00000008 00000002 c01039d2 00000018 c307b530 
       00000000 f74dc040 c307b530 00000002 000022c0 f7ea007b f7ea007b c047bea0 
       f7ea3fa0 c2d10400 00000001 000006db ac3324fc 00002528 c01248fa f7c6a5b0 
Call Trace:
 [<c01039d2>] common_interrupt+0x1a/0x20
 [<c01248fa>] __mod_timer+0xca/0x120
 [<c033de23>] schedule_timeout+0x73/0xd0
 [<c01254f0>] process_timeout+0x0/0x10
 [<c0111680>] balanced_irq+0x50/0x90
 [<c0111630>] balanced_irq+0x0/0x90
 [<c0101065>] kernel_thread_helper+0x5/0x10
kjournald     S 00000008     0  1565      1          1820   795 (L-TLB)
f74e3f54 00000046 f74e3f44 00000008 00000001 eb775434 00000000 c0396c00 
       f75f2200 f7485d20 00000124 00000003 00000000 00000000 f75f246c f75f2464 
       00000000 c2d08400 00000000 000007a7 90ab576a 0000039f 00000001 f7c930a0 
Call Trace:
 [<c01b8be2>] kjournald+0x202/0x280
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c01150a9>] schedule_tail+0x39/0xa0
 [<c01b89c0>] commit_timeout+0x0/0x10
 [<c01b89e0>] kjournald+0x0/0x280
 [<c0101065>] kernel_thread_helper+0x5/0x10
dhclient      S 00000008     0  1820      1          1863  1565 (NOTLB)
f753fea0 00000086 f753fe90 00000008 00000001 c039c200 000000d0 c0396c00 
       00000000 f7533aa0 00000001 00000000 f745fa60 00000010 c039ca00 00000000 
       00000600 c2d08400 00000000 00001171 ec716970 000024e2 c01248fa f745fa60 
Call Trace:
 [<c01248fa>] __mod_timer+0xca/0x120
 [<c033de23>] schedule_timeout+0x73/0xd0
 [<c01254f0>] process_timeout+0x0/0x10
 [<c02d4b39>] sock_poll+0x29/0x40
 [<c0175b73>] do_select+0x1a3/0x2e0
 [<c0175810>] __pollwait+0x0/0xd0
 [<c0175f79>] sys_select+0x299/0x440
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
syslogd       S 00000008     0  1863      1          1867  1820 (NOTLB)
f759fea0 00000082 f759fe90 00000008 00000001 f74f43c0 c11a8da0 c0396c00 
       c039c200 f7533820 00000000 000000d0 c0146332 c039ca00 c039c200 000000d0 
       00000001 c2d08400 00000000 000006a7 3b763d31 00002526 00000010 f7513080 
Call Trace:
 [<c0146332>] __alloc_pages+0x2f2/0x410
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<c02db69c>] datagram_poll+0x2c/0xe0
 [<c02d4b39>] sock_poll+0x29/0x40
 [<c0175b73>] do_select+0x1a3/0x2e0
 [<c0175810>] __pollwait+0x0/0xd0
 [<c0175f79>] sys_select+0x299/0x440
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
klogd         R running     0  1867      1          1879  1863 (NOTLB)
portmap       S 00000008     0  1879      1          1898  1867 (NOTLB)
f74c9efc 00000086 f74c9eec 00000008 00000001 f7599040 00000010 c0396c00 
       00000000 f74dccc0 000000d0 f7e4b7e0 f74c9fa0 c309c898 00000000 00000286 
       f746200c c2d08400 00000000 00003d83 87d81331 00000008 00000001 f7599040 
Call Trace:
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c02d4b39>] sock_poll+0x29/0x40
 [<c017617b>] do_pollfd+0x5b/0xa0
 [<c017626b>] do_poll+0xab/0xd0
 [<c01763d0>] sys_poll+0x140/0x210
 [<c0175810>] __pollwait+0x0/0xd0
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
rpc.statd     S 00000008     0  1898      1          1988  1879 (NOTLB)
f75b3ea0 00000082 f75b3e90 00000008 00000001 c039c200 000000d0 c0396c00 
       00000000 f758ba80 00000001 00000000 f7475060 00000010 c039ca00 00000000 
       c0396dc0 c2d08400 00000000 00005551 469cabd1 00000008 00000286 f7475060 
Call Trace:
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<c02f918c>] tcp_poll+0x2c/0x190
 [<c02d4b39>] sock_poll+0x29/0x40
 [<c0175b73>] do_select+0x1a3/0x2e0
 [<c0175810>] __pollwait+0x0/0xd0
 [<c0175f79>] sys_select+0x299/0x440
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
sshd          S 00000008     0  1988      1          2003  1898 (NOTLB)
f76c3ea0 00000086 f76c3e90 00000008 00000003 c16ec240 00000246 c307b020 
       f7e29740 f7501300 000000d0 c0146332 c039ca00 c039c200 000000d0 00000001 
       00000000 c2d18400 00000002 002ac7a9 8096d260 00000008 c039ca00 f745f040 
Call Trace:
 [<c0146332>] __alloc_pages+0x2f2/0x410
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<c02f918c>] tcp_poll+0x2c/0x190
 [<c02d4b39>] sock_poll+0x29/0x40
 [<c0175b73>] do_select+0x1a3/0x2e0
 [<c0175810>] __pollwait+0x0/0xd0
 [<c0175f79>] sys_select+0x299/0x440
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
xinetd        S 00000008     0  2003      1          2019  1988 (NOTLB)
f75b1ea0 00000086 f75b1e90 00000008 00000002 00000000 00000000 c307b530 
       c047cf40 f7445d60 00000246 c039c200 f7c881a0 00000000 000000d0 c0146332 
       c039ca00 c2d10400 00000001 0000520a c38b55cf 00000008 00000001 f7557020 
Call Trace:
 [<c0146332>] __alloc_pages+0x2f2/0x410
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<c02f918c>] tcp_poll+0x2c/0x190
 [<c02d4b39>] sock_poll+0x29/0x40
 [<c0175b73>] do_select+0x1a3/0x2e0
 [<c0175810>] __pollwait+0x0/0xd0
 [<c0175f79>] sys_select+0x299/0x440
 [<c0120018>] sys_time+0x28/0x40
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
ntpd          S 00000008     0  2019      1          2033  2003 (NOTLB)
f75b5ea0 00000082 f75b5e90 00000008 00000001 c039c200 000000d0 c0396c00 
       00000000 f7485d20 00000001 00000000 f7513aa0 00000010 c039ca00 00000000 
       c010a4ae c2d08400 00000000 000008cd 27ed66d5 00002527 00000286 f7513aa0 
Call Trace:
 [<c010a4ae>] save_i387_fxsave+0x9e/0x120
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c0315713>] udp_poll+0x23/0x150
 [<c0102cce>] handle_signal+0xbe/0x150
 [<c02d4b39>] sock_poll+0x29/0x40
 [<c0175b73>] do_select+0x1a3/0x2e0
 [<c0175810>] __pollwait+0x0/0xd0
 [<c0175f79>] sys_select+0x299/0x440
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
sendmail      R running     0  2033      1          2048  2019 (NOTLB)
cannaserver   S 00000008     0  2048      1          2059  2033 (NOTLB)
f7603ea0 00000082 f7603e90 00000008 00000001 00000000 c16eb5a0 c0396c00 
       c039c200 f7501a80 00000000 000000d0 c0146332 c039ca00 c039c200 000000d0 
       00000001 c2d08400 00000000 0000091c 007843c8 00002524 c01248fa f7482020 
Call Trace:
 [<c0146332>] __alloc_pages+0x2f2/0x410
 [<c01248fa>] __mod_timer+0xca/0x120
 [<c033de23>] schedule_timeout+0x73/0xd0
 [<c01254f0>] process_timeout+0x0/0x10
 [<c02d4b39>] sock_poll+0x29/0x40
 [<c0175b73>] do_select+0x1a3/0x2e0
 [<c0175810>] __pollwait+0x0/0xd0
 [<c0175f79>] sys_select+0x299/0x440
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
crond         S 00000008     0  2059      1  6106    2070  2048 (NOTLB)
f7567f40 00000082 f7567f30 00000008 00000001 f747c820 f747c84c c0396c00 
       00000007 f747c820 f747c820 f745dd84 42132c80 00000001 00000001 42132c80 
       f7eb2570 c2d08400 00000000 00001abd 7bce2e06 0000251a c01248fa f7eb2570 
Call Trace:
 [<c01248fa>] __mod_timer+0xca/0x120
 [<c033de23>] schedule_timeout+0x73/0xd0
 [<c01254f0>] process_timeout+0x0/0x10
 [<c01255f4>] sys_nanosleep+0xe4/0x180
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
jserver       S 00000008     0  2070      1          2082  2059 (NOTLB)
f77fdea0 00000082 f77fde90 00000008 00000001 00000000 c16ef620 c0396c00 
       c039c200 f762cae0 00000000 000000d0 c0146332 c039ca00 c039c200 000000d0 
       00000001 c2d08400 00000000 001a2376 c6531a4b 00000009 00000010 f756aa60 
Call Trace:
 [<c0146332>] __alloc_pages+0x2f2/0x410
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<c032936c>] unix_poll+0x2c/0xb0
 [<c02d4b39>] sock_poll+0x29/0x40
 [<c0175b73>] do_select+0x1a3/0x2e0
 [<c0175810>] __pollwait+0x0/0xd0
 [<c0175f79>] sys_select+0x299/0x440
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
anacron       S 00000008     0  2082      1  7729    2091  2070 (NOTLB)
c30d9f98 00000086 c30d9f88 00000008 00000001 00000086 00000000 c0396c00 
       00000000 f742d0c0 c0396c00 f75690c8 003c417f bff964d0 00000000 c30d9f70 
       ffffffff c2d08400 00000000 000006f6 294ec9d4 000003db 00000000 f7e58040 
Call Trace:
 [<c01020ed>] sys_rt_sigsuspend+0xcd/0xf0
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
atd           S 00000008     0  2091      1          2102  2082 (NOTLB)
f75b7f40 00000082 f75b7f30 00000008 00000001 00000000 00000000 c0396c00 
       c2cc7a80 f758b080 00000286 f75c37ec c033e5c6 00000001 4268250d c0185a99 
       c2cc7a80 c2d08400 00000000 0000246a 25ccae13 00002520 c01248fa f7599a60 
Call Trace:
 [<c033e5c6>] _spin_lock+0x16/0xa0
 [<c0185a99>] __mark_inode_dirty+0x69/0x1f0
 [<c01248fa>] __mod_timer+0xca/0x120
 [<c033de23>] schedule_timeout+0x73/0xd0
 [<c01254f0>] process_timeout+0x0/0x10
 [<c01255f4>] sys_nanosleep+0xe4/0x180
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
S99STP        S 00000008     0  2102      1  2115    2117  2091 (NOTLB)
f7013f30 00000082 f7013f20 00000008 00000001 f77d238c f7548080 c0396c00 
       c2d08400 f742dd40 f742dd6c f7e367ac 00000007 c01130fc f742dd40 f7e367ac 
       080e3c48 c2d08400 00000000 000157ad dcb4d2f7 00000009 f7013fc4 f74a4aa0 
Call Trace:
 [<c01130fc>] do_page_fault+0x19c/0x5f6
 [<c011f269>] do_wait+0x209/0x430
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c011f563>] sys_wait4+0x43/0x50
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
stp_client.pl S 00000008     0  2115   2102  2677               (NOTLB)
f75b9f30 00000082 f75b9f20 00000008 00000003 f77a7de8 f7561b7c c307b020 
       c2d18400 f7501080 f75010ac f7c8f544 00000007 c01130fc f7501080 f7c8f544 
       b7f7a4e0 c2d18400 00000002 0000135e 3d3ad4f4 0000001e f75b9fc4 f756a550 
Call Trace:
 [<c01130fc>] do_page_fault+0x19c/0x5f6
 [<c011f269>] do_wait+0x209/0x430
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0160999>] filp_close+0x59/0x90
 [<c011f563>] sys_wait4+0x43/0x50
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
mingetty      S 00000008     0  2117      1          2118  2102 (NOTLB)
f7491e78 00000086 f7491e64 00000008 00000001 00003fff c2d55000 f7475a80 
       0000300e f7501800 f7491e4c f7475a80 f7c93ac0 00001f40 f7475a80 00000000 
       c2d08d60 c2d08400 00000000 000024b3 f8c45a5e 00000009 c2d0843c f7e22080 
Call Trace:
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c0229919>] read_chan+0x279/0x700
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0223f70>] tty_write+0x1e0/0x2b0
 [<c0223d57>] tty_read+0x107/0x140
 [<c0191c9a>] dnotify_parent+0x3a/0xb0
 [<c0223c50>] tty_read+0x0/0x140
 [<c01612ae>] vfs_read+0xbe/0x130
 [<c0161591>] sys_read+0x51/0x80
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
mingetty      S 00000008     0  2118      1          2119  2117 (NOTLB)
f74bfe78 00000082 f74bfe64 00000008 00000002 c01143b8 f7eb2a80 f7eb2a80 
       0000300e f7e2f040 f74bfe4c f7eb2a80 c01143b8 f7e22aa0 f7eb2a80 00000000 
       c2d10d60 c2d10400 00000001 0000087c f8c4e21d 00000009 c2d1043c f7557530 
Call Trace:
 [<c01143b8>] recalc_task_prio+0xa8/0x180
 [<c01143b8>] recalc_task_prio+0xa8/0x180
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c0229919>] read_chan+0x279/0x700
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0223d57>] tty_read+0x107/0x140
 [<c0191c9a>] dnotify_parent+0x3a/0xb0
 [<c0223c50>] tty_read+0x0/0x140
 [<c01612ae>] vfs_read+0xbe/0x130
 [<c0161591>] sys_read+0x51/0x80
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
mingetty      S 00000008     0  2119      1          2120  2118 (NOTLB)
f7e6be78 00000086 f7e6be68 00000008 00000001 f7e6be58 c0115a7d c0396c00 
       00000008 f77db860 00000008 f7e6be50 c01143b8 f7e22aa0 00001f40 00000000 
       c310c560 c2d08400 00000000 000011dd f8c614cd 00000009 00000002 f7475a80 
Call Trace:
 [<c0115a7d>] find_busiest_group+0xcd/0x2e0
 [<c01143b8>] recalc_task_prio+0xa8/0x180
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c0229919>] read_chan+0x279/0x700
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0223d57>] tty_read+0x107/0x140
 [<c0125266>] run_timer_softirq+0x136/0x1d0
 [<c0223c50>] tty_read+0x0/0x140
 [<c01612ae>] vfs_read+0xbe/0x130
 [<c0161591>] sys_read+0x51/0x80
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
mingetty      S 00000008     0  2120      1          2126  2119 (NOTLB)
f7011e78 00000086 f7011e68 00000008 00000002 f7011e3c c0115d20 c307b530 
       0000300e f742dac0 f7011e4c c01143b8 f7c93ac0 00001f40 00000000 f7501d00 
       c2d10400 c2d10400 00000001 0000110d f8c6bbb4 00000009 c2d2043c f7eb2a80 
Call Trace:
 [<c0115d20>] find_busiest_queue+0x90/0xb0
 [<c01143b8>] recalc_task_prio+0xa8/0x180
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c0234e61>] con_write+0x31/0x40
 [<c0229919>] read_chan+0x279/0x700
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0223f70>] tty_write+0x1e0/0x2b0
 [<c0223d57>] tty_read+0x107/0x140
 [<c0191c9a>] dnotify_parent+0x3a/0xb0
 [<c0223c50>] tty_read+0x0/0x140
 [<c01612ae>] vfs_read+0xbe/0x130
 [<c0161591>] sys_read+0x51/0x80
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
mingetty      S 00000008     0  2126      1          2127  2120 (NOTLB)
f7047e78 00000086 f7047e68 00000008 00000003 f7047e58 c0115a7d c307b020 
       00000008 c310c560 00000008 f7047e50 c01143b8 f7c93ac0 00001f40 00000000 
       f7501d00 c2d18400 00000002 0000103a f8c64b93 00000009 00000003 f7e22aa0 
Call Trace:
 [<c0115a7d>] find_busiest_group+0xcd/0x2e0
 [<c01143b8>] recalc_task_prio+0xa8/0x180
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c0229919>] read_chan+0x279/0x700
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0223d57>] tty_read+0x107/0x140
 [<c0191c9a>] dnotify_parent+0x3a/0xb0
 [<c0223c50>] tty_read+0x0/0x140
 [<c01612ae>] vfs_read+0xbe/0x130
 [<c0161591>] sys_read+0x51/0x80
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
mingetty      S 00000008     0  2127      1          2763  2126 (NOTLB)
f7049e78 00000086 f7049e68 00000008 00000004 f7049e58 c0115a7d c3080a60 
       00000008 f7501d00 00000008 c047b4a0 f7049e58 c0115d20 00000000 00000008 
       f7049e58 c2d20400 00000003 00000974 f8c6af02 00000009 c033ea5d f7c93ac0 
Call Trace:
 [<c0115a7d>] find_busiest_group+0xcd/0x2e0
 [<c0115d20>] find_busiest_queue+0x90/0xb0
 [<c033ea5d>] _spin_unlock+0xd/0x30
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c033cb20>] schedule+0x370/0xd20
 [<c0229919>] read_chan+0x279/0x700
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0223d57>] tty_read+0x107/0x140
 [<c0191c9a>] dnotify_parent+0x3a/0xb0
 [<c0223c50>] tty_read+0x0/0x140
 [<c01612ae>] vfs_read+0xbe/0x130
 [<c0161591>] sys_read+0x51/0x80
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
sh            S 00000008     0  2677   2115  2715               (NOTLB)
f7149f30 00000086 f7149f20 00000008 00000001 f712e398 f7134080 c0396c00 
       c2d08400 f75330a0 f75330cc c31106fc 00000007 c01130fc f75330a0 c31106fc 
       080e6bb8 c2d08400 00000000 00017e85 424e4710 0000001e f7149fc4 f74d8a80 
Call Trace:
 [<c01130fc>] do_page_fault+0x19c/0x5f6
 [<c011f269>] do_wait+0x209/0x430
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c011f563>] sys_wait4+0x43/0x50
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
wrap.sh       S 00000008     0  2715   2677  2845               (NOTLB)
f7659f30 00000086 f7659f20 00000008 00000001 f71958a4 f713abfc c0396c00 
       c2d08400 f762c860 f762c88c f744859c 00000007 c01130fc f762c860 f744859c 
       bfe29fdc c2d08400 00000000 000043e7 4d54ec03 00000028 f7659fc4 f7c6a0a0 
Call Trace:
 [<c01130fc>] do_page_fault+0x19c/0x5f6
 [<c011f269>] do_wait+0x209/0x430
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c011f563>] sys_wait4+0x43/0x50
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
scsi_eh_1     S 00000008     0  2763      1          2764  2127 (L-TLB)
f714bf70 00000046 f714bf60 00000008 00000001 00000012 00000000 c0396c00 
       f714bf68 f756bd00 c0114921 00000003 c2d20400 00000000 f713b550 f71dd5b0 
       c2d08400 c2d08400 00000000 00001a74 727b46db 0000001e 00000000 f71dd5b0 
Call Trace:
 [<c0114921>] try_to_wake_up+0x81/0x2f0
 [<c033c6d6>] __down_interruptible+0xb6/0x12c
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116b07>] complete+0x47/0x60
 [<c033c75f>] __down_failed_interruptible+0x7/0xc
 [<c0287b46>] .text.lock.scsi_error+0x3b/0x45
 [<c0287560>] scsi_error_handler+0x0/0xe0
 [<c0101065>] kernel_thread_helper+0x5/0x10
aacraid       R running     0  2764      1          2791  2763 (L-TLB)
scsi_eh_2     S 00000008     0  2791      1          2792  2764 (L-TLB)
f721ff70 00000046 f721ff60 00000008 00000001 00000012 00000000 c0396c00 
       f721ff68 f756bd00 c0114921 00000001 c2d10400 00000000 f713b550 f7e58a60 
       c2d08400 c2d08400 00000000 00000dff b8389781 0000001f 00000000 f71e5020 
Call Trace:
 [<c0114921>] try_to_wake_up+0x81/0x2f0
 [<c033c6d6>] __down_interruptible+0xb6/0x12c
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116b07>] complete+0x47/0x60
 [<c033c75f>] __down_failed_interruptible+0x7/0xc
 [<c0287b46>] .text.lock.scsi_error+0x3b/0x45
 [<c0287560>] scsi_error_handler+0x0/0xe0
 [<c0101065>] kernel_thread_helper+0x5/0x10
aacraid       S 00000008     0  2792      1          2914  2791 (L-TLB)
f70e3f60 00000046 f70e3f50 00000008 00000001 00000006 f7648a20 c0396c00 
       f7648a20 f7485d20 f7648a20 f713e570 c033eaef f8a68556 f713e570 00000000 
       c2d08d60 c2d08400 00000000 0000009d a2b834d3 00002525 c2d0843c f713e570 
Call Trace:
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<f8a68556>] aac_insert_entry+0x76/0x90 [aacraid]
 [<f8a68da8>] aac_command_thread+0x2a8/0x3e4 [aacraid]
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0102ef2>] ret_from_fork+0x6/0x14
 [<c0116930>] default_wake_function+0x0/0x20
 [<f8a68b00>] aac_command_thread+0x0/0x3e4 [aacraid]
 [<c0101065>] kernel_thread_helper+0x5/0x10
stp_timeout.s S 00000008     0  2845   2715  2876    2896       (NOTLB)
f71b9f30 00000082 f71b9f20 00000008 00000001 f708638c f7431080 c0396c00 
       c2d08400 f7533d20 f7533d4c f7c8fcd4 00000007 c01130fc f7533d20 f7c8fcd4 
       080e3cfc c2d08400 00000000 00007a67 2c6c9f54 00000028 f71b9fc4 f713b550 
Call Trace:
 [<c01130fc>] do_page_fault+0x19c/0x5f6
 [<c011f269>] do_wait+0x209/0x430
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c011f563>] sys_wait4+0x43/0x50
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
sleep         S 00000008     0  2876   2845                     (NOTLB)
f70bbf40 00000086 f70bbf30 00000008 00000004 f747caa0 f747cacc c3080a60 
       00000004 f747caa0 f747caa0 f74aeee4 b7fbb970 00000000 00000000 b7fbb970 
       f71e5a40 c2d20400 00000003 000858ea 2c8ba63b 00000028 c01248fa f71e5a40 
Call Trace:
 [<c01248fa>] __mod_timer+0xca/0x120
 [<c033de23>] schedule_timeout+0x73/0xd0
 [<c01254f0>] process_timeout+0x0/0x10
 [<c01255f4>] sys_nanosleep+0xe4/0x180
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
runit.pl      S 00000008     0  2896   2715  6040          2845 (NOTLB)
f75fff30 00000082 f75fff20 00000008 00000001 f723af04 f747eb7c c0396c00 
       c2d10400 f762c0e0 f762c10c c311022c 00000007 c01130fc f762c0e0 c311022c 
       b7fc14e0 c2d08400 00000000 00002e9a 0b5d65ba 0000005a f75fffc4 f7557a40 
Call Trace:
 [<c01130fc>] do_page_fault+0x19c/0x5f6
 [<c011f269>] do_wait+0x209/0x430
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0160999>] filp_close+0x59/0x90
 [<c011f563>] sys_wait4+0x43/0x50
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
kjournald     S 00000008     0  2914      1          2923  2792 (L-TLB)
cd8c1f54 00000046 cd8c1f44 00000008 00000003 cb74002c 00000000 c307b020 
       f773e800 f7e2fa40 00000268 f74a4590 00000000 00000000 f70d126c f70d1264 
       00000000 c2d18400 00000002 0000071c a153d511 0000039f 00000001 f7482530 
Call Trace:
 [<c01b8be2>] kjournald+0x202/0x280
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c01150a9>] schedule_tail+0x39/0xa0
 [<c01b89c0>] commit_timeout+0x0/0x10
 [<c01b89e0>] kjournald+0x0/0x280
 [<c0101065>] kernel_thread_helper+0x5/0x10
kjournald     S 00000008     0  2923      1          2932  2914 (L-TLB)
ed55bf54 00000046 ed55bf44 00000008 00000003 cccff02c 00000000 c307b020 
       cb220000 f7e2fa40 00000278 d1cf2080 f71bc570 c0131400 f759886c f7598864 
       00000000 c2d18400 00000002 00000507 a19e3c05 0000039f 00000001 f71bc570 
Call Trace:
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c01b8be2>] kjournald+0x202/0x280
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c01150a9>] schedule_tail+0x39/0xa0
 [<c01b89c0>] commit_timeout+0x0/0x10
 [<c01b89e0>] kjournald+0x0/0x280
 [<c0101065>] kernel_thread_helper+0x5/0x10
kjournald     D 00000008     0  2932      1          2941  2923 (L-TLB)
e4b29eb8 00000046 e4b29ea4 00000008 00000003 00000000 00000000 d1cf2aa0 
       00000020 f72ab860 e4b29eac d1cf2aa0 c0485090 00000008 d1cf2aa0 00000000 
       c2d18d60 c2d18400 00000002 000004f6 93237e62 0000005c c2d188b4 f7475570 
Call Trace:
 [<c01312c0>] prepare_to_wait+0x20/0x70
 [<c01b6353>] journal_commit_transaction+0x1233/0x1310
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c01b8c0c>] kjournald+0x22c/0x280
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c01150a9>] schedule_tail+0x39/0xa0
 [<c01b89c0>] commit_timeout+0x0/0x10
 [<c01b89e0>] kjournald+0x0/0x280
 [<c0101065>] kernel_thread_helper+0x5/0x10
kjournald     S 00000008     0  2941      1          6101  2932 (L-TLB)
e4b57f54 00000046 e4b57f44 00000008 00000004 cb22204c 00000000 c3080a60 
       cb292800 c310ca60 0000026b 00000000 f74d8060 c0131400 f74cbc6c f74cbc64 
       00000000 c2d20400 00000003 00000a07 59abda20 0000005c 00000001 f74d8060 
Call Trace:
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c01b8be2>] kjournald+0x202/0x280
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c01150a9>] schedule_tail+0x39/0xa0
 [<c01b89c0>] commit_timeout+0x0/0x10
 [<c01b89e0>] kjournald+0x0/0x280
 [<c0101065>] kernel_thread_helper+0x5/0x10
sh            S 00000008     0  6040   2896  6044               (NOTLB)
dc2edf30 00000082 dc2edf20 00000008 00000004 f779a384 f74d5080 c3080a60 
       c2d10400 cb164ae0 cb164b0c f7408d84 00000007 c01130fc cb164ae0 f7408d84 
       080e173c c2d20400 00000003 00015f7f 0baba097 0000005a dc2edfc4 cd443a80 
Call Trace:
 [<c01130fc>] do_page_fault+0x19c/0x5f6
 [<c011f269>] do_wait+0x209/0x430
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c011f563>] sys_wait4+0x43/0x50
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
reaim         S 00000008     0  6044   6040  6074               (NOTLB)
e2097f30 00000082 e2097f20 00000008 00000002 00000000 c0118b37 c307b530 
       f4ca8550 cb4dbae0 c011cd08 f4ca8550 00000286 00000000 f4ca8550 000017bb 
       00000000 c2d10400 00000001 00000f87 8ac6ecd5 00000194 1998c1e3 f4ca8a60 
Call Trace:
 [<c0118b37>] free_task+0x27/0x30
 [<c011cd08>] release_task+0xf8/0x150
 [<c011f269>] do_wait+0x209/0x430
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c0116930>] default_wake_function+0x0/0x20
 [<c011f563>] sys_wait4+0x43/0x50
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
reaim         D 00000008     0  6074   6044          6076       (NOTLB)
e7c13c38 00000082 e7c13c28 00000008 00000002 cac329d4 f77a0a40 c307b530 
       00000014 e9ecd340 00000014 cac329d4 cac329d4 c30efe00 cd9a9600 f7740dd4 
       df87c254 c2d10400 00000001 00014c7f 9323ec4e 0000005c 00000002 f7eb2060 
Call Trace:
 [<c01b20b0>] start_this_handle+0x260/0x3c0
 [<c01a5df9>] ext3_mark_iloc_dirty+0x29/0x40
 [<c01aa634>] __ext3_journal_stop+0x24/0x50
 [<c0164c2a>] __block_prepare_write+0x31a/0x450
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c01b3d7d>] journal_stop+0x19d/0x260
 [<c01b2309>] journal_start+0xa9/0xd0
 [<c01a5d5c>] ext3_writepage_trans_blocks+0x1c/0x90
 [<c01a2f1a>] ext3_prepare_write+0x3a/0x190
 [<c033ebae>] _read_unlock_irq+0xe/0x30
 [<c0141400>] find_lock_page+0xb0/0xd0
 [<c014333a>] generic_file_buffered_write+0x1ba/0x6a0
 [<c017d537>] inode_update_time+0x57/0x100
 [<c0143baa>] __generic_file_aio_write_nolock+0x38a/0x5d0
 [<c0142005>] __generic_file_aio_read+0x1f5/0x240
 [<c01440a3>] generic_file_aio_write+0x73/0xe0
 [<c01a0664>] ext3_file_write+0x44/0xe0
 [<c01613de>] do_sync_write+0xbe/0xf0
 [<c0120a8a>] __do_softirq+0x8a/0x100
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c033e5c6>] _spin_lock+0x16/0xa0
 [<c0191c9a>] dnotify_parent+0x3a/0xb0
 [<c012930b>] sys_rt_sigaction+0x8b/0xd0
 [<c01614ce>] vfs_write+0xbe/0x130
 [<c0161611>] sys_write+0x51/0x80
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
reaim         D 00000008     0  6076   6044                6074 (NOTLB)
dc313c8c 00000086 dc313c7c 00000008 00000001 cd4747ac cb32df2c c0396c00 
       00000001 f72abd60 c2d08400 f7669b7c f72abda0 f72abd60 00000f2c c014fb30 
       00000000 c2d08400 00000000 004809dd a2e8dafa 0000005c 00000002 f74c4060 
Call Trace:
 [<c014fb30>] pte_alloc_map+0x80/0xd0
 [<c01b20b0>] start_this_handle+0x260/0x3c0
 [<c01130fc>] do_page_fault+0x19c/0x5f6
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c01b2309>] journal_start+0xa9/0xd0
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<c0114921>] try_to_wake_up+0x81/0x2f0
 [<c01a5f78>] ext3_dirty_inode+0x38/0x90
 [<c0185c16>] __mark_inode_dirty+0x1e6/0x1f0
 [<c012089d>] current_fs_time+0x5d/0x80
 [<c017d4b6>] update_atime+0xe6/0x110
 [<c0141a16>] do_generic_mapping_read+0x346/0x650
 [<c0142005>] __generic_file_aio_read+0x1f5/0x240
 [<c0141d20>] file_read_actor+0x0/0xf0
 [<c017a0b2>] dput+0x32/0x1d0
 [<c01420aa>] generic_file_aio_read+0x5a/0x80
 [<c01611be>] do_sync_read+0xbe/0xf0
 [<c015392f>] vma_merge+0x16f/0x1f0
 [<c015402e>] do_mmap_pgoff+0x53e/0x7e0
 [<c0131400>] autoremove_wake_function+0x0do_sync_read+0x0/0xf0
 [<c01612ae>] vfs_read+0xbe/0x130
 [<c0161591>] sys_read+0x51/0x80
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
sync          D 00000008     0  6100      1          8243  6101 (NOTLB)
f7255d60 00000082 f7255d50 00000008 00000004 c2c30080 c2c30080 c3080a60 
       00000000 cb0bb340 f7255d4c ceb16458 0000a400 00000000 00000000 00000000 
       00000000 c2d20400 00000003 00003531 93242254 0000005c f775abcc d1cf2590 
Call Trace:
 [<c033dd38>] io_schedule+0x28/0x40
 [<c0140901>] sync_page+0x41/0x60
 [<c033e09f>] __wait_on_bit_lock+0x5f/0x70
 [<c01408c0>] sync_page+0x0/0x60
 [<c0141293>] __lock_page+0xa3/0xb0
 [<c0131460>] wake_bit_function+0x0/0x60
 [<c0131460>] wake_bit_function+0x0/0x60
 [<c0187d0a>] __mpage_writepages+0x32a/0x3e0
 [<c01a3720>] ext3_writeback_writepage_helper+0x0/0x30
 [<c014828d>] mapping_tagged+0x3d/0x50
 [<c01a37c8>] ext3_writeback_writepages+0x78/0xb0
 [<c01a2a60>] ext3_writepages_get_block+0x0/0x40
 [<c01a3720>] ext3_writeback_writepage_helper+0x0/0x30
 [<c0147b55>] do_writepages+0x25/0x50
 [<c033ea5d>] _spin_unlock+0xd/0x30
 [<c0185cd6>] __sync_single_inode+0x66/0x200
 [<c0185ee1>] __writeback_single_inode+0x71/0x170
 [<c014bcf6>] pagevec_lookup_tag+0x36/0x40
 [<c0140b55>] wait_on_page_writeback_range+0x85/0x140
 [<c01861ba>] sync_sb_inodes+0x1da/0x2f0
 [<c0186478>] sync_inodes_sb+0xb8/0xd0
 [<c0186525>] get_super_to_sync+0x55/0x80
 [<c018657b>] sync_inodes+0x2b/0xa0
 [<c0162b44>] do_sync+0x44/0x80
 [<c0162b8f>] sys_sync+0xf/0x20
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
sync          D 00000008     0  6101      1          6100  2941 (NOTLB)
cd40fea8 00000086 cd40fe98 00000008 00000001 c024e417 c2d18400 c0396c00 
       00000001 f72ab860 c0169850 00000000 00000000 f7c562b8 00000040 d39835b8 
       00000012 c2d08400 00000000 00001aa4 d0d7816a 0000005c c020f5b6 d1cf2aa0 
Call Trace:
 [<c024e417>] elv_next_request+0x67/0x160
 [<c0169850>] blkdev_writepage+0x0/0x30
 [<c020f5b6>] radix_tree_gang_lookup_tag+0x56/0x70
 [<c017d635>] inode_wait+0x5/0x10
 [<c033df87>] __wait_on_bit+0x67/0x70
 [<c017d630>] inode_wait+0x0/0x10
 [<c0185fa7>] __writeback_single_inode+0x137/0x170
 [<c0131460>] wake_bit_function+0x0/0x60
 [<c0131460>] wake_bit_function+0x0/0x60
 [<c01861ba>] sync_sb_inodes+0x1da/0x2f0
 [<c478>] sync_inodes_sb+0xb8/0xd0
 [<c0186525>] get_super_to_sync+0x55/0x80
 [<c01865cb>] sync_inodes+0x7b/0xa0
 [<c0162b44>] do_sync+0x44/0x80
 [<c0162b8f>] sys_sync+0xf/0x20
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
crond         S 00000008     0  6106   2059  6107               (NOTLB)
f71dfec0 00000086 f71dfeb0 00000008 00000002 f72ab360 c010176f c307b530 
       c307b6f0 f72ab360 c2d10400 f72ab360 00000040 f71de000 f7533820 f71dfefc 
       c033cb20 c2d10400 00000001 000013e4 9f469853 0000009d 00000001 f74a4080 
Call Trace:
 [<c010176f>] __switch_to+0x1f/0x1e0
 [<c033cb20>] schedule+0x370/0xd20
 [<c016e5c8>] pipe_wait+0x98/0xc0
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c016bedb>] cp_new_stat64+0xfb/0x110
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c016e837>] pipe_readv+0x1f7/0x340
 [<c016e980>] pipe_read+0x0/0x40
 [<c016e9b7>] pipe_read+0x37/0x40
 [<c01612ae>] vfs_read+0xbe/0x130
 [<c0161591>] sys_read+0x51/0x80
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
run-parts     S 00000008     0  6107   6106  7713               (NOTLB)
cd9a1f30 00000082 cd9a1f20 00000008 00000001 f744638c f753b080 c0396c00 
       c2d08400 f72ab0e0 f72ab10c f77f96fc 00000007 c01130fc f72ab0e0 f77f96fc 
       080e3c48 c2d08400 00000000 00001fbb 3234f4c7 000000a3 cd9a1fc4 f713e060 
Call Trace:
 [<c01130fc>] do_page_fault+0x19c/0x5f6
 [<c011f269>] do_wait+0x209/0x430
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c011f563>] sys_wait4+0x43/0x50
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
slocate.cron  S 00000008     0  7713   6107  7716    7714       (NOTLB)
cb515f30 00000086 cb515f20 00000008 00000002 cb32b38c cb4b0080 c307b530 
       c2d10400 cb50fa60 cb50fa8c ea813334 00000007 c01130fc cb50fa60 ea813334 
       080e3c48 c2d10400 00000001 0000484d 32f9e456 000000a3 cb515fc4 cb2e9080 
Call Trace:
 [<c01130fc>] do_page_fault+0x19c/0x5f6
 [<c011f269>] do_wait+0x209/0x430
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c011f563>] sys_wait4+0x43/0x50
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
awk           S 00000008     0  7714   6107                7713 (NOTLB)
f21b5ec0 00000082 f21b5eb0 00000008 00000003 c2881760 00000000 c307b020 
       c033ea5d cb149a80 c2881760 420d1000 f21b5ea8 f6daa080 00000001 08097844 
       c0150fc0 c2d18400 00000002 0005aa2b 325091dd 000000a3 00000001 cb2e9590 
Call Trace:
 [<c033ea5d>] _spin_unlock+0xd/0x30
 [<c0150fc0>] do_wp_page+0x210/0x330
 [<c016e5c8>] pipe_wait+0x98/0xc0
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c016e837>] pipe_readv+0x1f7/0x340
 [<c016e980>] pipe_read+0x0/0x40
 [<c016e9b7>] pipe_read+0x37/0x40
 [<c01612ae>] vfs_read+0xbe/0x130
 [<c0161591>] sys_read+0x51/0x80
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
updatedb      D 00000008     0  7716   7713                     (NOTLB)
df12de34 00000082 df12de24 00000008 00000003 00000000 df12de1c c307b020 
       c01a25c4 cb3fd320 00000001 df12de4c df12de1c df12de14 f723c9d4 c0163f53 
       f723c9d4 c2d18400 00000002 0004c479 af29bcb2 000000a3 00000002 f4ca8040 
Call Trace:
 [<c01a25c4>] ext3_get_block_handle+0xb4/0x390
 [<c0163f53>] __find_get_block+0x73/0x100
 [<c01b20b0>] start_this_handle+0x260/0x3c0
 [<c01a2b05>] ext3_getblk+0x65/0x290
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c0170f4c>] link_path_walk+0x5c/0xe0
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c01b2309>] journal_start+0xa9/0xd0
 [<c01a5f78>] ext3_dirty_inode+0x38/0x90
 [<c0185c16>] __mark_inode_dirty+0x1e6/0x1f0
 [<c012089d>] current_fs_time+0x5d/0x80
 [<c017d4b6>] update_atime+0xe6/0x110
 [<c01752bf>] vfs_readdir+0x8f/0xa0
 [<c01755c0>] filldir64+0x0/0x110
 [<c017573f>] sys_getdents64+0x6f/0xb4
 [<c01755c0>] filldir64+0x0/0x110
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
run-parts     S 00000008     0  7729   2082  7944               (NOTLB)
ce07bf30 00000082 ce07bf20 00000008 00000002 ec56a3c0 cb227080 c307b530 
       c2d10400 f762c5e0 f762c60c f74aea6c 00000007 c01130fc f762c5e0 f74aea6c 
       080f00c0 c2d10400 00000001 000105b1 6653f574 0000039e ce07bfc4 f74c4a80 
Call Trace:
 [<c01130fc>] do_page_fault+0x19c/0x5f6
 [<c011f269>] do_wait+0x209/0x430
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c011f563>] sys_wait4+0x43/0x50
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
slocate.cron  S 00000008     0  7944   7729  7947    7945       (NOTLB)
e7c17f30 00000086 e7c17f20 00000008 00000002 d68be38c cb50b080 c307b530 
       c2d10400 cb164d60 cb164d8c cb3a89bc 00000007 c01130fc cb164d60 cb3a89bc 
       080e3c48 c2d10400 00000001 000290ce 66aed4ea 0000039e e7c17fc4 c30fa060 
Call Trace:
 [<c01130fc>] do_page_fault+0x19c/0x5f6
 [<c011f269>] do_wait+0x209/0x430
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c011f563>] sys_wait4+0x43/0x50
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
awk           S 00000008     0  7945   7729                7944 (NOTLB)
ce07fec0 00000086 ce07feb0 00000008 00000004 e9ec9080 00000001 c3080a60 
       ec56b90c f74dc2c0 f74dc2c0 ec56b90c ce50b260 e9ec9080 00000001 08098234 
       ce07fed8 c2d20400 00000003 000ca4d6 667f6c17 0000039e 00000001 f756a040 
Call Trace:
 [<c016e5c8>] pipe_wait+0x98/0xc0
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c0131400>] autoremove_wake_function+0x0/0x60
 [<c016e837>] pipe_readv+0x1f7/0x340
 [<c016e980>] pipe_read+0x0/0x40
 [<c016e9b7>] pipe_read+0x37/0x40
 [<c01612ae>] vfs_read+0xbe/0x130
 [<c0161591>] sys_read+0x51/0x80
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
updatedb      D 00000008     0  7947   7944                     (NOTLB)
d0a87f30 00000086 d0a87f20 00000008 00000004 c0211ec2 bfb300a0 c3080a60 
       00000060 e9ecd0c0 00000000 c016bedb bfb300a0 d0a87ef4 00000060 000008b1 
       00000000 c2d20400 00000003 00339790 77fb5a30 0000039e 00000000 f7e22590 
Call Trace:
 [<c0211ec2>] copy_to_user+0x42/0x60
 [<c016bedb>] cp_new_stat64+0xfb/0x110
 [<c033c5c3>] __down+0x93/0xf0
 [<c0116930>] default_wake_function+0x0/0x20
 [<c033c753>] __down_failed+0x7/0xc
 [<c017578c>] .text.lock.readdir+0x8/0x1c
 [<c033ea5d>] _spin_unlock+0xd/0x30
 [<c01623d9>] fget+0x49/0x60
 [<c017573f>] sys_getdents64+0x6f/0xb4
 [<c01755c0>] filldir64+0x0/0x110
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
agetty        S 00000008     0  8243      1                6100 (NOTLB)
f704de78 00000082 f704de68 00000008 00000001 f76886d4 00100100 c0396c00 
       026b02f4 cb4db0e0 00000000 4b87ad6e c01254f0 c04a0d60 c047a380 c04a0d60 
       c0241399 c2d08400 00000000 000023de 20f1b1d2 00002523 f7e55954 f76885b0 
Call Trace:
 [<c01254f0>] process_timeout+0x0/0x10
 [<c0241399>] serial8250_stop_tx+0x79/0x80
 [<c033de75>] schedule_timeout+0xc5/0xd0
 [<c023d0ed>] uart_start+0x2d/0x50
 [<c033eaef>] _spin_unlock_irqrestore+0xf/0x30
 [<c023d6a9>] uart_write+0xc9/0xe0
 [<c0229919>] read_chan+0x279/0x700
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0116930>] default_wake_function+0x0/0x20
 [<c0223f70>] tty_write+0x1e0/0x2b0
 [<c0223d57>] tty_read+0x107/0x140
 [<c0191c9a>] dnotify_parent+0x3a/0xb0
 [<c0223c50>] tty_read+0x0/0x140
 [<c01612ae>] vfs_read+0xbe/0x130
 [<c0161591>] sys_read+0x51/0x80
 [<c0102fbb>] sysenter_past_esp+0x54/0x75
[disconnect]
robot@build:~/stp/scripts$ exit
exit

Script done on Thu Apr 21 15:12:21 2005

-- 
"Ive always gone through periods where I bolt upright at four in the morning; 
now at least theres a reason." -Michael Feldman
