Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWFMUHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWFMUHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWFMUHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:07:09 -0400
Received: from mail.gmx.net ([213.165.64.21]:59539 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932176AbWFMUHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:07:08 -0400
X-Authenticated: #704063
Subject: [Patch] Remove needless checks in fs/9p/vfs_inode.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: ericvh@gmail.com
Content-Type: text/plain
Date: Tue, 13 Jun 2006 22:07:02 +0200
Message-Id: <1150229222.15006.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

coverity found two needless checks in vfs_inode.c (cid #1165 and #1164)
In both cases inode is always NULL when we goto error; either because it
is still initialized to NULL or is set to NULL explicitly. This patch
simply removes these checks to save some code.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>


--- linux-2.6.17-rc5/fs/9p/vfs_inode.c.orig	2006-06-13 22:01:56.000000000 +0200
+++ linux-2.6.17-rc5/fs/9p/vfs_inode.c	2006-06-13 22:02:18.000000000 +0200
@@ -530,9 +530,6 @@ error:
 	if (vfid)
 		v9fs_fid_destroy(vfid);
 
-	if (inode)
-		iput(inode);
-
 	return err;
 }
 
@@ -1171,9 +1168,6 @@ error:
 	if (vfid)
 		v9fs_fid_destroy(vfid);
 
-	if (inode)
-		iput(inode);
-
 	return err;
 
 }


