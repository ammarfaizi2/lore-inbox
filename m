Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSIAHIn>; Sun, 1 Sep 2002 03:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSIAHIm>; Sun, 1 Sep 2002 03:08:42 -0400
Received: from p508EBDAF.dip.t-dialin.net ([80.142.189.175]:34317 "EHLO
	tigra.home") by vger.kernel.org with ESMTP id <S316434AbSIAHIm>;
	Sun, 1 Sep 2002 03:08:42 -0400
Date: Sun, 1 Sep 2002 09:13:27 +0200
From: Alex Riesen <fork0@users.sf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: sct@redhat.com, akpm@zip.com.au, adilger@clusterfs.com
Subject: 2.4.20-pre1-ac1: Filesystem panic attempting to mount ext3
Message-ID: <20020901071327.GA404@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the problem appeared on the first partition of an ide
IBM-DHEA-36481 with one fat partition on it. I repartioned
the device (4 primaries) and "mke2fs -j" three of them.

Than i tried to mount the newly created filesystems and got
this in syslog:

Sep  1 08:47:32 steel kernel: FAT: Did not find valid FSINFO signature.
Sep  1 08:47:32 steel kernel: Found signature1 0x0 signature2 0x0 sector=1.
Sep  1 08:47:32 steel kernel: Directory 1: bad FAT
Sep  1 08:47:32 steel kernel: attempt to access beyond end of device
Sep  1 08:47:32 steel kernel: 16:41: rw=0, want=902238098, limit=3903763
Sep  1 08:47:32 steel kernel: attempt to access beyond end of device
Sep  1 08:47:32 steel kernel: 16:41: rw=0, want=902238099, limit=3903763
Sep  1 08:47:32 steel kernel: attempt to access beyond end of device
Sep  1 08:47:32 steel kernel: 16:41: rw=0, want=902238099, limit=3903763
Sep  1 08:47:32 steel kernel: attempt to access beyond end of device
Sep  1 08:47:32 steel kernel: 16:41: rw=0, want=902238100, limit=3903763
Sep  1 08:47:32 steel kernel: attempt to access beyond end of device
Sep  1 08:47:32 steel kernel: 16:41: rw=0, want=902238100, limit=3903763
Sep  1 08:47:32 steel kernel: attempt to access beyond end of device
Sep  1 08:47:32 steel kernel: 16:41: rw=0, want=902238101, limit=3903763
Sep  1 08:47:32 steel kernel: attempt to access beyond end of device
Sep  1 08:47:32 steel kernel: 16:41: rw=0, want=902238101, limit=3903763
Sep  1 08:47:32 steel kernel: attempt to access beyond end of device
Sep  1 08:47:32 steel kernel: 16:41: rw=0, want=902238102, limit=3903763
Sep  1 08:47:32 steel kernel: Filesystem panic (dev 16:41).
Sep  1 08:47:32 steel kernel:   FAT error
Sep  1 08:47:32 steel kernel:   File system has been set read-only

Umount produced something as well:

Sep  1 08:47:54 steel kernel: FAT: Did not find valid FSINFO signature.
Sep  1 08:47:54 steel kernel: Found signature1 0x0 signature2 0x0 sector=1.

Assuming that some garbage was left on the disk event after mke2fs,
i did "dd if=/dev/zero of=/dev/hdd1 bs=512", which cured the problem,
after being followed by mke2fs.

# fdisk -l /dev/hdd

Disk /dev/hdd: 255 heads, 63 sectors, 790 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdd1   *         1       486   3903763+  83  Linux
/dev/hdd2           487       608    979965   83  Linux
/dev/hdd3           609       632    192780   82  Linux swap
/dev/hdd4           633       790   1269135   83  Linux


