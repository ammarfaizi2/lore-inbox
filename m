Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUIEWrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUIEWrG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUIEWpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:45:46 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38033 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267319AbUIEWob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:44:31 -0400
Date: Sun, 5 Sep 2004 23:44:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Brent Casavant <bcasavan@sgi.com>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] shmem: Copyright file_setup trivia
In-Reply-To: <Pine.LNX.4.44.0409052331240.3218-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0409052343240.3218-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I _think_ shmem_file_setup is protected against negative loff_t size by
the TASK_SIZE in each arch, but prefer the security of an explicit test.
Wipe those parentheses off its return(file), and update our Copyright.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/shmem.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- shmem6/mm/shmem.c	2004-09-05 17:06:41.258138744 +0100
+++ shmem7/mm/shmem.c	2004-09-05 17:06:52.371449264 +0100
@@ -6,8 +6,8 @@
  *		 2000-2001 Christoph Rohland
  *		 2000-2001 SAP AG
  *		 2002 Red Hat Inc.
- * Copyright (C) 2002-2003 Hugh Dickins.
- * Copyright (C) 2002-2003 VERITAS Software Corporation.
+ * Copyright (C) 2002-2004 Hugh Dickins.
+ * Copyright (C) 2002-2004 VERITAS Software Corporation.
  * Copyright (C) 2004 Andi Kleen, SuSE Labs
  *
  * This file is released under the GPL.
@@ -2099,7 +2099,7 @@ struct file *shmem_file_setup(char *name
 	if (IS_ERR(shm_mnt))
 		return (void *)shm_mnt;
 
-	if (size > SHMEM_MAX_BYTES)
+	if (size < 0 || size > SHMEM_MAX_BYTES)
 		return ERR_PTR(-EINVAL);
 
 	if (shmem_acct_size(flags, size))
@@ -2133,7 +2133,7 @@ struct file *shmem_file_setup(char *name
 	file->f_mapping = inode->i_mapping;
 	file->f_op = &shmem_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
-	return(file);
+	return file;
 
 close_file:
 	put_filp(file);

