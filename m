Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262606AbRE3VXI>; Wed, 30 May 2001 17:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262695AbRE3VWs>; Wed, 30 May 2001 17:22:48 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:62735
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S262606AbRE3VWm>; Wed, 30 May 2001 17:22:42 -0400
Date: Wed, 30 May 2001 17:22:34 -0400
From: Chris Mason <mason@suse.com>
To: stimits@idcomm.com, kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 Oops at boot
Message-ID: <578120000.991257754@tiny>
In-Reply-To: <3B156024.8BD057B4@idcomm.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, May 30, 2001 03:03:32 PM -0600 "D. Stimits"
<stimits@idcomm.com> wrote:

[ snip ]

> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 249k freed
> VFS: Mounted root (ext2 filesystem).
> Red Hat nash version 3.0.10 starting
> VFS: Mounted root (ext2 filesystem) readonly.
> change_root: old root has d_count=2
> Trying to unmount old root ... <1>Unable to handle kernel NULL pointer
> dereference at virtual address 00000010
>  printing eip:

Can't say for sure without the oops decoded through ksymoops, but this
looks like the oops in rd_ioctl fixed by 2.4.5-ac3 and higher.  I think the
following patch (taken from ac3) will be sufficient:

-chris

--- linux.vanilla/fs/block_dev.c	Sat May 26 16:53:17 2001
+++ linux.ac/fs/block_dev.c	Mon May 28 16:10:59 2001
@@ -603,6 +602,7 @@
 	if (!bdev->bd_op->ioctl)
 		return -EINVAL;
 	inode_fake.i_rdev=rdev;
+	inode_fake.i_bdev=bdev;
 	init_waitqueue_head(&inode_fake.i_wait);
 	set_fs(KERNEL_DS);
 	res = bdev->bd_op->ioctl(&inode_fake, NULL, cmd, arg);

