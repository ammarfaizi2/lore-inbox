Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318712AbSHAL6t>; Thu, 1 Aug 2002 07:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318715AbSHAL6s>; Thu, 1 Aug 2002 07:58:48 -0400
Received: from mark.mielke.cc ([216.209.85.42]:39692 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S318712AbSHAL6q>;
	Thu, 1 Aug 2002 07:58:46 -0400
Date: Thu, 1 Aug 2002 08:01:44 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Alexander Viro <viro@math.psu.edu>, "Peter J. Braam" <braam@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BIG files & file systems
Message-ID: <20020801080144.A8872@mark.mielke.cc>
References: <20020731210739.GA15492@ravel.coda.cs.cmu.edu> <Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu> <20020801035119.GA21769@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020801035119.GA21769@ravel.coda.cs.cmu.edu>; from jaharkes@cs.cmu.edu on Wed, Jul 31, 2002 at 11:51:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 11:51:19PM -0400, Jan Harkes wrote:
> On Wed, Jul 31, 2002 at 05:13:46PM -0400, Alexander Viro wrote:
> > You _do_ need unique ->st_ino from stat(2), though - otherwise tar(1)
> > and friends will break in all sorts of amusing ways.  And there's
> > nothing kernel can do about that - applications expect 32bit st_ino
> > (compare them as 32bit values, etc.)
> Which is why "tar and friends" are to different extents already broken
> on various filesystems like Coda, NFS, NTFS, ReiserFS, and probably XFS.
> (i.e. anything that currently uses iget5_locked instead of iget to grab
> the inode).

In theory? Maybe.

In practice, a lot more than just "tar and friends" assume that inodes
are unique...

mark (who recently, *continues* to write code that makes this assumption,
      although, granted, most of the checks are 'file caching'-type
      checks, and it isn't likely that a file will be the same size, the
      same inode, the same device, and the same path...)

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

