Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbSK1AEe>; Wed, 27 Nov 2002 19:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSK1AEe>; Wed, 27 Nov 2002 19:04:34 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:1011 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S264950AbSK1AEd>; Wed, 27 Nov 2002 19:04:33 -0500
Date: Wed, 27 Nov 2002 16:08:52 -0800
From: Chris Wright <chris@wirex.com>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50 : fs/hugetlbfs/inode.c error
Message-ID: <20021127160852.A320@figure1.int.wirex.com>
Mail-Followup-To: Frank Davis <fdavis@si.rr.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211271845410.4018-100000@linux-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0211271845410.4018-100000@linux-dev>; from fdavis@si.rr.com on Wed, Nov 27, 2002 at 06:47:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Frank Davis (fdavis@si.rr.com) wrote:
> 
> fs/hugetlbfs/inode.c: In function `hugetlbfs_delete_inode':
> fs/hugetlbfs/inode.c:212: `security_ops' undeclared (first use in this function)
> fs/hugetlbfs/inode.c:212: (Each undeclared identifier is reported only once
> fs/hugetlbfs/inode.c:212: for each function it appears in.)
> fs/hugetlbfs/inode.c: In function `hugetlbfs_setattr':
> fs/hugetlbfs/inode.c:336: `security_ops' undeclared (first use in this function)

Yup, GregKH missed this one and posted a patch to Linus just as 2.5.50 was
released.  The following patch from GregKH will fix this error.  This is
already in 2.5-bk.

-chris

===== fs/hugetlbfs/inode.c 1.4 vs 1.5 =====
--- 1.4/fs/hugetlbfs/inode.c	Wed Nov 20 03:19:02 2002
+++ 1.5/fs/hugetlbfs/inode.c	Wed Nov 27 15:09:41 2002
@@ -209,7 +209,7 @@
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
 
-	security_ops->inode_delete(inode);
+	security_inode_delete(inode);
 
 	clear_inode(inode);
 	destroy_inode(inode);
@@ -333,7 +333,7 @@
 	if (error)
 		goto out;
 
-	error = security_ops->inode_setattr(dentry, attr);
+	error = security_inode_setattr(dentry, attr);
 	if (error)
 		goto out;
 


