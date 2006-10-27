Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946231AbWJ0HtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946231AbWJ0HtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 03:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946232AbWJ0HtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 03:49:16 -0400
Received: from smtp.boksi.fi ([195.10.143.42]:37343 "EHLO smtp1.boksi.fi")
	by vger.kernel.org with ESMTP id S1946231AbWJ0HtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 03:49:16 -0400
Message-ID: <4541B9E8.2030402@gmail.com>
Date: Fri, 27 Oct 2006 10:48:56 +0300
From: Mika Kukkonen <mikukkon@gmail.com>
Organization: Koti
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: ecryptfs-devel@lists.sourceforge.net
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix bug in fs/ecryptfs/inode.c: ecryptfs_encode_filename()
 returns int, not unsigned int
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Fix bug in fs/ecryptfs/inode.c: ecryptfs_encode_filename()
        returns int (with possible negative error value), not
        unsigned int. Both callers in the file get it wrong (they
        are also the only callers of this function). Found by gcc
        extra warning flags (the return value is checked to be < 0,
        which is pointless with unsigned). Compile tested only, but
        should be OK, as the value computed in the function
        internally is int too.

Signed-off-by: Mika Kukkonen <mikukkon@iki.fi>

---

 fs/ecryptfs/inode.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index efdd2b7..692419c 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -338,7 +338,7 @@ static struct dentry *ecryptfs_lookup(st
     struct vfsmount *lower_mnt;
     struct dentry *tlower_dentry = NULL;
     char *encoded_name;
-    unsigned int encoded_namelen;
+    int encoded_namelen;
     struct ecryptfs_crypt_stat *crypt_stat = NULL;
     char *page_virt = NULL;
     struct inode *lower_inode;
@@ -520,7 +520,7 @@ static int ecryptfs_symlink(struct inode
     struct dentry *lower_dir_dentry;
     umode_t mode;
     char *encoded_symname;
-    unsigned int encoded_symlen;
+    int encoded_symlen;
     struct ecryptfs_crypt_stat *crypt_stat = NULL;

     lower_dentry = ecryptfs_dentry_to_lower(dentry);


