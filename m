Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284599AbRLPLo6>; Sun, 16 Dec 2001 06:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284607AbRLPLou>; Sun, 16 Dec 2001 06:44:50 -0500
Received: from maile.telia.com ([194.22.190.16]:10206 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S284584AbRLPLon>;
	Sun, 16 Dec 2001 06:44:43 -0500
Date: Sun, 16 Dec 2001 12:44:36 +0100 (MET)
From: Jurij Smakov <jurij.smakov@telia.com>
X-X-Sender: jurij@bobcat
To: linux-kernel@vger.kernel.org
cc: hahn@physics.mcmaster.ca
Subject: Re: PDC20265 IDE controller trouble
Message-ID: <Pine.GHP.4.43.0112161058510.11934-100000@bobcat>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001 13:15:57 -0500 (EST)
Mark Hahn <hahn@physics.mcmaster.ca> wrote:
> can you replicate this with benchmarks more sane than hdparm
> (like build a raid0, and run bonnie or iozone on an ext2 on it?)

Here are the bonnie results on a RAID0 in my setup (kernel 2.4.17-pre8,
raidtools 0.9.0, PDC20265 controller on Asus TUSL2 motherboard, 2 IBM
60GB disks, one disk per channel). /etc/raidtab contains:

raiddev /dev/md0
        raid-level 0
        nr-raid-disks 2
        persistent-superblock 1
        chunk-size 4
        device /dev/hde
        raid-disk 0
        device /dev/hdg
        raid-disk 1

mkraid /dev/md0
mke2fs /dev/md0
mount /dev/md0 /backup
bonnie -d /backup -n 1 -s 1024k -u0

Version  1.02  ------Sequential Output------ --Sequential Input- --Random-
               -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
          Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
            1G  2338  16  2442   1  2135   1  7674  54 75023  28 236.7   0
                          ^^^^
As one can see, the results of writing time are RIDICULOUSLY low (2.4
MB/sec), while reading is ok. For comparison, result of bonnie on a
separate disk, used in the array:

mke2fs /dev/hde
mount /dev/hde /hde
bonnie -d /hde -n 1 -s 1024k -u0

Version  1.02  ------Sequential Output------ --Sequential Input- --Random-
               -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
          Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
            1G 11127  79 35617  21 16186  12 12969  93 39762  13 225.0   0

The results for the second disk look similarly.

Best regards,

Jurij.


