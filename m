Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVIBT3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVIBT3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVIBT3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:29:43 -0400
Received: from smtp.istop.com ([66.11.167.126]:2733 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1750954AbVIBT3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:29:43 -0400
From: Daniel Phillips <phillips@istop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ia_attr_flags - time to die
Date: Sat, 3 Sep 2005 05:14:22 +1000
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509030514.22844.phillips@istop.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Struct iattr is not involved any more in such things as NOATIME inode flags.
There are no in-tree users of ia_attr_flags.

Signed-off-by Daniel Phillips <phillips@istop.com>

diff -up --recursive 2.6.13-rc5-mm1.clean/fs/hostfs/hostfs.h 2.6.13-rc5-mm1/fs/hostfs/hostfs.h
--- 2.6.13-rc5-mm1.clean/fs/hostfs/hostfs.h	2005-08-09 18:23:11.000000000 -0400
+++ 2.6.13-rc5-mm1/fs/hostfs/hostfs.h	2005-09-01 17:54:40.000000000 -0400
@@ -49,7 +49,6 @@ struct hostfs_iattr {
 	struct timespec	ia_atime;
 	struct timespec	ia_mtime;
 	struct timespec	ia_ctime;
-	unsigned int	ia_attr_flags;
 };
 
 extern int stat_file(const char *path, unsigned long long *inode_out,
diff -up --recursive 2.6.13-rc5-mm1.clean/include/linux/fs.h 2.6.13-rc5-mm1/include/linux/fs.h
--- 2.6.13-rc5-mm1.clean/include/linux/fs.h	2005-08-09 18:23:31.000000000 -0400
+++ 2.6.13-rc5-mm1/include/linux/fs.h	2005-09-01 18:27:42.000000000 -0400
@@ -282,19 +282,9 @@ struct iattr {
 	struct timespec	ia_atime;
 	struct timespec	ia_mtime;
 	struct timespec	ia_ctime;
-	unsigned int	ia_attr_flags;
 };
 
 /*
- * This is the inode attributes flag definitions
- */
-#define ATTR_FLAG_SYNCRONOUS	1 	/* Syncronous write */
-#define ATTR_FLAG_NOATIME	2 	/* Don't update atime */
-#define ATTR_FLAG_APPEND	4 	/* Append-only file */
-#define ATTR_FLAG_IMMUTABLE	8 	/* Immutable file */
-#define ATTR_FLAG_NODIRATIME	16 	/* Don't update atime for directory */
-
-/*
  * Includes for diskquotas.
  */
 #include <linux/quota.h>
