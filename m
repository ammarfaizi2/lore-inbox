Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTJMBBO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 21:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTJMBBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 21:01:14 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:21508
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261305AbTJMBBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 21:01:05 -0400
Date: Sun, 12 Oct 2003 17:57:40 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: fire-eyes <sgtphou@fire-eyes.dynup.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7: ide / reiserfs errors? (reiserfs_read_locked_inode)
In-Reply-To: <1066006220.2347.11.camel@localhost>
Message-ID: <Pine.LNX.4.10.10310121755320.12324-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DONT pass idebus=66, I do not care what or who tells you to pass this!
They are brain dead.  You skewed the timing out of range.

Since VLB is basically dead, this parameter needs to be wrappered with the
CONFIG_ISA

Wash rinse repeat w/o idebus=66.

Andre Hedrick
LAD Storage Consulting Group

On Sun, 12 Oct 2003, fire-eyes wrote:

> This is my first real post to the list. If I can better provide
> information, please let me know, so I can give the best possible data.
> Thanks for any hand-holding, and keep up the great work.
> 
> I am seeing ide/reiserfs errors in 2.6.0-test7. I did not stick around
> long enough to investigate futher than what you see below:
> 
> 
> System
> Asus A7M266-D motherboard
> Two AMD XP+ 1800 CPUs
> 512MB DDR RAM
> Disk drive: hda: ST3120023A, ATA DISK drive
> 
> 
> 
> Paramaters passed to kernel via grub: root=/dev/hda6 idebus=66
> ide0=ata66 ide1=ata66
> 
> I may be confused as to how the bus speed is set in 2.6, but I did not
> have these problems in 2.6.0-test6 or earlier.
> 
> /var/log/syslog (hopefully this comes out sane):
> 
> Oct 12 20:19:49 localhost kernel: blk: queue dfd93c00, I/O limit 4095Mb
> (mask 0xffffffff)
> Oct 12 20:19:49 localhost kernel: hda: dma_intr: status=0x58 {
> DriveReady SeekComplete DataRequest }
> Oct 12 20:19:49 localhost kernel: 
> Oct 12 20:19:49 localhost kernel: hda: set_drive_speed_status:
> status=0x58 { DriveReady SeekComplete DataRequest }
> Oct 12 20:19:49 localhost kernel: ide0: Drive 0 didn't accept speed
> setting. Oh, well.
> Oct 12 20:19:49 localhost kernel: is_leaf: nr_item seems wrong: level=1,
> nr_items=0, free_space=0 rdkey 
> Oct 12 20:19:49 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 1033191. Fsck?
> Oct 12 20:19:49 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [373169 373170 0x0 SD]
> Oct 12 20:19:49 localhost kernel: blk: queue dfd93800, I/O limit 4095Mb
> (mask 0xffffffff)
> Oct 12 20:19:49 localhost xinetd[3940]: Reading included configuration
> file: /etc/xinetd.d/telnetd [file=/etc/xinetd.d/telnetd] [line=15]
> Oct 12 20:19:49 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:19:49 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:19:49 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6549 497433 0x0 SD]
> 
> [later]
> 
> Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
> Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
> Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
> Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
> Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
> Oct 12 20:20:41 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:20:41 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:20:41 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
> Oct 12 20:21:15 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:21:15 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:21:15 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
> Oct 12 20:21:22 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:21:22 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:21:22 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
> Oct 12 20:21:22 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:21:22 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:21:22 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
> Oct 12 20:22:49 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:22:49 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:22:49 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
> Oct 12 20:23:07 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:23:07 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:23:07 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
> Oct 12 20:23:07 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:23:07 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:23:07 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
> Oct 12 20:23:07 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:23:07 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:28:13 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:28:13 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:28:13 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6549 123379 0x0 SD]
> Oct 12 20:28:13 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:28:13 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:28:13 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6549 118884 0x0 SD]
> Oct 12 20:28:13 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:28:13 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> Oct 12 20:28:13 localhost kernel: vs-13070: reiserfs_read_locked_inode:
> i/o failure occurred trying to find stat data of [6549 496832 0x0 SD]
> Oct 12 20:28:13 localhost kernel: is_tree_node: node level 28530 does
> not match to the expected one 1
> Oct 12 20:28:13 localhost kernel: vs-5150: search_by_key: invalid format
> found in block 23404. Fsck?
> 
> This goes on for quite a while.
> 

