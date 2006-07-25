Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWGYPSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWGYPSp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 11:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWGYPSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 11:18:45 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:17878 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964772AbWGYPSo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 11:18:44 -0400
Subject: [PATCH] [jbd] Add lock annotation to jbd_sync_bh
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>,
       ext2-devel@lists.sourceforge.net
Content-Type: text/plain
Date: Tue, 25 Jul 2006 08:18:44 -0700
Message-Id: <1153840724.12517.6.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbd_sync_bh releases journal->j_list_lock.  Add a lock annotation to this
function so that sparse can check callers for lock pairing, and so that sparse
will not complain about this function since it intentionally uses the lock in
this manner.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 fs/jbd/checkpoint.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/jbd/checkpoint.c b/fs/jbd/checkpoint.c
index 47678a2..d068559 100644
--- a/fs/jbd/checkpoint.c
+++ b/fs/jbd/checkpoint.c
@@ -145,6 +145,7 @@ void __log_wait_for_space(journal_t *jou
  * jbd_unlock_bh_state().
  */
 static void jbd_sync_bh(journal_t *journal, struct buffer_head *bh)
+	__releases(journal->j_list_lock)
 {
 	get_bh(bh);
 	spin_unlock(&journal->j_list_lock);


