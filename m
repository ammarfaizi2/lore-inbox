Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269809AbUICV7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269809AbUICV7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 17:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269811AbUICV7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 17:59:06 -0400
Received: from smtp06.auna.com ([62.81.186.16]:64249 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S269809AbUICV6j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 17:58:39 -0400
Date: Fri, 03 Sep 2004 21:58:21 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: md RAID over SATA performance
To: linux-kernel@vger.kernel.org
References: <1094169937l.17931l.0l@werewolf.able.es>
In-Reply-To: <1094169937l.17931l.0l@werewolf.able.es> (from
	jamagallon@able.es on Fri Sep  3 02:05:37 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1094248701l.11549l.1l@werewolf.able.es>
X-Balsa-Fcc: file:///home/magallon/mail/sentbox
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.09.03, J.A. Magallon wrote:
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
>

Thanks to everybody for its answers...

My confusion/problem was that I has always tried with only two drives,
and with more or less old drives that gave around 20-25Mb/s each, so
the raid worked very optimally at about 50 Mb/s.
But with modern drives at 55 Mb/s, I hit the PCI speed limits, I suppose.
Board is a Supermicro P3TDDE, Via ApolloPro 266T chipset (aghhh),
33 MHz PCI, 2xPIII@933.

With a stock 2.6.8.1, I get this:

nada:~# hdparm -tT /dev/md0

/dev/md0:
 Timing buffer-cache reads:   864 MB in  2.00 seconds = 431.63 MB/sec
 Timing buffered disk reads:  252 MB in  3.01 seconds =  83.85 MB/sec

with this setup:

nada:~# mdadm --detail /dev/md0
/dev/md0:
        Version : 00.90.01
  Creation Time : Fri Sep  3 02:17:28 2004
     Raid Level : raid5
     Array Size : 1225557760 (1168.78 GiB 1254.97 GB)
    Device Size : 245111552 (233.76 GiB 250.99 GB)
   Raid Devices : 6
  Total Devices : 6
Preferred Minor : 0
    Persistence : Superblock is persistent

    Update Time : Fri Sep  3 19:01:39 2004
          State : clean
 Active Devices : 6
Working Devices : 6
 Failed Devices : 0
  Spare Devices : 0

         Layout : left-symmetric
     Chunk Size : 256K

           UUID : fd6fcad0:21da140b:072a82b1:11b3db21
         Events : 0.239

    Number   Major   Minor   RaidDevice State
       0       8        1        0      active sync   /dev/sda1
       1       8       17        1      active sync   /dev/sdb1
       2       8       33        2      active sync   /dev/sdc1
       3       8       49        3      active sync   /dev/sdd1
       4       8       65        4      active sync   /dev/sde1
       5       8       81        5      active sync   /dev/sdf1


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (RC 1) for i586
Linux 2.6.8.1-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #8


