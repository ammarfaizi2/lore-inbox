Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVFUFom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVFUFom (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 01:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVFTWkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:40:23 -0400
Received: from coderock.org ([193.77.147.115]:16539 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262257AbVFTWEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:04:41 -0400
Message-Id: <20050620215654.202069000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:56:54 +0200
From: domen@coderock.org
To: jack@suse.cz
Cc: linux-kernel@vger.kernel.org, Maximilian Attems <janitor@sternwelten.at>,
       domen@coderock.org
Subject: [patch 1/1] list_for_each_entry: fs-dquot.c
Content-Disposition: inline; filename=list-for-each-entry-safe-fs_dquot.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>



Make code more readable with list_for_each_entry_safe.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 dquot.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

Index: quilt/fs/dquot.c
===================================================================
--- quilt.orig/fs/dquot.c
+++ quilt/fs/dquot.c
@@ -409,13 +409,10 @@ out_dqlock:
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

--
