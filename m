Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWGXTwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWGXTwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 15:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWGXTwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 15:52:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:17880 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751423AbWGXTv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 15:51:59 -0400
Date: Thu, 20 Jul 2006 14:34:19 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Sane return value for ecryptfs_commit_write()
Message-ID: <20060720193419.GA12086@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calling functions expect the return value from ecryptfs_commit_write()
to be 0 on success.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/mmap.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

9c56c9f6f49840860068b461c1d956391cbc5550
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 65e7331..8a4040d 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -628,7 +628,6 @@ static int ecryptfs_commit_write(struct 
 {
 	struct ecryptfs_page_crypt_context ctx;
 	loff_t pos;
-	unsigned bytes = to - from;
 	struct inode *inode;
 	struct inode *lower_inode;
 	struct file *lower_file;
@@ -671,7 +670,7 @@ static int ecryptfs_commit_write(struct 
 				"index [0x%.16x])\n", page->index);
 		goto out;
 	}
-	rc = bytes;
+	rc = 0;
 	inode->i_blocks = lower_inode->i_blocks;
 	pos = (page->index << PAGE_CACHE_SHIFT) + to;
 	if (pos > i_size_read(inode)) {
-- 
1.3.3

