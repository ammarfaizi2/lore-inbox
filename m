Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030495AbWBHDUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbWBHDUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbWBHDUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:20:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:7297 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030495AbWBHDUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:20:17 -0500
To: torvalds@osdl.org
Subject: [PATCH 29/29] umount_tree() decrements mount count on wrong dentry
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6fsP-0006F1-6t@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:20:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138798401 -0500

*duh*

braino introduced when doing shared-tree patchset massage; missed during code
review _and_ testing; credit for finally noticing that in some cases rmdir()
and friends started returning -EBUSY even after umount() goes to
janak@us.ibm.com

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

f30ac319f1b91878cdc57a50930f15c36e0e103a
diff --git a/fs/namespace.c b/fs/namespace.c
index a2bef5c..058a448 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -494,7 +494,7 @@ void umount_tree(struct vfsmount *mnt, i
 		p->mnt_namespace = NULL;
 		list_del_init(&p->mnt_child);
 		if (p->mnt_parent != p)
-			mnt->mnt_mountpoint->d_mounted--;
+			p->mnt_mountpoint->d_mounted--;
 		change_mnt_propagation(p, MS_PRIVATE);
 	}
 }
-- 
0.99.9.GIT

