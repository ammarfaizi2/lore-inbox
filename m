Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWDFRy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWDFRy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 13:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWDFRy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 13:54:27 -0400
Received: from [198.99.130.12] ([198.99.130.12]:10422 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751296AbWDFRy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 13:54:26 -0400
Message-Id: <200604061655.k36GtMvc005146@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-xfs@oss.sgi.com, Daniel Phillips <phillips@google.com>,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/2] Add GFP_NOWAIT
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Apr 2006 12:55:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce GFP_NOWAIT, as an alias for GFP_ATOMIC & ~__GFP_HIGH.

This also changes XFS, which is the only in-tree user of this idiom that I 
could find.  The XFS piece is compile-tested only.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.16.orig/fs/xfs/linux-2.6/xfs_buf.c	2006-04-06 12:16:14.000000000 -0400
+++ linux-2.6.16/fs/xfs/linux-2.6/xfs_buf.c	2006-04-06 12:16:54.000000000 -0400
@@ -182,7 +182,7 @@ free_address(
 {
 	a_list_t	*aentry;
 
-	aentry = kmalloc(sizeof(a_list_t), GFP_ATOMIC & ~__GFP_HIGH);
+	aentry = kmalloc(sizeof(a_list_t), GFP_NOWAIT);
 	if (likely(aentry)) {
 		spin_lock(&as_lock);
 		aentry->next = as_free_head;
Index: linux-2.6.16/include/linux/gfp.h
===================================================================
--- linux-2.6.16.orig/include/linux/gfp.h	2006-03-21 11:50:12.000000000 -0500
+++ linux-2.6.16/include/linux/gfp.h	2006-04-06 12:15:18.000000000 -0400
@@ -57,6 +57,8 @@ struct vm_area_struct;
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
 			__GFP_NOMEMALLOC|__GFP_HARDWALL)
 
+/* This equals 0, but use constants in case they ever change */
+#define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
 /* GFP_ATOMIC means both !wait (__GFP_WAIT not set) and use emergency pool */
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)

