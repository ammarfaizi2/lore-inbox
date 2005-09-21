Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVIUBYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVIUBYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVIUBYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:24:08 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:29665 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932111AbVIUBYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:24:06 -0400
Date: Tue, 20 Sep 2005 21:24:05 -0400
From: Latchesar Ionkov <lucho@ionkov.net>
To: linux-kernel@vger.kernel.org
Cc: v9fs-developer@lists.sourceforge.net
Subject: [PATCH] v9fs-replace-strlen-with-pathmax-getname.patch
Message-ID: <20050921012405.GE2008@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

strlen errorneously called with newly allocated by __getname buffer

---
commit 0b381cf7efcd34bb6b316baf7ed5d18d402e62f0
tree c8ec5ac42ec5d1c28d2f97a1de553940f3746f2b
parent 34ad50ad5bf63c55687350d9f4e3c4dcc44304a7
author Latchesar Ionkov <lucho@ionkov.net> Tue, 20 Sep 2005 19:28:30 -0400
committer Latchesar Ionkov <lucho@ionkov.net> Tue, 20 Sep 2005 19:28:30 -0400

 fs/9p/vfs_inode.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1063,8 +1063,8 @@ static int v9fs_vfs_readlink(struct dent
 	int ret;
 	char *link = __getname();
 
-	if (strlen(link) < buflen)
-		buflen = strlen(link);
+	if (buflen > PATH_MAX)
+		buflen = PATH_MAX;
 
 	dprintk(DEBUG_VFS, " dentry: %s (%p)\n", dentry->d_iname, dentry);
 
