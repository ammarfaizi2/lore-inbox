Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWDWLrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWDWLrF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 07:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWDWLrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 07:47:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:268 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751383AbWDWLrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 07:47:04 -0400
Date: Sun, 23 Apr 2006 13:47:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ttb@tentacle.dhs.org, rml@novell.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/inotify.c: possible cleanups
Message-ID: <20060423114703.GL5010@stusta.de>
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

---

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
 

