Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTBEU5d>; Wed, 5 Feb 2003 15:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTBEU5d>; Wed, 5 Feb 2003 15:57:33 -0500
Received: from mail017.syd.optusnet.com.au ([210.49.20.175]:11401 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S264919AbTBEU5b> convert rfc822-to-8bit; Wed, 5 Feb 2003 15:57:31 -0500
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: kernel panic with anticipatory i/o scheduler 2.5.59-mm8
Date: Thu, 6 Feb 2003 08:06:40 +1100
User-Agent: KMail/1.5
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200302060806.53976.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tried to run contest on 2.5.59-mm8 with the anticipatory i/o scheduler out of 
the experimental directory patched in and got this:

Unable to handle kernel NULL pointer dereference at virtual address 00000016
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0263ea0>]    Not tainted
EFLAGS: 00010046
EIP is at ide_multwrite+0xa0/0x100
eax: 00000000   ebx: 00000001   ecx: ce5fb000   edx: 00000000
esi: c12a2da4   edi: 00000008   ebp: 00000008   esp: cd167c1c
ds: 007b   es: 007b   ss: 0068
Process contest (pid: 2171, threadinfo=cd166000 task=cec90d00)
Stack: 00000001 c1328c70 c12a2e2c c040b56c 00000008 c02645db c040b56c 00000010
       c040b56c c0263f00 00002710 00000000 c040b56c 010829d5 c1328be8 c040b6b0
       c12a2d60 c1328be8 0040b6b0 408854e8 c025a58b cd167c94 c040b56c c025a5e8
Call Trace:
 [<c02645db>] do_rw_disk+0x5cf/0x6d4
 [<c0263f00>] multwrite_intr+0x0/0xc0
 [<c025a58b>] start_request+0x97/0x150
 [<c025a5e8>] start_request+0xf4/0x150
 [<c025a960>] ide_do_request+0x2dc/0x33c
 [<c025a9d2>] do_ide_request+0x12/0x18
 [<c0248695>] generic_unplug_device+0x49/0x68
 [<c0248818>] blk_run_queues+0x88/0xb8
 [<c013b77f>] __wait_on_buffer+0x73/0x94
 [<c0113f44>] autoremove_wake_function+0x0/0x38
 [<c0113f44>] autoremove_wake_function+0x0/0x38
 [<c013d185>] __block_prepare_write+0x2c9/0x3d8
 [<c0178777>] __jbd_kmalloc+0x1b/0x6c
 [<c013d9cd>] block_prepare_write+0x21/0x38
 [<c016880c>] ext3_get_block+0x0/0x68
 [<c0168ddd>] ext3_prepare_write+0xdd/0x1ec
 [<c016880c>] ext3_get_block+0x0/0x68
 [<c0125fda>] generic_file_aio_write_nolock+0x5be/0x974
 [<c0112b6e>] do_schedule+0x26a/0x2f4
 [<c0126483>] generic_file_aio_write+0x67/0x7c
 [<c0166862>] ext3_file_write+0x4e/0x5c
 [<c013a7b9>] do_sync_write+0x81/0xb4
 [<c0111390>] do_page_fault+0x0/0x404
 [<c011baa6>] update_wall_time+0x12/0x3c
 [<c011bd5f>] do_timer+0x4b/0xcc
 [<c010d611>] timer_interrupt+0x55/0x140
 [<c013a895>] vfs_write+0xa9/0x13c
 [<c013a98e>] sys_write+0x2a/0x3c
 [<c0108a43>] syscall_call+0x7/0xb

Code: 0f b7 42 16 89 c3 43 66 89 5a 16 66 40 66 3b 42 14 72 09 66
 <4>hda: lost interrupt
Unable to handle kernel NULL pointer dereference at virtual address 00000016
 printing eip:
c0263ea0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0263ea0>]    Not tainted
EFLAGS: 00010046
EIP is at ide_multwrite+0xa0/0x100
eax: 00000000   ebx: c12a2da4   ecx: ce5fb000   edx: 00000000
esi: c12a2da4   edi: 00000000   ebp: 00000010   esp: c03b1ef4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03b0000 task=c02f4e80)
Stack: c12a2da4 c040b56c c12a2d60 c040b4c0 00000000 c0263f4b c040b56c 00000010
       c03b0000 c040b56c c12a2d60 c025abb7 c040b56c c02e5671 c040b56c c12a2d84
       c03b0000 c02f7b00 c12a2d60 00000282 c0263f00 c011bcbf c12a2d60 00000001
Call Trace:
 [<c0263f4b>] multwrite_intr+0x4b/0xc0
 [<c025abb7>] ide_timer_expiry+0x153/0x204
 [<c0263f00>] multwrite_intr+0x0/0xc0
 [<c011bcbf>] run_timer_softirq+0xeb/0x134
 [<c025aa64>] ide_timer_expiry+0x0/0x204
 [<c011870a>] do_softirq+0x5a/0xac
 [<c0109f90>] do_IRQ+0xfc/0x118
 [<c0106c90>] default_idle+0x0/0x28
 [<c0106c90>] default_idle+0x0/0x28
 [<c0108bb0>] common_interrupt+0x18/0x20
 [<c0106c90>] default_idle+0x0/0x28
 [<c0106c90>] default_idle+0x0/0x28
 [<c0106cb3>] default_idle+0x23/0x28
 [<c0106d33>] cpu_idle+0x37/0x48
 [<c0105000>] rest_init+0x0/0x5c
 [<c0105057>] rest_init+0x57/0x5c

Code: 0f b7 42 16 89 c3 43 66 89 5a 16 66 40 66 3b 42 14 72 09 66
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+QXzgF6dfvkL3i1gRAu9kAJ9ZpMZB9MbMFJygdsezuacrySZMlQCeKnr6
ivw7E5GTkLHfRkTFHnVX/Hg=
=QZUt
-----END PGP SIGNATURE-----
