Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbUKGQYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbUKGQYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 11:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUKGQYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 11:24:09 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:60899 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261646AbUKGQYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 11:24:05 -0500
Date: Sun, 7 Nov 2004 16:23:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, <ishikawa@yk.rim.or.jp>, <anton@samba.org>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] mount no tmpfs confusion
Message-ID: <Pine.LNX.4.44.0411071619590.21300-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My tmpfs superblock changes in 2.6.9 messed up mount -t tmpfs when
CONFIG_TMPFS is not enabled: it wrongly claimed to succeed, and left
the directory unusable, giving "Not a directory" errors thereafter.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.10-rc1/mm/shmem.c	2004-10-23 12:44:13.000000000 +0100
+++ linux/mm/shmem.c	2004-11-07 11:50:53.894426456 +0000
@@ -1930,6 +1930,8 @@ static int shmem_fill_super(struct super
 		sbinfo->free_inodes = inodes;
 	}
 	sb->s_xattr = shmem_xattr_handlers;
+#else
+	sb->s_flags |= MS_NOUSER;
 #endif
 
 	sb->s_maxbytes = SHMEM_MAX_BYTES;

