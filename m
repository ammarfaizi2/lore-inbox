Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269687AbUICN1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269687AbUICN1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269692AbUICN1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:27:41 -0400
Received: from wasp.net.au ([203.190.192.17]:57240 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S269687AbUICNXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:23:24 -0400
Message-ID: <41387071.4010504@wasp.net.au>
Date: Fri, 03 Sep 2004 17:24:01 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: md RAID over SATA performance
References: <1094169937l.17931l.0l@werewolf.able.es>
In-Reply-To: <1094169937l.17931l.0l@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> Hi all...
> 
> I am buildin an array with a linux box, and I run 2.6.8.1 (not stock, but
> the mandrake cooker version).
> 
> Disks are 6 SATA drives, plugged to a couple of Promise FastTrak S150 TX4
> cards.
> 
> Problem is that i get really poor performance. A single drive gives about
> 57 Mb/s, and a raid1 with two just gives about 64 Mb/s (measured with
> hdparm -tT). With the six drives:
> 
> nada:~/soft/kernel# hdparm -tT /dev/sda
> 
> /dev/sda:
> Timing buffer-cache reads:   844 MB in  2.01 seconds = 419.96 MB/sec
> Timing buffered disk reads:  174 MB in  3.01 seconds =  57.84 MB/sec
> nada:~/soft/kernel# hdparm -tT /dev/md0
> 
> /dev/md0:
> Timing buffer-cache reads:   884 MB in  2.00 seconds = 441.63 MB/sec
> Timing buffered disk reads:  310 MB in  3.01 seconds = 103.07 MB/sec
> 
> The real goal is to build a raid5 system, but I just tested with raid1.
> 

Here are some real-world figures for you (Not that they mean anything!)

srv:/home/brad# hdparm -t -T /dev/md0

/dev/md0:
  Timing buffer-cache reads:   1340 MB in  2.00 seconds = 668.76 MB/sec
  BLKGETSIZE failed: File too large
  Timing buffered disk reads:  182 MB in  3.02 seconds =  60.31 MB/sec
srv:/home/brad# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda1              19G   11G  6.5G  64% /
tmpfs                 252M     0  252M   0% /dev/shm
/dev/hda3             165G   21G  136G  13% /raid0
/dev/md0              2.1T  2.0T  114G  95% /raid
/dev/md2              459G  101G  358G  22% /raid2
srv:/home/brad# mdadm --detail /dev/md0
/dev/md0:
         Version : 00.90.01
   Creation Time : Sun May  2 18:02:14 2004
      Raid Level : raid5
      Array Size : 2206003968 (2103.81 GiB 2258.95 GB)
     Device Size : 245111552 (233.76 GiB 250.99 GB)
    Raid Devices : 10
   Total Devices : 10
Preferred Minor : 0
     Persistence : Superblock is persistent

     Update Time : Fri Sep  3 16:08:03 2004
           State : clean, no-errors
  Active Devices : 10
Working Devices : 10
  Failed Devices : 0
   Spare Devices : 0

          Layout : left-asymmetric
      Chunk Size : 128K

     Number   Major   Minor   RaidDevice State
        0       8        1        0      active sync   /dev/devfs/scsi/host0/bus0/target0/lun0/part1
        1       8       17        1      active sync   /dev/devfs/scsi/host1/bus0/target0/lun0/part1
        2       8       33        2      active sync   /dev/devfs/scsi/host2/bus0/target0/lun0/part1
        3       8       49        3      active sync   /dev/devfs/scsi/host3/bus0/target0/lun0/part1
        4       8       65        4      active sync   /dev/devfs/scsi/host4/bus0/target0/lun0/part1
        5       8       81        5      active sync   /dev/devfs/scsi/host5/bus0/target0/lun0/part1
        6       8       97        6      active sync   /dev/devfs/scsi/host6/bus0/target0/lun0/part1
        7       8      113        7      active sync   /dev/devfs/scsi/host7/bus0/target0/lun0/part1
        8       8      129        8      active sync   /dev/sdi1
        9       8      145        9      active sync   /dev/sdj1
            UUID : 05cc3f43:de1ecfa4:83a51293:78015f1e
          Events : 0.681631
