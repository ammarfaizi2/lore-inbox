Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263773AbTCVC1s>; Fri, 21 Mar 2003 21:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263775AbTCVC1s>; Fri, 21 Mar 2003 21:27:48 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:7993
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263773AbTCVC1q>; Fri, 21 Mar 2003 21:27:46 -0500
Date: Fri, 21 Mar 2003 21:35:37 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7(censored) dying horribly in 2.5.65-mm2
In-Reply-To: <Pine.LNX.4.50.0303212042000.28519-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303212048200.28519-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303210202080.2133-100000@montezuma.mastecende.com>
 <411800000.1048276482@aslan.btc.adaptec.com>
 <Pine.LNX.4.50.0303211842370.28519-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0303212042000.28519-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, please disregard that last oops i looked at the version numbers 
and they can't have been right. i don't think i booted the right image.

Here are some oopses with 6.2.30, there does appear to be a relation wrt 
interrupt routing because if i boot with noapic it passes the boot test 
and appears to be functional. If you have any more suggestions please send 
them my way, i shall also be trying a number of things.

Cheers,
	Zwane

0xc02ff2dc is in ahc_linux_run_complete_queue 
(drivers/scsi/aic7xxx/aic7xxx_osm.c:687).
682                      || (cmd->result & 0xFF) != SCSI_STATUS_OK)
683                             with_errors++;
684
685                     cmd->scsi_done(cmd); <===
686
687                     if (with_errors > AHC_LINUX_MAX_RETURNED_ERRORS) {


Bringing up loopback interface:  Unable to handle kernel paging request at virtual address 6b6b6b6b
*pde = 00000000
Oops: 0000 [#1]
CPU:    2
EIP:    0060:[<6b6b6b6b>]    Not tainted
EFLAGS: 00010002 VLI
EIP is at 0x6b6b6b6b
eax: c168da10   ebx: 00000000   ecx: cbe32290   edx: 00000000
esi: 00000001   edi: cb10dcac   ebp: 00000005   esp: cb10dc2c
ds: 007b   es: 007b   ss: 0068
Process ifup-routes (pid: 317, threadinfo=cb10c000 task=cbaa5360)
Stack: c02ff2dc c168da10 c168da10 cbe32290 c0305807 cbe32290 c168da10 00000296 
       cb10dcac c04a3dcc cbffe4f4 04000001 c010bb0d 00000005 cbe32290 cb10dcac 
       c05060a0 cb10c000 cb10c000 00000005 c010be49 00000005 cb10dcac cbffe4f4 
Call Trace:
 [<c02ff2dc>] ahc_linux_run_complete_queue+0x3c/0x50
 [<c0305807>] ahc_linux_isr+0x1d7/0x3a0
 [<c010bb0d>] handle_IRQ_event+0x2d/0x50
 [<c010be49>] do_IRQ+0x109/0x210
 [<c010a398>] common_interrupt+0x18/0x20
 [<c011ef53>] .text.lock.sched+0x10f/0x12c
 [<c011c5c0>] schedule+0x320/0x610
 [<c0119d80>] do_page_fault+0x210/0x47a
 [<c01a80b6>] do_get_write_access+0x5d6/0x720
 [<c011c900>] default_wake_function+0x0/0x20
 [<c015e2a4>] __bread+0x14/0x30
 [<c01a8249>] journal_get_write_access+0x49/0x70
 [<c019efd0>] ext3_reserve_inode_write+0x50/0xb0
 [<c01a7421>] get_transaction+0x91/0x100
 [<c019f048>] ext3_mark_inode_dirty+0x18/0x40
 [<c019f1ba>] ext3_dirty_inode+0x14a/0x180
 [<c017e7f3>] __mark_inode_dirty+0x143/0x150
 [<c0177fb5>] update_atime+0xb5/0xc0
 [<c013c79e>] __generic_file_aio_read+0x18e/0x1d0
 [<c013c4d0>] file_read_actor+0x0/0x140
 [<c013c821>] generic_file_aio_read+0x41/0x60
 [<c015b2cd>] do_sync_read+0x7d/0xb0
 [<c0110c56>] old_mmap+0xe6/0x140
 [<c015b3b1>] vfs_read+0xb1/0x1b0
 [<c015b73a>] sys_read+0x2a/0x40
 [<c0109477>] syscall_call+0x7/0xb

Code:  Bad EIP value.
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

-- 
function.linuxpower.ca
