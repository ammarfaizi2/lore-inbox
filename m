Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSDMXxX>; Sat, 13 Apr 2002 19:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311424AbSDMXxW>; Sat, 13 Apr 2002 19:53:22 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:34040
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311320AbSDMXxU>; Sat, 13 Apr 2002 19:53:20 -0400
Date: Sat, 13 Apr 2002 16:55:38 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Luigi Genoni <kernel@Expansa.sns.it>,
        Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
Message-ID: <20020413235538.GU23513@matchmail.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Luigi Genoni <kernel@Expansa.sns.it>,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020410233641.GG23513@matchmail.com> <Pine.LNX.4.44.0204111202440.17727-100000@Expansa.sns.it> <200204131929.g3DJT5g06645@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2002 at 01:29:05PM -0600, Richard Gooch wrote:
> Luigi Genoni writes:
> > 
> > > > >
> > > > > Ehh, I ran into this a while ago.  When you compile raid as modules
> > > > > it doesn't use the raid superblocks for anything except for
> > > > > verification.  I took a quick glance at the source and the
> > > > > auto-detect code is ifdefed out if you compiled as a module.
> > > >
> > > > Exactly where is this? A scan with find and grep don't reveal this.
> > > >
> > >
> > > drivers/md/md.c
> > >
> > > in the ifndef MODULE sectioin.
> > >
> > > > > Ever since I have had raid compiled into my kernels.
> > > >
> > > > This is my relevant .config:
> > > > CONFIG_MD=y
> > > > CONFIG_BLK_DEV_MD=y
> > > > CONFIG_MD_LINEAR=m
> > > > CONFIG_MD_RAID0=m
> > > > CONFIG_MD_RAID1=m
> > > > CONFIG_MD_RAID5=m
> > > > CONFIG_MD_MULTIPATH=m
> > > >
> > >
> > > Set this to =y and you're set.
> > >
> > > I'd like to see this working from modules though.
> > 
> > NO, please. There are hundreds of scenarios where that could be
> > dangerous.  Suppose you load the RAID module when all partitions are
> > mounted, and two partiton in mirror are mount on different mount
> > point (you can do this, raid module is not loaded, and so...). And
> > now you load the module and md device is registered. That would not
> > be really nice, also if it is ulikely that you could damnage your
> > system
> 
> The RAID code checks to see if there are busy inodes for each device
> in a RAID set. So your hundreds of scenarios are not a problem.
> 

I had a machine that had raid1 setup correctly but was accidentally
configured to root=/dev/hda1 (one member of the md0 raid1 set).

All was well until I noticed I wasn't rooting from md0, so reboot with new
root=/dev/md0 and now my filesystem is b0rked (maybe because hdc1 was the
primary mirror?).

Luckily I was still setting up that machine so I just reinstalled it.

This was with raid compiled into the kernel, so it's not a module checking
issue, and I consider it a user error.  But maybe someone else thinks
different...

Just reporting in case someone is intereted...

Mike
