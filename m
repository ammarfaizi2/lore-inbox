Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbUDPN0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 09:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUDPN0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 09:26:35 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:49931 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S263164AbUDPN0Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 09:26:24 -0400
Date: Fri, 16 Apr 2004 15:26:20 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andries Brouwer <aebr@win.tue.nl>, fledely <fledely@bgumail.bgu.ac.il>,
       linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Accessing odd last partition sector (was: [Linux-NTFS-Dev] mkntfs
 dirty volume marking)
In-Reply-To: <20040410211301.GW31500@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.21.0404161431220.16938-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > > > 
> > > > > > TODO.ntfsprogs conatins the following TODO item under mkntfs:
> > > > > >  - We don't know what the real last sector is, thus we mark the volume
> > > > > > dirty and the subsequent chkdsk (which will happen on reboot into
> > > > > > Windows automatically) recreates the backup boot sector if the Linux
> > > > > > kernel lied to us about the number of sectors.
> > > > 
> > > > The ioctl BLKGETSIZE64 will tell you the size (in bytes) of a
> > > > block device.

Unless kernel 2.4.1[567] used (they return the size in sectors) or no
ioctl conflict with the unofficial but used BLKSETLASTSECT (the issue was
also summarized at http://lwn.net/2001/0906/kernel.php3). The last one
could (did?) corrupt NTFS (NTFS keeps metadata there) when one tried to
get the device size by BLKGETSIZE64 ...

Unfortunately not many softwares get BLKGETSIZE64 right, but at least the
latest fdisk (2.12a) and e2fsprogs (1.36-WIP) are ok AFAIS, although they
workaround these issues differently.

> > > So will lseek() to SEEK_END, actually (both 2.4 and 2.6).
> > > And yes, last sector _is_ accessible for dd(1) et.al.

I checked these for 2.4.25 and 2.6.5. In 2.4 the last odd sector is
visible only by BLKGETSIZE64 and BLKGETSIZE, otherwise it can't be
accessed, as we agreed later on.

But 2.6 is ok in all cases, size is seen correctly by BLKGETSIZE64,
BLKGETSIZE and accessible by lseek.

I don't know how intrusive, risky would be the backport but I suspect 
it's not worth. 

Thank you for clarifying the issue,

	Szaka

