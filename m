Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbUJYOjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbUJYOjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbUJYOjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:39:37 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:38568 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261824AbUJYOjJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:39:09 -0400
Cc: raven@themaw.net
Subject: [PATCH 1/28] VFS: Unexport umount_tree
In-Reply-To: <10987151092039@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:39:00 -0400
Message-Id: <10987151403173@sun.com>
References: <10987151092039@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unexport umount_tree.  I don't see any in-kernel users of this call.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/namespace.c            |    2 +-
 include/linux/namespace.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6.9-quilt/include/linux/namespace.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/namespace.h	2004-08-14 01:36:59.000000000 -0400
+++ linux-2.6.9-quilt/include/linux/namespace.h	2004-10-22 17:17:32.919459624 -0400
@@ -12,7 +12,6 @@ struct namespace {
 	struct rw_semaphore	sem;
 };
 
-extern void umount_tree(struct vfsmount *);
 extern int copy_namespace(int, struct task_struct *);
 extern void __put_namespace(struct namespace *namespace);
 
Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-08-14 01:37:25.000000000 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:32.921459320 -0400
@@ -338,7 +338,7 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
-void umount_tree(struct vfsmount *mnt)
+static void umount_tree(struct vfsmount *mnt)
 {
 	struct vfsmount *p;
 	LIST_HEAD(kill);

