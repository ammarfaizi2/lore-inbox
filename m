Return-Path: <linux-kernel-owner+w=401wt.eu-S1750907AbXAPNj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbXAPNj4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 08:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbXAPNjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 08:39:55 -0500
Received: from aurora.bayour.com ([212.214.70.50]:45341 "EHLO
	aurora.bayour.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbXAPNjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 08:39:55 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 08:39:53 EST
To: linux-kernel@vger.kernel.org
Subject: Weird harddisk behaviour
X-PGP-Fingerprint: B7 92 93 0E 06 94 D6 22  98 1F 0B 5B FE 33 A1 0B
X-PGP-Key-ID: 0x788CD1A9
X-URL: http://www.bayour.com/
From: Turbo Fredriksson <turbo@bayour.com>
Organization: Bah!
Date: Tue, 16 Jan 2007 14:27:06 +0100
Message-ID: <87bqkzp0et.fsf@pumba.bayour.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of weeks ago my 400Gb SATA disk crashed. I just
got the replacement, but I can't seem to be able to create
a filesystem on it!

This is a PPC (Pegasos), running 2.6.15-27-powerpc (Ubuntu Dapper v2.6.15-27.50).

----- s n i p -----
root@pegasos:~# cfdisk -P s /dev/sda
Partition Table for /dev/sda

               First       Last
 # Type       Sector      Sector   Offset    Length   Filesystem Type (ID) Flag
-- ------- ----------- ----------- ------ ----------- -------------------- ----
 1 Primary           0   781417664     63   781417665 Linux raid auto (FD) None
root@pegasos:~# cfdisk -P s /dev/sdb
Partition Table for /dev/sdb

               First       Last
 # Type       Sector      Sector   Offset    Length   Filesystem Type (ID) Flag
-- ------- ----------- ----------- ------ ----------- -------------------- ----
 1 Primary           0   781417664     63   781417665 Linux raid auto (FD) None
root@pegasos:~# mke2fs -v -j /dev/sdb1
mke2fs 1.38 (30-Jun-2005)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
48840704 inodes, 97677200 blocks
4883860 blocks (5.00%) reserved for the super user
First data block=0
2981 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968

Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 36 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
root@pegasos:~# e2fsck /dev/sdb1
e2fsck 1.38 (30-Jun-2005)
e2fsck: Filesystem revision too high while trying to open /dev/sdb1
The filesystem revision is apparently too high for this version of e2fsck.
(Or the filesystem superblock is corrupt)


The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b 8193 <device>

root@pegasos:~# mount /dev/sdb1 /mnt/sdb
mount: wrong fs type, bad option, bad superblock on /dev/sdb1,
       missing codepage or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

root@pegasos:~# dmesg | tail -n1
[154695.371073] EXT3-fs: sdb1: couldn't mount because of unsupported optional features (20000).
----- s n i p -----

I tried using fdisk instead. Note that fdisk finds a different
partition table than cfdisk above!

----- s n i p -----
root@pegasos:~# fdisk -l /dev/sdb
/dev/sdb
        #                    type name                  length   base      ( size )  system
/dev/sdb1    Apple_partitiooma}amamamamamama Apple                     63 @ 1         ( 31.5k)  Unknown
/dev/sdb2    Apple_gee_e_e_e_e_e_ o%Gï¿½%@~%Gï¿½%@o%Gï¿½%@.%Gï¿½%@.%Gï¿½%@.%Gï¿½%@.%Gï¿½%@     781434611 @ 781397715 (372.6G)  Unknown

Block size=512, Number of Blocks=781422768
DeviceType=0x0, DeviceId=0x0

root@pegasos:~# dd if=/dev/zero of=/dev/sdb count=10000
10000+0 records in
10000+0 records out
5120000 bytes (5.1 MB) copied, 0.366181 seconds, 14.0 MB/s
root@pegasos:~# fdisk -l /dev/sdb
root@pegasos:~# cfdisk -P s /dev/sdb
FATAL ERROR: No partition table.

=> [fdisk /dev/sdb and chooses 'initialize partition map'] <=
root@pegasos:~# fdisk -l /dev/sdb
/dev/sdb
        #                    type name                  length   base      ( size )  system
/dev/sdb1    Apple_partitmooma}amamamamamama Apple                     63 @ 1         ( 31.5k)  Unknown
/dev/sdb2    Apple_gee_e_e_e_e_e_ o%Gï¿½%@~%Gï¿½%@o%Gï¿½%@.%Gï¿½%@.%Gï¿½%@.%Gï¿½%@.%Gï¿½%@     781434611 @ 781397715 (372.6G)  Unknown

Block size=512, Number of Blocks=781422768
DeviceType=0x0, DeviceId=0x0

root@pegasos:~# cfdisk -P s /dev/sdb
FATAL ERROR: No partition table.

=> [fdisk /dev/sdb and deletes both partitions (!!)] <=
root@pegasos:~# fdisk -l /dev/sdb
/dev/sdb
        #                    type name                  length   base      ( size )  system
/dev/sdb1              Apple_Free Extra                     63 @ 1         ( 31.5k)  Free space
/dev/sdb2    Apple_gee_e_e_e_e_e_ o%Gï¿½%@~%Gï¿½%@o%Gï¿½%@.%Gï¿½%@.%Gï¿½%@.%Gï¿½%@.%Gï¿½%@     781434611 @ 781397715 (372.6G)  Unknown

Block size=512, Number of Blocks=781422768
DeviceType=0x0, DeviceId=0x0

=> [in the syslog during the fdisk sessions:] <=
root@pegasos:~# tail -f /var/log/syslog -n0
Jan 16 07:15:59 localhost kernel: [154926.816696] SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
Jan 16 07:15:59 localhost kernel: [154926.817340] SCSI device sdb: drive cache: write back
Jan 16 07:15:59 localhost kernel: [154926.817515]  sdb: [mac] sdb1 sdb2
Jan 16 07:15:59 localhost kernel: [154926.987204] printk: 292503 messages suppressed.
Jan 16 07:15:59 localhost kernel: [154926.987230] Buffer I/O error on device sdb2, logical block 781434368
Jan 16 07:15:59 localhost kernel: [154926.987238] Buffer I/O error on device sdb2, logical block 781434369
Jan 16 07:15:59 localhost kernel: [154926.987245] Buffer I/O error on device sdb2, logical block 781434370
Jan 16 07:15:59 localhost kernel: [154926.987252] Buffer I/O error on device sdb2, logical block 781434371
Jan 16 07:15:59 localhost kernel: [154926.987258] Buffer I/O error on device sdb2, logical block 781434372
Jan 16 07:15:59 localhost kernel: [154926.987265] Buffer I/O error on device sdb2, logical block 781434373
Jan 16 07:15:59 localhost kernel: [154926.987272] Buffer I/O error on device sdb2, logical block 781434374
Jan 16 07:15:59 localhost kernel: [154926.987279] Buffer I/O error on device sdb2, logical block 781434375
Jan 16 07:15:59 localhost kernel: [154926.988530] Buffer I/O error on device sdb2, logical block 781434368
Jan 16 07:15:59 localhost kernel: [154926.988538] Buffer I/O error on device sdb2, logical block 781434369
Jan 16 07:16:00 localhost kernel: [154927.448100] SMB connection re-established (-5)
Jan 16 07:16:01 localhost kernel: [154928.859934] SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
Jan 16 07:16:01 localhost kernel: [154928.865115] SCSI device sdb: drive cache: write back
Jan 16 07:16:01 localhost kernel: [154928.865381]  sdb: [mac] sdb1 sdb2
Jan 16 07:17:01 localhost /USR/SBIN/CRON[4826]: (root) CMD (   run-parts --report /etc/cron.hourly)
Jan 16 07:17:41 localhost kernel: [155028.253528] SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
Jan 16 07:17:41 localhost kernel: [155028.259334] SCSI device sdb: drive cache: write back
Jan 16 07:17:41 localhost kernel: [155028.259613]  sdb: [mac] sdb1 sdb2
Jan 16 07:17:41 localhost kernel: [155028.377550] printk: 254 messages suppressed.
Jan 16 07:17:41 localhost kernel: [155028.377577] Buffer I/O error on device sdb2, logical block 781434368
Jan 16 07:17:41 localhost kernel: [155028.377586] Buffer I/O error on device sdb2, logical block 781434369
Jan 16 07:17:41 localhost kernel: [155028.377593] Buffer I/O error on device sdb2, logical block 781434370
Jan 16 07:17:41 localhost kernel: [155028.377600] Buffer I/O error on device sdb2, logical block 781434371
Jan 16 07:17:41 localhost kernel: [155028.377606] Buffer I/O error on device sdb2, logical block 781434372
Jan 16 07:17:41 localhost kernel: [155028.377613] Buffer I/O error on device sdb2, logical block 781434373
Jan 16 07:17:41 localhost kernel: [155028.377620] Buffer I/O error on device sdb2, logical block 781434374
Jan 16 07:17:41 localhost kernel: [155028.377627] Buffer I/O error on device sdb2, logical block 781434375
Jan 16 07:17:41 localhost kernel: [155028.379062] Buffer I/O error on device sdb2, logical block 781434368
Jan 16 07:17:41 localhost kernel: [155028.379073] Buffer I/O error on device sdb2, logical block 781434369
Jan 16 07:17:43 localhost kernel: [155030.273386] SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
Jan 16 07:17:43 localhost kernel: [155030.279303] SCSI device sdb: drive cache: write back
Jan 16 07:17:43 localhost kernel: [155030.279591]  sdb: [mac] sdb1 sdb2
----- s n i p -----

Note that I don't get a pip in the logs if I do a dd from /dev/zero to /dev/sdb
and the full length/size of the disk.  Also not a word about I/O errors when
mkfs'ing the disk...
This when using cfdisk to partition the disk! I only get that when I'm using
the MAC table (!?).


If I use cfdisk to create ONE partition, but which starts a couple of megs
in (cfdisk say the disk is exactly 400085.84Mb so if I create a partition
that's 400000Mb and which is located at the _end_ of the disk), then the
partition isn't found!

----- s n i p -----
                                  cfdisk 2.12r

                              Disk Drive: /dev/sdb
                       Size: 400088457216 bytes, 400.0 GB
             Heads: 255   Sectors per Track: 63   Cylinders: 48641

    Name        Flags      Part Type  FS Type          [Label]        Size (MB)
 ------------------------------------------------------------------------------
                            Pri/Log   Free Space                          82.26
    sdb1                    Primary   Linux                           400003.60
[... quit ...]
root@pegasos:~# cfdisk -P s /dev/sdb
FATAL ERROR: Bad primary partition 0: Partition ends after end-of-disk
----- s n i p -----

I also saw this 'after end-of-disk' problem earlier (can't reproduce it now
though). When I used 'less -f /dev/sdb' (didn't have any partitions then)
less stopped after a few bytes. Also 'dd if=/dev/sdb | hexdump -c' stopped
after only a few lines/bytes.

The whole reason I found out that something was seriosly wrong with this/it
was that I could not do a 'pvcreate' on the disk (choosed to use disk, not
partition):

----- s n i p -----
root@pegasos:~# pvcreate /dev/sdb
  Physical volume "/dev/sdb" successfully created
root@pegasos:~# pvscan
  PV /dev/md0   VG movies   lvm2 [372.61 GB / 0    free]
  PV /dev/hdb               lvm2 [74.53 GB]
  Total: 2 [447.14 GB] / in use: 1 [372.61 GB] / in no VG: 1 [74.53 GB]
----- s n i p -----

If/when I get sdb working, it will become the degraded md1 which I could
vgcreate togheter with md0 which is now mounted. Md1 is also a degraded
mirror - containing only sda - which is an identical disk as sdb.

The smallest 'Free Space' I can create (see above) seems to be 8.23Mb
and that doesn't show 'Partition ends after end-of-disk' but still
shows the same 'unsupported optional features' in the logs...
Next step(s) is: 16.46, 24.68, 32.91, 41.13. At 41.13, I get (in syslog)
'sdb: unknown partition table' so somewhere between 32.91Mb and 41.13Mb
there's something "weird" (sorry, but I have NO idea how else to describe
it :).


Just in case someone wonders/cares about the two decraded mirrors... I
can't afford 4 400Gb disk at the moment, but I don't want to lock myself
into a corner (or complicate matters like have to move data back and forth)
when I DO afford more disk. I could just add disk(s) to the mirrors...
Guess I could do that with LVM to, but I don't have much experience
with LVM at the moment, but I do know md quite well...
