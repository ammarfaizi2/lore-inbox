Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbTAOKun>; Wed, 15 Jan 2003 05:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266228AbTAOKun>; Wed, 15 Jan 2003 05:50:43 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:21473 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S266224AbTAOKum>; Wed, 15 Jan 2003 05:50:42 -0500
From: "Ivan G." <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.58: Kernel BUG at fs/devfs/base.c
Date: Wed, 15 Jan 2003 03:59:26 -0700
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301150359.27845.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.5.58 + bitkeeper patches + a patch by Patrick Mochel to fix an 
initrd oops: http://www.uwsg.iu.edu/hypermail/linux/kernel/0301.1/2364.html

I hit the following BUG twice while working with GNU parted.
The first time I tried to remove (rm) a partition and create a smaller one in 
its place (mkpart). The second time I tried to remove a partition and create 
a larger one in its place. Both times the partitions were created with the 
proper size, but parted crashed with a segmentation fault.

Here's the important parts of the BUG:

parted: OOPS	 devfs.put: Poisoned put
...
Kernel BUG at fs/devfs/base.c: 930!
...
EIP: devfs_put+0x13c/0x150
...
Call Trace:
	delete_partition+0x65/0x80
	rescan_partitions+0x10d/0x120
	blkdev_reread_part+0x72/0x90
	blkdev_ioctl+0x131/0x450
	sys_ioctl+0xfa/0x290
	sysenter_entry+0x52/0x70
...
Call: 0f 0b a2 03 43 f9 37 c0 e9 d7 fe ff ff 8d b4 26 00 00 00 00
Segmentation fault



