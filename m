Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUARK2i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 05:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUARK2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 05:28:38 -0500
Received: from c215067.adsl.hansenet.de ([213.39.215.67]:2688 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S265847AbUARK17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 05:27:59 -0500
Message-ID: <400A5FAA.5030504@portrix.net>
Date: Sun, 18 Jan 2004 11:27:54 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext3 on raid5 failure
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've recently upgraded my fileserver to 2.6.1 and since then I had to 
reboot two times because of the following errors. Afterwards the 
blockdevice was set readonly, so I couldn't even remount the partition 
rw. Interestingly after reboot the raid is not marked dirty. So is this 
an ext3 only error?
This never happenend with 2.4.23pre6-aa3 or any other 2.4 version which 
run for about a year on this system without any (linux caused) downtime.
What I can try to debug this? The first time it happened after about 3 
or 4 days uptime, the second time after about 1 day. So it's pretty 
reproducible.

Thanks,

Jan

EXT3-fs error (device dm-1): ext3_readdir: bad entry in directory 
#9783034: rec_len % 4 != 0 - offset=0, inode=1846971784, rec_len=33046, 
name_len=154
Aborting journal on device dm-1.
ext3_abort called.
EXT3-fs abort (device dm-1): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only

and

EXT3-fs error (device dm-1): ext3_readdir: bad entry in directory 
#8422045: rec_len % 4 != 0 - offset=0, inode=655393188, rec_len=1998, 
name_len=0
Aborting journal on device dm-1.
ext3_abort called.
EXT3-fs abort (device dm-1): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only
EXT3-fs error (device dm-1) in start_transaction: Journal has aborted


$ cat /proc/mdstat
Personalities : [raid5]
read_ahead 1024 sectors
md0 : active raid5 ide/host2/bus1/target1/lun0/part1[3]
ide/host2/bus1/target0/lun0/part1[1]
ide/host2/bus0/target1/lun0/part1[2]
ide/host2/bus0/target0/lun0/part1[0]
ide/host0/bus1/target0/lun0/part1[4]
       468872704 blocks level 5, 4k chunk, algorithm 2 [5/5] [UUUUU]

$ vgdisplay:
   --- Volume group ---
   VG Name               myraid
   System ID
   Format                lvm2
   Metadata Areas        1
   Metadata Sequence No  7
   VG Access             read/write
   VG Status             resizable
   MAX LV                256
   Cur LV                2
   Open LV               2
   Max PV                256
   Cur PV                1
   Act PV                1
   VG Size               447.15 GB
   PE Size               4.00 MB
   Total PE              114470
   Alloc PE / Size       114470 / 447.15 GB
   Free  PE / Size       0 / 0
   VG UUID               0xPsvH-t204-YlD4-jVAW-mYgK-ndF5-nEVOTk

$ lvdisplay:
   --- Logical volume ---
   LV Name                /dev/myraid/lvol0
   VG Name                myraid
   LV UUID                X47Raw-ZGgE-PZ4I-F1o3-lYX9-TVQ1-KIWqrs
   LV Write Access        read/write
   LV Status              available
   # open                 1
   LV Size                100.00 GB
   Current LE             25600
   Segments               1
   Allocation             next free (default)
   Read ahead sectors     0
   Block device           254:1

   --- Logical volume ---
   LV Name                /dev/myraid/lvol1
   VG Name                myraid
   LV UUID                LgnX1d-r3BP-3u7t-yLQb-iRke-544J-v7uBBd
   LV Write Access        read/write
   LV Status              available
   # open                 1
   LV Size                347.15 GB
   Current LE             88870
   Segments               1
   Allocation             next free (default)
   Read ahead sectors     0
   Block device           254:2

$ mount -l
/dev/mapper/myraid-lvol1 on /mnt/data/1 type ext3 (rw)
/dev/mapper/myraid-lvol0 on /mnt/backup type ext3 (rw)

