Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVCaOJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVCaOJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVCaOJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:09:19 -0500
Received: from smtp05.auna.com ([62.81.186.15]:44189 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S261460AbVCaOIt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:08:49 -0500
Date: Thu, 31 Mar 2005 14:08:36 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Poor SATA / RAID performance (2.6.11 and promise SATAII150 TX4)
To: linux-kernel@vger.kernel.org
References: <20050331031250.42410.qmail@web30511.mail.mud.yahoo.com>
In-Reply-To: <20050331031250.42410.qmail@web30511.mail.mud.yahoo.com> (from
	tim_harvey@yahoo.com on Thu Mar 31 05:12:50 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1112278116l.9046l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.31, Tim Harvey wrote:
> Greetings,
> 
> I'm attempting to benchmark software RAID5 on a system with:
>   - Promise SATAII150 TX4 card
>   - 4 Segate ST3300831AS drives 
>   - custom built kernel 2.6.11 (to get driver for promise SATAIITX4)
>   - FC3 install
>   - EPIA M10000 mainboard, 256MB memory
> 
> The tools I'm familiar with for benchmarking a PATA based RAID system are:
>   - hdparm
>   - dd
> 
> Here are some interesting stats from my system:
> 

Here goes my setup/results, FWIW...
Hard:  Dual PIII@9333
       2 Promise FastTrak S150 TX4 (rev 02)
       6x Maxtor 7Y250M0, 250Gb, 3 on each card.
Soft:
> [root@epiam10k ~]# more /proc/mdstat
> Personalities : [raid5] 
> md0 : active raid5 sdd1[3] sdc1[2] sdb1[1] sda1[0]
>       879100608 blocks level 5, 4k chunk, algorithm 2 [4/4] [UUUU]
>       
> unused devices: <none>

nada:~# cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5] [multipath] [raid6] [raid10] 
md0 : active raid5 sdf1[5] sde1[4] sdd1[3] sdc1[2] sdb1[1] sda1[0]
      1225557760 blocks level 5, 256k chunk, algorithm 2 [6/6] [UUUUUU]
      
unused devices: <none>

> [root@epiam10k ~]# hdparm -t /dev/sda
> 
> /dev/sda:
>  Timing buffered disk reads:  116 MB in  3.02 seconds =  38.45 MB/sec
> HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for
> device
> [root@epiam10k ~]# hdparm -t /dev/sda1
> 
> /dev/sda1:
>  Timing buffered disk reads:  104 MB in  3.05 seconds =  34.10 MB/sec
> HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for
> device

nada:~# hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   900 MB in  2.00 seconds = 449.84 MB/sec
 Timing buffered disk reads:  172 MB in  3.03 seconds =  56.70 MB/sec

> [root@epiam10k ~]# hdparm -t /dev/md0
> 
> /dev/md0:
>  Timing buffered disk reads:   72 MB in  3.03 seconds =  23.79 MB/sec
> 

nada:~# hdparm -tT /dev/md0

/dev/md0:
 Timing cached reads:   912 MB in  2.01 seconds = 454.48 MB/sec
 Timing buffered disk reads:  178 MB in  3.04 seconds =  58.60 MB/sec

> [root@epiam10k ~]# vmstat
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  1  0      0   3628   8984 142704    0    0   423    23 1023   112 30  3 61  6
> 
> Observations:
>   - the performance of a raw SATA device (/dev/sda in the above example) seems
> low when I compare it to a PATA drive from a previous system (which would get
> about 45MB/sec)
>   - the performance of the RAID5 array (/dev/md0) seems very low - I expect
> quite an increase over a single device due to striping
>   - the number of interrupts per second (1023) seems very high
> 

It is not marvelous in my case, but slightly better than yours...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam10 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-7mdk)) #1


