Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312465AbSDNVIV>; Sun, 14 Apr 2002 17:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312466AbSDNVIT>; Sun, 14 Apr 2002 17:08:19 -0400
Received: from hera.cwi.nl ([192.16.191.8]:20734 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312465AbSDNVIQ>;
	Sun, 14 Apr 2002 17:08:16 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 14 Apr 2002 21:08:00 GMT
Message-Id: <UTC200204142108.VAA622694.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] chown in 2.5.8pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.8pre3 root cannot chown his files to some mortal.
I have not read the code but blindly made the change below,
and that fixed this particular problem for me.

Andries

--- /linux/2.5/linux-2.5.8-pre3/linux/fs/open.c	Fri Apr 12 12:10:48 2002
+++ ./open.c	Tue Apr 16 00:00:38 2002
@@ -522,13 +522,13 @@
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto out;
-	newattrs.ia_valid =  ATTR_CTIME;
+	newattrs.ia_valid = ATTR_CTIME;
 	if (user != (uid_t) -1) {
-		newattrs.ia_valid =  ATTR_UID;
+		newattrs.ia_valid |= ATTR_UID;
 		newattrs.ia_uid = user;
 	}
 	if (group != (gid_t) -1) {
-		newattrs.ia_valid =  ATTR_GID;
+		newattrs.ia_valid |= ATTR_GID;
 		newattrs.ia_gid = group;
 	}
 	if (!S_ISDIR(inode->i_mode))
