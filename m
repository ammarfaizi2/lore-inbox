Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273131AbRIWCyM>; Sat, 22 Sep 2001 22:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273132AbRIWCyC>; Sat, 22 Sep 2001 22:54:02 -0400
Received: from ip122-15.asiaonline.net ([202.85.122.15]:30089 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S273131AbRIWCxo>; Sat, 22 Sep 2001 22:53:44 -0400
Date: Sun, 23 Sep 2001 10:49:48 +0800 (HKT)
From: David Chow <davidtl@rcn.com.hk>
X-X-Sender: <davidtl@uranus.planet.rcn.com.hk>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: vfs_symlink return NULL inode
In-Reply-To: <Pine.GSO.4.21.0109220845230.11204-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0109231046370.25177-100000@uranus.planet.rcn.com.hk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2001, Alexander Viro wrote:

>
>
> On Sat, 22 Sep 2001, David Chow wrote:
>
> > Dear all,
> >
> > I have one question from using vfs_symlink, is it usual after I called
> > vfs_symlink that will return a dentry with dentry->d_inode == NULL???
>
> vfs_symlink() returns an integer, not dentry.
>
> > The link was sucessfully created but I receive a null inode pointer.
> > When creating a symlink it should also create an inode. But according to
> > the documentation about VFS from Richard, the symlink call of
> > inode_operations, should self call d_instantiate() this also means it
> > should automatically create an inode pointer. This shouldn't be done by
> > the caller???? Any hints? the vfs_create works fine and return with a
> > proper inode number, why vfs_symlink doesn't? Thanks.
>
> No, it doesn't.  vfs_create() returns 0 in case of success and small negative
> number in case of error.  Neither has any relation to inode numbers.
>
> dentry you've passed to it is modified - it gets non-NULL ->d_inode _if_
> operation succeeded.  Which is not guaranteed - depends on kind of filesystem,
> length of symlink body, permissions, etc.
>
> So unless you tell what you are passing to vfs_symlink(), what does it
> return, etc. - there's nothing anyone could do.  We might be smart, by
> I'm not aware of anybody here being telepathic.
>
I shouldn't say return, it is the dentry that I pass to vfs_symlink() and
vfs_create(). The dentry passed to vfs_create did pass back a proper
dentry->d_inode. For the vfs_symlink() it didn't?? Even the link was
sucessfully created on the filesystem. The dentry->d_inode is NULL. That's
the story... thanks.

regards,

David Chow

