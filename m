Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271920AbRH2GzQ>; Wed, 29 Aug 2001 02:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271922AbRH2GzG>; Wed, 29 Aug 2001 02:55:06 -0400
Received: from [195.66.192.167] ([195.66.192.167]:36874 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271920AbRH2Gy7>; Wed, 29 Aug 2001 02:54:59 -0400
Date: Wed, 29 Aug 2001 09:54:13 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <22075604.20010829095413@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: fsck root fs: fsck, devfs, /proc/mounts miscooperate.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I use devfs to manage my /dev.
I symlinked /etc/mtab to /proc/mounts.
My root fs is on /dev/sdb1 and stays RO.
There is not /etc/fstab entry for it
(I hate making new Linux partitions by copying my old system, boot
them and discover I forgot to change root entry in /etc/fstab - kernel
already knows where root is, so why do I need to tell that?).

I have trouble with fsck'ing my root fs from init script.
As you can see below:
"fsck /" can't figure out from where my root is mounted.
"fsck /dev/sdb1" works fine, but that means init script must be
modified when root mount point is changed.
"fsck /dev/scsi/host0/bus0/target1/lun0/part1" is suitable for init
script (I could get dev name from /proc/mounts)
but complaining about mounted fs (why? my root fs is RO).

So, how can I fsck my root?

# cat /etc/mtab
/dev/scsi/host0/bus0/target1/lun0/part1 / ext2 ro 0 0
...

# fsck /
Parallelizing fsck version 1.15 (18-Jul-1999)
e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
/sbin/e2fsck: Is a directory while trying to open /

The superblock could not be read or does not describe a correct ext2
filesystem...

# fsck /dev/sdb1
Parallelizing fsck version 1.15 (18-Jul-1999)
e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
/dev/sdb1: clean, 6416/122400 files, 86059/488432 blocks

# fsck /dev/scsi/host0/bus0/target1/lun0/part1
Parallelizing fsck version 1.15 (18-Jul-1999)
e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
/dev/scsi/host0/bus0/target1/lun0/part1 is mounted.

WARNING!!!  Running e2fsck on a mounted filesystem may cause
SEVERE filesystem damage...
-- 
Best regards,
VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


