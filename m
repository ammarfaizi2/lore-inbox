Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbRGMJzg>; Fri, 13 Jul 2001 05:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266960AbRGMJz0>; Fri, 13 Jul 2001 05:55:26 -0400
Received: from swsoft.mipt.ru ([193.125.143.146]:5111 "HELO srv.mipt.sw.ru")
	by vger.kernel.org with SMTP id <S266959AbRGMJzP>;
	Fri, 13 Jul 2001 05:55:15 -0400
Date: Fri, 13 Jul 2001 13:57:59 +0400
From: malfet@gw.mipt.sw.ru
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: Question about ext2
Message-ID: <20010713135759.A9986@srv.mipt.sw.ru>
In-Reply-To: <20010713120840.A9431@srv.mipt.sw.ru> <3B4EB493.DC805F45@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B4EB493.DC805F45@uow.edu.au>; from andrewm@uow.edu.au on Fri, Jul 13, 2001 at 06:42:59PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's implicit - rename can only rename files to files, and
> directories to directories.  So the check is made at a higher
> level.  Consequently when we get to ext2_rename, if we find
> that the old inode is a directory, we *know* that the new
> one is a directory as well.
Ok, let's look  at the higher levels
We call vfs_rename (old_dir, old_dentry, new_dir, new_dentry), which
checks, wether old_dentry->d_inode is directory
If so it calls vfs_rename_dir, if not calls vfs_rename_other
In vfs_rename_dir checked if we can delete old_dentry (by means of may_delete), then if new_dentry->d_inode is present, check if we can delete it
But it is not checked, wether new_dentry->d_inode directory or not
I don't find this check in chain started from syscall and ends in ext2_rename
Correct me if I'm wrong.
Thanks in advance,
	Nikita

