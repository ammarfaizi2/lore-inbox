Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWCUROk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWCUROk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWCUROj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:14:39 -0500
Received: from pat.uio.no ([129.240.130.16]:43165 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751301AbWCUROi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:14:38 -0500
Subject: VFS,fs/locks.c: cleanup locks_insert_block
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 12:14:28 -0500
Message-Id: <1142961269.7987.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.763, required 12,
	autolearn=disabled, AWL 1.24, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@fieldses.org>

BUG instead of handling a case that should never happen.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/locks.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1b4b899..a2278bc 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -533,12 +533,7 @@ static void locks_delete_block(struct fi
 static void locks_insert_block(struct file_lock *blocker, 
 			       struct file_lock *waiter)
 {
-	if (!list_empty(&waiter->fl_block)) {
-		printk(KERN_ERR "locks_insert_block: removing duplicated lock "
-			"(pid=%d %Ld-%Ld type=%d)\n", waiter->fl_pid,
-			waiter->fl_start, waiter->fl_end, waiter->fl_type);
-		__locks_delete_block(waiter);
-	}
+	BUG_ON(!list_empty(&waiter->fl_block));
 	list_add_tail(&waiter->fl_block, &blocker->fl_block);
 	waiter->fl_next = blocker;
 	if (IS_POSIX(blocker))



