Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbSJaIDc>; Thu, 31 Oct 2002 03:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265213AbSJaIDc>; Thu, 31 Oct 2002 03:03:32 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:10238 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S265211AbSJaIDb>; Thu, 31 Oct 2002 03:03:31 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 31 Oct 2002 01:07:17 -0700
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: Htree ate my hard drive, was: post-halloween 0.2
Message-ID: <20021031080717.GF28982@clusterfs.com>
Mail-Followup-To: Duncan Sands <baldrick@wanadoo.fr>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <20021030171149.GA15007@suse.de> <200210310727.52636.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210310727.52636.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2002  07:27 +0100, Duncan Sands wrote:
> > EXT3 Htree support.
> > ~~~~~~~~~~~~~~~~~~~
> > The ext3 filesystem has gained indexed directory support, which offers
> > considerable performance gains when used on filesystems with large
> > directories. In order to use the htree feature, you need at least version
> > 1.29 of e2fsprogs. Existing filesystems can be converted using the command
> > "tune2fs -O dir_index /dev/hdXXX" The latest e2fsprogs can be found at
> > http://prdownloads.sourceforge.net/e2fsprogs
> 
> I ran this (tune2fs -O dir_index /dev/hdXXX).
> 
> After a bit of switching back and forth between 2.4.19 and 2.5.44,
> fsck was run while booting 2.4.19 (the usual check because of >30
> mounts).  There was a message about optimizing directories.  Booting
> continued but (big surprise) X refused to run.  It turned out that some
> device files had vanished.  Very strange.  On rebooting, fsck found a
> gazillion bad inodes.  They all turned out to be from the 2.5.44 tree -
> poetic justice I suppose!  But this did not suffice.  Rebooting, I got
> "optimizing directories" again.  Next fsck showed up more dud inodes.
> After a few cycles of this, I ran
> 
> tune2fs -O ^dir_index /dev/hdXXX
> 
> to remove htree support.  No problems since then.
> 
> tune2fs 1.30-WIP (30-Sep-2002)

I wonder if there is still a bug in the e2fsck code for re-hashing
directories?  It shouldn't be possible to have e2fsck complete and
there still be an error in the filesystem (ok, sometimes it happens,
but in those cases it spews a lot of warnings about the filesystem
not being fixed yet and to run manually).

What else is strange (at least to me) is e2fsck "optimizing directories"
on a reboot.  My understanding at least is that this would be done only
when explicitly asked for, otherwise it might slow down booting a lot,
and as you can see it adds to the possibility of corrupting the fs when
e2fsck should only be fixing it.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

