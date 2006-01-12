Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWALO7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWALO7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbWALO7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:59:13 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:57307 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030438AbWALO7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:59:12 -0500
Date: Thu, 12 Jan 2006 16:59:11 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] isofs: remove d_splice_alias NULL check from isofs_lookup
Message-ID: <Pine.LNX.4.58.0601121658010.4513@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch removes redundant NULL check in isofs_lookup() as d_splice_alias()
can take NULL inode as input.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/isofs/namei.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: 2.6/fs/isofs/namei.c
===================================================================
--- 2.6.orig/fs/isofs/namei.c
+++ 2.6/fs/isofs/namei.c
@@ -185,8 +185,5 @@ struct dentry *isofs_lookup(struct inode
 		}
 	}
 	unlock_kernel();
-	if (inode)
-		return d_splice_alias(inode, dentry);
-	d_add(dentry, inode);
-	return NULL;
+	return d_splice_alias(inode, dentry);
 }
