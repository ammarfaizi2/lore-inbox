Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129861AbRBAKSt>; Thu, 1 Feb 2001 05:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129917AbRBAKSk>; Thu, 1 Feb 2001 05:18:40 -0500
Received: from proxy1.braun.de ([193.17.96.34]:58593 "EHLO relay-ext.braun.de")
	by vger.kernel.org with ESMTP id <S129861AbRBAKSb>;
	Thu, 1 Feb 2001 05:18:31 -0500
Message-ID: <3A7937EE.1030104@gmx.de>
Date: Thu, 01 Feb 2001 11:18:22 +0100
From: Daniel Schroeter <d.schroeter@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; m18) Gecko/20010116
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: raid-1 with raid-0 and normal disk -> performance and autostart?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
i using kernel 2.4.1. mkraid version 0.90.0
i build /dev/md0 raid-0 with hda5 and sda1. then i build /dev/md1 raid-1 
with /dev/md0 and sdb1.
it works fine.
BUT the resync takes a long time. i have a performance from 253K/sec. 
whats there wrong?
[root@mendocino <mailto:root@mendocino> /root]# cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5]
read_ahead 1024 sectors
md0 : active raid1 md1[1] sdb1[0]
      8891712 blocks [2/2] [UU]
      [>....................]  resync =  0.0% (5572/8891712) 
finish=581.8min speed=253K/sec
md1 : active raid0 sda1[1] hda5[0]
      8891776 blocks 4k chunks

unused devices: <none>

if i build a raid-1 with sdb1 and hda5 i get:

Personalities : [linear] [raid0] [raid1] [raid5]
read_ahead 1024 sectors
md0 : active raid1 sdb1[1] hda5[0]
      4449920 blocks [2/2] [UU]
      [>....................]  resync =  0.4% (21952/4449920) 
finish=10.0min speed=7317K/sec
unused devices: <none>

i get the same speer also with sda1 and sdb1.
any ideas?

i will mount the raid-10 (or 01???) as "/". but the autodetection 
doesn't work corect. the partitions are all "Linux raid autodetect". the 
raid-0 starts fine. if he tries to start the raid-1 the dev md0 will not 
integrated in the array. must i start a ramdisk, and starting there 
manuell the raid-1? if i change md1 and md0 it's the same.

THNX
CU
    daniel


raidtab:

raiddev /dev/md0
    raid-level                0
    nr-raid-disks             2
    persistent-superblock     1
    chunk-size                4

    device                    /dev/hda5
    raid-disk                 0
    device                    /dev/sda1
    raid-disk                 1

raiddev /dev/md1
    raid-level                1
    nr-raid-disks             2
   persistent-superblock     1 # i tried also 0 here
    chunk-size                4

    device                    /dev/sdb1
    raid-disk                 0
    device                    /dev/md0
    raid-disk                 1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
