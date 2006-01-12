Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbWALO6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWALO6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbWALO6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:58:05 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:54747 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030436AbWALO6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:58:01 -0500
Date: Thu, 12 Jan 2006 16:58:00 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ext3: remove d_splice_alias NULL check from ext3_lookup
Message-ID: <Pine.LNX.4.58.0601121657220.4513@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch removes redundant NULL check in ext3_lookup() as d_splice_alias()
can take NULL inode as input.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/ext3/namei.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: 2.6/fs/ext3/namei.c
===================================================================
--- 2.6.orig/fs/ext3/namei.c
+++ 2.6/fs/ext3/namei.c
@@ -1005,10 +1005,7 @@ static struct dentry *ext3_lookup(struct
 		if (!inode)
 			return ERR_PTR(-EACCES);
 	}
-	if (inode)
-		return d_splice_alias(inode, dentry);
-	d_add(dentry, inode);
-	return NULL;
+	return d_splice_alias(inode, dentry);
 }
 
 
