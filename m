Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272773AbRJBPnD>; Tue, 2 Oct 2001 11:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273709AbRJBPmy>; Tue, 2 Oct 2001 11:42:54 -0400
Received: from kehcheng.Stanford.EDU ([171.64.103.40]:53485 "EHLO
	kehcheng.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S272773AbRJBPms>; Tue, 2 Oct 2001 11:42:48 -0400
Date: Tue, 2 Oct 2001 08:43:16 -0700
From: Keh-Cheng Chu <kehcheng@quake.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Subject: NFS atime problem in ac kernels
Message-ID: <20011002084316.A12571@kehcheng.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In fs/nfs/inode.c, the function __nfs_refresh_inode() has a
line removed (see below) from all recent ac kernels.  This
may be the reason why, in ac kernels but not in Linus kernels,
the atime of a file in an NFS mounted directory does not get
updated after file access.  Putting the line back has solved
the problem for me.

Keh-Cheng Chu

--- linux-2.4.10/fs/nfs/inode.c Fri Sep  7 09:40:04 2001
+++ linux-2.4.10-ac3/fs/nfs/inode.c     Tue Oct  2 08:07:02 2001

@@ -1006,8 +1029,6 @@
         NFS_CACHE_CTIME(inode) = fattr->ctime;
         inode->i_ctime = nfs_time_to_secs(fattr->ctime);

-       inode->i_atime = nfs_time_to_secs(fattr->atime);
-
         NFS_CACHE_MTIME(inode) = new_mtime;
         inode->i_mtime = nfs_time_to_secs(new_mtim
