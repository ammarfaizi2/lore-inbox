Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSDMT37>; Sat, 13 Apr 2002 15:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293713AbSDMT35>; Sat, 13 Apr 2002 15:29:57 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:21387 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S293680AbSDMT3S>; Sat, 13 Apr 2002 15:29:18 -0400
Date: Sat, 13 Apr 2002 13:29:05 -0600
Message-Id: <200204131929.g3DJT5g06645@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Andreas Dilger <adilger@clusterfs.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: RAID superblock confusion
In-Reply-To: <Pine.LNX.4.44.0204111202440.17727-100000@Expansa.sns.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni writes:
> 
> > > >
> > > > Ehh, I ran into this a while ago.  When you compile raid as modules
> > > > it doesn't use the raid superblocks for anything except for
> > > > verification.  I took a quick glance at the source and the
> > > > auto-detect code is ifdefed out if you compiled as a module.
> > >
> > > Exactly where is this? A scan with find and grep don't reveal this.
> > >
> >
> > drivers/md/md.c
> >
> > in the ifndef MODULE sectioin.
> >
> > > > Ever since I have had raid compiled into my kernels.
> > >
> > > This is my relevant .config:
> > > CONFIG_MD=y
> > > CONFIG_BLK_DEV_MD=y
> > > CONFIG_MD_LINEAR=m
> > > CONFIG_MD_RAID0=m
> > > CONFIG_MD_RAID1=m
> > > CONFIG_MD_RAID5=m
> > > CONFIG_MD_MULTIPATH=m
> > >
> >
> > Set this to =y and you're set.
> >
> > I'd like to see this working from modules though.
> 
> NO, please. There are hundreds of scenarios where that could be
> dangerous.  Suppose you load the RAID module when all partitions are
> mounted, and two partiton in mirror are mount on different mount
> point (you can do this, raid module is not loaded, and so...). And
> now you load the module and md device is registered. That would not
> be really nice, also if it is ulikely that you could damnage your
> system

The RAID code checks to see if there are busy inodes for each device
in a RAID set. So your hundreds of scenarios are not a problem.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
