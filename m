Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWEAHLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWEAHLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWEAHLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:11:40 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44817 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751304AbWEAHLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:11:38 -0400
Date: Mon, 1 May 2006 09:11:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: John McCutchan <john@johnmccutchan.com>, rml@novell.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/inotify.c: cleanups
Message-ID: <20060501071138.GJ3570@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global variables static:
  - inotify_max_user_instances
  - inotify_max_user_watches
  - inotify_max_queued_events
- remove the following unused EXPORT_SYMBOL_GPL's:
  - inotify_get_cookie
  - inotify_unmount_inodes
  - inotify_inode_is_dead

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: John McCutchan <john@johnmccutchan.com>

---

This patch was already sent on:
- 23 Apr 2006

 fs/inotify.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- linux-2.6.17-rc1-mm3-full/fs/inotify.c.old	2006-04-23 12:12:52.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/fs/inotify.c	2006-04-23 12:18:46.000000000 +0200
@@ -45,9 +45,9 @@
 static struct vfsmount *inotify_mnt __read_mostly;
 
 /* these are configurable via /proc/sys/fs/inotify/ */
-int inotify_max_user_instances __read_mostly;
-int inotify_max_user_watches __read_mostly;
-int inotify_max_queued_events __read_mostly;
+static int inotify_max_user_instances __read_mostly;
+static int inotify_max_user_watches __read_mostly;
+static int inotify_max_queued_events __read_mostly;
 
 /*
  * Lock ordering:
@@ -627,7 +627,6 @@
 {
 	return atomic_inc_return(&inotify_cookie);
 }
-EXPORT_SYMBOL_GPL(inotify_get_cookie);
 
 /**
  * inotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
@@ -706,7 +705,6 @@
 		spin_lock(&inode_lock);
 	}
 }
-EXPORT_SYMBOL_GPL(inotify_unmount_inodes);
 
 /**
  * inotify_inode_is_dead - an inode has been deleted, cleanup any watches
@@ -725,7 +723,6 @@
 	}
 	mutex_unlock(&inode->inotify_mutex);
 }
-EXPORT_SYMBOL_GPL(inotify_inode_is_dead);
 
 /* Device Interface */
 

