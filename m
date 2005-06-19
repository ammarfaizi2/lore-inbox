Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVFSTcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVFSTcj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 15:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVFSTch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 15:32:37 -0400
Received: from mail.dif.dk ([193.138.115.101]:34488 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261284AbVFSTce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 15:32:34 -0400
Date: Sun, 19 Jun 2005 21:38:03 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: "Rickard E. (Rik) Faith" <faith@redhat.com>, Rik Faith <faith@cs.unc.edu>
Subject: [PATCH] Small kfree cleanup, save a local variable.
Message-ID: <Pine.LNX.4.62.0506192129300.2832@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch with a small improvement to kernel/auditsc.c .
There's no need for the local variable  struct audit_entry *e  , 
we can just call kfree directly on container_of() .
Patch also removes an extra space a little further down in the file.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 kernel/auditsc.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.12-orig/kernel/auditsc.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/kernel/auditsc.c	2005-06-19 21:21:37.000000000 +0200
@@ -202,8 +202,7 @@ static inline int audit_add_rule(struct 
 
 static void audit_free_rule(struct rcu_head *head)
 {
-	struct audit_entry *e = container_of(head, struct audit_entry, rcu);
-	kfree(e);
+	kfree(container_of(head, struct audit_entry, rcu));
 }
 
 /* Note that audit_add_rule and audit_del_rule are called via
@@ -612,7 +611,7 @@ static inline void audit_free_context(st
 		audit_free_names(context);
 		audit_free_aux(context);
 		kfree(context);
-		context  = previous;
+		context = previous;
 	} while (context);
 	if (count >= 10)
 		printk(KERN_ERR "audit: freed %d contexts\n", count);


