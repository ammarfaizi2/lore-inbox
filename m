Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278561AbRJXPUd>; Wed, 24 Oct 2001 11:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278566AbRJXPUX>; Wed, 24 Oct 2001 11:20:23 -0400
Received: from sigint.cs.purdue.edu ([128.10.2.82]:43666 "HELO
	sigint.cs.purdue.edu") by vger.kernel.org with SMTP
	id <S278561AbRJXPUQ>; Wed, 24 Oct 2001 11:20:16 -0400
Date: Wed, 24 Oct 2001 10:20:50 -0500
From: linux@sigint.cs.purdue.edu
To: linux-kernel@vger.kernel.org
Subject: [PATCH] autofs4 symlink size
Message-ID: <20011024102050.A12112@sigint.cs.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Disclaimer: Any similarity to an opinion of Purdue is purely coincidental
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this to the autofs4 maintainer a while ago, but never heard back.
autofs4 doesn't return a size for the symlinks it creates, which is
inconsistent with other filesystems.  (The Almquist shell uses the sizes
of path components to allocate buffers during a walk, so it can't traverse
autofs4-linked paths.)

This patch applies against 2.4.9 (and probably earlier) through 2.4.13.

--- fs/autofs4/inode.c.orig	Fri Feb  9 14:29:44 2001
+++ fs/autofs4/inode.c	Thu Aug 23 16:01:59 2001
@@ -315,8 +315,10 @@
 		inode->i_nlink = 2;
 		inode->i_op = &autofs4_dir_inode_operations;
 		inode->i_fop = &autofs4_dir_operations;
-	} else if (S_ISLNK(inf->mode))
+	} else if (S_ISLNK(inf->mode)) {
+		inode->i_size = inf->size;
 		inode->i_op = &autofs4_symlink_inode_operations;
+	}
 
 	return inode;
 }
