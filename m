Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288825AbSAEO3W>; Sat, 5 Jan 2002 09:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288826AbSAEO3K>; Sat, 5 Jan 2002 09:29:10 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:61349 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288825AbSAEO27>; Sat, 5 Jan 2002 09:28:59 -0500
Message-Id: <5.1.0.14.2.20020105142339.03156750@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 05 Jan 2002 14:29:06 +0000
To: Daniel Phillips <phillips@bonn-fries.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Cc: Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <E16JRb5-0000cg-00@starship.berlin>
In-Reply-To: <20011226222809.A8233@havoc.gtf.org>
 <E16JR71-0000cU-00@starship.berlin>
 <20011226222809.A8233@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:52 27/12/01, Daniel Phillips wrote:
>On December 27, 2001 04:28 am, Legacy Fishtank wrote:
> > Change in principle looks good except IMHO you should go ahead and
> > remove the ext2 stuff from the union...  (with the additional changes
> > that implies)
>
>Thanks for your confidence, but that would be a considerably bigger patch.
>It's not just a matter of removing the includes - other bits and pieces have
>to be put in place, such as per-filesystem inode slab.  The support for this
>goes outside ext2.
>
>My idea is to just let people have a look and test this minimally intrusive
>change.  Getting rid of the includes for ext2 inodes will be a two-patch
>change:
>
>   1) Abstract away the ext2 .u's (done)
>   2) Per-fs inode slab, initially only for ext2 (partly done)
>
>Removing the includes for ext2 superblocks will need another two patches.  By
>the time all filesystems are done, it would be thousands of lines if it was
>all in one patch.  I think it's better to keep it broken up, and do it
>incrementally.

If anyone wants a look NTFS TNG already has gone all the way (for a while 
now in fact). Both fs inode and super block are fs internal slab caches and 
both use static inline NTFS_I / NTFS_SB functions and the ntfs includes 
from linux/fs.h are removed altogether. Code is in sourceforge cvs. For 
instructions how to download the code or to browse it online, see:

         http://sourceforge.net/cvs/?group_id=13956

The module of interest is ntfs-driver-tng.

If anyone is doing patches for all kernel file systems, don't bother with 
ntfs in 2.5 as NTFS TNG will replace the old ntfs driver soon (certainly in 
2.5 time frame).

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

