Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131342AbRARAnI>; Wed, 17 Jan 2001 19:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131340AbRARAmt>; Wed, 17 Jan 2001 19:42:49 -0500
Received: from [24.65.192.120] ([24.65.192.120]:14832 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S131342AbRARAlb>;
	Wed, 17 Jan 2001 19:41:31 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101180039.f0I0du929822@webber.adilger.net>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <Pine.LNX.4.30.0101180009460.26536-100000@pine.parrswood.manchester.sch.uk>
 "from Tim Fletcher at Jan 18, 2001 00:14:42 am"
To: Tim Fletcher <tim@parrswood.manchester.sch.uk>
Date: Wed, 17 Jan 2001 17:39:56 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Werner Almesberger <Werner.Almesberger@epfl.ch>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Fletcher writes:
> You can already do this, just specify /dev/md0 as the device to install
> onto, and lilo does the rest
> 
> > This would potentially allow you to boot from the second drive if the
> > first one fails, assuming the kernel does UUID or LABEL resolution for
> > the root device.  The kernel would boot from the first BIOS drive, and
> > would search for a UUID or LABEL as the root device.
> 
> I have a mirrored boot drive in a pair of firewalls / routers and to test
> before I put them into service I pulled hda and the machine booted fine
> from hdc and baring winging about the missing disk (all the drives are
> mirrored) carried on as normal. A fresh disk was put and rebuilt no
> problems and was then booted off with the other disk missing.

Ahh.  What I was missing was that by specifying /dev/md0 as the root device,
not only do you get an identical map for the kernels, but the root device
remains /dev/md0 no matter which drive fails and LILO/kernel don't need to
do anything special to find it.  This assumes the BIOS can boot from /dev/hdc
to start with (i.e. /dev/hda is totally gone).

How does MD/RAID0 know which array should be /dev/md0?  What if you had a
second array on /dev/hdb and /dev/hdd, would that become /dev/md0 (assuming
it had a kernel/boot sector)?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
