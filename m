Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVATDax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVATDax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVATDYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:24:32 -0500
Received: from mail.suse.de ([195.135.220.2]:31187 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262031AbVATDX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:23:27 -0500
Message-Id: <20050120032510.682620000@suse.de>
References: <20050120020124.110155000@suse.de>
Date: Thu, 20 Jan 2005 03:01:24 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Cc: Andrew Tridgell <tridge@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: [patch 2/5] Set the EXT3_FEATURE_COMPAT_EXT_ATTR for in-inode xattrs
Content-Disposition: inline; filename=ea-xattr-update-sb.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The xattr feature was only set when creating an xattr block. Also set it
when creating in-inode xattrs.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-latest/fs/ext3/xattr.c
===================================================================
--- linux-2.6.11-latest.orig/fs/ext3/xattr.c
+++ linux-2.6.11-latest/fs/ext3/xattr.c
@@ -823,7 +823,6 @@ getblk_failed:
 			error = ext3_journal_dirty_metadata(handle, new_bh);
 			if (error)
 				goto cleanup;
-			ext3_xattr_update_super_block(handle, sb);
 		}
 	}
 
@@ -1001,6 +1000,7 @@ ext3_xattr_set_handle(handle_t *handle, 
 		}
 	}
 	if (!error) {
+		ext3_xattr_update_super_block(handle, inode->i_sb);
 		inode->i_ctime = CURRENT_TIME_SEC;
 		error = ext3_mark_iloc_dirty(handle, inode, &is.iloc);
 		/*

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

