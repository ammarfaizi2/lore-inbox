Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVCYWJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVCYWJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVCYWIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:08:36 -0500
Received: from mail.dif.dk ([193.138.115.101]:25271 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261836AbVCYWHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:07:01 -0500
Date: Fri, 25 Mar 2005 23:08:55 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: ext2-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] no need to check for NULL before calling kfree() - fs/ext2/
Message-ID: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please keep me on CC)


kfree() handles NULL fine, to check is redundant.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/fs/ext2/acl.c	2005-03-02 08:38:18.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/ext2/acl.c	2005-03-25 22:41:07.000000000 +0100
@@ -194,8 +194,7 @@ ext2_get_acl(struct inode *inode, int ty
 		acl = NULL;
 	else
 		acl = ERR_PTR(retval);
-	if (value)
-		kfree(value);
+	kfree(value);
 
 	if (!IS_ERR(acl)) {
 		switch(type) {
@@ -262,8 +261,7 @@ ext2_set_acl(struct inode *inode, int ty
 
 	error = ext2_xattr_set(inode, name_index, "", value, size, 0);
 
-	if (value)
-		kfree(value);
+	kfree(value);
 	if (!error) {
 		switch(type) {
 			case ACL_TYPE_ACCESS:


