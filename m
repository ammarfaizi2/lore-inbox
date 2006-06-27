Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932961AbWF0CKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932961AbWF0CKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 22:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932962AbWF0CKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 22:10:39 -0400
Received: from 70-57-128-88.albq.qwest.net ([70.57.128.88]:7560 "EHLO
	moria.ionkov.net") by vger.kernel.org with ESMTP id S932961AbWF0CKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 22:10:38 -0400
Date: Mon, 26 Jun 2006 22:22:02 -0600
From: Latchesar Ionkov <lucho@ionkov.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH] v9fs: fix fid check in v9fs_create
Message-ID: <20060627042202.GA17354@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an incorrect check whether a fid was allocated in
v9fs_create and if it should be freed on error.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit 11658df9c0dac2f2fdffc135f1daa3a711d21d21
tree 356a204b379e8c02d17e8987d994842c94122b2f
parent c675b970b2befed791fa29f606852e205a009e62
author Latchesar Ionkov <lucho@ionkov.net> Mon, 26 Jun 2006 11:09:47 -0600
committer Latchesar Ionkov <lucho@ionkov.net> Mon, 26 Jun 2006 11:09:47 -0600

 fs/9p/vfs_inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 5c6bdf8..2f580a1 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -300,7 +300,7 @@ clunk_fid:
 	fid = V9FS_NOFID;
 
 put_fid:
-	if (fid >= 0)
+	if (fid != V9FS_NOFID)
 		v9fs_put_idpool(fid, &v9ses->fidpool);
 
 	kfree(fcall);

