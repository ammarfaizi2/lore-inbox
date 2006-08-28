Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWH1W3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWH1W3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 18:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWH1W3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 18:29:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:56976 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964854AbWH1W3X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 18:29:23 -0400
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
From: Badari Pulavarty <pbadari@gmail.com>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, "J. Bruce Fields" <bfields@fieldses.org>,
       Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <44EAD613.76E4.0078.0@novell.com>
References: <20060820013121.GA18401@fieldses.org>
	 <44E97353.76E4.0078.0@novell.com>
	 <20060821094718.79c9a31a.rdunlap@xenotime.net>
	 <20060821212043.332fdd0f.akpm@osdl.org>  <44EAD613.76E4.0078.0@novell.com>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 15:32:32 -0700
Message-Id: <1156804352.447.5.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 10:01 +0200, Jan Beulich wrote:
> >>> Andrew Morton <akpm@osdl.org> 22.08.06 06:20 >>>
> >On Mon, 21 Aug 2006 09:47:18 -0700
> >"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> >
> >> > The 'stuck' unwinder issue at hand already has a fix, though planned to
> >> > be merged for 2.6.19 only. The crash after switching to the legacy
> >> > stack trace code is bad, though, but has little to do with the unwinder
> >> > additions/changes. The way that code reads the stack is just
> >> > inappropriate in contexts where things must be expected to be broken.
> >> 
> >> "merged for 2.6.19" meaning:
> >> - in (before) 2.6.19, or
> >> - after 2.6.19 is released
> >> 
> >> If "after," then it will likely need to be added to -stable also,
> >> so it might as well go in "before" 2.6.19 is released.
> >
> >Precisely.
> 
> My understanding of 'for' is that Andi will send to Linus after in the 2.6.19
> merge window.
> 
> >Guys, this unwinder change has been quite problematic.  We really cannot
> >let this badness out into 2.6.18 - it degrades our ability to debug every
> >subsystem in the entire kernel.  Would marking it CONFIG_BROKEN get us back
> >to 2.6.17 behaviour?
> 
> I'd prefer pushing into 2.6.18 some of the patches currently scheduled for
> 2.6.19 over marking it CONFIG_BROKEN. But that's clearly not my decision.
> 
> Jan


I get into few "unwinder" issues - see following 2 cases.
(nothing really stopping my work). It gives me *useful* stacks 
than before - so no major complaints :)

I know that you are working on some of the unwinder fixes for 
2.6.19 - just want to let you know about my problems also :)

Thanks,
Badari

Case 1:
========

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/buffer.c:2791
invalid opcode: 0000 [1] SMP
CPU 1
Modules linked in: sg sd_mod qla2xxx firmware_class scsi_transport_fc
scsi_mod ipv6 thermal processor fan button battery ac dm_mod floppy
parport_pc lp parport
Pid: 4216, comm: kjournald Not tainted 2.6.18-rc4 #3
RIP: 0010:[<ffffffff80282d39>]  [<ffffffff80282d39>] submit_bh
+0x29/0x130
RSP: 0018:ffff8101bde8dd08  EFLAGS: 00010246
RAX: 0000000000000005 RBX: ffff8101bd0ad250 RCX: ffff8101df880e88
RDX: ffff8101733887c0 RSI: ffff8101bd0ad250 RDI: 0000000000000001
RBP: ffff8101bde8dd28 R08: ffff8101a033be38 R09: ffff81017605d7c0
R10: 00000000000a8f52 R11: 00000000000a8f54 R12: ffff8101a0113260
R13: 0000000000000001 R14: 0000000000000003 R15: 0000000000000080
FS:  00002b5b2e4476d0(0000) GS:ffff8101800a5140(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002b5b2e1bd000 CR3: 0000000000201000 CR4: 00000000000006e0
Process kjournald (pid: 4216, threadinfo ffff8101bde8c000, task
ffff810180259790)
Stack:  ffff810174897f70 ffff8101bd0ad250 ffff8101a0113260
000000000000004c
 ffff8101bde8dd68 ffffffff80284179 00000000bde8dd68 ffff81017441d250
 ffff8101769ee910 ffff8101dd2518c0 0000000000000080 ffff8101a0059200
Call Trace:
 [<ffffffff80284179>] ll_rw_block+0x79/0xd0
 [<ffffffff8030e868>] journal_commit_transaction+0x478/0x1170
 [<ffffffff80312c8e>] kjournald+0xde/0x290
 [<ffffffff8024562c>] kthread+0xdc/0x110
 [<ffffffff8020abe2>] child_rip+0x8/0x12
DWARF2 unwinder stuck at child_rip+0x8/0x12
Leftover inexact backtrace:
 [<ffffffff80245550>] kthread+0x0/0x110
 [<ffffffff8020abda>] child_rip+0x0/0x12


Code: 0f 0b 68 d3 e0 50 80 c2 e7 0a 48 83 7b 38 00 75 0a 0f 0b 68
RIP  [<ffffffff80282d39>] submit_bh+0x29/0x130
 RSP <ffff8101bde8dd08>
 <1>Unable to handle kernel paging request at 0000000146f4eac0 RIP:
 [<ffffffff802277b8>] task_rq_lock+0x38/0x90
PGD 1ddc2e067 PUD 0
Oops: 0000 [2] SMP

Case 2:
=======

kfree_debugcheck: bad ptr ffff8100d39ae000h.
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/slab.c:2698
invalid opcode: 0000 [1] SMP
CPU 0
Modules linked in: stap_2543 autofs4 hidp rfcomm l2cap bluetooth sunrpc
af_packet xt_state ip_conntrack nfnetlink xt_tcpudp ip6table_filter
ip6_tables x_tables ipv6 acpi_cpufreq freq_table processor binfmt_misc
parport_pc lp parport ide_cd cdrom generic floppy e752x_edac edac_mc
shpchp i2c_i801 uhci_hcd piix serio_raw ehci_hcd i2c_core pci_hotplug
usbcore dm_snapshot dm_zero dm_mirror dm_mod ide_disk ide_core
Pid: 2638, comm: fsx-linux Not tainted 2.6.18-rc4-smp #17
RIP: 0010:[<ffffffff8027de3d>]  [<ffffffff8027de3d>] kfree_debugcheck
+0x9a/0xa8
RSP: 0018:ffff81010d9ad5b8  EFLAGS: 00010096
RAX: 0000000000000030 RBX: ffff8100d39ae000 RCX: ffffffff8062daa0
RDX: 0000000000000000 RSI: 0000000000000092 RDI: 0000000100000000
RBP: ffff81010d9ad5c8 R08: 00000000000042ee R09: 0000000000000000
R10: 0000000000000092 R11: 0000000000000000 R12: ffff81010ab2dd60
R13: ffff8100d39ae000 R14: ffff8101212ddea8 R15: 0000000000000286
FS:  00002b611ab05200(0000) GS:ffffffff8069b000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002af34fee4000 CR3: 000000010b1c5000 CR4: 00000000000006e0
Process fsx-linux (pid: 2638, threadinfo ffff81010d9ac000, task
ffff81010b6a30c0)
Stack:  0000000000000000 0000000000000000 ffff81010d9ad618
ffffffff8027fbbc
 ffff81010d9ad618 ffffffff80309080 ffff81010d9ad608 0000000000000000
 ffff81010ab2dd60 ffff81010da6d928 ffff8101212ddea8 0000000000000000
Call Trace:
 [<ffffffff8027fbbc>] kfree+0x26/0x1f2
 [<ffffffff80304110>] do_get_write_access+0x52e/0x54f
 [<ffffffff803051a3>] journal_get_undo_access+0x2e/0x118
 [<ffffffff802f0a0c>] ext3_try_to_allocate_with_rsv+0x4b/0x504
 [<ffffffff802f117e>] ext3_new_blocks+0x2b9/0x74e
 [<ffffffff802f46d3>] ext3_get_blocks_handle+0x467/0xac4
 [<ffffffff802f5095>] ext3_get_block+0xc4/0xec
 [<ffffffff8028795c>] __block_prepare_write+0x1bf/0x41e
 [<ffffffff80287bdd>] block_prepare_write+0x22/0x30
 [<ffffffff802f660f>] ext3_prepare_write+0xb5/0x185
 [<ffffffff8025fbc3>] generic_file_buffered_write+0x2c7/0x6b7
 [<ffffffff80260298>] __generic_file_aio_write_nolock+0x2e5/0x331
 [<ffffffff8026034d>] generic_file_aio_write+0x69/0xc4
 [<ffffffff802f21a6>] ext3_file_write+0x1e/0x9b
 [<ffffffff80284804>] do_sync_write+0xf0/0x12e
 [<ffffffff80285197>] vfs_write+0xcf/0x175
 [<ffffffff8028577f>] sys_write+0x47/0x70
 [<ffffffff8020988e>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83
Leftover inexact backtrace:


Code: 0f 0b 68 ae 3c 4a 80 c2 8a 0a 58 5b c9 c3 55 48 89 e5 41 57
RIP  [<ffffffff8027de3d>] kfree_debugcheck+0x9a/0xa8
 RSP <ffff81010d9ad5b8>
 <3>BUG: sleeping function called from invalid context at
kernel/rwsem.c:20
in_atomic():0, irqs_disabled():1

Call Trace:
 [<ffffffff8020ad7f>] show_trace+0xae/0x30e
 [<ffffffff8020aff4>] dump_stack+0x15/0x17
 [<ffffffff802288a5>] __might_sleep+0xb2/0xb4
 [<ffffffff8024750e>] down_read+0x1d/0x2f
 [<ffffffff8023e674>] blocking_notifier_call_chain+0x1b/0x41
 [<ffffffff80232511>] profile_task_exit+0x15/0x17
 [<ffffffff80233f95>] do_exit+0x25/0x91e
 [<ffffffff8020b222>] kernel_math_error+0x0/0x96
 [<ffff81010b6a30c0>]
DWARF2 unwinder stuck at 0xffff81010b6a30c0
Leftover inexact backtrace:
 [<ffffffff80471079>] do_trap+0xe0/0xef
 [<ffffffff8020b82d>] do_invalid_op+0xa7/0xb3
 [<ffffffff8027de3d>] kfree_debugcheck+0x9a/0xa8
 [<ffffffff804707db>] _spin_unlock_irq+0x9/0xc
 [<ffffffff8046e95e>] thread_return+0x5e/0xef
 [<ffffffff8020a55d>] error_exit+0x0/0x84
 [<ffffffff8027de3d>] kfree_debugcheck+0x9a/0xa8
 [<ffffffff8027de3d>] kfree_debugcheck+0x9a/0xa8
 [<ffffffff8027fbbc>] kfree+0x26/0x1f2
 [<ffffffff80309080>] journal_cancel_revoke+0x137/0x1ac
 [<ffffffff80304110>] do_get_write_access+0x52e/0x54f
 [<ffffffff80244b7f>] wake_bit_function+0x0/0x2a
 [<ffffffff80286ca7>] __find_get_block+0x171/0x183
 [<ffffffff803051a3>] journal_get_undo_access+0x2e/0x118
 [<ffffffff802f0a0c>] ext3_try_to_allocate_with_rsv+0x4b/0x504
 [<ffffffff80286cf2>] __getblk+0x39/0x25c
 [<ffffffff80288592>] __bread+0xe/0xb5
 [<ffffffff802f117e>] ext3_new_blocks+0x2b9/0x74e
 [<ffffffff802f46d3>] ext3_get_blocks_handle+0x467/0xac4
 [<ffffffff8028613f>] alloc_buffer_head+0x19/0x40
 [<ffffffff8027dd28>] cache_alloc_debugcheck_after+0x1a5/0x1b4
 [<ffffffff8028613f>] alloc_buffer_head+0x19/0x40
 [<ffffffff8027ef82>] kmem_cache_alloc+0xbe/0xca
 [<ffffffff802f5095>] ext3_get_block+0xc4/0xec
 [<ffffffff8028795c>] __block_prepare_write+0x1bf/0x41e
 [<ffffffff802f4fd1>] ext3_get_block+0x0/0xec
 [<ffffffff80287bdd>] block_prepare_write+0x22/0x30
 [<ffffffff802f660f>] ext3_prepare_write+0xb5/0x185
 [<ffffffff80470693>] _write_unlock_irq+0x9/0xc
 [<ffffffff8025fbc3>] generic_file_buffered_write+0x2c7/0x6b7
 [<ffffffff8029e15d>] touch_atime+0x6b/0xaa
 [<ffffffff80236172>] current_fs_time+0x3f/0x41
 [<ffffffff8025f059>] do_generic_mapping_read+0x42e/0x47a
 [<ffffffff80260298>] __generic_file_aio_write_nolock+0x2e5/0x331
 [<ffffffff8026034d>] generic_file_aio_write+0x69/0xc4
 [<ffffffff802f21a6>] ext3_file_write+0x1e/0x9b
 [<ffffffff80284804>] do_sync_write+0xf0/0x12e
 [<ffffffff80244b47>] autoremove_wake_function+0x0/0x38
 [<ffffffff8046f59e>] mutex_lock+0x22/0x32
 [<ffffffff80285197>] vfs_write+0xcf/0x175
 [<ffffffff8028577f>] sys_write+0x47/0x70
 [<ffffffff8020988e>] system_call+0x7e/0x83


