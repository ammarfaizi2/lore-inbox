Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129351AbQKWRd7>; Thu, 23 Nov 2000 12:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129385AbQKWRdt>; Thu, 23 Nov 2000 12:33:49 -0500
Received: from radius.brandx.net ([209.55.67.42]:18949 "EHLO radius.brandx.net")
        by vger.kernel.org with ESMTP id <S129351AbQKWRdn>;
        Thu, 23 Nov 2000 12:33:43 -0500
Date: Thu, 23 Nov 2000 09:00:48 -0800
From: Matt Kraai <kraai@alumni.carnegiemellon.edu>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix error code when read()ing directories in /proc
Message-ID: <20001123090048.A321@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

Calling read() on some directories in /proc returns EINVAL, rather
than EISDIR.  The other filesystems return EISDIR and the manpage says
this is what should be returned in this situation.  The appended patch
applies against 2.4.0-test11.

Matt

diff -urN linux-vanilla/fs/proc/generic.c linux/fs/proc/generic.c
--- linux-vanilla/fs/proc/generic.c	Fri Nov 17 16:51:47 2000
+++ linux/fs/proc/generic.c	Thu Nov 23 08:00:41 2000
@@ -336,6 +336,7 @@
  * the /proc directory.
  */
 static struct file_operations proc_dir_operations = {
+	read:			generic_read_dir,
 	readdir:		proc_readdir,
 };
 
diff -urN linux-vanilla/fs/proc/root.c linux/fs/proc/root.c
--- linux-vanilla/fs/proc/root.c	Fri Nov 17 16:51:47 2000
+++ linux/fs/proc/root.c	Thu Nov 23 08:00:27 2000
@@ -82,6 +82,7 @@
  * directory handling functions for that..
  */
 static struct file_operations proc_root_operations = {
+	read:		 generic_read_dir,
 	readdir:	 proc_root_readdir,
 };
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
