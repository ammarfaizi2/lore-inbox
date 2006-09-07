Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWIGG72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWIGG72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 02:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWIGG72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 02:59:28 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:30874 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1161066AbWIGEcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 00:32:18 -0400
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [Problem] System hang when I run pounder and syscall test on kernel 2.6.18-rc5
X-Mailer: Lotus Notes Release 7.0 August 18, 2005
Message-ID: <OF9B5F5146.C2CBBAE0-ON482571E2.001911F0-482571E2.0018E74C@cn.ibm.com>
From: Shu Qing Yang <yangshuq@cn.ibm.com>
Date: Thu, 7 Sep 2006 12:35:09 +0800
X-MIMETrack: Serialize by Router on D23M0037/23/M/IBM(Release 7.0HF124 | January 12, 2006) at
 09/07/2006 12:35:10,
	Serialize complete at 09/07/2006 12:35:10
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem description:
    I run pounder, scsi_debug on a machine. Then start 200 random syscall 
test 
simultaneously. Tens of minutes later, the system hang.

Hardware Environment
    Cpu type :power5+
Software Env:
    kernel: 2.6.18-rc5
    Base system: opensuse10

Is the system (not just the application) hung?
    Yes

Did the system produce an OOPS message on the console?
    No.

Is the system sitting in a debugger right now?
    Yes, xmon and sysrq are on.

Additional information:
    I use 'sysrq + t' then force system into xmon. And get following 
message:
<4>Call Trace:.
<4>[C000000046977160] [C000000046977200] 0xc000000046977200 (unreliable).
<4>[C000000046977330] [C00000000000FF24] .__switch_to+0x12c/0x150.
<4>[C0000000469773C0] [C00000000052D94C].schedule+0xa38/0xb84.
<4>[C0000000469774C0] [C000000000179E0C].start_this_handle+0x32c/0x5c4.
<4>[C0000000469775E0] [C00000000017A180] .journal_start+0xdc/0x130.
<4>[C000000046977680] [C000000000170490] .ext3_journal_start_sb+0x58/0x78.
<4>[C000000046977700] [C000000000169D14] .ext3_dirty_inode+0x38/0xec.
<4>[C000000046977790] [C0000000000F7174] .__mark_inode_dirty+0x64/0x1d8.
<4>[C000000046977830] [C0000000000EB674] .touch_atime+0xc8/0xe0.
<4>[C0000000469778C0] [C00000000009B8EC] 
.do_generic_mapping_read+0x470/0x4fc.
<4>[C000000046977A10] 
[C00000000009C4A4].__generic_file_aio_read+0x184/0x22c.
<4>[C000000046977AE0] [C00000000009C640] .generic_file_aio_read+0x44/0x54.
<4>[C000000046977B70] [C0000000000C874C] .do_sync_read+0xd4/0x130.
<4>[C000000046977CF0] [C0000000000C9410] .vfs_read+0xd0/0x1b4.
<4>[C000000046977D90] [C0000000000C98F0] .sys_read+0x4c/0x8c.
<4>[C000000046977E30] [C00000000000871C] syscall_exit+0x0/0x40.
<3>BUG: soft lockup detected on CPU#0!.
<4>Call Trace:.
<4>[C0000000228B3B90] [C00000000000F7F0] 
.show_stack+0x68/0x1b0(unreliable).
<4>[C0000000228B3C30] [C000000000094834] .softlockup_tick+0xec/0x124.
<4>[C0000000228B3CD0] [C0000000000686DC] .run_local_timers+0x1c/0x30.
<4>[C0000000228B3D50] [C000000000021AD4].timer_interrupt+0xa8/0x47c.
<4>[C0000000228B3E30] [C0000000000034EC] decrementer_common+0xec/0x100.
<3>BUG: softlockup detectedon CPU#3!.
<4>Call Trace:.
<4>[C000000033BEE620][C00000000000F7F0] .show_stack+0x68/0x1b0 
(unreliable).
<4>[C000000033BEE6C0] [C000000000094834].softlockup_tick+0xec/0x124.
<4>[C000000033BEE760] [C0000000000686DC] .run_local_timers+0x1c/0x30.
<4>[C000000033BEE7E0] [C000000000021AD4] .timer_interrupt+0xa8/0x47c.
<4>[C000000033BEE8C0] [C0000000000034EC] decrementer_common+0xec/0x100.
<4>--- Exception: 901 at .hpte_update+0x158/0x1d0.
<4> LR = .page_referenced_one+0xd8/0x188.
<4>[C000000033BEEBB0][C0000000000B4244] .page_check_address+0xcc/0x16c 
(unreliable).
<4>[C000000033BEEC50] [C0000000000B4418] .page_referenced_one+0xd8/0x188.
<4>[C000000033BEED00] [C0000000000B5480] .page_referenced+0x90/0x180.
<4>[C000000033BEEDB0] [C0000000000A6908] 
.shrink_inactive_list+0x1d8/0xa0c.
<4>[C000000033BEF020] [C0000000000A7248] .shrink_zone+0x10c/0x168.
<4>[C000000033BEF0C0][C0000000000A7FE8] .try_to_free_pages+0x1c8/0x320.
<4>[C000000033BEF1D0] [C0000000000A1954] .__alloc_pages+0x1ec/0x344.
<4>[C000000033BEF2C0] [C00000000009DE34].find_or_create_page+0x8c/0x10c.
<4>[C000000033BEF370] [C0000000000CBA78] .__getblk+0x130/0x2d0.
<4>[C000000033BEF420] [C0000000001672F0] .ext3_getblk+0xd8/0x2b0.
<4>[C000000033BEF520] [C00000000016CC54] .ext3_find_entry+0x344/0x608.
<4>[C000000033BEF6C0] [C00000000016EB54] .ext3_lookup+0x44/0x178.
<4>[C000000033BEF760] [C0000000000DB620].do_lookup+0xfc/0x22c.
<4>[C000000033BEF820] [C0000000000DDD9C] .__link_path_walk+0xb60/0x121c.
<4>[C000000033BEF8F0] [C0000000000DE4F4] .link_path_walk+0x9c/0x184.
<4>[C000000033BEFA30] [C0000000000DEAB8] .do_path_lookup+0x304/0x398.
<4>[C000000033BEFAE0] 
[C0000000000DF728].__path_lookup_intent_open+0x70/0xd0.
<4>[C000000033BEFB90] [C0000000000DF974] .open_namei+0x94/0x820.
<4>[C000000033BEFC60] [C0000000000C6D20] .do_filp_open+0x38/0x70.
<4>[C000000033BEFD80] [C0000000000C6DCC] .do_sys_open+0x74/0x130.
<4>[C000000033BEFE30] [C00000000000871C]syscall_exit+0x0/0x40.
<3>BUG: soft lockup detected on CPU#5!.
<4>Call Trace:.
<4>[C00000005AB73B90] [C00000000000F7F0] .show_stack+0x68/0x1b0 
(unreliable).
<4>[C00000005AB73C30] [C000000000094834] .softlockup_tick+0xec/0x124.
<4>[C00000005AB73CD0] [C0000000000686DC] .run_local_timers+0x1c/0x30.
<4>[C00000005AB73D50] [C000000000021AD4] .timer_interrupt+0xa8/0x47c.
<4>[C00000005AB73E30] [C0000000000034EC]decrementer_common+0xec/0x100.
<3>BUG: soft lockup detected on CPU#2!.
<4>Call Trace:.
<4>[C0000000228B7B90] [C00000000000F7F0] .show_stack+0x68/0x1b0 
(unreliable).
<4>[C0000000228B7C30] [C000000000094834] .softlockup_tick+0xec/0x124.
<4>[C0000000228B7CD0] [C0000000000686DC].run_local_timers+0x1c/0x30.
<4>[C0000000228B7D50] [C000000000021AD4] .timer_interrupt+0xa8/0x47c.
<4>[C0000000228B7E30] [C0000000000034EC] decrementer_common+0xec/0x100.
<3>BUG:soft lockup detected on CPU#4!.
<4>Call Trace:.
<4>[C0000000531FBB90] [C00000000000F7F0] .show_stack+0x68/0x1b0 
(unreliable).
<4>[C0000000531FBC30][C000000000094834] .softlockup_tick+0xec/0x124.
<4>[C0000000531FBCD0] [C0000000000686DC] .run_local_timers+0x1c/0x30.
<4>[C0000000531FBD50] [C000000000021AD4] .timer_interrupt+0xa8/0x47c.
<4>[C0000000531FBE30][C0000000000034EC] decrementer_common+0xec/0x100.

---------------------------
3:mon> t
[c00000000ffe3c30] c0000000002f122c .__handle_sysrq+0xf0/0x1cc
[c00000000ffe3ce0] c0000000002f3658 .hvc_poll+0x198/0x2cc
[c00000000ffe3dc0] c0000000002f37a0 .hvc_handle_interrupt+0x14/0x34
[c00000000ffe3e40] c000000000094c04 .handle_IRQ_event+0x7c/0xf8
[c00000000ffe3ef0] c000000000096b74 .handle_fasteoi_irq+0xe4/0x188
[c00000000ffe3f90] c000000000025130 .call_handle_irq+0x1c/0x2c
[c00000005b47bda0] c00000000000c78c .do_IRQ+0xf4/0x1a4
[c00000005b47be30] c0000000000041ec hardware_interrupt_entry+0xc/0x10
--- Exception: 501 (Hardware Interrupt) at 0000000010002524
SP (ffff99cea70) is in userspace
3:mon> e
cpu 0x3: Vector: 0  at [c00000000ffe3a30]
    pc: c00000000004b134: .sysrq_handle_xmon+0x48/0x60
    lr: c00000000004b134: .sysrq_handle_xmon+0x48/0x60
    sp: c00000000ffe3ba0
   msr: 8000000000001032
  current = 0xc000000002e235f0
  paca    = 0xc0000000006b4900
    pid   = 16858, comm = waitpid13
3:mon> r
R00 = 0000000000000000   R16 = 0000000000000000
R01 = c00000000ffe3ba0   R17 = 0000000000000000
R02 = c000000000909c00   R18 = 0000000000000000
R03 = c00000000ffe3a30   R19 = 0000000000000000
R04 = c0000000009a4eb0   R20 = 0000000000000000
R05 = c0000000009a4ee0   R21 = 0000000000000000
R06 = c0000000008abec0   R22 = 0000000000000000
R07 = c0000000008ac148   R23 = 8000000000001032
R08 = c0000000008ac130   R24 = 8000000000001032
R09 = c0000000008ac178   R25 = c0000000038dee70
R10 = c0000000008ac160   R26 = 0000000000000000
R11 = 0000000000000000   R27 = 0000000000000078
R12 = c0000000009a4eb8   R28 = 0000000000000007
R13 = c0000000006b4900   R29 = 0000000000000000
R14 = 0000000000000000   R30 = c000000000780668
R15 = 0000000000000000   R31 = c00000000ffe3a30
pc  = c00000000004b134 .sysrq_handle_xmon+0x48/0x60
lr  = c00000000004b134 .sysrq_handle_xmon+0x48/0x60
msr = 8000000000001032   cr  = 28000428
ctr = c00000000004f0e4   xer = 000000000000000f   trap =    0
3:mon> c
cpus stopped: 0-5
3:mon> c0
0:mon> e
cpu 0x0: Vector: 501 (Hardware Interrupt) at [c0000000228b3ea0]
    pc: 0000000010002524
    lr: 0000000010002570
    sp: ffff99cea70
   msr: 800000000000d032
  current = 0xc000000002e25770
  paca    = 0xc0000000006b4300
    pid   = 16866, comm = waitpid13
0:mon> t
SP (ffff99cea70) is in userspace
0:mon> c1
1:mon> e
cpu 0x1: Vector: 501 (Hardware Interrupt) at [c000000059f89ed0]
    pc: c0000000000a4780: .release_pages+0xac/0x260
    lr: c0000000000a5138: .__pagevec_release+0x28/0x48
    sp: c000000059f8a150
   msr: 8000000000009032
  current = 0xc00000005f2b66b0
  paca    = 0xc0000000006b4500
    pid   = 16704, comm = shmctl01
1:mon> t
[c000000059f8a280] c0000000000a5138 .__pagevec_release+0x28/0x48
[c000000059f8a310] c0000000000a7074 .shrink_inactive_list+0x944/0xa0c
[c000000059f8a580] c0000000000a7248 .shrink_zone+0x10c/0x168
[c000000059f8a620] c0000000000a7fe8 .try_to_free_pages+0x1c8/0x320
[c000000059f8a730] c0000000000a1954 .__alloc_pages+0x1ec/0x344
[c000000059f8a820] c00000000009de34 .find_or_create_page+0x8c/0x10c
[c000000059f8a8d0] c0000000000cba78 .__getblk+0x130/0x2d0
[c000000059f8a980] c0000000000ce1e0 .__bread+0x20/0x124
[c000000059f8aa10] c000000000166280 .ext3_get_branch+0xa4/0x158
[c000000059f8aac0] c000000000166620 .ext3_get_blocks_handle+0xf8/0xcf0
[c000000059f8aca0] c0000000001675cc .ext3_get_block+0x104/0x14c
[c000000059f8ad50] c0000000000cef64 .block_read_full_page+0x12c/0x390
[c000000059f8b220] c0000000000f81bc .do_mpage_readpage+0x5cc/0x63c
[c000000059f8b720] c0000000000f882c .mpage_readpages+0xf0/0x1b4
[c000000059f8b8c0] c000000000166450 .ext3_readpages+0x28/0x40
[c000000059f8b940] c0000000000a3c10 .__do_page_cache_readahead+0x194/0x2f0
[c000000059f8ba90] c00000000009e01c .filemap_nopage+0x168/0x460
[c000000059f8bb60] c0000000000ace18 .__handle_mm_fault+0x544/0xee4
[c000000059f8bc50] c00000000002db24 .do_page_fault+0x408/0x5e8
[c000000059f8be30] c0000000000048e0 .handle_page_fault+0x20/0x54
--- Exception: 301 (Data Access) at 000004000000f4e0
SP (ffffd36e400) is in userspace
1:mon> c2
2:mon> t
SP (ffff99cea70) is in userspace
2:mon> c4
4:mon> t
SP (ffff99cea70) is in userspace
4:mon> e
cpu 0x4: Vector: 501 (Hardware Interrupt) at [c0000000531fbea0]
    pc: 0000000010002524
    lr: 0000000010002570
    sp: ffff99cea70
   msr: 800000000000d032
  current = 0xc000000022f7b9f0
  paca    = 0xc0000000006b4b00
    pid   = 16863, comm = waitpid13
4:mon> c5
5:mon> e
cpu 0x5: Vector: 501 (Hardware Interrupt) at [c00000005ab73ea0]
    pc: 0000000010002534
    lr: 0000000010002570
    sp: ffff99cea70
   msr: 800000000000d032
  current = 0xc00000001265b390
  paca    = 0xc0000000006b4d00
    pid   = 16862, comm = waitpid13
5:mon> t
SP (ffff99cea70) is in userspace
5:mon> c2
2:mon> e
cpu 0x2: Vector: 501 (Hardware Interrupt) at [c0000000228b7ea0]
    pc: 0000000010002524
    lr: 0000000010002570
    sp: ffff99cea70
   msr: 800000000000d032
  current = 0xc00000001b7daab0
  paca    = 0xc0000000006b4700
    pid   = 16867, comm = waitpid13
2:mon> t
SP (ffff99cea70) is in userspace
2:mon>
Best Regards,

Shu Qing Yang
---------------------------
LTC Test, Linux Technology Center, China Systems & Technology Lab


