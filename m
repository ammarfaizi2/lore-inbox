Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269568AbUJFVCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269568AbUJFVCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269566AbUJFU7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:59:22 -0400
Received: from peabody.ximian.com ([130.57.169.10]:31720 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269558AbUJFU5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:57:24 -0400
Subject: Re: [RFC][PATCH] inotify 0.13
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1097095286.9199.2.camel@vertex>
References: <1097095286.9199.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-kN7g84Tp1nhFKYDXP6oY"
Date: Wed, 06 Oct 2004 16:55:52 -0400
Message-Id: <1097096152.4160.15.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kN7g84Tp1nhFKYDXP6oY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-10-06 at 16:41 -0400, John McCutchan wrote:

> -MOVED_FROM/MOVED_TO cookie code (me)

Forgot to update the functions in the case of !CONFIG_INOTIFY.

Attached.

	Robert Love


--=-kN7g84Tp1nhFKYDXP6oY
Content-Disposition: attachment; filename=inotify-0.13-rml-update-prototypes-1.patch
Content-Type: text/x-patch; name=inotify-0.13-rml-update-prototypes-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Update functions in case of !CONFIG_INOTIFY

Signed-Off-By: Robert Love <rml@novell.com>

 include/linux/inotify.h |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff -urN linux-inotify-0.13/include/linux/inotify.h linux/include/linux/inotify.h
--- linux-inotify-0.13/include/linux/inotify.h	2004-10-06 16:47:54.470547048 -0400
+++ linux/include/linux/inotify.h	2004-10-06 16:53:21.210874968 -0400
@@ -91,12 +91,13 @@
 
 #ifdef CONFIG_INOTIFY
 
-extern void inotify_inode_queue_event(struct inode *, __u32, __u32, const char *);
+extern void inotify_inode_queue_event(struct inode *, __u32, __u32,
+				      const char *);
 extern void inotify_dentry_parent_queue_event(struct dentry *, __u32, __u32,
 					      const char *);
 extern void inotify_super_block_umount(struct super_block *);
 extern void inotify_inode_is_dead(struct inode *);
-extern __u32  inotify_get_cookie (void);
+extern __u32 inotify_get_cookie(void);
 
 /* this could be kstrdup if only we could add that to lib/string.c */
 static inline char * inotify_oldname_init(struct dentry *old_dentry)
@@ -117,13 +118,13 @@
 #else
 
 static inline void inotify_inode_queue_event(struct inode *inode,
-					     __u32 mask,
+					     __u32 mask, __u32 cookie,
 					     const char *filename)
 {
 }
 
 static inline void inotify_dentry_parent_queue_event(struct dentry *dentry,
-						     __u32 mask,
+						     __u32 mask, __u32 cookie,
 						     const char *filename)
 {
 }

--=-kN7g84Tp1nhFKYDXP6oY--

