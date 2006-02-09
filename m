Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWBIJkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWBIJkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbWBIJkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:40:52 -0500
Received: from [218.25.172.144] ([218.25.172.144]:49931 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S965120AbWBIJkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:40:52 -0500
Date: Thu, 9 Feb 2006 17:40:58 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sb_set_blocksize cleanup
Message-ID: <20060209094058.GA4166@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sb_set_blocksize() cleanup: make sb_set_blocksize() use blksize_bits().

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6e50346..ee78af5 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -86,16 +86,12 @@ EXPORT_SYMBOL(set_blocksize);
 
 int sb_set_blocksize(struct super_block *sb, int size)
 {
-	int bits = 9; /* 2^9 = 512 */
-
 	if (set_blocksize(sb->s_bdev, size))
 		return 0;
 	/* If we get here, we know size is power of two
 	 * and it's value is between 512 and PAGE_SIZE */
 	sb->s_blocksize = size;
-	for (size >>= 10; size; size >>= 1)
-		++bits;
-	sb->s_blocksize_bits = bits;
+	sb->s_blocksize_bits = blksize_bits(size);
 	return sb->s_blocksize;
 }
 

-- 
Coywolf Qi Hunt
