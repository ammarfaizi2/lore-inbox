Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269288AbUI3NmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269288AbUI3NmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 09:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269259AbUI3NZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 09:25:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18072 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269262AbUI3NX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 09:23:58 -0400
Date: Thu, 30 Sep 2004 14:23:18 +0100
Message-Id: <200409301323.i8UDNI0t004759@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 1/10]: ext3 online resize: fix error codes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return EPERM, not EACCES, if we try to extend the filesystem without
sufficient privilege.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc2-mm4/fs/ext3/ioctl.c.=K0000=.orig
+++ linux-2.6.9-rc2-mm4/fs/ext3/ioctl.c
@@ -181,7 +181,7 @@ flags_err:
 		int err;
 
 		if (!capable(CAP_SYS_RESOURCE))
-			return -EACCES;
+			return -EPERM;
 
 		if (sb->s_flags & MS_RDONLY)
 			return -EROFS;
@@ -202,7 +202,7 @@ flags_err:
 		int err;
 
 		if (!capable(CAP_SYS_RESOURCE))
-			return -EACCES;
+			return -EPERM;
 
 		if (inode->i_sb->s_flags & MS_RDONLY)
 			return -EROFS;
