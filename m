Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWF2LoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWF2LoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWF2LoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:44:21 -0400
Received: from tornado.reub.net ([202.89.145.182]:18847 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S964798AbWF2LoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:44:20 -0400
Message-ID: <44A3BD0B.7060408@reub.net>
Date: Thu, 29 Jun 2006 23:44:11 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060623)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: Re: 2.6.17-mm4
References: <20060629013643.4b47e8bd.akpm@osdl.org>
In-Reply-To: <20060629013643.4b47e8bd.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2006 8:36 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm4/

> - The RAID patches have been dropped due to testing failures in -mm3.

Things are still not perfect on the raid front, but better than -mm3.  The raid
oopsing on boot is gone, but my RAID-1 arrays seem to be coming up degraded for 
no obvious reason.  The system was shut down fine before booting -mm3 and comes 
up OK after reverting to the older -mm releases (eg -mm1) and the supposedly 
faulty partitions readded back into the array.

[root@tornado ~]# cat /proc/mdstat
Personalities : [raid1]
md1 : active raid1 sdc3[2](F) sda3[0]
       4891712 blocks [2/1] [U_]
       bitmap: 13/150 pages [52KB], 16KB chunk

md2 : active raid1 sdc5[2](F) sda5[0]
       4891648 blocks [2/1] [U_]
       bitmap: 36/150 pages [144KB], 16KB chunk

md3 : active raid1 sdc6[2](F) sda6[0]
       104320 blocks [2/1] [U_]
       bitmap: 1/13 pages [4KB], 4KB chunk

md4 : active raid1 sdc7[1] sda7[2](F)
       497856 blocks [2/1] [_U]
       bitmap: 11/61 pages [44KB], 4KB chunk

md6 : active raid1 sdc10[1] sda10[0]
       20008832 blocks [2/2] [UU]

md5 : active raid1 sdc11[2](F) sda11[0]
       20008832 blocks [2/1] [U_]

md0 : active raid1 sdc2[2](F) sda2[0]
       24410688 blocks [2/1] [U_]
       bitmap: 9/187 pages [36KB], 64KB chunk

unused devices: <none>
[root@tornado ~]#

 From dmesg:

md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdc11 ...
md:  adding sdc11 ...
md: sdc10 has different UUID to sdc11
md: sdc7 has different UUID to sdc11
md: sdc6 has different UUID to sdc11
md: sdc5 has different UUID to sdc11
md: sdc3 has different UUID to sdc11
md: sdc2 has different UUID to sdc11
md:  adding sda11 ...
md: sda10 has different UUID to sdc11
md: sda7 has different UUID to sdc11
md: sda6 has different UUID to sdc11
md: sda5 has different UUID to sdc11
md: sda3 has different UUID to sdc11
md: sda2 has different UUID to sdc11
md: created md5
md: bind<sda11>
md: bind<sdc11>
md: running: <sdc11><sda11>
raid1: raid set md5 active with 2 out of 2 mirrors
md: considering sdc10 ...
md:  adding sdc10 ...
md: sdc7 has different UUID to sdc10
md: sdc6 has different UUID to sdc10
md: sdc5 has different UUID to sdc10
md: sdc3 has different UUID to sdc10
md: sdc2 has different UUID to sdc10
md:  adding sda10 ...
md: sda7 has different UUID to sdc10
md: sda6 has different UUID to sdc10
md: sda5 has different UUID to sdc10
md: sda3 has different UUID to sdc10
md: sda2 has different UUID to sdc10
md: created md6
md: bind<sda10>
md: bind<sdc10>
md: running: <sdc10><sda10>
raid1: raid set md6 active with 2 out of 2 mirrors
md: considering sdc7 ...
md:  adding sdc7 ...
md: sdc6 has different UUID to sdc7
md: sdc5 has different UUID to sdc7
md: sdc3 has different UUID to sdc7
md: sdc2 has different UUID to sdc7
md:  adding sda7 ...
md: sda6 has different UUID to sdc7
md: sda5 has different UUID to sdc7
md: sda3 has different UUID to sdc7
md: sda2 has different UUID to sdc7
md: created md4
md: bind<sda7>
md: bind<sdc7>
md: running: <sdc7><sda7>
raid1: raid set md4 active with 2 out of 2 mirrors
md4: bitmap initialized from disk: read 4/4 pages, set 7 bits, status: 0
created bitmap (61 pages) for device md4
raid1: Disk failure on sda7, disabling device.
         Operation continuing on 1 devices
md: considering sdc6 ...
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:1, o:0, dev:sda7
  disk 1, wo:0, o:1, dev:sdc7
md:  adding sdc6 ...
md: sdc5 has different UUID to sdc6
md: sdc3 has different UUID to sdc6
md: sdc2 has different UUID to sdc6
md:  adding sda6 ...
md: sda5 has different UUID to sdc6
RAID1 conf printout:
  --- wd:1 rd:2
  disk 1, wo:0, o:1, dev:sdc7
md: sda3 has different UUID to sdc6
md: sda2 has different UUID to sdc6
md: created md3
md: bind<sda6>
md: bind<sdc6>
md: running: <sdc6><sda6>
raid1: raid set md3 active with 2 out of 2 mirrors
md3: bitmap initialized from disk: read 1/1 pages, set 2 bits, status: 0
created bitmap (13 pages) for device md3
raid1: Disk failure on sdc6, disabling device.
         Operation continuing on 1 devices
md: considering sdc5 ...
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:0, o:1, dev:sda6
  disk 1, wo:1, o:0, dev:sdc6
md:  adding sdc5 ...
md: sdc3 has different UUID to sdc5
md: sdc2 has different UUID to sdc5
md:  adding sda5 ...
md: sda3 has different UUID to sdc5
md: sda2 has different UUID to sdc5
md: created md2
md: bind<sda5>
md: bind<sdc5>
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:0, o:1, dev:sda6
md: running: <sdc5><sda5>
raid1: raid set md2 active with 2 out of 2 mirrors
md2: bitmap initialized from disk: read 10/10 pages, set 80 bits, status: 0
created bitmap (150 pages) for device md2
raid1: Disk failure on sdc5, disabling device.
         Operation continuing on 1 devices
md: considering sdc3 ...
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:0, o:1, dev:sda5
  disk 1, wo:1, o:0, dev:sdc5
md:  adding sdc3 ...
md: sdc2 has different UUID to sdc3
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:0, o:1, dev:sda5
md:  adding sda3 ...
md: sda2 has different UUID to sdc3
md: created md1
md: bind<sda3>
md: bind<sdc3>
md: running: <sdc3><sda3>
raid1: raid set md1 active with 2 out of 2 mirrors
md1: bitmap initialized from disk: read 10/10 pages, set 55 bits, status: 0
created bitmap (150 pages) for device md1
raid1: Disk failure on sdc3, disabling device.
         Operation continuing on 1 devices
md: considering sdc2 ...
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:0, o:1, dev:sda3
  disk 1, wo:1, o:0, dev:sdc3
md:  adding sdc2 ...
md:  adding sda2 ...
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:0, o:1, dev:sda3
md: created md0
md: bind<sda2>
md: bind<sdc2>
md: running: <sdc2><sda2>
raid1: raid set md0 active with 2 out of 2 mirrors
md0: bitmap initialized from disk: read 12/12 pages, set 37 bits, status: 0
created bitmap (187 pages) for device md0
raid1: Disk failure on sdc2, disabling device.
         Operation continuing on 1 devices
md: ... autorun DONE.
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:0, o:1, dev:sda2
  disk 1, wo:1, o:0, dev:sdc2
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:0, o:1, dev:sda2
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.


Here's one of the arrays:

[root@tornado ~]# mdadm --examine /dev/sda5
/dev/sda5:
           Magic : a92b4efc
         Version : 00.90.01
            UUID : d18ac80d:63c7bd9d:8cbb8566:6a378891
   Creation Time : Sun Sep  4 18:25:28 2005
      Raid Level : raid1
     Device Size : 4891648 (4.67 GiB 5.01 GB)
      Array Size : 4891648 (4.67 GiB 5.01 GB)
    Raid Devices : 2
   Total Devices : 2
Preferred Minor : 2

     Update Time : Thu Jun 29 23:34:42 2006
           State : clean
Internal Bitmap : present
  Active Devices : 1
Working Devices : 1
  Failed Devices : 1
   Spare Devices : 0
        Checksum : 5f63b753 - correct
          Events : 0.16052320


       Number   Major   Minor   RaidDevice State
this     0       8        5        0      active sync   /dev/sda5

    0     0       8        5        0      active sync   /dev/sda5
    1     1       0        0        1      faulty removed
[root@tornado ~]# mdadm --examine /dev/sdc5
/dev/sdc5:
           Magic : a92b4efc
         Version : 00.90.01
            UUID : d18ac80d:63c7bd9d:8cbb8566:6a378891
   Creation Time : Sun Sep  4 18:25:28 2005
      Raid Level : raid1
     Device Size : 4891648 (4.67 GiB 5.01 GB)
      Array Size : 4891648 (4.67 GiB 5.01 GB)
    Raid Devices : 2
   Total Devices : 2
Preferred Minor : 2

     Update Time : Thu Jun 29 23:08:32 2006
           State : clean
Internal Bitmap : present
  Active Devices : 2
Working Devices : 2
  Failed Devices : 0
   Spare Devices : 0
        Checksum : 5f63b148 - correct
          Events : 0.16052318


       Number   Major   Minor   RaidDevice State
this     1       8       37        1      active sync   /dev/sdc5

    0     0       8        5        0      active sync   /dev/sda5
    1     1       8       37        1      active sync   /dev/sdc5
[root@tornado ~]#

Reuben

