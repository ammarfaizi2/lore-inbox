Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316994AbSGSUqX>; Fri, 19 Jul 2002 16:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317020AbSGSUqX>; Fri, 19 Jul 2002 16:46:23 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:31997 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316994AbSGSUqW>; Fri, 19 Jul 2002 16:46:22 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 19 Jul 2002 14:47:38 -0600
To: Shawn <core@enodev.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020719204738.GF10315@clusterfs.com>
Mail-Followup-To: Shawn <core@enodev.com>, linux-kernel@vger.kernel.org
References: <20020716153926.GR7955@tahoe.alcove-fr> <20020716194542.GD22053@merlin.emma.line.org> <20020716150422.A6254@q.mn.rr.com> <20020716161158.A461@shookay.newview.com> <20020716152231.B6254@q.mn.rr.com> <20020717114501.GB28284@merlin.emma.line.org> <20020717190259.GA31503@clusterfs.com> <20020719102906.A5131@krusty.dt.e-technik.uni-dortmund.de> <20020719163907.GD10315@clusterfs.com> <20020719150116.A31973@q.mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719150116.A31973@q.mn.rr.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 19, 2002  15:01 -0500, Shawn wrote:
> On 07/19, Andreas Dilger said something like:
> > You cannot mount a dirty ext3 filesystem from read-only media.
> 
> I thought you could "mount -t ext2" ext3 volumes, and thought you could
> force mount ext2.

This is true if the ext3 filesystem is unmounted cleanly.  Otherwise
there is a flag in the superblock which tells the kernel it can't
mount the filesystem because there is something there it doesn't
understand (namely the dirty journal with all of the recent changes).

This flag (EXT3_FEATURE_INCOMPAT_RECOVERY) is cleared when the
filesystem is unmounted properly, when e2fsck or a r/w mount
recovers the journal, and not coincidentally when an LVM snapshot
is created.

In case you are more curious, there are a couple of paragraphs in
linux/Documentation/filesystems/ext2.txt about the compat flags,
which are really one of the great features of ext2.  You may think
that an overstatement, but without the feature flags, none of the
other enhancements that have been added to ext2 over the last few
years (and in the next few years too) would have been so easily done.

As for mounting a dirty ext2 filesystem, yes that is possible with
only a warning at mount time.  That is why nobody has put much effort
into adding the snapshot hooks into ext2 yet.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

