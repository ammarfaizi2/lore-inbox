Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316783AbSFQGsa>; Mon, 17 Jun 2002 02:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSFQGrP>; Mon, 17 Jun 2002 02:47:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16910 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316773AbSFQGrN>;
	Mon, 17 Jun 2002 02:47:13 -0400
Message-ID: <3D0D86E6.6164E1ED@zip.com.au>
Date: Sun, 16 Jun 2002 23:51:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 3/19] update_atime cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Remove unneeded do_update_atime(), and convert update_atime() to C.




--- 2.5.22/fs/inode.c~update_atime-cleanup	Sun Jun 16 22:50:17 2002
+++ 2.5.22-akpm/fs/inode.c	Sun Jun 16 22:50:17 2002
@@ -913,16 +913,6 @@ int bmap(struct inode * inode, int block
 	return res;
 }
 
-static inline void do_atime_update(struct inode *inode)
-{
-	unsigned long time = CURRENT_TIME;
-	if (inode->i_atime != time) {
-		inode->i_atime = time;
-		mark_inode_dirty_sync(inode);
-	}
-}
-
-
 /**
  *	update_atime	-	update the access time
  *	@inode: inode accessed
@@ -932,15 +922,19 @@ static inline void do_atime_update(struc
  *	as well as the "noatime" flag and inode specific "noatime" markers.
  */
  
-void update_atime (struct inode *inode)
+void update_atime(struct inode *inode)
 {
 	if (inode->i_atime == CURRENT_TIME)
 		return;
-	if ( IS_NOATIME (inode) ) return;
-	if ( IS_NODIRATIME (inode) && S_ISDIR (inode->i_mode) ) return;
-	if ( IS_RDONLY (inode) ) return;
-	do_atime_update(inode);
-}   /*  End Function update_atime  */
+	if (IS_NOATIME(inode))
+		return;
+	if (IS_NODIRATIME(inode) && S_ISDIR(inode->i_mode))
+		return;
+	if (IS_RDONLY(inode))
+		return;
+	inode->i_atime = CURRENT_TIME;
+	mark_inode_dirty_sync(inode);
+}
 
 int inode_needs_sync(struct inode *inode)
 {

-
