Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279842AbRKRPxL>; Sun, 18 Nov 2001 10:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279860AbRKRPxB>; Sun, 18 Nov 2001 10:53:01 -0500
Received: from milsum.Biomed.McGill.CA ([132.206.111.48]:35845 "EHLO
	milsum.biomed.mcgill.ca") by vger.kernel.org with ESMTP
	id <S279842AbRKRPwv>; Sun, 18 Nov 2001 10:52:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian Lavoie <clavoie@bmed.mcgill.ca>
To: linux-kernel@vger.kernel.org
Subject: Creating partitions under 2.4.14
Date: Sun, 18 Nov 2001 10:52:50 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011118155255Z279842-17408+15786@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I've hit this bug again:

http://www.cs.helsinki.fi/linux/linux-kernel/2001-40/0208.html

I'm trying to create a 7.5 gigs partition on /dev/sda, over a aic7xxxx SCSI 
controller [Adaptec 7892A (rev 2)]. Fdisk will create partition labels right, 
but mke2fs dies (1.18 and 1.25 both) with "File size limit exceeded".

I'm running 2.4.14 vanilla, e2fsprogs 1.25, glibc 2.2.1, on a progeny debian 
system (more or less potato).

Anyone can confirm the patch made it into 2.4.15?

----

/home/clavoie# fdisk -l /dev/sda

Disk /dev/sda: 255 heads, 63 sectors, 1115 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1             1        33    265041   82  Linux swap
/dev/sda2            34      1081   8418060   83  Linux
/dev/sda3          1082      1115    273105   82  Linux swap

----

/home/clavoie# mke2fs -v /dev/sda2
mke2fs 1.25 (20-Sep-2001)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
1052480 inodes, 2104515 blocks
105225 blocks (5.00%) reserved for the super user
First data block=0
65 block groups
32768 blocks per group, 32768 fragments per group
16192 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

File size limit exceeded

----

-- 
Christian Lavoie
clavoie@bmed.mcgill.ca
