Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318599AbSHADry>; Wed, 31 Jul 2002 23:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318601AbSHADry>; Wed, 31 Jul 2002 23:47:54 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:30913 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S318599AbSHADrx>; Wed, 31 Jul 2002 23:47:53 -0400
Date: Wed, 31 Jul 2002 23:51:19 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: "Peter J. Braam" <braam@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: BIG files & file systems
Message-ID: <20020801035119.GA21769@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	"Peter J. Braam" <braam@clusterfs.com>,
	linux-kernel@vger.kernel.org
References: <20020731210739.GA15492@ravel.coda.cs.cmu.edu> <Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 05:13:46PM -0400, Alexander Viro wrote:
> On Wed, 31 Jul 2002, Jan Harkes wrote:
> > On Wed, Jul 31, 2002 at 01:16:20PM -0600, Peter J. Braam wrote:
> > > I've just been told that some "limitations" of the following kind will
> > > remain:
> > >   page index = unsigned long
> > >   ino_t      = unsigned long
> > 
> > The number of files is not limited by ino_t, just look at the
> > iget5_locked operation in fs/inode.c. It is possible to have your own
> > n-bit file identifier, and simply provide your own comparison function.
> > The ino_t then becomes the 'hash-bucket' in which the actual inode is
> > looked up.
> 
> You _do_ need unique ->st_ino from stat(2), though - otherwise tar(1)
> and friends will break in all sorts of amusing ways.  And there's
> nothing kernel can do about that - applications expect 32bit st_ino
> (compare them as 32bit values, etc.)

Which is why "tar and friends" are to different extents already broken
on various filesystems like Coda, NFS, NTFS, ReiserFS, and probably XFS.
(i.e. anything that currently uses iget5_locked instead of iget to grab
the inode).

Jan

