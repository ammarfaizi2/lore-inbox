Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265236AbSKJWx0>; Sun, 10 Nov 2002 17:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265237AbSKJWx0>; Sun, 10 Nov 2002 17:53:26 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:47622 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S265236AbSKJWxY>; Sun, 10 Nov 2002 17:53:24 -0500
Date: Mon, 11 Nov 2002 00:04:03 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: linux-kernel@vger.kernel.org
Subject: 2.5.46: buffer layer error at fs/buffer.c:399
Message-ID: <Pine.LNX.4.44.0211101839380.1451-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

shortly after upgrading 2.5.45->2.5.46 I got this while cp'ing some 
regular file. Source and destination was both in rootfs, which is ext2. 
It's not exactly reproducible, however apparently triggered by files 
larger than about 500KB - at least I got a few with those but never from 
smaller one.

Despite this error/warning(?) the requested file was successfully copied 
(and diffed). A forced fsck on / didn't find any corruption. And it seems 
it doesn't occur if the target file exists, i.e. it's overwritten.

Kernel is 2.5.46 SMP running on UP box. The new extended attributes were 
not enabled for ext2.

Martin

-------------------

* this one was triggered by "cp file1 file2" (cwd=/root)

buffer layer error at fs/buffer.c:399
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0151db6>] __find_get_block_slow+0xe6/0x150
 [<c0152ec6>] __find_get_block+0xd6/0xf0
 [<c0153277>] unmap_underlying_metadata+0x17/0x50
 [<c0153853>] __block_prepare_write+0x163/0x450
 [<c0153885>] __block_prepare_write+0x195/0x450
 [<c0138d13>] file_read_actor+0x83/0xf0
 [<c0142196>] buffered_rmqueue+0x116/0x120
 [<c015434c>] block_prepare_write+0x1c/0x40
 [<c01a0e70>] ext2_get_block+0x0/0x420
 [<c013a1ad>] generic_file_write_nolock+0x5ed/0x9d0
 [<c01a0e70>] ext2_get_block+0x0/0x420
 [<c01590d5>] cp_new_stat64+0xa5/0xc0
 [<c011883f>] do_page_fault+0x12f/0x44b
 [<c013a603>] generic_file_write+0x53/0x70
 [<c014fd3d>] vfs_write+0xcd/0x170
 [<c0150028>] sys_write+0x28/0x40
 [<c0109157>] syscall_call+0x7/0xb

* and this one by "dd if=/dev/zero of=/root/file bs=1k count=512"

buffer layer error at fs/buffer.c:399
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0151db6>] __find_get_block_slow+0xe6/0x150
 [<c0152ec6>] __find_get_block+0xd6/0xf0
 [<c0153277>] unmap_underlying_metadata+0x17/0x50
 [<c0153853>] __block_prepare_write+0x163/0x450
 [<c0153885>] __block_prepare_write+0x195/0x450
 [<c0149075>] __set_page_dirty_nobuffers+0xa5/0xb0
 [<c0153bb5>] __block_commit_write+0x75/0xb0
 [<c015434c>] block_prepare_write+0x1c/0x40
 [<c01a0e70>] ext2_get_block+0x0/0x420
 [<c013a1ad>] generic_file_write_nolock+0x5ed/0x9d0
 [<c01a0e70>] ext2_get_block+0x0/0x420
 [<c012a07a>] update_process_times+0x2a/0x30
 [<c01266af>] tasklet_hi_action+0x7f/0xe0
 [<c012639c>] do_softirq+0x5c/0xc0
 [<c010be45>] do_IRQ+0x1a5/0x1b0
 [<c010a048>] common_interrupt+0x18/0x20
 [<c013a603>] generic_file_write+0x53/0x70
 [<c014fd3d>] vfs_write+0xcd/0x170
 [<c012639c>] do_softirq+0x5c/0xc0
 [<c0150028>] sys_write+0x28/0x40
 [<c0109157>] syscall_call+0x7/0xb

