Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289776AbSBKOZF>; Mon, 11 Feb 2002 09:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289757AbSBKOY6>; Mon, 11 Feb 2002 09:24:58 -0500
Received: from angband.namesys.com ([212.16.7.85]:16768 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289766AbSBKOYq>; Mon, 11 Feb 2002 09:24:46 -0500
Date: Mon, 11 Feb 2002 17:24:45 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] 2.5 [2 of 8] 02-savelink_nospace_nowarning.diff
Message-ID: <20020211172445.B1768@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Do not print a warning if savelink was not created due to lack of space.

--- linux/fs/reiserfs/super.c.orig	Mon Feb 11 09:55:00 2002
+++ linux/fs/reiserfs/super.c	Mon Feb 11 09:55:58 2002
@@ -296,10 +296,11 @@
 
     /* put "save" link inot tree */
     retval = reiserfs_insert_item (th, &path, &key, &ih, (char *)&link);
-    if (retval)
-	reiserfs_warning ("vs-2120: add_save_link: insert_item returned %d\n",
+    if (retval) {
+	if (retval != -ENOSPC)
+	    reiserfs_warning ("vs-2120: add_save_link: insert_item returned %d\n",
 			  retval);
-    else {
+    } else {
 	if( truncate )
 	    REISERFS_I(inode) -> i_flags |= i_link_saved_truncate_mask;
 	else
