Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWARHZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWARHZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWARHZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:25:00 -0500
Received: from 203-59-65-76.dyn.iinet.net.au ([203.59.65.76]:22469 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1030275AbWARHYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:24:55 -0500
Date: Wed, 18 Jan 2006 15:24:19 +0800
Message-Id: <200601180724.k0I7OJr3006202@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: [PATCH 11/13] autofs4 - rename simple_empty_nolock function
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames the function simple_empty_nolock to
__simple_empty in line with kernel naming conventions.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.15-mm3/fs/autofs4/autofs_i.h.rename-simple_empty_nolock	2006-01-13 16:27:45.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/autofs_i.h	2006-01-13 16:28:06.000000000 +0800
@@ -200,7 +200,7 @@ static inline int simple_positive(struct
 	return dentry->d_inode && !d_unhashed(dentry);
 }
 
-static inline int simple_empty_nolock(struct dentry *dentry)
+static inline int __simple_empty(struct dentry *dentry)
 {
 	struct dentry *child;
 	int ret = 0;
--- linux-2.6.15-mm3/fs/autofs4/root.c.rename-simple_empty_nolock	2006-01-13 16:27:09.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/root.c	2006-01-13 16:28:07.000000000 +0800
@@ -343,7 +343,7 @@ static int autofs4_revalidate(struct den
 	spin_lock(&dcache_lock);
 	if (S_ISDIR(dentry->d_inode->i_mode) &&
 	    !d_mountpoint(dentry) && 
-	    simple_empty_nolock(dentry)) {
+	    __simple_empty(dentry)) {
 		DPRINTK("dentry=%p %.*s, emptydir",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 		spin_unlock(&dcache_lock);
