Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967141AbWKYUd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967141AbWKYUd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967167AbWKYUd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:33:56 -0500
Received: from 1wt.eu ([62.212.114.60]:43012 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S967141AbWKYUd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:33:56 -0500
Date: Sat, 25 Nov 2006 22:24:40 +0100
From: Willy Tarreau <w@1wt.eu>
To: shaggy@austin.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH-2.4] jfs: incorrect use of "&&" instead of "&"
Message-ID: <20061125212440.GA5930@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

I'm about to merge this fix in 2.4. It's already in 2.6 BTW.
Do you have any objection ?

Thanks in advance,
Willy

>From b14cb91c6621908f8e957aad5a85d6c41b31dfea Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sat, 25 Nov 2006 21:57:26 +0100
Subject: [PATCH] jfs: incorrect use of "&&" instead of "&"

in jfs_txnmgr, the use of "tblk->flag && COMMIT_DELETE" in a
if() condition is obviously wrong. This bug has already been
fixed in 2.6.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 fs/jfs/jfs_txnmgr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 62e6493..4e6a280 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -1175,7 +1175,7 @@ int txCommit(tid_t tid,		/* transaction 
 		jfs_ip = JFS_IP(ip);
 
 		if (test_and_clear_cflag(COMMIT_Syncdata, ip) &&
-		    ((tblk->flag && COMMIT_DELETE) == 0))
+		    ((tblk->flag & COMMIT_DELETE) == 0))
 			fsync_inode_data_buffers(ip);
 
 		/*
-- 
1.4.2.4

