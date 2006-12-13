Return-Path: <linux-kernel-owner+w=401wt.eu-S964849AbWLMLTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWLMLTH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWLMLTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:19:07 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57328 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964849AbWLMLTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:19:06 -0500
X-Greylist: delayed 636 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 06:19:06 EST
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <containers@lists.osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 11/12] pid: Remove now unused do_each_task_pid and while_each_task_pid
Date: Wed, 13 Dec 2006 04:07:55 -0700
Message-Id: <11660080802807-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
References: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I have changed all of the users remove the old version of these
functions.  This should be a clear hint to any out of tree users
that they should use do_each_pid_task and while_each_pid_task for
new code.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/pid.h |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 4dec047..2ac27f9 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -105,20 +105,6 @@ static inline pid_t pid_nr(struct pid *pid)
 	return nr;
 }
 
-
-#define do_each_task_pid(who, type, task)				\
-	do {								\
-		struct hlist_node *pos___;				\
-		struct pid *pid___ = find_pid(who);			\
-		if (pid___ != NULL)					\
-			hlist_for_each_entry_rcu((task), pos___,	\
-				&pid___->tasks[type], pids[type].node) {
-
-#define while_each_task_pid(who, type, task)				\
-			}						\
-	} while (0)
-
-
 #define do_each_pid_task(pid, type, task)				\
 	do {								\
 		struct hlist_node *pos___;				\
-- 
1.4.4.1.g278f

