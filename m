Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbWHOSXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbWHOSXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWHOSXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:23:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14302 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030443AbWHOSXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:23:33 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4/7] pid: Export the symbols needed to use struct pid *
Date: Tue, 15 Aug 2006 12:23:09 -0600
Message-Id: <1155666193615-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pids aren't something that drivers should care about.
However there are a lot of helper layers in the kernel that do
care, and are built as modules.  Before I can convert them
to using struct pid instead of pid_t I need to export the
appropriate symbols so they can continue to be built.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/pid.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index a7ca901..40e8e4d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -153,6 +153,7 @@ fastcall void put_pid(struct pid *pid)
 	     atomic_dec_and_test(&pid->count))
 		kmem_cache_free(pid_cachep, pid);
 }
+EXPORT_SYMBOL_GPL(put_pid);
 
 static void delayed_put_pid(struct rcu_head *rhp)
 {
@@ -218,6 +219,7 @@ struct pid * fastcall find_pid(int nr)
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(find_pid);
 
 int fastcall attach_pid(struct task_struct *task, enum pid_type type, int nr)
 {
@@ -302,6 +304,7 @@ struct pid *find_get_pid(pid_t nr)
 
 	return pid;
 }
+EXPORT_SYMBOL_GPL(find_get_pid);
 
 /*
  * The pid hash table is scaled according to the amount of memory in the
-- 
1.4.2.rc3.g7e18e-dirty

