Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRBZXta>; Mon, 26 Feb 2001 18:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129271AbRBZXtQ>; Mon, 26 Feb 2001 18:49:16 -0500
Received: from [213.4.18.231] ([213.4.18.231]:40203 "EHLO fulanito.nisupu.com")
	by vger.kernel.org with ESMTP id <S129268AbRBZXs6>;
	Mon, 26 Feb 2001 18:48:58 -0500
Message-ID: <11dd01c0a04e$98b92e60$f40237d1@MIACFERNANDEZ>
From: "Carlos Fernandez Sanz" <cfernandez@myalert.com>
To: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Problem creating filesystem
Date: Mon, 26 Feb 2001 18:48:16 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just purchased a new HD and I'm getting problems creating a
filesystem for it. I've done some research and some people claim the problem
might be kernel related so I'm asking here just in case.

The HD is a Maxtor 80 Gb, plugged to the Promise controller that comes with
Asus A7V motherboards. The controller is ide2, and the HD is /dev/hde. ide0
and ide1 are working with no problems.

-----------------
fdisk shows some warnings (but doesn't refuse to create the partition):

[root@alhambra /sbin]# fdisk /dev/hde
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF
disklabel
Building a new DOS disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course, the previous
content won't be recoverable.

The number of cylinders for this disk is set to 15871.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)
Warning: invalid flag 0xffffa855 of partition table 5 will be corrected by
w(rite)

Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
p
Partition number (1-4): 1
First cylinder (1-15871, default 1):
Using default value 1
Last cylinder or +size or +sizeM or +sizeK (1-15871, default 15871):
Using default value 15871

Command (m for help): p

Disk /dev/hde: 16 heads, 63 sectors, 15871 cylinders
Units = cylinders of 1008 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hde1             1     15871   7998952+  83  Linux

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: If you have created or modified any DOS 6.x
partitions, please see the fdisk manual page for additional
information.
Syncing disks.
------------------
When trying to create the filesystem, I get this:

[root@alhambra /sbin]# ./mke2fs /dev/hde1
mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
/dev/hde1: Invalid argument passed to ext2 library while setting up
superblock
-------------------

I'm using
Linux version 2.2.17-14 (root@porky.devel.redhat.com) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Feb 5 16:02:20 EST
2001

The IDE controller is
  Bus  0, device  17, function  0:
    Unknown mass storage controller: Promise Technology Unknown device (rev
2).
      Vendor id=105a. Device id=d30.
      Medium devsel.  IRQ 10.  Master Capable.  Latency=32.
      I/O at 0x9000 [0x9001].
      I/O at 0x8800 [0x8801].
      I/O at 0x8400 [0x8401].
      I/O at 0x8000 [0x8001].
      I/O at 0x7800 [0x7801].
      Non-prefetchable 32 bit memory at 0xdd800000 [0xdd800000].
[root@alhambra /proc]#

Any suggestion?

