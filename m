Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288839AbSAEO4d>; Sat, 5 Jan 2002 09:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288835AbSAEO4X>; Sat, 5 Jan 2002 09:56:23 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:21928 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288831AbSAEO4K>; Sat, 5 Jan 2002 09:56:10 -0500
Message-Id: <5.1.0.14.2.20020105145226.03163170@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 05 Jan 2002 14:56:23 +0000
To: Daniel Phillips <phillips@bonn-fries.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Cc: Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <E16Ms6L-0001Gz-00@starship.berlin>
In-Reply-To: <5.1.0.14.2.20020105142339.03156750@pop.cus.cam.ac.uk>
 <20011226222809.A8233@havoc.gtf.org>
 <5.1.0.14.2.20020105142339.03156750@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:47 05/01/02, Daniel Phillips wrote:
>On January 5, 2002 03:29 pm, Anton Altaparmakov wrote:
> > If anyone wants a look NTFS TNG already has gone all the way (for a while
> > now in fact). Both fs inode and super block are fs internal slab caches 
> and
> > both use static inline NTFS_I / NTFS_SB functions and the ntfs includes
> > from linux/fs.h are removed altogether. Code is in sourceforge cvs. For
> > instructions how to download the code or to browse it online, see:
>
>Nice, did you use the generic_ip fields?

Yes. From ntfs-driver-tng/linux/fs/ntfs/fs.h:

/**
  * NTFS_SB - return the ntfs volume given a vfs super block
  * @sb:         VFS super block
  *
  * NTFS_SB() returns the ntfs volume associated with the VFS super block @sb.
  */
static inline ntfs_volume *NTFS_SB(struct super_block *sb)
{
         return sb->u.generic_sbp;
}

/**
  * NTFS_I - return the ntfs inode given a vfs inode
  * @inode:      VFS inode
  *
  * NTFS_I() returns the ntfs inode associated with the VFS @inode.
  */
static inline ntfs_inode *NTFS_I(struct inode *inode)
{
         return inode->u.generic_ip;
}

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

