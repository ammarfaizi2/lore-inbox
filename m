Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUENQHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUENQHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUENQHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:07:40 -0400
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:62653 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S261611AbUENQHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:07:36 -0400
Subject: [PATCH] befs i_flags thinko
From: Will Dyson <will_dyson@pobox.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Message-Id: <1084550848.20184.7.camel@thalience>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Fri, 14 May 2004 12:07:28 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was caught by Jörn Engel <joern@wohnheim.fh-wedel.de> some time
ago. It is obviously correct. My public apologies to Jörn for delaying
his patch.


 linuxvfs.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

 
--- linux-2.6.4/fs/befs/linuxvfs.c~ext23_inode_flags    2004-03-21 17:43:58.000000000 +0100
+++ linux-2.6.4/fs/befs/linuxvfs.c      2004-03-24 01:01:11.000000000 +0100
@@ -376,7 +376,7 @@
        befs_ino->i_attribute = fsrun_to_cpu(sb, raw_inode->attributes);
        befs_ino->i_flags = fs32_to_cpu(sb, raw_inode->flags);
 
-       if (S_ISLNK(inode->i_mode) && !(inode->i_flags & BEFS_LONG_SYMLINK)) {
+       if (S_ISLNK(inode->i_mode) && !(befs_ino->i_flags & BEFS_LONG_SYMLINK)){
                inode->i_size = 0;
                inode->i_blocks = befs_sb->block_size / VFS_BLOCK_SIZE;
                strncpy(befs_ino->i_data.symlink, raw_inode->data.symlink,

