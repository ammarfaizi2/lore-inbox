Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131262AbRBDAUn>; Sat, 3 Feb 2001 19:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131252AbRBDAUd>; Sat, 3 Feb 2001 19:20:33 -0500
Received: from ecstasy.ksu.ru ([193.232.252.41]:47309 "EHLO ecstasy.ksu.ru")
	by vger.kernel.org with ESMTP id <S131262AbRBDAUT>;
	Sat, 3 Feb 2001 19:20:19 -0500
X-Pass-Through: Kazan State University network
Message-ID: <3A7C9D95.6090501@ksu.ru>
Date: Sun, 04 Feb 2001 03:08:53 +0300
From: Art Boulatov <art@ksu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10-pre5-reiserfs-3.6.18-acpi-i2c i686; en-US; 0.6) Gecko/20001205
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [SoftwareRAID in 2.4.1] md_import_device() returned -22
X-Priority: 1 (highest)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could anybody please help me to resolve why this error is returned?
(md_import_device() returned -22)

I'm trying to setup software RAID0
on Asus CUR-DLS (dual channel ULTRA2 SCSI - sym53c896).

kernel is pure 2.4.1(SMP),
with devfs, sym53c8xx and raid0 support linked in.

raidtools are 19990824-0.90 from kernel.org.

Here is /etc/raidtab:
-----
raiddev         /dev/md/0

raid-level      0

persistent-superblock   1

chunk-size      16

nr-raid-disks   2

device  /dev/scsi/host0/bus0/target0/lun0/part1
raid-disk       0

device  /dev/scsi/host0/bus0/target1/lun0/part1
raid-disk       1

#same bus because I have only one cable right now :)

---------

And here is what I got with "mkraid /dev/md/0":
---------
handling MD device /dev/md/0
analyzing super-block
disk 0: /dev/scsi/host0/bus0/target0/lun0/part1, 17921008kB, raid 
superblock at 17920896kB
disk 1: /dev/scsi/host0/bus0/target1/lun0/part1, 17921008kB, raid 
superblock at 17920896kB
mkraid: aborted, see the syslog and /proc/mdstat for potential clues.
----------

And syslog says:
--------
modprobe: modprobe: Can't locate module block-major-8
kernel: md: could not lock scsi/host0/bus0/target0/lun0/part1, 
zero-size? Marking faulty.
kernel: md: error, md_import_device() returned -22
-----------

Is that "modprobe" line causing problem?
But I have compiled scsi driver in...

Or is that a devfs issue or am I doing anything wrong?

I would really be glad to get some pointers to the answer,
since I can't figure that out myself.

Thanks a lot,
Art.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
