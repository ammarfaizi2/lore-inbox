Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311433AbSDNAAU>; Sat, 13 Apr 2002 20:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311445AbSDNAAT>; Sat, 13 Apr 2002 20:00:19 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:46731 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S311433AbSDNAAS>; Sat, 13 Apr 2002 20:00:18 -0400
Date: Sat, 13 Apr 2002 18:00:13 -0600
Message-Id: <200204140000.g3E00DX09756@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Luigi Genoni <kernel@Expansa.sns.it>,
        Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
In-Reply-To: <20020413235538.GU23513@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk writes:
> On Sat, Apr 13, 2002 at 01:29:05PM -0600, Richard Gooch wrote:
> > Luigi Genoni writes:
> > > 
> > > > > >
> > > > > > Ehh, I ran into this a while ago.  When you compile raid as modules
> > > > > > it doesn't use the raid superblocks for anything except for
> > > > > > verification.  I took a quick glance at the source and the
> > > > > > auto-detect code is ifdefed out if you compiled as a module.
> > > > >
> > > > > Exactly where is this? A scan with find and grep don't reveal this.
> > > > >
> > > >
> > > > drivers/md/md.c
> > > >
> > > > in the ifndef MODULE sectioin.
> > > >
> > > > > > Ever since I have had raid compiled into my kernels.
> > > > >
> > > > > This is my relevant .config:
> > > > > CONFIG_MD=y
> > > > > CONFIG_BLK_DEV_MD=y
> > > > > CONFIG_MD_LINEAR=m
> > > > > CONFIG_MD_RAID0=m
> > > > > CONFIG_MD_RAID1=m
> > > > > CONFIG_MD_RAID5=m
> > > > > CONFIG_MD_MULTIPATH=m
> > > > >
> > > >
> > > > Set this to =y and you're set.
> > > >
> > > > I'd like to see this working from modules though.
> > > 
> > > NO, please. There are hundreds of scenarios where that could be
> > > dangerous.  Suppose you load the RAID module when all partitions are
> > > mounted, and two partiton in mirror are mount on different mount
> > > point (you can do this, raid module is not loaded, and so...). And
> > > now you load the module and md device is registered. That would not
> > > be really nice, also if it is ulikely that you could damnage your
> > > system
> > 
> > The RAID code checks to see if there are busy inodes for each device
> > in a RAID set. So your hundreds of scenarios are not a problem.
> > 
> 
> I had a machine that had raid1 setup correctly but was accidentally
> configured to root=/dev/hda1 (one member of the md0 raid1 set).
> 
> All was well until I noticed I wasn't rooting from md0, so reboot with new
> root=/dev/md0 and now my filesystem is b0rked (maybe because hdc1 was the
> primary mirror?).
> 
> Luckily I was still setting up that machine so I just reinstalled it.
> 
> This was with raid compiled into the kernel, so it's not a module checking
> issue, and I consider it a user error.  But maybe someone else thinks
> different...

Yep, user error. Just like if you dd if=/dev/zero of=/dev/hda2 but
meant to write to /dev/hda1 instead, and /dev/hda2 has your OS while
/dev/hda1 had M$ which you wanted to erase and re-install. Not much to
be done about that. One learns best by fucking up :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
