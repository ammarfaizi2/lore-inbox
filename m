Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVIROYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVIROYE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbVIROXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:23:37 -0400
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]:36019 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932076AbVIROX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:23:29 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 02/12] HPPFS: don't check sb->s_op in is_pid()
Date: Sun, 18 Sep 2005 16:09:46 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <20050918140946.31461.26100.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Al Viro

To check whether a directory in /proc is a "pid" directory, we also check
(uselessly) whether the super_operations match the HPPFS ones. Drop that,
as suggested by Al Viro. Cleanup codingstyle in nearby code, btw.

Actually, we don't know why we used to do this. Just guessing.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -49,18 +49,16 @@ static struct vfsmount * proc_submnt;
 
 static int is_pid(struct dentry *dentry)
 {
-	struct super_block *sb;
 	int i;
 
-	sb = dentry->d_sb;
-	if((sb->s_op != &hppfs_sbops) || (dentry->d_parent != sb->s_root))
-		return(0);
+	if (dentry->d_parent != dentry->d_sb->s_root)
+		return 0;
 
-	for(i = 0; i < dentry->d_name.len; i++){
-		if(!isdigit(dentry->d_name.name[i]))
-			return(0);
+	for (i = 0; i < dentry->d_name.len; i++) {
+		if (!isdigit(dentry->d_name.name[i]))
+			return 0;
 	}
-	return(1);
+	return 1;
 }
 
 static char *dentry_name(struct dentry *dentry, int extra)

