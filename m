Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVESW67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVESW67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 18:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVESW60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:58:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59810 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261312AbVESW5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:57:11 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (19/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtxQ-0007tt-Ni@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:57:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(19/19)

__do_follow_link() passes potentially worng vfsmount to touch_atime().
It matters only in (currently impossible) case of symlink mounted on
something, but it's trivial to fix and that actually makes more sense.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-18/fs/namei.c RC12-rc4-19/fs/namei.c
--- RC12-rc4-18/fs/namei.c	2005-05-19 16:39:48.010936857 -0400
+++ RC12-rc4-19/fs/namei.c	2005-05-19 16:39:49.096720499 -0400
@@ -503,7 +503,7 @@
 	int error;
 	struct dentry *dentry = path->dentry;
 
-	touch_atime(nd->mnt, dentry);
+	touch_atime(path->mnt, dentry);
 	nd_set_link(nd, NULL);
 
 	if (path->mnt == nd->mnt)
