Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbULPHuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbULPHuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 02:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbULPHuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 02:50:17 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:62924 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S261826AbULPHuL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 02:50:11 -0500
Date: Wed, 15 Dec 2004 23:50:10 -0800 (PST)
From: vlobanov <vlobanov@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix init_wait macro
Message-ID: <Pine.LNX.4.58.0412152340500.17260@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In looking through bugzilla.kernel.org, I found a rather old and easy
bug still laying around unfixed:
  bug #3863 (http://bugzilla.kernel.org/show_bug.cgi?id=3863)

The patch is straightforward -- wrap the macro argument in parentheses,
to prevent incorrect operator binding. Applies against 2.6.10-rc3.

======================================================
diff -Nru a/include/linux/wait.h b/include/linux/wait.h
--- a/include/linux/wait.h	2004-12-04 23:00:18.000000000 -0800
+++ b/include/linux/wait.h	2004-12-15 22:51:58.000000000 -0800
@@ -344,9 +344,9 @@

 #define init_wait(wait)							\
 	do {								\
-		wait->task = current;					\
-		wait->func = autoremove_wake_function;			\
-		INIT_LIST_HEAD(&wait->task_list);			\
+		(wait)->task = current;					\
+		(wait)->func = autoremove_wake_function;		\
+		INIT_LIST_HEAD(&(wait)->task_list);			\
 	} while (0)

 /**
======================================================

Let me know if there are any objections to this patch, though I do not
foresee any. Since this is a general patch, I should forward it to Linux
or Rusty, though not sure who would be best in this case.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>
