Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVCaDMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVCaDMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 22:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVCaDMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 22:12:55 -0500
Received: from web30511.mail.mud.yahoo.com ([68.142.201.239]:22914 "HELO
	web30511.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261926AbVCaDMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 22:12:51 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=sFBSN3Mlg5yS73w8uxMjKZtwDgV5P1Th1gHH78R7odpRkv8db2isWlQKkE/geRBWJZZnwdrMuLv4CRv1uZYsXAVQ02IrDB7+/lt8XZqAAV41Hx00bZr+mip1S7KsvR9IUCOGJREFgfWkfdskqQStf+AdYvmdUdQUz8jhl5HQeYs=  ;
Message-ID: <20050331031250.42410.qmail@web30511.mail.mud.yahoo.com>
Date: Wed, 30 Mar 2005 19:12:50 -0800 (PST)
From: Tim Harvey <tim_harvey@yahoo.com>
Subject: Poor SATA / RAID performance (2.6.11 and promise SATAII150 TX4)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I'm attempting to benchmark software RAID5 on a system with:
  - Promise SATAII150 TX4 card
  - 4 Segate ST3300831AS drives 
  - custom built kernel 2.6.11 (to get driver for promise SATAIITX4)
  - FC3 install
  - EPIA M10000 mainboard, 256MB memory

The tools I'm familiar with for benchmarking a PATA based RAID system are:
  - hdparm
  - dd

Here are some interesting stats from my system:

[root@epiam10k ~]# more /proc/mdstat
Personalities : [raid5] 
md0 : active raid5 sdd1[3] sdc1[2] sdb1[1] sda1[0]
      879100608 blocks level 5, 4k chunk, algorithm 2 [4/4] [UUUU]
      
unused devices: <none>
[root@epiam10k ~]# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  116 MB in  3.02 seconds =  38.45 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for
device
[root@epiam10k ~]# hdparm -t /dev/sda1

/dev/sda1:
 Timing buffered disk reads:  104 MB in  3.05 seconds =  34.10 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for
device
[root@epiam10k ~]# hdparm -t /dev/md0

/dev/md0:
 Timing buffered disk reads:   72 MB in  3.03 seconds =  23.79 MB/sec

[root@epiam10k ~]# vmstat
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0      0   3628   8984 142704    0    0   423    23 1023   112 30  3 61  6

Observations:
  - the performance of a raw SATA device (/dev/sda in the above example) seems
low when I compare it to a PATA drive from a previous system (which would get
about 45MB/sec)
  - the performance of the RAID5 array (/dev/md0) seems very low - I expect
quite an increase over a single device due to striping
  - the number of interrupts per second (1023) seems very high

Questions:
  - is hdparm the right tool for looking at SATA devices?
  - is the error regarding the ioctl an issue?
  - how do I set/get the DMA modes for the SATA controller and SATA drives?
  - why would the interrupts per sec reported from vmstat be so high?

Thanks for any suggesitons.  Please 'cc' me in any replies to the list.

Tim Harvey
