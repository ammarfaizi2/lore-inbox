Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262474AbRENUKc>; Mon, 14 May 2001 16:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262471AbRENUKW>; Mon, 14 May 2001 16:10:22 -0400
Received: from [136.159.55.21] ([136.159.55.21]:35737 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262464AbRENUKI>; Mon, 14 May 2001 16:10:08 -0400
Date: Mon, 14 May 2001 14:09:15 -0600
Message-Id: <200105142009.f4EK9FE17307@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B0033A4.8BB96F43@mandrakesoft.com>
In-Reply-To: <3B002FC6.C0093C18@transmeta.com>
	<3B0033A4.8BB96F43@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> "H. Peter Anvin" wrote:
> > Linus Torvalds has requested a moratorium on new device number
> > assignments. His hope is that a new and better method for device space
> > handing will emerge as a result.
> 
> Here's my suggestion for a solution.
> 
> Once I work through a bunch of net driver problems, I want to release a
> snapshot block device driver (freezes a blkdev in time).  For this, I
> needed a block major.  After hearing about the device number freeze, I
> was wondering if this solution works:
> 
> Register block device using existing API, and obtain a dynamically
> assigned major number.  Export a tiny ramfs which lists all device
> nodes.  Mounted on /dev/snap, /dev/snap/0 would be the first blkdev for
> snap's dynamically assigned major.  (Al Viro said he has skeleton code
> to create such an fs, IIRC)
> 
> This solution
> (a) keeps from grot-ing up /proc even more [I had considered
> proc_mknod() until viro talked me out of it]
> (b) does not require centrally assigned majors and minors.
> (c) does not require devfs.  most distros ship without it afaik, and
> switching to it is not an overnight process, and requires devfsd to be
> useful in the real world.

So we add yet another series of hacks to avoid doing what's
necessary?!?

BTW: I once made a patch that put back in the compatibility device
names in the kernel, so you don't need to run devfsd for this.
Obviously, that's not a patch that Linus would want in his kernel
(otherwise he wouldn't have made me take them out in the first place),
but it is something vendors can add in their patchsets (does anybody
ship a virgin kernel?).

This patch is very small and clean. It touches two places in
fs/devfs/base.c and creates one new file in fs/devfs.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
