Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131263AbRCNB3u>; Tue, 13 Mar 2001 20:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131262AbRCNB3k>; Tue, 13 Mar 2001 20:29:40 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:55546 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131260AbRCNB3d>; Tue, 13 Mar 2001 20:29:33 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103140128.f2E1S3506105@webber.adilger.int>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <Pine.GSO.4.21.0103092114420.17677-100000@weyl.math.psu.edu> from
 Alexander Viro at "Mar 9, 2001 09:42:01 pm"
To: Alexander Viro <viro@math.psu.edu>
Date: Tue, 13 Mar 2001 18:28:03 -0700 (MST)
CC: LA Walsh <law@sgi.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al, you write:
> If you have the pair (mnt, dentry) - p = d_path(mnt, dentry, buf, buflen);
> will put the path into buf and set p pointing to its beginning.
> 
> dentry alone is not enough - it simply doesn't describe a unique point
> in the namespace. It does describe the unique point in the filesystem
> tree, but that tree can occur in several places of the unified tree.
> Thus the need of pair (vfsmount, dentry).
> 
> If you ever need to do someting like "let's find any vfsmount that
> could go in pair with our dentry" - you are doing something wrong
> (or I had missed something last Spring). Table below gives the
> list of such pairs.
> 		vfsmount	dentry
> file		->f_vfsmnt	->f_dentry
> nameidata	->mnt		->dentry
> swap component	->swap_vfsmnt	->swap_file
> knfsd export	->exp_mnt	->exp_dentry
> cwd		->pwdmnt	->pwd
> root		->rootmnt	->root
> emul.root	->altrootmnt	->altroot
> mountpoint	->mnt_parent	->mnt_mountpoint

What about if I want to know the mountpoint (inside the filesystem)
when it is mounted?  The comments in the code say sb->s_type->kern_mnt
is only valid for in-kernel filesystems (FS_SINGLE).

Would it be possible to put a valid vfsmnt pointer in kern_mnt for
non-FS_SINGLE filesystems?  Would only the vfsmnt information (maybe
d_path(kern_mnt, kern_mnt->mnt_mountpoint, buf, buflen)) be enough
to determine the pathname of the filesystem mount point?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
