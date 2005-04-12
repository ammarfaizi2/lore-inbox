Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVDLSQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVDLSQn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVDLKbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:31:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:55495 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262108AbVDLKa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:30:57 -0400
Message-Id: <200504121030.j3CAUkUl005147@shell0.pdx.osdl.net>
Subject: [patch 009/198] Fix acl Oops
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, agruen@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andreas Gruenbacher <agruen@suse.de>

ext[23]_get_acl will return an error when reading the attribute fails or
out-of-memory occurs.  Catch this case.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/ext2/acl.c |    2 ++
 25-akpm/fs/ext3/acl.c |    2 ++
 2 files changed, 4 insertions(+)

diff -puN fs/ext2/acl.c~fix-acl-oops fs/ext2/acl.c
--- 25/fs/ext2/acl.c~fix-acl-oops	2005-04-12 03:21:05.616283096 -0700
+++ 25-akpm/fs/ext2/acl.c	2005-04-12 03:21:05.621282336 -0700
@@ -283,6 +283,8 @@ ext2_check_acl(struct inode *inode, int 
 {
 	struct posix_acl *acl = ext2_get_acl(inode, ACL_TYPE_ACCESS);
 
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
 	if (acl) {
 		int error = posix_acl_permission(inode, acl, mask);
 		posix_acl_release(acl);
diff -puN fs/ext3/acl.c~fix-acl-oops fs/ext3/acl.c
--- 25/fs/ext3/acl.c~fix-acl-oops	2005-04-12 03:21:05.618282792 -0700
+++ 25-akpm/fs/ext3/acl.c	2005-04-12 03:21:05.622282184 -0700
@@ -286,6 +286,8 @@ ext3_check_acl(struct inode *inode, int 
 {
 	struct posix_acl *acl = ext3_get_acl(inode, ACL_TYPE_ACCESS);
 
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
 	if (acl) {
 		int error = posix_acl_permission(inode, acl, mask);
 		posix_acl_release(acl);
_
