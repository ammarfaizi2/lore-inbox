Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265509AbUFTIja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265509AbUFTIja (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 04:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbUFTIja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 04:39:30 -0400
Received: from smtp.loomes.de ([212.40.161.2]:38129 "EHLO falcon.loomes.de")
	by vger.kernel.org with ESMTP id S265509AbUFTIjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 04:39:23 -0400
From: Sebastian Slota <sebastian@sslota.de>
To: Ricky Beam <jfbeam@bluetronic.net>
Subject: Re: Raid issues on Sil 3114 (MB: Abit MAX3, i875 )
Date: Sun, 20 Jun 2004 10:39:44 +0200
User-Agent: KMail/1.6.1
References: <Pine.GSO.4.33.0406191447090.25702-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0406191447090.25702-100000@sweetums.bluetronic.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406201039.44448.sebastian@sslota.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >#1 - Linux sees the HD's but dont recognises the partitions
> More accurately, it see the partition table from the first chunk of the
> array.
True, did so for me :-)

> If you know EXACTLY how the raid is setup and it NEVER changes, then yes,
> Linux can be "tricked" into building a software RAID array in a BIOS
> compatible manner.

Great! I've borrowed another PC with some 350GB to save my data and 
reconfigure my drive

> I do this:
> 	md=d0,0,2,0,/dev/sda,/dev/sdb,/dev/sdc,/dev/sdd
> 		See also: Documentation/md.txt (within the kernel source)
> That tells the kernel to build a non-persistent, partitioned RAID0 array
> with a 16k stripe (2^2 * 4k) from sda-sdd (in that order) which looks like
> this...
>
> [root:pts/6{1}]spork:/[02:59 PM]:fdisk -l /dev/md/d0
> Disk /dev/md/d0: 640.1 GB, 640167510016 bytes
> 255 heads, 63 sectors/track, 77829 cylinders
> Units = cylinders of 16065 * 512 = 8225280 bytes
>
>       Device Boot      Start         End      Blocks   Id  System
> /dev/md/d0p1   *           1       72606   583207663+   7  HPFS/NTFS
> /dev/md/d0p2           72607       77306    37752750   83  Linux
> /dev/md/d0p3           77307       77828     4192965   82  Linux swap
> (NOTE: Cyl 77829 is unused.)

Thats exactily what I would like to do! Great!

But is linux able to boot from this array?
Do I need some special Software package installed for use md ?

I'm trying to install Yoper and the install CD is lacking most software.
I'm in contact with the developer there and allowed to modify the install 
packages.


> (The same is visible from /dev/sda although it's 1/4th the size.)
>
> [root:pts/6{1}]spork:/[03:00 PM]:mdadm --detail /dev/md/d0
> /dev/md/d0:
>         Version : 00.90.01
>   Creation Time : Fri Jun 18 16:41:33 2004
>      Raid Level : raid0
>      Array Size : 625163584 (596.20 GiB 640.17 GB)
>    Raid Devices : 4
>   Total Devices : 4
> Preferred Minor : 0
>     Persistence : Superblock is not persistent
>
>     Update Time : Fri Jun 18 16:41:33 2004
>           State : clean, no-errors
>  Active Devices : 4
> Working Devices : 4
>  Failed Devices : 0
>   Spare Devices : 0
>
>      Chunk Size : 16K
>
>     Number   Major   Minor   RaidDevice State
>        0       8        0        0      active sync   /dev/sda
>        1       8       16        1      active sync   /dev/sdb
>        2       8       32        2      active sync   /dev/sdc
>        3       8       48        3      active sync   /dev/sdd
>
> [root:pts/6{1}]spork:/[03:08 PM]:df -h /dev/md/d0p1
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/md/d0p1          557G   72G  486G  13% /mnt/ntfs
>
> --Ricky
Would you write me a small howto?
My Hardware: 4x160GB, (1hh ata for installing, temporalily )
My partition would be:
- WinXP ( 10GB)
- Linux1 ( 20GB )
- Linux2 (10GB)
- Swap (2GB)
- FAT32 ( 100GB)
- /home (the rest)

Txs!

Sebastian
