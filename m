Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263110AbUKTEeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbUKTEeW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbUKTCkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:40:53 -0500
Received: from baikonur.stro.at ([213.239.196.228]:56980 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S262838AbUKTCcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:32:05 -0500
Subject: [patch 8/9]  list_for_each_entry: fs-dquot.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:32:04 +0100
Message-ID: <E1CVL2i-0000yp-L5@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Make code more readable with list_for_each_entry_safe.
(Didn't compile before, doesn't compile now)

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/fs/dquot.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff -puN fs/dquot.c~list-for-each-entry-safe-fs_dquot fs/dquot.c
--- linux-2.6.10-rc2-bk4/fs/dquot.c~list-for-each-entry-safe-fs_dquot	2004-11-19 17:15:07.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/fs/dquot.c	2004-11-19 17:15:07.000000000 +0100
@@ -406,13 +406,10 @@ out_dqlock:
  * for this sb+type at all. */
 static void invalidate_dquots(struct super_block *sb, int type)
 {
-	struct dquot *dquot;
-	struct list_head *head;
+	struct dquot *dquot, *tmp;
 
 	spin_lock(&dq_list_lock);
-	for (head = inuse_list.next; head != &inuse_list;) {
-		dquot = list_entry(head, struct dquot, dq_inuse);
-		head = head->next;
+	list_for_each_entry_safe(dquot, tmp, &inuse_list, dq_inuse) {
 		if (dquot->dq_sb != sb)
 			continue;
 		if (dquot->dq_type != type)
_
