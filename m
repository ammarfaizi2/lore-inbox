Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293682AbSCAT5h>; Fri, 1 Mar 2002 14:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293681AbSCATzQ>; Fri, 1 Mar 2002 14:55:16 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:46506 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S293705AbSCATyy>; Fri, 1 Mar 2002 14:54:54 -0500
Date: Fri, 1 Mar 2002 14:54:51 -0500 (EST)
From: Bharath Krishnan <bharath@MIT.EDU>
To: <h.lubitz@internet-factory.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Yet another disk transfer speed problem 
Message-ID: <Pine.GSO.4.30L.0203011451590.3706-100000@stymie.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is fdisk -l results:

[root@yakuza root]# /sbin/fdisk -l /dev/hdg

Disk /dev/hdg: 255 heads, 63 sectors, 4866 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdg1   *         1       255   2048256    6  FAT16


[root@yakuza root]# /sbin/fdisk -l /dev/hde

Disk /dev/hde: 255 heads, 63 sectors, 1867 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hde1             1         6     48163+  83  Linux
/dev/hde2             7      1056   8434125   83  Linux
/dev/hde3   *      1154      1867   5735205    7  HPFS/NTFS
/dev/hde4          1057      1153    779152+   f  Win95 Ext'd (LBA)
/dev/hde5          1057      1153    779121   82  Linux swap

Partition table entries are not in disk order


As you can see, I have a fat16 partition on hdg. I can delete it and make
an ext3 partition there and see if that changes anything.


Thanks,

-bharath

>>>

Could you provide fdisk -l for both? For some odd reason unknown to me
some filesystems give slower results with hdparm than others, even with
the buffer-cache reads (which are intended to measure memory speed, not
drive speed, and thus should be the same for all drives on a given
mainboard). Also, hdparm directly on the drive device is often a bit
slower than hdparm for the first (outermost) partition. These problems
have been far worse in older kernels, though. With 2.2 I once
benchmarked a vfat-partition at half the speed the same partition gave
as ext2.

Holger



-bharath





