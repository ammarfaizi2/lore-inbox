Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282668AbRLBBuP>; Sat, 1 Dec 2001 20:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282670AbRLBBt4>; Sat, 1 Dec 2001 20:49:56 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:7102 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282668AbRLBBty>; Sat, 1 Dec 2001 20:49:54 -0500
Date: Sat, 1 Dec 2001 18:49:54 -0700
Message-Id: <200112020149.fB21nso04834@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
Cc: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17pre2: devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
In-Reply-To: <20011202013724.9085AFB80D@tabris.net>
In-Reply-To: <E16A6LR-00042s-00@mrvdom02.schlund.de>
	<200112011808.fB1I8lq31535@vindaloo.ras.ucalgary.ca>
	<20011202013724.9085AFB80D@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Schrotenboer writes:
> On Saturday 01 December 2001 13:08, Richard Gooch wrote:
> > linux-kernel@borntraeger.net writes:
> <snip>
> > The new devfs core is less forgiving about these kinds of
> > bugs/misuses.
> >
> > > devfs: devfs_register(nvidiactl): could not append to parent, err: -17
> > > devfs: devfs_register(nvidia0): could not append to parent, err: -17
> > >
> > > with 2.4.16 and before the message was:
> > >
> > > devfs: devfs_register(): device already registered: "nvidia0"
> >
> > Who knows what nvidia does? Talk to them. Could be a bug in their
> > driver where they create duplicate entries (the old devfs code would
> > often let you get away with this). Or again, perhaps something in
> > user-space is creating these entries.
> >
> As of 1541 anyway (haven't tried anything newer, assuming newer
> exists), the make install of the nvidia driver also runs
> makedevices.sh (a vendor sp script that makes the devnodes. This may
> also have been put in the initscripts (mine isn't, but i tend to use
> the tar.gz fmt, not using the RPMs) Perhaps there is no check for
> devfs (likely will be fixed in the next release, as this is a new
> situation)

Well, it doesn't matter if the install script dumps things into /dev,
since that will be lost on the next boot anyway. What matters is if
the boot scripts (or something else) puts things in devfs.

> > > Why has this changed, and what is actually happen? My system runs
> > > fine.
> >
> > You're lucky that the with way you use your system, it still works.
> >
> <snip> AFAIK, the nvidia scipt does not make the devnodes persistent
> (if so, it's b0rken on my box)

You can easily check this: move the NVidia drivers elsewhere and
reboot. If device nodes for nvidia appear in devfs, then something in
user-space is creating those inodes.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
