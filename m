Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291308AbSBSLxt>; Tue, 19 Feb 2002 06:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291310AbSBSLxi>; Tue, 19 Feb 2002 06:53:38 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:51128 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S291308AbSBSLxW>; Tue, 19 Feb 2002 06:53:22 -0500
Date: Tue, 19 Feb 2002 12:52:32 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andreas Dilger <adilger@turbolabs.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patches] RFC: Export inode generations to the userland
In-Reply-To: <20020219034208.E24428@lynx.adilger.int>
Message-ID: <Pine.GSO.3.96.1020219122913.390A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002, Andreas Dilger wrote:

> Well, I don't see what's so bad with EXT2_IOC_GETVERSION?  It's not like
> many Linux filesystems have inode generation numbers in the first place.

1. You need permissions to open a file.

2. Opening may cause undesired side effects (think "/dev/st0").

3. You can't open a symlink.

> It may even be that reiserfs does/would implement the EXT2_IOC_GETVERSION
> ioctl also (they implemented EXT2_IOC_GETATTR compatible with ext2/ext3).
> You can wrap this inside glibc if you really want to, and that has the
> added benefit of working with all kernels in existence.  That's not to
> say this ioctl is the best interface...

 Due to the limitations quoted above the ioctl is unsuitable as an
underlying way to retrieve "st_gen" for neither of stat(), stat64(),
lstat() or lstat64(). 

> IIRC, there are several other desirable changes to struct stat/stat64
> (64-bit timestamps, 32-bit UIDs/GIDs, and others I believe, some searching
> should show up complaintants) so if there is really a need to add yet
> _another_ stat struct/syscall we may as well do it right _this_ time
> (like we've said every other time we change this interface).

 Fully agreed.  It might be desireable to keep a few spare bytes at the
end of the new "struct stat64" as well (like it's already done for "struct
stat"), so there is no need to add syscalls each time a new member is
added. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

