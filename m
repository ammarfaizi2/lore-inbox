Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269250AbUI3Nhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269250AbUI3Nhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 09:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269262AbUI3NZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 09:25:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21400 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269266AbUI3NYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 09:24:03 -0400
Date: Thu, 30 Sep 2004 14:23:34 +0100
Message-Id: <200409301323.i8UDNYYV004777@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 4/10]: ext3 online resize: Use IS_RDONLY()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_RDONLY() instead of checking MS_RDONLY manually, for readability.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc2-mm4/fs/ext3/ioctl.c.=K0003=.orig
+++ linux-2.6.9-rc2-mm4/fs/ext3/ioctl.c
@@ -183,7 +183,7 @@ flags_err:
 		if (!capable(CAP_SYS_RESOURCE))
 			return -EPERM;
 
-		if (sb->s_flags & MS_RDONLY)
+		if (IS_RDONLY(inode))
 			return -EROFS;
 
 		if (get_user(n_blocks_count, (__u32 *)arg))
@@ -204,7 +204,7 @@ flags_err:
 		if (!capable(CAP_SYS_RESOURCE))
 			return -EPERM;
 
-		if (inode->i_sb->s_flags & MS_RDONLY)
+		if (IS_RDONLY(inode))
 			return -EROFS;
 
 		if (copy_from_user(&input, (struct ext3_new_group_input *)arg,
