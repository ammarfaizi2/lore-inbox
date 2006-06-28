Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWF1Wwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWF1Wwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbWF1Www
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:52:52 -0400
Received: from mail.gmx.de ([213.165.64.21]:15566 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751651AbWF1Www (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:52:52 -0400
X-Authenticated: #704063
Subject: [Patch] Dead code in fs/9p/vfs_inode.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: v9fs-developer@lists.sourceforge.net
Content-Type: text/plain
Date: Thu, 29 Jun 2006 00:52:47 +0200
Message-Id: <1151535167.28311.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

coverity (id #971) found some dead code. In all error
cases ret is NULL, so we can remove the if statement.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git11/fs/9p/vfs_inode.c.orig	2006-06-29 00:50:53.000000000 +0200
+++ linux-2.6.17-git11/fs/9p/vfs_inode.c	2006-06-29 00:51:11.000000000 +0200
@@ -386,9 +386,6 @@ v9fs_inode_from_fid(struct v9fs_session_
 
 error:
 	kfree(fcall);
-	if (ret)
-		iput(ret);
-
 	return ERR_PTR(err);
 }
 


