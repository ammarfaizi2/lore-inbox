Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312913AbSDUM6H>; Sun, 21 Apr 2002 08:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313267AbSDUM6G>; Sun, 21 Apr 2002 08:58:06 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:48063 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S312913AbSDUM6G>;
	Sun, 21 Apr 2002 08:58:06 -0400
Date: Sun, 21 Apr 2002 22:53:32 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu
Subject: [PATCH] double down() in nfsd_symlink
Message-ID: <20020421125332.GA28702@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Probably as a result of the recent BKL removal in notify_change,
nfsd_symlink downs the inode semaphore twice (the first time is in
fh_lock). Al does this patch look OK to you?


--- linux-2.5/fs/nfsd/vfs.c	Sun Apr 21 22:48:04 2002
+++ linux-2.5_work/fs/nfsd/vfs.c	Sun Apr 21 22:38:28 2002
@@ -1127,9 +1127,7 @@
 				iap->ia_valid |= ATTR_CTIME;
 				iap->ia_mode = (iap->ia_mode&S_IALLUGO)
 					| S_IFLNK;
-				down(&dentry->d_inode->i_sem);
 				err = notify_change(dnew, iap);
-				up(&dentry->d_inode->i_sem);
 				if (!err && EX_ISSYNC(fhp->fh_export))
 					write_inode_now(dentry->d_inode, 1);
 		       }

Anton
