Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261977AbTCRCKM>; Mon, 17 Mar 2003 21:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262082AbTCRCKM>; Mon, 17 Mar 2003 21:10:12 -0500
Received: from ip-92-118-134-202.rev.dyxnet.com ([202.134.118.92]:28211 "EHLO
	mail.office") by vger.kernel.org with ESMTP id <S261977AbTCRCKJ>;
	Mon, 17 Mar 2003 21:10:09 -0500
Message-ID: <3E7683C9.5000802@thizgroup.com>
Date: Tue, 18 Mar 2003 10:26:17 +0800
From: =?Big5?B?QWxleCBMYXUgvEKrVL3l?= <alexlau@thizgroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: zh-hk, zh-tw, zh-cn
MIME-Version: 1.0
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
CC: linux-kernel@vger.kernel.org, fai@thizgroup.com
Subject: Re: FileSystem XFS vs RiserFS vs ext3
References: <E18uq2v-0004P7-00@calista.inka.de>
In-Reply-To: <E18uq2v-0004P7-00@calista.inka.de>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bernd Eckenfels wrote:

>NFS is a bit tricky. Reiser used to be broken on it, and at least from large
>XFS NFS Servers I know that they tend to be unstable, still.
>
>For the Database Servers, I am not sure how well they operate with
>journaling filesystems. I think Linux Journal had an article on performance
>on that.
>
>Reiser might be your bet, depending on the usage pattern of the filename
>space, with Ext3 catching up. Personally I love the XFS features for
>resizing in connection with LVMs, but i guess you can have that with Ext3
>and Reiser, too.
>
>Greetings
>Bernd
>  
>
Thanks for all the input. Here is some info after I get from my setting.
Hardware config: Tyan 2466 Duel MP2200+ 512MB, SX6000 4 ide 120GB
7200RPM RAID5

-------------------------------------------------------------------------
StPeter:/mnt/part1# sfdisk -l /dev/sda

Disk /dev/sda: 351905 cylinders, 64 heads, 32 sectors/track
Warning: extended partition does not start at a cylinder boundary.
DOS and Linux will interpret the contents differently.
Warning: The first partition looks like it was made
for C/H/S=*/255/63 (instead of 351905/64/32).
For this listing I'll assume that geometry.
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0

Device Boot Start End #cyls #blocks Id System
/dev/sda1 0+ 44860 44861- 360345951 5 Extended
/dev/sda2 0 - 0 0 0 Empty
/dev/sda3 0 - 0 0 0 Empty
/dev/sda4 0 - 0 0 0 Empty
/dev/sda5 0+ 3646 3647- 29294464+ 83 Linux
/dev/sda6 3647+ 7293 3647- 29294496 83 Linux
/dev/sda7 7294+ 10940 3647- 29294496 83 Linux
/dev/sda8 10941+ 14587 3647- 29294496 83 Linux
/dev/sda9 14588+ 18234 3647- 29294496 83 Linux
/dev/sda10 18235+ 21881 3647- 29294496 83 Linux
/dev/sda11 21882+ 25528 3647- 29294496 83 Linux
/dev/sda12 25529+ 29175 3647- 29294496 83 Linux
/dev/sda13 29176+ 32822 3647- 29294496 83 Linux
/dev/sda14 32823+ 36469 3647- 29294496 83 Linux
/dev/sda15 36470+ 44860 8391- 67400676 83 Linux

------------------------------------------------------------------
StPeter:/mnt/part1# hdparm -t /dev/sda

/dev/sda:
Timing buffered disk reads: 64 MB in 1.60 seconds = 40.00 MB/sec
StPeter:/mnt/part1# hdparm -T /dev/sda

/dev/sda:
Timing buffer-cache reads: 128 MB in 0.47 seconds =272.34 MB/sec
------------------------------------------------------------------
StPeter:/mnt/part1# mount
/dev/sda5 on /mnt/part1 type xfs (rw,noexec,nosuid,nodev)
/dev/sda6 on /mnt/part2 type reiserfs (rw,noexec,nosuid,nodev)
/dev/sda7 on /mnt/part3 type ext3 (rw,noexec,nosuid,nodev)

StPeter:/mnt/part1# df -h
Filesystem Size Used Avail Use% Mounted on
/dev/sda5 28G 4.8M 27G 1% /mnt/part1
/dev/sda6 28G 33M 27G 1% /mnt/part2
/dev/sda7 27G 33M 26G 1% /mnt/part3

StPeter:/mnt/part1# time cp -rf /usr/src/kernel-source-2.4.20 ./

real 1m3.501s
user 0m0.140s
sys 0m2.680s

StPeter:/mnt/part2# time cp -rf /usr/src/kernel-source-2.4.20 ./

real 0m3.696s *************** so fast...
user 0m0.110s
sys 0m3.570s

StPeter:/mnt/part3# time cp -rf /usr/src/kernel-source-2.4.20 ./

real 1m29.697s
user 0m0.090s
sys 0m2.490s

*ext3 used the most space

StPeter:/mnt/part3# df -h
Filesystem Size Used Avail Use% Mounted on
/dev/sda5 28G 180M 27G 1% /mnt/part1
/dev/sda6 28G 191M 27G 1% /mnt/part2
/dev/sda7 27G 211M 25G 1% /mnt/part3
--------------------------------------------------------
StPeter:/mnt/part1# time rm -rf kernel-source-2.4.20/

real 0m23.351s
user 0m0.050s
sys 0m1.250s

StPeter:/mnt/part2# time rm -rf kernel-source-2.4.20/

real 0m1.297s
user 0m0.010s
sys 0m0.890s

StPeter:/mnt/part3# time rm -rf kernel-source-2.4.20/

real 0m1.062s
user 0m0.000s
sys 0m0.690s

-------------------------------------------------------

Any suggestion for other test?
Thanks
Alex






