Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314013AbSDKKHr>; Thu, 11 Apr 2002 06:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314014AbSDKKHq>; Thu, 11 Apr 2002 06:07:46 -0400
Received: from Expansa.sns.it ([192.167.206.189]:50693 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S314013AbSDKKHp>;
	Thu, 11 Apr 2002 06:07:45 -0400
Date: Thu, 11 Apr 2002 12:07:13 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@clusterfs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RAID superblock confusion
In-Reply-To: <20020410233641.GG23513@matchmail.com>
Message-ID: <Pine.LNX.4.44.0204111202440.17727-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > >
> > > Ehh, I ran into this a while ago.  When you compile raid as modules
> > > it doesn't use the raid superblocks for anything except for
> > > verification.  I took a quick glance at the source and the
> > > auto-detect code is ifdefed out if you compiled as a module.
> >
> > Exactly where is this? A scan with find and grep don't reveal this.
> >
>
> drivers/md/md.c
>
> in the ifndef MODULE sectioin.
>
> > > Ever since I have had raid compiled into my kernels.
> >
> > This is my relevant .config:
> > CONFIG_MD=y
> > CONFIG_BLK_DEV_MD=y
> > CONFIG_MD_LINEAR=m
> > CONFIG_MD_RAID0=m
> > CONFIG_MD_RAID1=m
> > CONFIG_MD_RAID5=m
> > CONFIG_MD_MULTIPATH=m
> >
>
> Set this to =y and you're set.
>
> I'd like to see this working from modules though.

NO, please. There are hundreds of scenarios where that could be dangerous.
Suppose you load the RAID
module when all partitions are mounted, and two partiton in mirror are
mount on different mount point (you can do this, raid module is not
loaded, and so...). And now you load the module and md device is
registered. That would not be really nice, also if it is ulikely that you
could damnage your system




