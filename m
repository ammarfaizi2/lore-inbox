Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbTA3MdS>; Thu, 30 Jan 2003 07:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267498AbTA3MdR>; Thu, 30 Jan 2003 07:33:17 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:53509 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267497AbTA3MdQ>; Thu, 30 Jan 2003 07:33:16 -0500
Date: Thu, 30 Jan 2003 13:42:24 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: raid-0/reiserfs problem; file system not recognized after reboot
Message-ID: <20030130124224.GA8844@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with raid-0 and reiserfs in linux-2.4.21-pre3-ac5 on
Debian/Testing.

When I create two raid-0 partitions with this script:

umount /dev/md0
umount /dev/md1
raidstop /dev/md0
raidstop /dev/md1
dd if=/dev/zero of=/dev/hdi bs=512 count=1
dd if=/dev/zero of=/dev/hdk bs=512 count=1
fdisk /dev/hdi < /root/fdisk.in
fdisk /dev/hdk < /root/fdisk.in
mkraid --really-force /dev/md0
mkraid --really-force /dev/md1
yes | mkreiserfs /dev/md0
yes | mkreiserfs /dev/md

with fdisk.in like this:

n
p
1

140000
t
fd
n
p
2


t
2
fd
w
p
q

and the partitions like this:

Disk /dev/hdi: 80.0 GB, 80026361856 bytes
16 heads, 63 sectors/track, 155061 cylinders
Units = cylinders of 1008 * 512 = 516096 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdi1             1    140000  70559968+  fd  Linux raid autodetect
/dev/hdi2        140001    155061   7590744   fd  Linux raid autodetect

Disk /dev/hdk: 80.0 GB, 80026361856 bytes
16 heads, 63 sectors/track, 155061 cylinders
Units = cylinders of 1008 * 512 = 516096 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdk1             1    140000  70559968+  fd  Linux raid autodetect
/dev/hdk2        140001    155061   7590744   fd  Linux raid autodetect

I can mount both /dev/md0 and /dev/md1 without any trouble.

After a reboot, I see this:

:mount /dev/md1 /space6
reiserfs: checking transaction log (device 09:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
:mount /dev/md0 /space5
FAT: bogus logical sector size 0
VFS: Can't find a valid FAT filesystem on dev 09:00.
mount: you must specify the filesystem type
:mount -t reiserfs /dev/md0 /space5
read_super_block: can't find a reiserfs filesystem on (dev 09:00, block 128, size 512)
read_super_block: can't find a reiserfs filesystem on (dev 09:00, block 16, size 512)
mount: wrong fs type, bad option, bad superblock on /dev/md0,
       or too many mounted file systems
:r /proc/mdstat

Personalities : [raid0] 
read_ahead 1024 sectors
md1 : active raid0 hdi1[0] hdk1[1]
      141119744 blocks 64k chunks
      
md0 : active raid0 hdi[0] hdk[1]
      156301312 blocks 64k chunks
      
unused devices: <none>

I searched google (www/usenet) and didn't find any hints. I'm not
mounting the partitions from fstab, so the raid process is started at
the correct time.

Can anybody point me to the error I'm making?

Thanks,
Jurriaan
-- 
HORROR FILM WISDOM:
1. When it seems that you've killed the monster, never check to see if
it's really dead.
GNU/Linux 2.4.21-pre3-ac5 SMP/ReiserFS 1x2824 bogomips load av: 0.29 0.61 0.31
