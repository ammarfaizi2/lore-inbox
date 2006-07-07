Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWGGMiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWGGMiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWGGMiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:38:11 -0400
Received: from lucidpixels.com ([66.45.37.187]:35801 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932146AbWGGMiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:38:09 -0400
Date: Fri, 7 Jul 2006 08:38:08 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
cc: linux-raid@vger.kernel.org
Subject: Kernel 2.6.17 and RAID5 Grow Problem (critical section backup)
Message-ID: <Pine.LNX.4.64.0607070830450.2648@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

p34:~# mdadm /dev/md3 -a /dev/hde1
mdadm: added /dev/hde1

p34:~# mdadm -D /dev/md3
/dev/md3:
         Version : 00.90.03
   Creation Time : Fri Jun 30 09:17:12 2006
      Raid Level : raid5
      Array Size : 1953543680 (1863.04 GiB 2000.43 GB)
     Device Size : 390708736 (372.61 GiB 400.09 GB)
    Raid Devices : 6
   Total Devices : 7
Preferred Minor : 3
     Persistence : Superblock is persistent

     Update Time : Fri Jul  7 08:25:44 2006
           State : clean
  Active Devices : 6
Working Devices : 7
  Failed Devices : 0
   Spare Devices : 1

          Layout : left-symmetric
      Chunk Size : 512K

            UUID : e76e403c:7811eb65:73be2f3b:0c2fc2ce
          Events : 0.232940

     Number   Major   Minor   RaidDevice State
        0      22        1        0      active sync   /dev/hdc1
        1      56        1        1      active sync   /dev/hdi1
        2       3        1        2      active sync   /dev/hda1
        3       8       49        3      active sync   /dev/sdd1
        4      88        1        4      active sync   /dev/hdm1
        5       8       33        5      active sync   /dev/sdc1

        6      33        1        -      spare   /dev/hde1
p34:~# mdadm --grow /dev/md3 --raid-disks=7
mdadm: Need to backup 15360K of critical section..
mdadm: Cannot set device size/shape for /dev/md3: No space left on device
p34:~# mdadm --grow /dev/md3 --bitmap=internal --raid-disks=7
mdadm: can change at most one of size, raiddisks, bitmap, and layout
p34:~# umount /dev/md3
p34:~# mdadm --grow /dev/md3 --raid-disks=7
mdadm: Need to backup 15360K of critical section..
mdadm: Cannot set device size/shape for /dev/md3: No space left on device
p34:~#

The disk only has about 350GB of 1.8TB used, any idea why I get this 
error?

I searched google but could not find anything on this issue when trying to 
grow the array?


