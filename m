Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUDZK2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUDZK2C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUDZK2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:28:02 -0400
Received: from ns.suse.de ([195.135.220.2]:20181 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261184AbUDZK17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:27:59 -0400
Subject: [PATCH] Return more useful error number when acls are too large
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1082973939.3295.16.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 26 Apr 2004 12:27:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

could you please add this to mainline? Getting EINVAL when an acl
becomes too large is quite confusing.



Index: linux-2.6.6-rc2/fs/ext2/acl.c
===================================================================
--- linux-2.6.6-rc2.orig/fs/ext2/acl.c	2004-04-20 23:29:46.000000000 +0200
+++ linux-2.6.6-rc2/fs/ext2/acl.c	2004-04-26 11:45:59.724792120 +0200
@@ -256,7 +256,7 @@
 	}
  	if (acl) {
 		if (acl->a_count > EXT2_ACL_MAX_ENTRIES)
-			return -EINVAL;
+			return -ENOSPC;
 		value = ext2_acl_to_disk(acl, &size);
 		if (IS_ERR(value))
 			return (int)PTR_ERR(value);
Index: linux-2.6.6-rc2/fs/ext3/acl.c
===================================================================
--- linux-2.6.6-rc2.orig/fs/ext3/acl.c	2004-04-20 23:28:53.000000000 +0200
+++ linux-2.6.6-rc2/fs/ext3/acl.c	2004-04-26 11:46:05.143968280 +0200
@@ -260,7 +260,7 @@
 	}
  	if (acl) {
 		if (acl->a_count > EXT3_ACL_MAX_ENTRIES)
-			return -EINVAL;
+			return -ENOSPC;
 		value = ext3_acl_to_disk(acl, &size);
 		if (IS_ERR(value))
 			return (int)PTR_ERR(value);


Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

