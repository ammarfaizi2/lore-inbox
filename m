Return-Path: <linux-kernel-owner+w=401wt.eu-S1161446AbWLPUCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161446AbWLPUCc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 15:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWLPUCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 15:02:31 -0500
Received: from alnrmhc12.comcast.net ([206.18.177.52]:55536 "EHLO
	alnrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161446AbWLPUCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 15:02:31 -0500
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 15:02:31 EST
Date: Sat, 16 Dec 2006 14:55:16 -0500
From: "A. Kalten" <akalten@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: DVD-RAM cannot be mounted RW with 2.6.18/2.6.19
Message-Id: <20061216145516.13bdeb68.akalten@comcast.net>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

DVD-RAM disks previously made with a Linux system can
no longer be mounted in RW mode.  For some reason, as
indicated by the error message from the mount command,
the disks are detected as being write-protected (which
is not the case).  To be able to write to these disks,
the mount command must be issued again with the "-o remount"
option.

The commands given are as follows.  Although the file
type in this example is ext2, the same behavior is seen
also with the udf file type.

# modprobe ide-cd
# hdparm -d1 -X udma4 -k1 /dev/hde

# mount -t ext2 -o rw,noatime /dev/hde /cdrom
mount: block device /dev/hde is write-protected, mounting read-only

# mount -t ext2 -o remount,rw,noatime /dev/hde /cdrom

Now the DVD-RAM disk can be written normally, but there should
be no need for the second mount command.

The kernel log for this command sequence seems to show nothing abnormal:

kernel: hde: ATAPI 39X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(66)
kernel: Uniform CD-ROM driver Revision: 3.20
kernel: hde: CHECK for good STATUS
kernel: cdrom: hde: mrw address space DMA selected
kernel: cdrom open: mrw_status 'not mrw'

Furthermore, if I attempt to check the unmounted DVD-RAM disk with
e2fsck, the drive is still reported as read-only:

# e2fsck -p /dev/hde
e2fsck: Read-only file system while trying to open /dev/hde
Disk write-protected; use the -n option to do a read-only
check of the device.

However, as I indicated above, the disk is not write-protected.

I am reporting this problem on the lkml because of a hint
that I discovered at this link:

http://lists.opensuse.org/packet-writing/2006-10/msg00000.html

Although this problem does not involve packet-writing, it may
be related to the cdrom code.

Andrew Kalten

