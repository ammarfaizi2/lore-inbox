Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131254AbRBUBLh>; Tue, 20 Feb 2001 20:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130731AbRBUBL2>; Tue, 20 Feb 2001 20:11:28 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21338 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130510AbRBUBLY>; Tue, 20 Feb 2001 20:11:24 -0500
Date: Wed, 21 Feb 2001 02:12:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Linux LVM Development list <lvm-devel@sistina.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Subject: Re: [lvm-devel] *** ANNOUNCEMENT *** LVM 0.9.1 beta5 available at www.sistina.com
Message-ID: <20010221021252.A932@athlon.random>
In-Reply-To: <20010220234219.B2023@athlon.random> <200102210031.f1L0VQU15564@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200102210031.f1L0VQU15564@webber.adilger.net>; from adilger@turbolinux.com on Tue, Feb 20, 2001 at 05:31:25PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 05:31:25PM -0700, Andreas Dilger wrote:
> The reason why the IOP was changed was because the VG_CREATE ioctl now
> depends on the vg_number in the supplied vg_t to determine which VG minor
> number to use.  The old interface used the minor number of the opened
> device inode, but for devfs the device inodes don't exist until the VG
> is created...  If you run an older kernel with new tools, you can only
> use the first VG.

Ah, I was reading the patch incidentally against 2.2 patch where devfs support
is not included, so I wasn't thinking the devfs way ;). Thanks for the
explanation.

I assume it's not possible to mknod on top of devfs.  So then we could use a
temporary device in /var/tmp or whatever for that.  However those workarounds
tends to be ugly.

Probably the best way to preserve the IOP that I recommend for beta6 is to add
a new ioctl to the VG chardevice.  Rename VG_CREATE to VG_CREATE_OLD.
VG_CREATE_OLD is a wrapper that calculates the minor number from the inode and
then fallbacks into VG_CREATE, and the new VG_CREATE is the one that gets
the minor of the vg from userspace.

Either ways we don't break backwards compatibilty across 0.9* cycle.

If there would been a strong reason and it would be a mess to provide backwards
compatibilty I would of course agree to raise at IOP 11, but just to avoid a
few lines of code for a wrapper or a temporary mknod on /tmp for a devfs-only
fix, I think it worth to preserve IOP 10.

Andrea
