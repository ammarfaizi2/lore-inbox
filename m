Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUKTCkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUKTCkv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbUKTCkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:40:09 -0500
Received: from baikonur.stro.at ([213.239.196.228]:58057 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263092AbUKTCb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:31:56 -0500
Subject: [patch 5/9]  list_for_each_entry: 	fs-namespace.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:31:54 +0100
Message-ID: <E1CVL2Z-0000s0-8C@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Make code more readable with list_for_each_entry.
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/fs/namespace.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN fs/namespace.c~list-for-each-entry-fs_namespace fs/namespace.c
--- linux-2.6.10-rc2-bk4/fs/namespace.c~list-for-each-entry-fs_namespace	2004-11-19 17:14:57.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/fs/namespace.c	2004-11-19 17:14:57.000000000 +0100
@@ -535,7 +535,6 @@ lives_below_in_same_fs(struct dentry *d,
 static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry)
 {
 	struct vfsmount *res, *p, *q, *r, *s;
-	struct list_head *h;
 	struct nameidata nd;
 
 	res = q = clone_mnt(mnt, dentry);
@@ -544,8 +543,7 @@ static struct vfsmount *copy_tree(struct
 	q->mnt_mountpoint = mnt->mnt_mountpoint;
 
 	p = mnt;
-	for (h = mnt->mnt_mounts.next; h != &mnt->mnt_mounts; h = h->next) {
-		r = list_entry(h, struct vfsmount, mnt_child);
+	list_for_each_entry(r, &mnt->mnt_mounts, mnt_child) {
 		if (!lives_below_in_same_fs(r->mnt_mountpoint, dentry))
 			continue;
 
_
