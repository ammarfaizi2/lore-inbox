Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263881AbRFMAJ1>; Tue, 12 Jun 2001 20:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263905AbRFMAJR>; Tue, 12 Jun 2001 20:09:17 -0400
Received: from epic20.Stanford.EDU ([171.64.15.55]:55207 "EHLO
	epic20.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263881AbRFMAJJ>; Tue, 12 Jun 2001 20:09:09 -0400
Date: Tue, 12 Jun 2001 17:08:29 -0700 (PDT)
From: John Martin <suntzu@stanford.edu>
To: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: [PATCH] symlink.c
Message-ID: <Pine.GSO.4.31.0106121706490.25662-100000@epic20.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch adds a check to make sure memory was allocated, returns an
error code otherwise.
   -john

--- fs/autofs4/symlink.c.orig   Fri Apr 21 14:41:36 2000
+++ fs/autofs4/symlink.c        Sun Jun  3 00:43:18 2001
@@ -15,13 +15,15 @@
 static int autofs4_readlink(struct dentry *dentry, char *buffer, int
buflen)
 {
        struct autofs_info *ino = autofs4_dentry_ino(dentry);
-
        return vfs_readlink(dentry, buffer, buflen, ino->u.symlink);
 }

 static int autofs4_follow_link(struct dentry *dentry, struct nameidata
*nd)
 {
        struct autofs_info *ino = autofs4_dentry_ino(dentry);
+
+       if(!ino)
+               return -ENOMEM;

        return vfs_follow_link(nd, ino->u.symlink);
 }


