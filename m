Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVBJCAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVBJCAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 21:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVBJCAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 21:00:55 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:61826 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262008AbVBJCAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 21:00:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16906.49203.328885.266125@wombat.chubb.wattle.id.au>
Date: Thu, 10 Feb 2005 13:00:19 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
CC: akbm@osdl.org, dsw@gelato.unsw.edu.au
Subject: JBD problems in linux 2.6.11 rc3
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On a 12-way IA64, with ext3 filesystem on an Ramdisk, when attempting
to run the disk I/O load of OSDL's aim-7 benchmark, I see an oops when
the multiprogramming level reaches around 200.

Turning on CONFIG_JBD_DEBUG shows:

Assertion failure in __journal_file_buffer() at
/home/dsw/LCA/linux-2.6.11-rc2/fs/jbd/transaction.c:1913: "jh->b_jlist < 9"
kernel BUG at/home/dsw/LCA/linux-2.6.11-rc2/fs/jbd/transaction.c:1913!
kjournald[1483]: bugcheck! 0 [1]
Modules linked in: tg3
Pid: 1483, CPU 9, comm:            kjournald
psr : 0000101008026018 ifs : 8000000000000590 ip  : [<a0000001001d37c0>]    Not tainted
ip is at __journal_file_buffer+0x380/0x6c0
unat: 0000000000000000 pfs : 0000000000000590 rsc : 0000000000000003
rnat: 0009804c8a70033f bsps: 0000000000000000 pr  : 0000000000006941
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001001d37c0 b6  : a0000001005f95e0 b7  : a00000010041b1e0
f6  : 0fffbccccccccc8c00000 f7  : 0ffd9a200000000000000
f8  : 0ffff8000000000000000 f9  : 10002a000000000000000
f10 : 0fffbccccccccc8c00000 f11 : 1003e0000000000000000
r1  : a000000100a60ad0 r2  : 0000000000004000 r3  : 0000000000004000
r8  : 0000000000000048 r9  : 0000000000000001 r10 : 0000000000000000
r11 : a000000100875e78 r12 : e0000040f0e97b10 r13 : e0000040f0e90000
r14 : a0000001007b7b30 r15 : a000000100875e50 r16 : a000000100873bf8
r17 : 0000000000000000 r18 : a000000100875e44 r19 : a0000001007b7b30
r20 : a000000100860d38 r21 : 0000000000000001 r22 : c0000f0000019000
r23 : 0000000000000005 r24 : 0000000000000060 r25 : 0000000000000000
r26 : 0000000011000040 r27 : 0000001008026018 r28 : a0000001008a01ce
r29 : 000000000001f05e r30 : 0000000000000000 r31 : a000000100875e20

Call Trace:
 [<a00000010000f3a0>] show_stack+0x80/0xa0
                                sp=e0000040f0e976d0
				bsp=e0000040f0e910f0
 [<a00000010000fc00>] show_regs+0x7e0/0x800
                                sp=e0000040f0e978a0
				bsp=e0000040f0e91090
 [<a0000001000335f0>] die+0x150/0x1c0
                                sp=e0000040f0e978b0
				bsp=e0000040f0e91050
 [<a0000001000336a0>] die_if_kernel+0x40/0x60
                                sp=e0000040f0e978b0
				bsp=e0000040f0e91020
 [<a0000001000338e0>] ia64_bad_break+0x220/0x340
                                sp=e0000040f0e978b0
				bsp=e0000040f0e90ff0
 [<a00000010000a780>] ia64_leave_kernel+0x0/0x260
                                sp=e0000040f0e97940
				bsp=e0000040f0e90ff0
 [<a0000001001d37c0>] __journal_file_buffer+0x380/0x6c0
                                sp=e0000040f0e97b10
				bsp=e0000040f0e90f70
 [<a0000001001d7390>] journal_commit_transaction+0x2df0/0x3220
                                sp=e0000040f0e97b10
				bsp=e0000040f0e90e70
 [<a0000001001dd610>] kjournald+0x270/0x760
                                sp=e0000040f0e97d80
				bsp=e0000040f0e90e00
 [<a000000100011410>] kernel_thread_helper+0xd0/0x100
                                sp=e0000040f0e97e30
				bsp=e0000040f0e90dd0
 [<a0000001000090e0>] start_kernel_thread+0x20/0x40
                                sp=e0000040f0e97e30
				bsp=e0000040f0e90dd0
 kernel BUG at /home/dsw/LCA/linux-2.6.11-rc2/kernel/timer.c:416!
reaim[14320]: bugcheck! 0 [2]
Modules linked in: tg3

Pid: 14320, CPU 11, comm:                reaim
psr : 0000101008022018 ifs : 800000000000048c ip  : [<a00000010009f010>]    Not tainted 
ip is at cascade+0xf0/0x100
unat: 0000000000000000 pfs : 000000000000048c rsc : 0000000000000003
rnat: eba873c37e000000 bsps: 0000000000010009 pr  : 0010a1015966a9a5
ldrs: 0000000000000000 ccv : 0000000000000004 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a00000010009f010 b6  : a000000100003320 b7  : a0000001000bbd40
f6  : 1003e8080808080808081 f7  : 1003e0000000000000180
f8  : 1003e0000000000001200 f9  : 1003e00000000000023dc
f10 : 1003e000000000e580000 f11 : 1003e00000000356f424c
r1  : a000000100a60ad0 r2  : 0000000000000000 r3  : 0000000000004000
r8  : 0000000000000041 r9  : a0000001007b7b30 r10 : a0000001007b7b30
r11 : 000000000000000b r12 : e0000000165afa70 r13 : e0000000165a8000
r14 : 0000000000000004 r15 : a0000001007b7b30 r16 : e0000000165a8d74
r17 : e00000007ab67de8 r18 : 0000000000000000 r19 : 0000000000000014
r20 : 0000000000000000 r21 : 0000000000000004 r22 : 0000000000000004
r23 : 0000000000000004 r24 : 0000000000000004 r25 : 0000000000000001
r26 : 0000000000000001 r27 : 0000000000000000 r28 : 0000000000000000
r29 : 0000000000000004 r30 : e0000000165a8d70 r31 : e0000000165a802c

Call Trace:
 [<a00000010000f3a0>] show_stack+0x80/0xa0
                                sp=e0000000165af630
				bsp=e0000000165a95c0
 [<a00000010000fc00>] show_regs+0x7e0/0x800
                                sp=e0000000165af800
				bsp=e0000000165a9560
 [<a0000001000335f0>] die+0x150/0x1c0
                                sp=e0000000165af810
				bsp=e0000000165a9520
 [<a0000001000336a0>] die_if_kernel+0x40/0x60
                                sp=e0000000165af810
				bsp=e0000000165a94f0
 [<a0000001000338e0>] ia64_bad_break+0x220/0x340
                                sp=e0000000165af810
				bsp=e0000000165a94c8
 [<a00000010000a780>] ia64_leave_kernel+0x0/0x260
                                sp=e0000000165af8a0
				bsp=e0000000165a94c8
 [<a00000010009f010>] cascade+0xf0/0x100
                                sp=e0000000165afa70
				bsp=e0000000165a9468
 [<a00000010009ffb0>] run_timer_softirq+0x370/0x460
                                sp=e0000000165afa70
				bsp=e0000000165a93d8
 [<a000000100095740>] __do_softirq+0x200/0x240
                                sp=e0000000165afa90
				bsp=e0000000165a9338
 [<a000000100095800>] do_softirq+0x80/0xe0
                                sp=e0000000165afa90
				bsp=e0000000165a92d8
 [<a000000100095a40>] irq_exit+0x80/0xa0
                                sp=e0000000165afa90
				bsp=e0000000165a92c0
 [<a00000010000e3f0>] ia64_handle_irq+0x110/0x140
                                sp=e0000000165afa90
				bsp=e0000000165a9288
 [<a00000010000a780>] ia64_leave_kernel+0x0/0x260
                                sp=e0000000165afa90
				bsp=e0000000165a9288
 [<a000000100009120>] ia64_spinlock_contention+0x20/0x60
                                sp=e0000000165afc60
				bsp=e0000000165a9288
 [<a0000001005f95e0>] _spin_lock+0x40/0x60
                                sp=e0000000165afc60
				bsp=e0000000165a9280
 [<a0000001001d0330>] journal_dirty_data+0x1b0/0x760
                                sp=e0000000165afc60
				bsp=e0000000165a9230
 [<a0000001001af1d0>] ext3_journal_dirty_data+0x30/0xa0
                                sp=e0000000165afc60
				bsp=e0000000165a9200
 [<a0000001001aee00>] walk_page_buffers+0x160/0x180
                                sp=e0000000165afc60
				bsp=e0000000165a9180
 [<a0000001001af3d0>] ext3_ordered_commit_write+0x70/0x180
                                sp=e0000000165afc60
				bsp=e0000000165a9128
 [<a0000001000d5a60>] generic_file_buffered_write+0x520/0xca0
                                sp=e0000000165afc60
				bsp=e0000000165a9030
 [<a0000001000d6600>] __generic_file_aio_write_nolock+0x420/0x6e0
                                sp=e0000000165afd10
				bsp=e0000000165a8fb8
 [<a0000001000d6d70>] generic_file_aio_write+0xd0/0x240
                                sp=e0000000165afd30
				bsp=e0000000165a8f60
 [<a0000001001a9820>] ext3_file_write+0x60/0x220
                                sp=e0000000165afd40
				bsp=e0000000165a8f28
 [<a00000010011c410>] do_sync_write+0x130/0x180
                                sp=e0000000165afd40
				bsp=e0000000165a8ee8
 [<a00000010011c630>] vfs_write+0x1d0/0x2a0
                                sp=e0000000165afe20
				bsp=e0000000165a8ea0
 [<a00000010011c860>] sys_write+0x80/0xe0
                                sp=e0000000165afe20
				bsp=e0000000165a8e20
 [<a00000010000a600>] ia64_ret_from_syscall+0x0/0x20
                                sp=e0000000165afe30
				bsp=e0000000165a8e20
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
 

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
