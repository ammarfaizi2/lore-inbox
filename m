Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbTBGNsL>; Fri, 7 Feb 2003 08:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbTBGNsL>; Fri, 7 Feb 2003 08:48:11 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:26763 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S265099AbTBGNsI>;
	Fri, 7 Feb 2003 08:48:08 -0500
Date: Fri, 7 Feb 2003 14:58:00 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 15 * 180gb in raid5 gives 299.49 GiB ?
In-Reply-To: <15937.50001.367258.485512@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.53.0302061915390.17629@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302060059210.6169@ddx.a2000.nu>
 <Pine.LNX.4.53.0302060123150.6169@ddx.a2000.nu> <Pine.LNX.4.53.0302060211030.6169@ddx.a2000.nu>
 <15937.50001.367258.485512@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003, Peter Chubb wrote:

> OK, must have missed a change.
>
> In drivers/scsi/aic7xxx_osm.c find the function ahc_linux_biosparam()
> and  cast disk->capacity to unsigned int like so:
>
> -	cylinders = disk->capacity / (heads * sectors);
> +	cylinders = (unsigned)disk->capacity / (heads * sectors);

Thnx Peter, this fixes the compile error
now i run 2.4.20 with the patch, and build the raid correctly

only a small thing left (in the raid code?) that needs to be fixed :
(array size is neggative)
mdadm version 1.0.1
but maybe it is just mdadm which is a buggy program
since the 'Total Devices : 16' is also incorrect (seen before on multiple
systems)

]# mdadm -D /dev/md0
/dev/md0:
        Version : 00.90.00
  Creation Time : Thu Feb  6 14:20:02 2003
     Raid Level : raid5
     Array Size : -1833441152 (2347.49 GiB 2520.65 GB)
    Device Size : 175823296 (167.68 GiB 180.09 GB)
   Raid Devices : 15
  Total Devices : 16
Preferred Minor : 0
    Persistence : Superblock is persistent

    Update Time : Fri Feb  7 10:15:15 2003
          State : dirty, no-errors
 Active Devices : 15
Working Devices : 15
 Failed Devices : 1
  Spare Devices : 0

         Layout : left-symmetric
     Chunk Size : 64K

    Number   Major   Minor   RaidDevice State
       0       8       17        0      active sync   /dev/sdb1
       1       8       33        1      active sync   /dev/sdc1
       2       8       49        2      active sync   /dev/sdd1
       3       8       65        3      active sync   /dev/sde1
       4       8       81        4      active sync   /dev/sdf1
       5       8       97        5      active sync   /dev/sdg1
       6       8      113        6      active sync   /dev/sdh1
       7       8      129        7      active sync   /dev/sdi1
       8       3        1        8      active sync   /dev/hda1
       9      22        1        9      active sync   /dev/hdc1
      10      33        1       10      active sync   /dev/hde1
      11      56        1       11      active sync   /dev/hdi1
      12      57        1       12      active sync   /dev/hdk1
      13      88        1       13      active sync   /dev/hdm1
      14      89        1       14      active sync   /dev/hdo1
           UUID : 967349d3:ae82ce10:f6d112a5:dccda06b

]# cat /proc/mdstat
Personalities : [raid0] [raid5]
read_ahead 1024 sectors
md0 : active raid5 hdo1[14] hdm1[13] hdk1[12] hdi1[11] hde1[10] hdc1[9]
hda1[8] sdi1[7] sdh1[6] sdg1[5] sdf1[4] sde1[3] sdd1[2] sdc1[1] sdb1[0]
      2461526144 blocks level 5, 64k chunk, algorithm 2 [15/15]
[UUUUUUUUUUUUUUU]

unused devices: <none>
