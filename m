Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVBPUTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVBPUTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 15:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVBPUTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 15:19:50 -0500
Received: from mx2.mail.ru ([194.67.23.122]:9824 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261861AbVBPUTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 15:19:48 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] posix_acl_xattr: fix endianness warnings
Date: Wed, 16 Feb 2005 23:19:44 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502162319.44162.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix endianness warnings in fs/xattr_acl.c, fs/xfs/xfs_acl.c. Adds some in
fs/cifs/cifssmb.c ("21 insertions(+), 39 deletions(-)").

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Index: linux-warnings/include/linux/posix_acl_xattr.h
===================================================================
--- linux-warnings/include/linux/posix_acl_xattr.h	(revision 6)
+++ linux-warnings/include/linux/posix_acl_xattr.h	(revision 7)
@@ -23,13 +23,13 @@
 #define ACL_UNDEFINED_ID	(-1)
 
 typedef struct {
-	__u16			e_tag;
-	__u16			e_perm;
-	__u32			e_id;
+	__le16			e_tag;
+	__le16			e_perm;
+	__le32			e_id;
 } posix_acl_xattr_entry;
 
 typedef struct {
-	__u32			a_version;
+	__le32			a_version;
 	posix_acl_xattr_entry	a_entries[0];
 } posix_acl_xattr_header;
 
