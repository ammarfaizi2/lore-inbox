Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVAJSsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVAJSsD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVAJSoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:44:44 -0500
Received: from coderock.org ([193.77.147.115]:45756 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262404AbVAJSmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:42:22 -0500
Subject: [patch 1/1] list_for_each_entry: fs-dquot.c
To: mvw@planets.elm.net
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, janitor@sternwelten.at
From: domen@coderock.org
Date: Mon, 10 Jan 2005 19:42:17 +0100
Message-Id: <20050110184218.405431F1ED@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Make code more readable with list_for_each_entry_safe.
(Didn't compile before, doesn't compile now)

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/fs/dquot.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff -puN fs/dquot.c~list-for-each-entry-safe-fs_dquot fs/dquot.c
--- kj/fs/dquot.c~list-for-each-entry-safe-fs_dquot	2005-01-10 17:59:46.000000000 +0100
+++ kj-domen/fs/dquot.c	2005-01-10 17:59:46.000000000 +0100
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
