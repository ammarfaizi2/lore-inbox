Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRIVMxA>; Sat, 22 Sep 2001 08:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbRIVMwu>; Sat, 22 Sep 2001 08:52:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:56543 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269641AbRIVMwd>;
	Sat, 22 Sep 2001 08:52:33 -0400
Date: Sat, 22 Sep 2001 08:52:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: David Chow <davidchow@rcn.com.hk>
cc: linux-kernel@vger.kernel.org
Subject: Re: vfs_symlink return NULL inode
In-Reply-To: <3BAC320B.219B808F@rcn.com.hk>
Message-ID: <Pine.GSO.4.21.0109220845230.11204-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 22 Sep 2001, David Chow wrote:

> Dear all,
> 
> I have one question from using vfs_symlink, is it usual after I called
> vfs_symlink that will return a dentry with dentry->d_inode == NULL???

vfs_symlink() returns an integer, not dentry.

> The link was sucessfully created but I receive a null inode pointer. 
> When creating a symlink it should also create an inode. But according to
> the documentation about VFS from Richard, the symlink call of
> inode_operations, should self call d_instantiate() this also means it
> should automatically create an inode pointer. This shouldn't be done by
> the caller???? Any hints? the vfs_create works fine and return with a
> proper inode number, why vfs_symlink doesn't? Thanks.

No, it doesn't.  vfs_create() returns 0 in case of success and small negative
number in case of error.  Neither has any relation to inode numbers.

dentry you've passed to it is modified - it gets non-NULL ->d_inode _if_
operation succeeded.  Which is not guaranteed - depends on kind of filesystem,
length of symlink body, permissions, etc.

So unless you tell what you are passing to vfs_symlink(), what does it
return, etc. - there's nothing anyone could do.  We might be smart, by
I'm not aware of anybody here being telepathic.

