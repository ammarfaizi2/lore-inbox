Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268185AbUIGPNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268185AbUIGPNP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUIGPK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:10:56 -0400
Received: from verein.lst.de ([213.95.11.210]:30362 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268323AbUIGPGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:06:04 -0400
Date: Tue, 7 Sep 2004 17:06:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport files_lock and put_filp
Message-ID: <20040907150600.GA9322@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rather lowlevel functions that modules shouldn't mess with and
foruntatly currently don't.


--- 1.36/fs/file_table.c	2004-08-27 08:31:38 +02:00
+++ edited/fs/file_table.c	2004-09-07 14:04:36 +02:00
@@ -24,11 +24,9 @@
 
 EXPORT_SYMBOL(files_stat); /* Needed by unix.o */
 
-/* public *and* exported. Not pretty! */
+/* public. Not pretty! */
 spinlock_t __cacheline_aligned_in_smp files_lock = SPIN_LOCK_UNLOCKED;
 
-EXPORT_SYMBOL(files_lock);
-
 static spinlock_t filp_count_lock = SPIN_LOCK_UNLOCKED;
 
 /* slab constructors and destructors are called from arbitrary
@@ -198,8 +196,6 @@
 		file_free(file);
 	}
 }
-
-EXPORT_SYMBOL(put_filp);
 
 void file_move(struct file *file, struct list_head *list)
 {
