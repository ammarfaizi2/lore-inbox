Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbSK1A1Z>; Wed, 27 Nov 2002 19:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSK1A1Y>; Wed, 27 Nov 2002 19:27:24 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:9221 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264983AbSK1A1X>;
	Wed, 27 Nov 2002 19:27:23 -0500
Date: Wed, 27 Nov 2002 16:26:38 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [PATCH] More LSM changes for 2.5.49
Message-ID: <20021128002638.GD7187@kroah.com>
References: <20021127230626.GB7187@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021127230626.GB7187@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.925, 2002/11/27 15:09:52-08:00, greg@kroah.com

LSM: fix conversions in hugetlbfs that I missed in the last merge.


diff -Nru a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
--- a/fs/hugetlbfs/inode.c	Wed Nov 27 15:18:16 2002
+++ b/fs/hugetlbfs/inode.c	Wed Nov 27 15:18:16 2002
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
 
