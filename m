Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265999AbSKFIiD>; Wed, 6 Nov 2002 03:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266002AbSKFIiD>; Wed, 6 Nov 2002 03:38:03 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:1010 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S265999AbSKFIiB>; Wed, 6 Nov 2002 03:38:01 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 6 Nov 2002 01:41:43 -0700
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 dirty ext2 mount error
Message-ID: <20021106084143.GN588@clusterfs.com>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <3DC8ACAB.8C0DB37D@digeo.com> <21861.1036564011@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21861.1036564011@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06, 2002  17:26 +1100, Keith Owens wrote:
> Unclean shutdown, reboot.
> 
> LILO boot: 2.4.20-rc1
> Loading 2.4.20-rc1........................
> Linux version 2.4.20-rc1 (kaos@sherman) (gcc version 3.2 20020822 (Red Hat Linux Rawhide 3.2-4)) #10 SMP Wed Nov 6 16:10:31 EST 2002
> Kernel command line: auto BOOT_IMAGE=2.4.20-rc1 ro root=801 BOOT_FILE=/lib/modules/2.4.20-rc1/bzImage console=tty0 console=ttyS0,38400 mem=127M
> EXT2-fs: sd(8,1): couldn't mount because of unsupported optional features (4).
> Kernel panic: VFS: Unable to mount root fs on 08:01
>  
> Entering kdb (current=0xc11f4000, pid 1) on processor 1 due to KDB_ENTER()
> [1]kdb> reboot
> 
> Come up on 2.4.18-14 from RH.  It detects ext3 and cleans the journal,
> even though fstab says ext2.  Then ext2 does fsck.ext2 -a /dev/sda1.  I
> guess the question is why ext3 is being used when fstab says ext2?
> Especially when that stuffs up booting into other kernels that do not
> have ext3 support at all.

/etc/fstab is not available until after the kernel mounts the root
filesystem, so what is in /etc/fstab is totally irrelevant here.

If you don't simultaneously crash your system running ext3, and then reboot
into a kernel which does not support ext3 you will be fine.  A clean
shutdown will clear the "needs_recovery" flag (and any ext2-only kernel
can blissfully use that filesystem), any ext3-aware kernel can also
mount it again and do a journal flush, or any modern (last year or two)
e2fsck will clean it up too (from a rescue disk if desparate).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

