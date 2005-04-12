Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVDLS6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVDLS6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVDLSuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:50:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:7114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262114AbVDLKcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:51 -0400
Message-Id: <200504121032.j3CAWi7J005664@shell0.pdx.osdl.net>
Subject: [patch 131/198] quota: fix possible oops on quotaoff
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jack@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jan Kara <jack@suse.cz>

Remove dquot structures from quota file on quotaon - quota code does not
expect them to be there.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/dquot.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/dquot.c~quota-fix-possible-oops-on-quotaoff fs/dquot.c
--- 25/fs/dquot.c~quota-fix-possible-oops-on-quotaoff	2005-04-12 03:21:35.241779336 -0700
+++ 25-akpm/fs/dquot.c	2005-04-12 03:21:35.245778728 -0700
@@ -1443,6 +1443,7 @@ static int vfs_quota_on_inode(struct ino
 	oldflags = inode->i_flags & (S_NOATIME | S_IMMUTABLE | S_NOQUOTA);
 	inode->i_flags |= S_NOQUOTA | S_NOATIME | S_IMMUTABLE;
 	up_write(&dqopt->dqptr_sem);
+	sb->dq_op->drop(inode);
 
 	error = -EIO;
 	dqopt->files[type] = igrab(inode);
_
