Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291103AbSBSKoE>; Tue, 19 Feb 2002 05:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291110AbSBSKny>; Tue, 19 Feb 2002 05:43:54 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:6899 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S291103AbSBSKnq>;
	Tue, 19 Feb 2002 05:43:46 -0500
Date: Tue, 19 Feb 2002 03:42:08 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
        Olaf Kirch <okir@caldera.de>
Subject: Re: [patches] RFC: Export inode generations to the userland
Message-ID: <20020219034208.E24428@lynx.adilger.int>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-kernel@vger.kernel.org,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Olaf Kirch <okir@caldera.de>
In-Reply-To: <Pine.GSO.3.96.1020218204630.13485Q-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020218204630.13485Q-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Feb 18, 2002 at 10:06:48PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 18, 2002  22:06 +0100, Maciej W. Rozycki wrote:
>  As you may know, there are serious problems with creating unique file
> handles in the userland NFS server.  They exist because the inode
> generation number, which allows to determine if an inode was deleted and
> recreated, is currently only available to the kernel -- it's by no means
> exported to user programs[1].

Well, I don't see what's so bad with EXT2_IOC_GETVERSION?  It's not like
many Linux filesystems have inode generation numbers in the first place.
It may even be that reiserfs does/would implement the EXT2_IOC_GETVERSION
ioctl also (they implemented EXT2_IOC_GETATTR compatible with ext2/ext3).
You can wrap this inside glibc if you really want to, and that has the
added benefit of working with all kernels in existence.  That's not to
say this ioctl is the best interface...

> 1. Linux was modified to add another member of "struct stat" and "struct
> stat64".  The member provides the value of the inode generation at the
> time one of the stat syscalls is invoked.  It is named "st_gen" as it is
> the name other systems give it (it seems DEC OSF/1 and IBM AIX define this
> member currently).  New syscalls have been defined wherever spare space
> was not available in "struct stat" or "struct stat64", otherwise only the
> semantics of old ones was extended.

IIRC, there are several other desirable changes to struct stat/stat64
(64-bit timestamps, 32-bit UIDs/GIDs, and others I believe, some searching
should show up complaintants) so if there is really a need to add yet
_another_ stat struct/syscall we may as well do it right _this_ time
(like we've said every other time we change this interface).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

