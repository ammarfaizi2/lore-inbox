Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272021AbRH2SSD>; Wed, 29 Aug 2001 14:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272036AbRH2SRx>; Wed, 29 Aug 2001 14:17:53 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:34551 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S272021AbRH2SRn>; Wed, 29 Aug 2001 14:17:43 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 29 Aug 2001 12:17:32 -0600
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fsck root fs: fsck, devfs, /proc/mounts miscooperate.
Message-ID: <20010829121732.I24270@turbolinux.com>
Mail-Followup-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <22075604.20010829095413@port.imtp.ilyichevsk.odessa.ua> <20010829021304.D24270@turbolinux.com> <6410958637.20010829151417@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6410958637.20010829151417@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 29, 2001  15:14 +0300, VDA wrote:
> Installed e2fsprogs 1.23. It does not print warning now on
> "fsck /dev/scsi/host0/bus0/target1/lun0/part1"
> However, it still cannot fs check root fs when given "fsck /" which I
> really need in my init script. Now the only way to do root fs check
> for me is to parse /proc/mounts and extract mount point for / via sed
> (I have never used sed yet...).
> 
> # fsck /
> Parallelizing fsck version 1.15 (18-Jul-1999)
> e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
> /sbin/e2fsck: Is a directory while trying to open /

That's because "/" is a directory and not a device.  fsck works with
devices.  If you want to avoid specifying your root partition in
/etc/fstab explicitly, then you can use an ext2 label instead.  Set
the label on the filesystem with "tune2fs -L root <root_dev>", and
then put "LABEL=root" in /etc/fstab instead of a device name.  This
way if your root device gets moved around you are still OK.  This
of course works with filesystems other than root as long as they are
ext2/ext3/xfs (reiserfs does not have labels yet).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

