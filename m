Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLGWVA>; Thu, 7 Dec 2000 17:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbQLGWUv>; Thu, 7 Dec 2000 17:20:51 -0500
Received: from rmx614-mta.mail.com ([165.251.48.52]:52146 "EHLO
	rmx614-mta.mail.com") by vger.kernel.org with ESMTP
	id <S129260AbQLGWUg>; Thu, 7 Dec 2000 17:20:36 -0500
Message-ID: <380814282.976225806017.JavaMail.root@web176-ec>
Date: Thu, 7 Dec 2000 16:50:03 -0500 (EST)
From: Vivek Dasgupta <vivek_dasgupta@email.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Ramdisk root filesystem strangeness
CC: carlson@sibyte.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 64.1.233.187
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I m sorry if this question doesn't belong to this list. But I couldn't
access the linux-admin list.

Is there support for using RAMDISK as the final root file system
in 2.2.x versions, or is it there in the 2.4.x versions.

I am trying to bring up linux on a diskless server which initially mounts
root FS thru NFS. Then I want to load HDD image to a RAMDISK and use it as
the final root filesystem.

I am not sure whether it is a ready supported or any kernel change will be
required for this?

Any pointers would be helpful.

thanks

vivek

-----Original Message-----
From: Justin Carlson [mailto:carlson@sibyte.com]
Sent: Thursday, December 07, 2000 11:52 AM
To: linux-kernel@vger.kernel.org
Subject: Ramdisk root filesystem strangeness


Am in the midst of bringing up the kernel on a new MIPS variant, and I'm
tryingthe mount a statically linked ramdisk as the root filesystem.

Note, this is NOT using initrd support, I really want to use a ramdisk as my
final filesystem, not as an intermediate step in booting the system.

In blkdev_get(), called from mount_root(), there's some code that grabs
an empty inode, sets up i_rdev, and calls open() for the root device
with the caveat that open() must not examine anything except i_rdev.

in rd_open, though, there's this code snippet:

/*
* Immunize device against invalidate_buffers() and prune_icache().
*/
if (rd_inode[DEVICE_NR(inode->i_rdev)] == NULL) {
if (!inode->i_bdev)
return -ENXIO;

I'm hitting the -ENXIO return, which is based on an uninitialized field of
the
inode structure.

Being relatively new to the code base, I'm not sure what this code is trying
to
do, nor how to fix it.  Any suggestions?

The code involved is from the MIPS CVS repository at oss.sgi.com, which was
synced in the past couple days from 2.4.0test11

-Justin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/


-----------------------------------------------
FREE! The World's Best Email Address @email.com
Reserve your name now at http://www.email.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
