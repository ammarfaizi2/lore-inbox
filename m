Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161222AbWJKURN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161222AbWJKURN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWJKURM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:17:12 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:58525 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161217AbWJKURK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:17:10 -0400
Subject: [PATCH] null dereference in fs/jbd2/journal.c
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>,
       Eric Sesterhenn <snakebyte@gmx.de>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 15:17:07 -0500
Message-Id: <1160597827.12884.15.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is Eric Sesterhenn's jbd patch applied to jbd2.
Commit: 41716c7c21b15e7ecf14f0caf1eef3980707fb74

His words:

Since commit d1807793e1e7e502e3dc047115e9dbc3b50e4534 we dereference a NULL
pointer.  Coverity id #1432.  We set journal to NULL, and use it directly
afterwards.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 10db92c..c60f378 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -725,6 +725,7 @@ journal_t * jbd2_journal_init_dev(struct
 			__FUNCTION__);
 		kfree(journal);
 		journal = NULL;
+		goto out;
 	}
 	journal->j_dev = bdev;
 	journal->j_fs_dev = fs_dev;
@@ -735,7 +736,7 @@ journal_t * jbd2_journal_init_dev(struct
 	J_ASSERT(bh != NULL);
 	journal->j_sb_buffer = bh;
 	journal->j_superblock = (journal_superblock_t *)bh->b_data;
-
+out:
 	return journal;
 }
 

-- 
David Kleikamp
IBM Linux Technology Center

