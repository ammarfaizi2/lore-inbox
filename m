Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315325AbSDWUY0>; Tue, 23 Apr 2002 16:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315326AbSDWUYZ>; Tue, 23 Apr 2002 16:24:25 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:2301 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315325AbSDWUYZ>; Tue, 23 Apr 2002 16:24:25 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 23 Apr 2002 14:22:29 -0600
To: Jeremy Jackson <jerj@coplanar.net>
Cc: Alvaro Figueroa <fede2@fuerzag.ulatina.ac.cr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Adding snapshot capability to Linux
Message-ID: <20020423202229.GV3017@turbolinux.com>
Mail-Followup-To: Jeremy Jackson <jerj@coplanar.net>,
	Alvaro Figueroa <fede2@fuerzag.ulatina.ac.cr>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0204231041010.8087-100000@weyl.math.psu.edu> <007f01c1eaf9$a63aeb40$7e0aa8c0@bridge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 23, 2002  12:04 -0700, Jeremy Jackson wrote:
> This type of snapshot is very desirable.  It can be done by remounting
> the fs ro, then taking EVMS or LVM snapshot, but you can't do that with open
> files.
> 
> For a journaling fs cooperation with snapshot while rw, the fs must accept
> a snapshot request, pause in flight IO, sync all pending buffers, flush
> it's log, mark fs clean (almost like umount) continue the block dev
> snapshot, mark fs in use, resume io.
> 
> How about having all FS export methods for this, and VFS export to
> userspace.

Please do your homework.  What you describe already exists.  The VFS
methods (write_super_lockfs and unlockfs) are already there, and all
of the journaling filesystems support this.  The LVM and EVMS code has
patches to call these VFS methods.  For some reason the VFS-lock patch
has not yet been included in the kernel, but it should be.

As for filesystem-level snapshots (i.e. blocking write requests at the
VFS layer and doing COW) that is what snapfs (previously mentioned) does.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

