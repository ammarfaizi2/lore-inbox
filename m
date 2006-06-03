Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWFCP3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWFCP3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 11:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWFCP3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 11:29:24 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:47630 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750798AbWFCP3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 11:29:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=PDGkwbcanODxHy40a1FsoIj81pEwFbLj4EmervugmWriqgQurPQwcdLI+x3AgE95GglELAWOKoIAsuNyepFjeCUE1jtuoSjB1QQ6KyC2Dv45abZ7iSoMxIxIrK0gMKJasy86ubOYzsUeuodB6K7ywQVLSJ5HxM1tCDtpJckg9go=
Message-ID: <4481AC0F.6040805@gmail.com>
Date: Sat, 03 Jun 2006 11:34:39 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: mark.fasheh@oracle.com, kurt.hackel@oracle.com
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] ocfs2: dereference before NULL check in ocfs2_direct_IO_get_blocks()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'bh_result' & 'inode' are explicitly checked against NULL so they
shouldn't be dereferenced prior to that.

Coverity ID: 1273, 1274.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

 fs/ocfs2/aops.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 47152bf..16d6478 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -559,13 +559,14 @@ static int ocfs2_direct_IO_get_blocks(st
 	u64 p_blkno;
 	int contig_blocks;
 	unsigned char blocksize_bits;
-	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
+	unsigned long max_blocks;
 
 	if (!inode || !bh_result) {
 		mlog(ML_ERROR, "inode or bh_result is null\n");
 		return -EIO;
 	}
 
+	max_blocks = bh_result->b_size >> inode->i_blkbits;
 	blocksize_bits = inode->i_sb->s_blocksize_bits;
 
 	/* This function won't even be called if the request isn't all



