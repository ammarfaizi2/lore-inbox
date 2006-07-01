Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932700AbWGALPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbWGALPv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 07:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932780AbWGALPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 07:15:51 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:22922 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932700AbWGALPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 07:15:51 -0400
Date: Sat, 1 Jul 2006 13:11:53 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, mingo@redhat.com
Subject: Re: 2.6.17-mm4 raid bugs & traces
Message-ID: <20060701111153.GA10855@aitel.hist.no>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629013643.4b47e8bd.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raid-1 is not well in mm4.  Now, my raid devices may
have some problems after running mm2, because mm2 tends to
trip up on shutdown, which might cause linux to come up again
with some failed mirrors. That shouldn't cause mm4 to go BUG
and spit call traces though.

When I boot up mm4, dmesg tells me this:

[...]
SCTP: Hash tables configured (established 16384 bind 16384)
powernow-k8: Found 1 AMD Opteron(tm) Processor 244 processors (version 2.00.00)
powernow-k8: BIOS error - no PSB or ACPI _PSS objects
BIOS EDD facility v0.16 2004-Jun-25, 4 devices found
Freeing unused kernel memory: 272k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sde2 ...
md:  adding sde2 ...
md:  adding sdd2 ...
md: sdc1 has different UUID to sde2
md: sdb5 has different UUID to sde2
md: sdb1 has different UUID to sde2
md: sda5 has different UUID to sde2
md: sda2 has different UUID to sde2
md: created md2
md: bind<sdd2>
md: bind<sde2>
md: running: <sde2><sdd2>
md: kicking non-fresh sdd2 from array!
md: unbind<sdd2>
md: export_rdev(sdd2)
BUG: warning at fs/block_dev.c:1109/__blkdev_put()

Call Trace:
 [<ffffffff8016a1e2>] dump_stack+0x12/0x20
 [<ffffffff801ba2d0>] __blkdev_put+0xb0/0x1c0
 [<ffffffff803d37bb>] export_rdev+0x7b/0x90
 [<ffffffff803d5818>] do_md_run+0x138/0x6f0
 [<ffffffff803d60bb>] autorun_devices+0x2eb/0x380
 [<ffffffff803d8c26>] md_ioctl+0x166/0x1490
 [<ffffffff8024acd0>] blkdev_ioctl+0x680/0x700
 [<ffffffff801b9b8b>] block_ioctl+0x1b/0x30
 [<ffffffff8014122b>] do_ioctl+0x1b/0x60
 [<ffffffff801303cf>] vfs_ioctl+0x23f/0x260
 [<ffffffff8014bab9>] sys_ioctl+0x49/0x80
 [<ffffffff8015ea7e>] system_call+0x7e/0x83
 [<000000000040b9a5>]
BUG: warning at fs/block_dev.c:1128/__blkdev_put()

Call Trace:
 [<ffffffff8016a1e2>] dump_stack+0x12/0x20
 [<ffffffff801ba381>] __blkdev_put+0x161/0x1c0
 [<ffffffff803d37bb>] export_rdev+0x7b/0x90
 [<ffffffff803d5818>] do_md_run+0x138/0x6f0
 [<ffffffff803d60bb>] autorun_devices+0x2eb/0x380
 [<ffffffff803d8c26>] md_ioctl+0x166/0x1490
 [<ffffffff8024acd0>] blkdev_ioctl+0x680/0x700
 [<ffffffff801b9b8b>] block_ioctl+0x1b/0x30
 [<ffffffff8014122b>] do_ioctl+0x1b/0x60
 [<ffffffff801303cf>] vfs_ioctl+0x23f/0x260
 [<ffffffff8014bab9>] sys_ioctl+0x49/0x80
 [<ffffffff8015ea7e>] system_call+0x7e/0x83
 [<000000000040b9a5>]
md: md2: raid array is not clean -- starting background reconstruction
raid1: raid set md2 active with 1 out of 2 mirrors
md: considering sdc1 ...
md:  adding sdc1 ...
md:  adding sdb5 ...
md: sdb1 has different UUID to sdc1
md:  adding sda5 ...
md: sda2 has different UUID to sdc1
md: created md3
md: bind<sda5>
md: bind<sdb5>
md: export_rdev(sdc1)
BUG: warning at fs/block_dev.c:1109/__blkdev_put()

Call Trace:
 [<ffffffff8016a1e2>] dump_stack+0x12/0x20
 [<ffffffff801ba2d0>] __blkdev_put+0xb0/0x1c0
 [<ffffffff803d37bb>] export_rdev+0x7b/0x90
 [<ffffffff803d6038>] autorun_devices+0x268/0x380
 [<ffffffff803d8c26>] md_ioctl+0x166/0x1490
 [<ffffffff8024acd0>] blkdev_ioctl+0x680/0x700
 [<ffffffff801b9b8b>] block_ioctl+0x1b/0x30
 [<ffffffff8014122b>] do_ioctl+0x1b/0x60
 [<ffffffff801303cf>] vfs_ioctl+0x23f/0x260
 [<ffffffff8014bab9>] sys_ioctl+0x49/0x80
 [<ffffffff8015ea7e>] system_call+0x7e/0x83
 [<000000000040b9a5>]
BUG: warning at fs/block_dev.c:1128/__blkdev_put()

Call Trace:
 [<ffffffff8016a1e2>] dump_stack+0x12/0x20
 [<ffffffff801ba381>] __blkdev_put+0x161/0x1c0
 [<ffffffff803d37bb>] export_rdev+0x7b/0x90
 [<ffffffff803d6038>] autorun_devices+0x268/0x380
 [<ffffffff803d8c26>] md_ioctl+0x166/0x1490
 [<ffffffff8024acd0>] blkdev_ioctl+0x680/0x700
 [<ffffffff801b9b8b>] block_ioctl+0x1b/0x30
 [<ffffffff8014122b>] do_ioctl+0x1b/0x60
 [<ffffffff801303cf>] vfs_ioctl+0x23f/0x260
 [<ffffffff8014bab9>] sys_ioctl+0x49/0x80
 [<ffffffff8015ea7e>] system_call+0x7e/0x83
 [<000000000040b9a5>]
md: running: <sdb5><sda5>
md: kicking non-fresh sda5 from array!
md: unbind<sda5>
md: export_rdev(sda5)
BUG: warning at fs/block_dev.c:1109/__blkdev_put()

Call Trace:
 [<ffffffff8016a1e2>] dump_stack+0x12/0x20
 [<ffffffff801ba2d0>] __blkdev_put+0xb0/0x1c0
 [<ffffffff803d37bb>] export_rdev+0x7b/0x90
 [<ffffffff803d5818>] do_md_run+0x138/0x6f0
 [<ffffffff803d60bb>] autorun_devices+0x2eb/0x380
 [<ffffffff803d8c26>] md_ioctl+0x166/0x1490
 [<ffffffff8024acd0>] blkdev_ioctl+0x680/0x700
 [<ffffffff801b9b8b>] block_ioctl+0x1b/0x30
 [<ffffffff8014122b>] do_ioctl+0x1b/0x60
 [<ffffffff801303cf>] vfs_ioctl+0x23f/0x260
 [<ffffffff8014bab9>] sys_ioctl+0x49/0x80
 [<ffffffff8015ea7e>] system_call+0x7e/0x83
 [<000000000040b9a5>]
BUG: warning at fs/block_dev.c:1128/__blkdev_put()

Call Trace:
 [<ffffffff8016a1e2>] dump_stack+0x12/0x20
 [<ffffffff801ba381>] __blkdev_put+0x161/0x1c0
 [<ffffffff803d37bb>] export_rdev+0x7b/0x90
 [<ffffffff803d5818>] do_md_run+0x138/0x6f0
 [<ffffffff803d60bb>] autorun_devices+0x2eb/0x380
 [<ffffffff803d8c26>] md_ioctl+0x166/0x1490
 [<ffffffff8024acd0>] blkdev_ioctl+0x680/0x700
 [<ffffffff801b9b8b>] block_ioctl+0x1b/0x30
 [<ffffffff8014122b>] do_ioctl+0x1b/0x60
 [<ffffffff801303cf>] vfs_ioctl+0x23f/0x260
 [<ffffffff8014bab9>] sys_ioctl+0x49/0x80
 [<ffffffff8015ea7e>] system_call+0x7e/0x83
 [<000000000040b9a5>]
raid1: raid set md3 active with 1 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2>
md: bind<sdb1>
md: running: <sdb1><sda2>
md: kicking non-fresh sda2 from array!
md: unbind<sda2>
md: export_rdev(sda2)
BUG: warning at fs/block_dev.c:1109/__blkdev_put()

Call Trace:
 [<ffffffff8016a1e2>] dump_stack+0x12/0x20
 [<ffffffff801ba2d0>] __blkdev_put+0xb0/0x1c0
 [<ffffffff803d37bb>] export_rdev+0x7b/0x90
 [<ffffffff803d5818>] do_md_run+0x138/0x6f0
 [<ffffffff803d60bb>] autorun_devices+0x2eb/0x380
 [<ffffffff803d8c26>] md_ioctl+0x166/0x1490
 [<ffffffff8024acd0>] blkdev_ioctl+0x680/0x700
 [<ffffffff801b9b8b>] block_ioctl+0x1b/0x30
 [<ffffffff8014122b>] do_ioctl+0x1b/0x60
 [<ffffffff801303cf>] vfs_ioctl+0x23f/0x260
 [<ffffffff8014bab9>] sys_ioctl+0x49/0x80
 [<ffffffff8015ea7e>] system_call+0x7e/0x83
 [<000000000040b9a5>]
BUG: warning at fs/block_dev.c:1128/__blkdev_put()

Call Trace:
 [<ffffffff8016a1e2>] dump_stack+0x12/0x20
 [<ffffffff801ba381>] __blkdev_put+0x161/0x1c0
 [<ffffffff803d37bb>] export_rdev+0x7b/0x90
 [<ffffffff803d5818>] do_md_run+0x138/0x6f0
 [<ffffffff803d60bb>] autorun_devices+0x2eb/0x380
 [<ffffffff803d8c26>] md_ioctl+0x166/0x1490
 [<ffffffff8024acd0>] blkdev_ioctl+0x680/0x700
 [<ffffffff801b9b8b>] block_ioctl+0x1b/0x30
 [<ffffffff8014122b>] do_ioctl+0x1b/0x60
 [<ffffffff801303cf>] vfs_ioctl+0x23f/0x260
 [<ffffffff8014bab9>] sys_ioctl+0x49/0x80
 [<ffffffff8015ea7e>] system_call+0x7e/0x83
 [<000000000040b9a5>]
md: md0: raid array is not clean -- starting background reconstruction
raid1: raid set md0 active with 1 out of 2 mirrors
md: ... autorun DONE.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sdd1: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 1095592
EXT3-fs: sdd1: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
[...]		  

Helge Hafting
