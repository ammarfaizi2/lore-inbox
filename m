Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282907AbRLBUWc>; Sun, 2 Dec 2001 15:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282920AbRLBUWW>; Sun, 2 Dec 2001 15:22:22 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16063 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282907AbRLBUWP>; Sun, 2 Dec 2001 15:22:15 -0500
Date: Sun, 2 Dec 2001 13:22:11 -0700
Message-Id: <200112022022.fB2KMBQ12728@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@borntraeger.net (Christian =?iso-8859-1?q?Borntr=E4ger?=),
        acmay@acmay.homeip.net (andrew may),
        ajschrotenboer@lycosmail.com (Adam Schrotenboer),
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17pre2: devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
In-Reply-To: <E16Ad0j-0004Qg-00@the-village.bc.nu>
In-Reply-To: <200112022001.fB2K16Q12503@vindaloo.ras.ucalgary.ca>
	<E16Ad0j-0004Qg-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > I wouldn't say it's not back compatible. If you want to use a new
> > devfsd feature, then you need the new devfs. The key difference
> > between the old and new devfs core (aside from fixing those races) is
> > that the new devfs core will spit out an EEXIST warning message
> > whereas before it didn't. But his system still worked. It didn't
> > break.
> 
> Ok so the old devfsd works but spews a few errors. Right - then I
> agree with you.

It's not simply the version of devfsd that matters. Upgrading to a new
devfsd won't cause the errors. It's the new devfs core that's issuing
the warnings. These warnings happen because Mandrake populates devfs
with a bunch of inodes early in the boot scripts, then later the
drivers are loaded. When the drivers try to register entries, devfs
spits out the EEXIST warnings.

The point of the new devfsd is that you can use the new RESTORE
directive instead of some kludged-up boot scripts to restore
inodes. The RESTORE directive will only re-create *manually created*
inodes (i.e. when the admin goes "ln -s misc/psaux mouse"), and not
ones created by drivers or devfsd (it does however restore permissions
for any changed inodes). This avoids the duplicates that you otherwise
get with Mandrake's boot scripts.

However, for the new RESTORE directive to do what you want, you need
the new devfs core. Otherwise RESTORE will end up re-creating inodes
created by devfsd (i.e. from MKOLDCOMPAT), which is undesirable.

I hope that explains it clearly.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
