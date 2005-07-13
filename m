Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVGMQnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVGMQnB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVGMQky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:40:54 -0400
Received: from peabody.ximian.com ([130.57.169.10]:33925 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262960AbVGMQjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:39:14 -0400
Subject: [patch 2/3] inotify: event ordering
From: Robert Love <rml@novell.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 12:38:39 -0400
Message-Id: <1121272719.6384.26.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached patch rearranges the event ordering for "open" to be consistent
with the ordering of the other events.

Patch is against current git tree.  Please, apply.

	Robert Love


Signed-off-by: Robert Love <rml@novell.com>

 include/linux/fsnotify.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-inotify/include/linux/fsnotify.h linux/include/linux/fsnotify.h
--- linux-inotify/include/linux/fsnotify.h	2005-07-13 11:25:31.000000000 -0400
+++ linux/include/linux/fsnotify.h	2005-07-13 11:24:27.000000000 -0400
@@ -125,8 +125,8 @@
 	if (S_ISDIR(inode->i_mode))
 		mask |= IN_ISDIR;
 
-	inotify_inode_queue_event(inode, mask, 0, NULL);
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, mask, 0, NULL);	
 }
 
 /*


