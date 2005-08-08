Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVHHWbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVHHWbQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVHHWbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:31:12 -0400
Received: from coderock.org ([193.77.147.115]:30851 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932301AbVHHWah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:30:37 -0400
Message-Id: <20050808223024.861461000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:40 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Maximilian Attems <janitor@sternwelten.at>,
       domen@coderock.org
Subject: [patch 04/16] fs/namespace.c: list_for_each_entry
Content-Disposition: inline; filename=list-for-each-entry-fs_namespace.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>



Make code more readable with list_for_each_entry.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 namespace.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Index: quilt/fs/namespace.c
===================================================================
--- quilt.orig/fs/namespace.c
+++ quilt/fs/namespace.c
@@ -537,7 +537,6 @@ lives_below_in_same_fs(struct dentry *d,
 static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry)
 {
 	struct vfsmount *res, *p, *q, *r, *s;
-	struct list_head *h;
 	struct nameidata nd;
 
 	res = q = clone_mnt(mnt, dentry);
@@ -546,8 +545,7 @@ static struct vfsmount *copy_tree(struct
 	q->mnt_mountpoint = mnt->mnt_mountpoint;
 
 	p = mnt;
-	for (h = mnt->mnt_mounts.next; h != &mnt->mnt_mounts; h = h->next) {
-		r = list_entry(h, struct vfsmount, mnt_child);
+	list_for_each_entry(r, &mnt->mnt_mounts, mnt_child) {
 		if (!lives_below_in_same_fs(r->mnt_mountpoint, dentry))
 			continue;
 

--
