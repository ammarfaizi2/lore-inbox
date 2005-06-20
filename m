Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVFUAkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVFUAkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVFUAin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:38:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:44516 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261764AbVFTW7y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:54 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] add klist_node_attached() to determine if a node is on a list or not.
In-Reply-To: <11193083653850@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:25 -0700
Message-Id: <11193083653258@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] add klist_node_attached() to determine if a node is on a list or not.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/include/linux/klist.h b/include/linux/klist.h

---
commit 8b0c250be489dcbf1a3a33bb4ec4c7f33735a365
tree 17935d1064101df10ad7bb2f7ed94e6a88af295c
parent 2287c322b61fced7e0c326a1a9606aa73147e3df
author mochel@digitalimplant.org <mochel@digitalimplant.org> Thu, 24 Mar 2005 12:58:57 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:17 -0700

 include/linux/klist.h |    2 ++
 lib/klist.c           |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/include/linux/klist.h b/include/linux/klist.h
--- a/include/linux/klist.h
+++ b/include/linux/klist.h
@@ -37,6 +37,8 @@ extern void klist_add_head(struct klist 
 extern void klist_del(struct klist_node * n);
 extern void klist_remove(struct klist_node * n);
 
+extern int klist_node_attached(struct klist_node * n);
+
 
 struct klist_iter {
 	struct klist		* i_klist;
diff --git a/lib/klist.c b/lib/klist.c
--- a/lib/klist.c
+++ b/lib/klist.c
@@ -112,6 +112,7 @@ static void klist_release(struct kref * 
 	struct klist_node * n = container_of(kref, struct klist_node, n_ref);
 	list_del(&n->n_node);
 	complete(&n->n_removed);
+	n->n_klist = NULL;
 }
 
 static int klist_dec_and_del(struct klist_node * n)
@@ -154,6 +155,19 @@ EXPORT_SYMBOL_GPL(klist_remove);
 
 
 /**
+ *	klist_node_attached - Say whether a node is bound to a list or not.
+ *	@n:	Node that we're testing.
+ */
+
+int klist_node_attached(struct klist_node * n)
+{
+	return (n->n_klist != NULL);
+}
+
+EXPORT_SYMBOL_GPL(klist_node_attached);
+
+
+/**
  *	klist_iter_init_node - Initialize a klist_iter structure.
  *	@k:	klist we're iterating.
  *	@i:	klist_iter we're filling.
@@ -246,3 +260,5 @@ struct klist_node * klist_next(struct kl
 }
 
 EXPORT_SYMBOL_GPL(klist_next);
+
+

