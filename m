Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131200AbRBUAcU>; Tue, 20 Feb 2001 19:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131167AbRBUAcL>; Tue, 20 Feb 2001 19:32:11 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:55538 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129677AbRBUAcG>; Tue, 20 Feb 2001 19:32:06 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102210031.f1L0VQU15564@webber.adilger.net>
Subject: Re: [lvm-devel] *** ANNOUNCEMENT *** LVM 0.9.1 beta5 available at www.sistina.com
In-Reply-To: <20010220234219.B2023@athlon.random> from Andrea Arcangeli at "Feb
 20, 2001 11:42:19 pm"
To: Linux LVM Development list <lvm-devel@sistina.com>
Date: Tue, 20 Feb 2001 17:31:25 -0700 (MST)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea writes:
> On Tue, Feb 20, 2001 at 10:49:07PM +0000, Heinz Mauelshagen wrote:
> > A change in the i/o protocoll version *forces* you to update
> > the driver as well.
> 
> I didn't had much time to look into beta5 yet but I can't see why you changed
> the protocol to 11. There's no breakage between beta4 and beta5 in the
> datastructures shared with userspace.  I don't like gratuitous API breakage.

The reason why the IOP was changed was because the VG_CREATE ioctl now
depends on the vg_number in the supplied vg_t to determine which VG minor
number to use.  The old interface used the minor number of the opened
device inode, but for devfs the device inodes don't exist until the VG
is created...  If you run an older kernel with new tools, you can only
use the first VG.

I suggested reverting this change for the current release, and only fixing
the LVM devfs code (which is probably still broken in other ways).  Heinz
decided to update the IOP instead.  Note that with the new library build,
it is possible to have multiple IOP tools installed at the same time, and
the correct ones are chosen at runtime based on the kernel IOP.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
