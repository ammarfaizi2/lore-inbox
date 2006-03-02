Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWCBNOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWCBNOR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 08:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWCBNOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 08:14:17 -0500
Received: from kilius.dnsgold.net ([212.239.26.2]:8650 "EHLO
	kilius.dnsgold.net") by vger.kernel.org with ESMTP id S1751397AbWCBNOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 08:14:16 -0500
Message-ID: <001501c63dfb$298d2780$040010ac@Tesla>
From: "Paolo Roberti" <tesla@thgnet.it>
To: <linux-kernel@vger.kernel.org>
Subject: My desperation: Oops during mkfs.ext3 on large partitions
Date: Thu, 2 Mar 2006 14:13:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - kilius.dnsgold.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thgnet.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings, please CC me as i'm not currently subscribed to the list.

I'll try to be brief, i've been over this problem for 48 hours so far, I 
have no clue about what to do now.

I've made a lot of hardware switching tests and I know the harddisk is OK, 
because it works on another computer, but let's stick to the offending one:

badblocks -w /dev/hda2 runs OK, and says there are no corrupted blocks
on the same machine, issuing
mkfs.ext3 /dev/hda2
hangs (requiring hardware reboot, not even sysrq-b) or gives kernel OOPS 
with a variable content.

I've tried remapping IRQs, switching PCI slots, removing unused PCI cards, 
attaching this HD as slave and running mkfs.ext3 from a running system with 
Red Hat 9 (i'd always been trying from a PXE booted Fedora Core 4). There 
seems to be NO way to run mkfs from this computer.

What drives me crazy is that badblocks (read and read/write) runs smooth, so 
the partition is fully addressable from the PCI controller...

Following there is a sample Oops when running mkfs.ext3 /dev/hda1, which is 
a partition smaller than /dev/hda2, but different runs give different type 
of Oops.
Any help is GREATLY apprecited!

Best Regards
Paolo


mke2fs 1.37 (21-Mar-2005)
Filesystem label=
OS type: Linux
Block size=4906 (log=2)
Fragment size=4096 (log=2)
1028160 inodes, 2052295 blocks
102614 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=2105540608
63 block groups
32768 blocks per group, 32768 fragments per group
16320 inodes per group
Superblock backups stored on blocks:
 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Writing inode tables: Oops: 0000 [#1]
Modules linked in: parport_pc parport dm_snapshot dm_mirror dm_zero dm_mod 
xfs exportfs jfs reiserfs ext3 jbd msdos raid6 raid5 xor raid1 raid0 3c59x 
mii uhci_hcd sr_mod sd_mod scsi_mod pcspkr edd loop nfs lockd sunrpc vfat 
fat cramfs vga16fb vgastate
CPU:    0
EIP:    9969:[<c014f89d>]    Not tainted VLI
EFLAGS: 00010002   (2.6.11-1.1369_FC4)
EIP is at find_lock_page+0x2d/0x80
eax: 00000000 ebx: 00000000 ecx: 0000000 edx: fffffffa
esi: 001e81f0 edi: dffd9640 ebp: dffd963c esp: d46aedb4
ds: 007b   es: 007b   ss: 0068
Process mkfs.ext3 (pid: 589, threadinfo=d46ae000 task=d6109550)
Stack: 00000000
Call Trace:
 [<c0151287>] generic_file_buffered_write+0x127/0x640
 [<c0105a88>] do_IRQ+0x58/0x90
 [<c012726a>] current_fs_time+0x4a/0x70
 [<c0151a18>] __generic_file_aio_write_nolock+0x278/0x4a0
 [<c0151c79>] generic_file_aio_write_nolock+0x39/0xa0
 [<c0151e05>] generic_file_write_nolock+0x85/0xa0
 [<c013d7d0>] autoremove_wake_function+0x0/0x30
 [<c0181240>] blkdev_file_write+0x0/0x20
 [<c018125b>] blkdev_file_write+0x1b/0x20
 [<c0176275>] vfs_write+0x95/0x110
 [<c017639c>] sys_write+0x3c/0x70
 [<c01039d9>] syscall_call+0x7/0xb
Code: c5 57 56 89 d6 53 fa 8d 78 04
 Segmentation fault


