Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSFRU0l>; Tue, 18 Jun 2002 16:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317604AbSFRU0k>; Tue, 18 Jun 2002 16:26:40 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:21752 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317603AbSFRU0k>; Tue, 18 Jun 2002 16:26:40 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 18 Jun 2002 14:25:00 -0600
To: Chris Adams <cmadams@hiwaay.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/scsi/map
Message-ID: <20020618202500.GP22427@clusterfs.com>
Mail-Followup-To: Chris Adams <cmadams@hiwaay.net>,
	linux-kernel@vger.kernel.org
References: <20020618150654.A506017@hiwaay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020618150654.A506017@hiwaay.net>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 18, 2002  15:06 -0500, Chris Adams wrote:
> I use OSF/1^WDigital Unix^WCompaq^WHP Tru64 Unix here at work, and with
> version 5, they've got a nice persistent device naming system (I don't
> claim to know how it works however).  The first hard drive found is
> /dev/disk/dsk0, the second is /dev/disk/dsk1, etc.  It doesn't matter
> how you get to the drive (which is important if you want multipathing -
> the controller and bus should NOT figure into the device name or you are
> going to have problems).  If you remove dsk0, there won't be another
> dsk0 (unless you clean it out of the device database).

Yes, this is the same as AIX - the physical connection is irrelevant.
Any attempts to identify disk devices by their physical connection
are only marginally better than the current "probe order" naming.

I have written a library which allows identifying devices by content.
It uses the UUIDs found in ext2/ext3/XFS/JFS/MD. I added support for
UUIDs in reiserfs and swap also - the reiserfs UUID support is in
recent kernels/tools, but I never got around to submitting a patch
for swap (just to reserve the fields in the swap header definition,
the kernel doesn't really care about the contents).

The code was built as part of e2fsprogs (so fsck could use it), but
again I didn't push my changes back to the stock e2fsprogs yet.  What
I'm really waiting for is to ensure the current library works well
with mount (so you can use "mount LABEL=blah" for all filesystem types).

The library is at the following URL if anyone is interested in hacking
mount to use it.  I have an agreement-in-principle from Andries Brouwer
to accept changes to the mount/swapon code to use libblkid.

http://www-mddsp.enel.ucalgary.ca/People/adilger/blkid/

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

