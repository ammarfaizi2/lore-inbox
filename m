Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSHBM2L>; Fri, 2 Aug 2002 08:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSHBM2L>; Fri, 2 Aug 2002 08:28:11 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:43904 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S311025AbSHBM2J>; Fri, 2 Aug 2002 08:28:09 -0400
Message-Id: <5.1.0.14.2.20020802133144.00ab5a40@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 02 Aug 2002 13:33:42 +0100
To: Chris Mason <mason@suse.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: BIG files & file systems
Cc: Stephen Lord <lord@sgi.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
       Alexander Viro <viro@math.psu.edu>,
       "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1028290680.12670.199.camel@tiny>
References: <1028246981.11223.56.camel@snafu>
 <20020731210739.GA15492@ravel.coda.cs.cmu.edu>
 <Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu>
 <20020801035119.GA21769@ravel.coda.cs.cmu.edu>
 <1028246981.11223.56.camel@snafu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:17 02/08/02, Chris Mason wrote:
>On Thu, 2002-08-01 at 20:09, Stephen Lord wrote:
>
> > > > You _do_ need unique ->st_ino from stat(2), though - otherwise tar(1)
> > > > and friends will break in all sorts of amusing ways.  And there's
> > > > nothing kernel can do about that - applications expect 32bit st_ino
> > > > (compare them as 32bit values, etc.)
> > >
> > > Which is why "tar and friends" are to different extents already broken
> > > on various filesystems like Coda, NFS, NTFS, ReiserFS, and probably XFS.
> > > (i.e. anything that currently uses iget5_locked instead of iget to grab
> > > the inode).
> >
> > Why are they broken? In the case of XFS at least you still get a unique
> > and stable inode number back - and it fits in 32 bits too.
>
>reiserfs is not broken here.  It has unique stable 32 bit inode numbers,
>but looking up the file on disk requires 64 bits of information.

ntfs is not broken here, either. It also uses unique stable 32 bit inode 
numbers, but inside the driver (not visible to user space at all at 
present), we use additional, fake inodes. But tar and friends will never 
see those so there is no problem...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

