Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261751AbREPBQw>; Tue, 15 May 2001 21:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261753AbREPBQc>; Tue, 15 May 2001 21:16:32 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:23802 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261752AbREPBQZ>; Tue, 15 May 2001 21:16:25 -0400
Message-Id: <5.1.0.14.2.20010516020702.00acce40@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 16 May 2001 02:17:47 +0100
To: "H. Peter Anvin" <hpa@transmeta.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Getting FS access events
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3B01AF49.A66DB880@transmeta.com>
In-Reply-To: <200105152231.f4FMVSC246046@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:35 15/05/2001, H. Peter Anvin wrote:
>"Albert D. Cahalan" wrote:
> > H. Peter Anvin writes:
> > > This would leave no way (without introducing new interfaces) to write,
> > > for example, the boot block on an ext2 filesystem.  Note that the
> > > bootblock (defined as the first 1024 bytes) is not actually used by
> > > the filesystem, although depending on the block size it may share a
> > > block with the superblock (if blocksize > 1024).
> >
> > The lack of coherency would screw this up anyway, doesn't it?
> > You have a block device, soon to be in the page cache, and
> > a superblock, also soon to be in the page cache. LILO writes to
> > the block device, while the ext2 driver updates the superblock.
> > Whatever gets written out last wins, and the other is lost.
>
>Albert, I *did* say "this better work or we have a problem."

And how are you thinking of this working "without introducing new 
interfaces" if the caches are indeed incoherent? Please correct me if I 
understand wrong, but when two caches are incoherent, I thought it means 
that the above _would_ screw up unless protected by exclusive write locking 
as I suggested in my previous post with the side effect that you can't 
write the boot block without unmounting the filesystem or modifying some 
interface somewhere.

As not all filesystems are like ext2, perhaps it would be better to fix 
ext2 and not the cache coherency? If ext2 is claiming ownership of a 
device, then it should do so in its entirety IMHO. You could always extend 
ext2 to use the NTFS approach where the bootsector is nothing more than a 
file which happens to exist on sector(s) zero (and following) of the 
device... (just a thought)

Best regards,

Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

