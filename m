Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWFRKbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWFRKbF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 06:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWFRKbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 06:31:05 -0400
Received: from lucidpixels.com ([66.45.37.187]:21634 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751085AbWFRKbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 06:31:03 -0400
Date: Sun, 18 Jun 2006 06:31:02 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-raid@vger.kernel.org
cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: SW RAID 5 Bug? - Slow After Rebuild (XFS+2.6.16.20)
Message-ID: <Pine.LNX.4.64.0606180621530.2965@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I set a disk faulty and then rebuilt it, afterwards, I got horrible 
performance, I was using 2.6.16.20 during the tests.

The FS I use is XFS.

# xfs_info /dev/md3
meta-data=/dev/root              isize=256    agcount=16, agsize=1097941 
blks
          =                       sectsz=512   attr=0
data     =                       bsize=4096   blocks=17567056, imaxpct=25
          =                       sunit=0      swidth=0 blks, unwritten=1
naming   =version 2              bsize=4096
log      =internal               bsize=4096   blocks=8577, version=1
          =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0

After a raid5 rebuild before reboot:

$ cat 448mb.img > /dev/null

  0  1      4  25104     64 905560    0    0     4     0 1027   154  0  0 88 12
  0  0      4  14580     64 914128    0    0 14344    34 1081   718  0  2 77 21
  0  0      4  14516     64 912360    0    0 10312   184 1128  1376  0  3 97  0
  0  0      4  15244     64 911884    0    0 12660     0 1045  1248  0  3 97  0
  0  0      4  15464     64 911272    0    0 11916     0 1055  1081  0  3 98  0
  0  1      4  15100     64 915488    0    0  7844     0 1080   592  0  3 76 21
  0  1      4  13840     64 916780    0    0  1268     0 1295  1757  0  1 49 49
  0  1      4  13480     64 917188    0    0   388    48 1050   142  0  1 50 49
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  0  1      4  14816     64 915896    0    0   492     0 1047   321  0  1 49 49
  0  1      4  14504     64 916236    0    0   324     0 1022   108  0  2 50 49
  0  1      4  14144     64 916576    0    0   388     0 1021   108  0  1 50 50
  0  1      4  13904     64 916848    0    0   256     0 1043   159  0  0 50 49
  0  1      4  13728     64 917120    0    0   260    24 1032   102  0  1 50 49
  0  0      4  15244     64 913040    0    0 11856     0 1042  1315  0  3 90  7
  0  0      4  14564     64 913652    0    0 12288     0 1068  1137  1  3 97  0
  0  0      4  15252     64 912972    0    0 12288     0 1054  1128  0  3 97  0
  0  0      4  15132     64 913108    0    0 16384     0 1048  1368  0  4 96  0
  0  0      4  15372     64 912836    0    0 12288     0 1062  1125  0  3 97  0
  0  0      4  15660     64 912632    0    0 12288     0 1065  1093  0  3 97  0
  0  0      4  15388     64 912768    0    0 12288     0 1042  1051  0  3 97  0
  0  0      4  15028     64 913312    0    0 12288     0 1040  1122  0  3 97  0

With an ftp:
  0  1      4 208564     64 723660    0    0  8192     0 1945   495  0  4 53 44
  1  0      4 200592     64 731820    0    0  8192     0 1828   459  0  5 52 44
  0  0      4 194472     64 737940    0    0  6144     0 1396   220  0  2 50 47
  0  1      4 186128     64 746168    0    0  8192     0 1622   377  0  4 51 45
  0  1      4 180008     64 752288    0    0  6144     0 1504   339  0  3 51 46
  0  1      4 174012     64 758476    0    0  6144     0 1438   229  0  3 51 47
  0  1      4 167956     64 764596    0    0  6144     0 1498   263  0  2 51 46
  0  1      4 162084     64 770716    0    0  6144     0 1497   326  0  3 51 46
  0  1      4 156152     64 776904    0    0  6144     0 1476   293  0  3 51 47
  0  1      4 150048     64 783024    0    0  6144    20 1514   273  0  2 51 46

Also note, when I run 'sync' it would take up to 5 minutes!!! And I was 
not even doing anything on the array.

After reboot:

`448mb.img' at 161467144 (34%) 42.82M/s eta:7s [Receiving data] 
`448mb.img' at 283047424 (60%) 45.23M/s eta:4s [Receiving data] 
`448mb.img' at 406802192 (86%) 46.29M/s eta:1s [Receiving data]

Write speed to the RAID5 is also back to normal.

  0  0      0  16664      8 928940    0    0     0 44478 1522 19791  1 35 43 21
  0  0      0  15304      8 930368    0    0    20 49816 1437 19260  0 21 59 20
  0  0      4  16964      8 928324    0    0    20 50388 1410 20059  0 20 47 33
  0  0      4  13504      8 931928    0    0     0 46792 1449 16712  0 17 69 15
  0  0      4  14952      8 930432    0    0     8 43510 1489 16443  0 16 60 23
  0  0      4  16328      8 929072    0    0    36 50316 1498 16972  1 19 59 23
  0  1      4  16708      8 928460    0    0     0 45604 1504 17196  0 19 55 26
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  0  0      4  16968      8 928120    0    4     0 47640 1584 17821  0 19 57 25
  0  0      4  15160      8 929888    0    0     0 40836 1637 15335  0 17 63 19
  0  1      4  15372      8 929616    0    0     0 41932 1630 14862  0 17 64 19

Was curious if anyone else had seen this?

/dev/md3:
         Version : 00.90.03
   Creation Time : Sun Jun 11 16:52:00 2006
      Raid Level : raid5
      Array Size : 1562834944 (1490.44 GiB 1600.34 GB)
     Device Size : 390708736 (372.61 GiB 400.09 GB)
    Raid Devices : 5
   Total Devices : 5
Preferred Minor : 3
     Persistence : Superblock is persistent

     Update Time : Sun Jun 18 06:26:08 2006
           State : clean
  Active Devices : 5
Working Devices : 5
  Failed Devices : 0
   Spare Devices : 0

          Layout : left-symmetric
      Chunk Size : 512K

            UUID : 7c9d7547:99200e21:0c0523df:14ed90a3
          Events : 0.421994

     Number   Major   Minor   RaidDevice State
        0       3        1        0      active sync   /dev/hda1
        1      89        1        1      active sync   /dev/hdo1
        2      57        1        2      active sync   /dev/hdk1
        3      88        1        3      active sync   /dev/hdm1
        4      56        1        4      active sync   /dev/hdi1

# mdadm -V
mdadm - v1.12.0 - 14 June 2005

