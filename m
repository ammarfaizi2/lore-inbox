Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282196AbRK1X4x>; Wed, 28 Nov 2001 18:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282204AbRK1X4o>; Wed, 28 Nov 2001 18:56:44 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:31988 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282196AbRK1X40>;
	Wed, 28 Nov 2001 18:56:26 -0500
Date: Wed, 28 Nov 2001 16:55:30 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 bio offset by one error in VIA IDE
Message-ID: <20011128165530.L856@lynx.no>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com> <15364.3457.368582.994067@gargle.gargle.HOWL> <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com> <20011128132000.T23858@suse.de> <5.1.0.14.2.20011128232246.00aea8f0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <5.1.0.14.2.20011128232246.00aea8f0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Wed, Nov 28, 2001 at 11:31:14PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 28, 2001  23:31 +0000, Anton Altaparmakov wrote:
> I just booted my Athlon VIA KT133 chipset box with 2.5.1-pre2 only to 
> discover it dropped me into single user mode because /dev/hda2 could not be 
> mounted. (Rebooting into 2.5.0+viro patch everything is ok, back into 
> 2.5.1-pre2 is broken...)
> 
> Looking with hexedit /dev/hda2 when booted into 2.5.1-pre2 the first sector 
> contains junk, the second sector contains the real data that I see as the 
> first sector when booted into 2.5.0+viro fix.
> 
> That suggests to me there is an off by one error in the VIA IDE driver in 
> the 2.5.10pre2 kernel causing the partition to start one sector earlier 
> than it should.

It may be an issue with your particular partition table having /dev/hda1
being an odd number of 512-byte sectors long, but Jens' code only doing
math on 1kB blocks.  Just speculation of course.  What does "fdisk -ul"
tell you under the two kernels?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

