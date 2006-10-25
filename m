Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWJYT2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWJYT2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 15:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWJYT2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 15:28:38 -0400
Received: from smtp.boksi.fi ([195.10.143.42]:6745 "EHLO smtp1.boksi.fi")
	by vger.kernel.org with ESMTP id S1750788AbWJYT2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 15:28:36 -0400
Message-ID: <453FBAF3.7060208@gmail.com>
Date: Wed, 25 Oct 2006 22:28:51 +0300
From: Mika Kukkonen <mikukkon@gmail.com>
Organization: Koti
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: v9fs-developer@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Function v9fs_get_idpool returns int, not u32 as called twice
 in fs/9p/vfs_inode.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

|[V9FS] Function v9fs_get_idpool returns int, not u32. Actually
       it returns -1 on errors, and these two callers check if
       the value is smaller than 0, which was caught by gcc with
       extra warning flags. Compile tested only but should be OK,
       as the value computed in v9fs_get_idpool() is also int.

Signed-of-by: Mika Kukkonen <mikukkon@iki.fi>

---

 fs/9p/vfs_inode.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 5241c60..18f26cd 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -256,7 +256,7 @@ static int
 v9fs_create(struct v9fs_session_info *v9ses, u32 pfid, char *name, u32 perm,
 	u8 mode, char *extension, u32 *fidp, struct v9fs_qid *qid, u32 *iounit)
 {
-	u32 fid;
+	int fid;
 	int err;
 	struct v9fs_fcall *fcall;
 
@@ -310,7 +310,7 @@ static struct v9fs_fid*
 v9fs_clone_walk(struct v9fs_session_info *v9ses, u32 fid, struct dentry *dentry)
 {
 	int err;
-	u32 nfid;
+	int nfid;
 	struct v9fs_fid *ret;
 	struct v9fs_fcall *fcall;


|


