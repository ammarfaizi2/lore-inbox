Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVAJSwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVAJSwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVAJSva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:51:30 -0500
Received: from coderock.org ([193.77.147.115]:50620 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262405AbVAJSpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:45:30 -0500
Subject: [patch 1/5] list_for_each_entry: fs-namespace.c
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, janitor@sternwelten.at
From: domen@coderock.org
Date: Mon, 10 Jan 2005 19:45:24 +0100
Message-Id: <20050110184525.2FBAB1F1ED@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Make code more readable with list_for_each_entry.
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/fs/namespace.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN fs/namespace.c~list-for-each-entry-fs_namespace fs/namespace.c
--- kj/fs/namespace.c~list-for-each-entry-fs_namespace	2005-01-10 17:59:44.000000000 +0100
+++ kj-domen/fs/namespace.c	2005-01-10 17:59:44.000000000 +0100
@@ -536,7 +536,6 @@ lives_below_in_same_fs(struct dentry *d,
 static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry)
 {
 	struct vfsmount *res, *p, *q, *r, *s;
-	struct list_head *h;
 	struct nameidata nd;
 
 	res = q = clone_mnt(mnt, dentry);
@@ -545,8 +544,7 @@ static struct vfsmount *copy_tree(struct
 	q->mnt_mountpoint = mnt->mnt_mountpoint;
 
 	p = mnt;
-	for (h = mnt->mnt_mounts.next; h != &mnt->mnt_mounts; h = h->next) {
-		r = list_entry(h, struct vfsmount, mnt_child);
+	list_for_each_entry(r, &mnt->mnt_mounts, mnt_child) {
 		if (!lives_below_in_same_fs(r->mnt_mountpoint, dentry))
 			continue;
 
_
