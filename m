Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUEMSfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUEMSfL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbUEMSdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:33:06 -0400
Received: from village.ehouse.ru ([193.111.92.18]:1296 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264388AbUEMScL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:32:11 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] befs (2/5): microoptimisation, use befs_bread() instead of befs_bread_iaddr()
Date: Thu, 13 May 2004 22:21:35 +0400
User-Agent: KMail/1.6.1
Cc: Will Dyson <will_dyson@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <E1BOL05-0003ou-00@mail.ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We already have block number (inode->i_ino), so there is no need
to calculate it from befs_block_run before sb_bread() call (this
is what befs_bread_iaddr() do).

===== fs/befs/linuxvfs.c 1.17 vs edited =====
--- 1.17/fs/befs/linuxvfs.c	Thu Mar  4 18:03:10 2004
+++ edited/fs/befs/linuxvfs.c	Thu May 13 12:09:56 2004
@@ -325,7 +325,7 @@
 		   befs_ino->i_inode_num.allocation_group,
 		   befs_ino->i_inode_num.start, befs_ino->i_inode_num.len);
 
-	bh = befs_bread_iaddr(sb, befs_ino->i_inode_num);
+	bh = befs_bread(sb, inode->i_ino);
 	if (!bh) {
 		befs_error(sb, "unable to read inode block - "
 			   "inode = %lu", inode->i_ino);

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc

