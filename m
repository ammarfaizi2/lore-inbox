Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262599AbTCIUT6>; Sun, 9 Mar 2003 15:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262600AbTCIUT6>; Sun, 9 Mar 2003 15:19:58 -0500
Received: from wall.ttu.ee ([193.40.254.238]:32014 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id <S262599AbTCIUTx>;
	Sun, 9 Mar 2003 15:19:53 -0500
Date: Sun, 9 Mar 2003 22:30:25 +0200 (EET)
From: Siim Vahtre <siim@pld.ttu.ee>
To: <linux-kernel@vger.kernel.org>
Subject: [2.5.64-mm4] ext-fs errors @ mounting loop device
Message-ID: <Pine.SOL.4.31.0303092208020.28624-100000@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've made backup from my old ext3 disk partition to NFS share. It was made
with something like 'dd if=/dev/hda1 of=/nfs/share/void-hda1-date'.

Using 'file' utility it says following about that image:

void-hda1-feb07: x86 boot sector, code offset 0x58, OEM-ID "MSWIN4.1",
sectors/cluster 8, Media descriptor 0xf8, heads 64, hidden sectors 63,
sectors 3152961 (volumes > 32 MB) , FAT (32 bit), sectors/FAT 3077,
reserved3 0x1800000, reserved 0x1, serial number 0x263619e1, label: "BUUMA
"

I have used the image before and never had any problems until today...
In the morning, I mounted the image and it said:

EXT2-fs warning (device loop(7,0)): ext2_fill_super: mounting ext3 filesystem as ext2
EXT2-fs warning: maximal mount count reached, running e2fsck is recommended

So it shows I made a mistake and mounted the fs as ext2, although it was
ext3. I basicly ignored the errors, unmounted the fs, made e2fsck on it
and remounted it. After copying some important files I unmounted it
again.

Now, in the evening I decided that I need more files from that image. So I
remounted it and this time as ext3. I used following line:
mount -text3 -oloop void-hda1-feb07 -oro /loop/

...and I got:

---------------
kjournald starting.  Commit interval 5 seconds
EXT3-fs: loop(7,0): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 129738
ext3_orphan_cleanup: deleting unreferenced inode 48087
ext3_orphan_cleanup: deleting unreferenced inode 112435
ext3_orphan_cleanup: deleting unreferenced inode 48354
ext3_orphan_cleanup: deleting unreferenced inode 48352
ext3_orphan_cleanup: deleting unreferenced inode 48347
ext3_orphan_cleanup: deleting unreferenced inode 48342
ext3_orphan_cleanup: deleting unreferenced inode 48341
ext3_orphan_cleanup: deleting unreferenced inode 48340
ext3_orphan_cleanup: deleting unreferenced inode 48339
ext3_orphan_cleanup: deleting unreferenced inode 48338
ext3_orphan_cleanup: deleting unreferenced inode 48337
ext3_orphan_cleanup: deleting unreferenced inode 48333
ext3_orphan_cleanup: deleting unreferenced inode 48332
ext3_orphan_cleanup: deleting unreferenced inode 48294
EXT3-fs: loop(7,0): 15 orphan inodes deleted
EXT3-fs: recovery complete.
buffer layer error at fs/buffer.c:1153
Call Trace:
 [<c014e2b4>] mark_buffer_dirty+0x54/0x60
 [<c0197d90>] journal_update_superblock+0x40/0xa0
 [<c01959d6>] __try_to_free_cp_buf+0x46/0x50
 [<c0195fa5>] cleanup_journal_tail+0x95/0x110
 [<c0195ef1>] log_do_checkpoint+0x151/0x170
 [<c0123bf5>] mod_timer+0x155/0x220
 [<c0232cb3>] scrup+0x143/0x150
 [<c0123bf5>] mod_timer+0x155/0x220
 [<c01192a9>] do_schedule+0x1a9/0x3b0
 [<c0119500>] default_wake_function+0x0/0x20
 [<c01975f8>] log_wait_commit+0x58/0xb0
 [<c0198682>] journal_flush+0x252/0x280
 [<c011d048>] printk+0x118/0x180
 [<c018e6fc>] ext3_mark_recovery_complete+0x1c/0x70
 [<c018de2e>] ext3_fill_super+0x80e/0xa80
 [<c021422f>] sprintf+0x1f/0x30
 [<c0152743>] get_sb_bdev+0x123/0x160
 [<c018edff>] ext3_get_sb+0x2f/0x33
 [<c018d620>] ext3_fill_super+0x0/0xa80
 [<c015299f>] do_kern_mount+0x5f/0xe0
 [<c01679c1>] do_add_mount+0x81/0x170
 [<c0167d11>] do_mount+0x181/0x1d0
 [<c0167b8a>] copy_mount_options+0xda/0xe0
 [<c0168207>] sys_mount+0xd7/0x140
 [<c01092c3>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2544
Call Trace:
 [<c01505ff>] submit_bh+0x10f/0x160
 [<c0150749>] sync_dirty_buffer+0x69/0xc0
 [<c014e29b>] mark_buffer_dirty+0x3b/0x60
 [<c0197da4>] journal_update_superblock+0x54/0xa0
 [<c01959d6>] __try_to_free_cp_buf+0x46/0x50
 [<c0195fa5>] cleanup_journal_tail+0x95/0x110
 [<c0195ef1>] log_do_checkpoint+0x151/0x170
 [<c0123bf5>] mod_timer+0x155/0x220
 [<c0232cb3>] scrup+0x143/0x150
 [<c0123bf5>] mod_timer+0x155/0x220
 [<c01192a9>] do_schedule+0x1a9/0x3b0
 [<c0119500>] default_wake_function+0x0/0x20
 [<c01975f8>] log_wait_commit+0x58/0xb0
 [<c0198682>] journal_flush+0x252/0x280
 [<c011d048>] printk+0x118/0x180
 [<c018e6fc>] ext3_mark_recovery_complete+0x1c/0x70
 [<c018de2e>] ext3_fill_super+0x80e/0xa80
 [<c021422f>] sprintf+0x1f/0x30
 [<c0152743>] get_sb_bdev+0x123/0x160
 [<c018edff>] ext3_get_sb+0x2f/0x33
 [<c018d620>] ext3_fill_super+0x0/0xa80
 [<c015299f>] do_kern_mount+0x5f/0xe0
 [<c01679c1>] do_add_mount+0x81/0x170
 [<c0167d11>] do_mount+0x181/0x1d0
 [<c0167b8a>] copy_mount_options+0xda/0xe0
 [<c0168207>] sys_mount+0xd7/0x140
 [<c01092c3>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:1153
Call Trace:
 [<c014e2b4>] mark_buffer_dirty+0x54/0x60
 [<c0197d90>] journal_update_superblock+0x40/0xa0
 [<c01975f8>] log_wait_commit+0x58/0xb0
 [<c01984bf>] journal_flush+0x8f/0x280
 [<c011d048>] printk+0x118/0x180
 [<c018e6fc>] ext3_mark_recovery_complete+0x1c/0x70
 [<c018de2e>] ext3_fill_super+0x80e/0xa80
 [<c021422f>] sprintf+0x1f/0x30
 [<c0152743>] get_sb_bdev+0x123/0x160
 [<c018edff>] ext3_get_sb+0x2f/0x33
 [<c018d620>] ext3_fill_super+0x0/0xa80
 [<c015299f>] do_kern_mount+0x5f/0xe0
 [<c01679c1>] do_add_mount+0x81/0x170
 [<c0167d11>] do_mount+0x181/0x1d0
 [<c0167b8a>] copy_mount_options+0xda/0xe0
 [<c0168207>] sys_mount+0xd7/0x140
 [<c01092c3>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2544
Call Trace:
 [<c01505ff>] submit_bh+0x10f/0x160
 [<c0150749>] sync_dirty_buffer+0x69/0xc0
 [<c014e29b>] mark_buffer_dirty+0x3b/0x60
 [<c0197da4>] journal_update_superblock+0x54/0xa0
 [<c01975f8>] log_wait_commit+0x58/0xb0
 [<c01984bf>] journal_flush+0x8f/0x280
 [<c011d048>] printk+0x118/0x180
 [<c018e6fc>] ext3_mark_recovery_complete+0x1c/0x70
 [<c018de2e>] ext3_fill_super+0x80e/0xa80
 [<c021422f>] sprintf+0x1f/0x30
 [<c0152743>] get_sb_bdev+0x123/0x160
 [<c018edff>] ext3_get_sb+0x2f/0x33
 [<c018d620>] ext3_fill_super+0x0/0xa80
 [<c015299f>] do_kern_mount+0x5f/0xe0
 [<c01679c1>] do_add_mount+0x81/0x170
 [<c0167d11>] do_mount+0x181/0x1d0
 [<c0167b8a>] copy_mount_options+0xda/0xe0
 [<c0168207>] sys_mount+0xd7/0x140
 [<c01092c3>] syscall_call+0x7/0xb

EXT3-fs: mounted filesystem with ordered data mode.

---------------
Again, I copied few important files and unmounted the image.
After unmounting it said:
---------------

buffer layer error at fs/buffer.c:1153
Call Trace:
 [<c014e2b4>] mark_buffer_dirty+0x54/0x60
 [<c0197d90>] journal_update_superblock+0x40/0xa0
 [<c01971e8>] journal_kill_thread+0x38/0x50
 [<c01980f9>] journal_destroy+0xc9/0x1b0
 [<c0190f6e>] ext3_xattr_put_super+0x1e/0x30
 [<c018c4c6>] ext3_put_super+0x26/0x180
 [<c0151df8>] generic_shutdown_super+0x148/0x160
 [<c015279d>] kill_block_super+0x1d/0x50
 [<c0151b5f>] deactivate_super+0x5f/0xc0
 [<c016717f>] sys_umount+0x3f/0x90
 [<c01671e7>] sys_oldumount+0x17/0x20
 [<c01092c3>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2544
Call Trace:
 [<c01505ff>] submit_bh+0x10f/0x160
 [<c0150749>] sync_dirty_buffer+0x69/0xc0
 [<c014e29b>] mark_buffer_dirty+0x3b/0x60
 [<c0197da4>] journal_update_superblock+0x54/0xa0
 [<c01971e8>] journal_kill_thread+0x38/0x50
 [<c01980f9>] journal_destroy+0xc9/0x1b0
 [<c0190f6e>] ext3_xattr_put_super+0x1e/0x30
 [<c018c4c6>] ext3_put_super+0x26/0x180
 [<c0151df8>] generic_shutdown_super+0x148/0x160
 [<c015279d>] kill_block_super+0x1d/0x50
 [<c0151b5f>] deactivate_super+0x5f/0xc0
 [<c016717f>] sys_umount+0x3f/0x90
 [<c01671e7>] sys_oldumount+0x17/0x20
 [<c01092c3>] syscall_call+0x7/0xb

---------------

Oh.. and because it was on NFS share, maybe it is important that I've
also recieved lot of errors like "nfs_statfs: statfs error = 116" and
"NFS: server cheating in read reply: count 8192 > recvd 1000" on very
random places.

The bug is 100% reproduceable.

And note that I have not tested that with pure 2.5.64 (w/o -mm4) because
there I cannot use fs image over NFS at all right now.

I like living on the top of the knife ;-)


