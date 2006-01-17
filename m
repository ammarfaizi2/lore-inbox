Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWAQOzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWAQOzk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWAQOu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:50:58 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:22435 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750906AbWAQOua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143326.623167000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:13 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 15/34] PID Virtualization task virtual pid access functions
Content-Disposition: inline; filename=F2-define-task-virt-access-functions.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce task access functions for the virtual pid domain
for pid/ppid/tgid/process_group/sessionids

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 sched.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)

Index: linux-2.6.15/include/linux/sched.h
===================================================================
--- linux-2.6.15.orig/include/linux/sched.h	2006-01-17 08:37:03.000000000 -0500
+++ linux-2.6.15/include/linux/sched.h	2006-01-17 08:37:03.000000000 -0500
@@ -887,6 +887,26 @@
 	return p->__tgid;
 }
 
+static inline pid_t task_vpid(const struct task_struct *p)
+{
+	return task_pid(p);
+}
+
+static inline pid_t task_vppid(const struct task_struct *p)
+{
+	return task_pid(p->parent);
+}
+
+static inline pid_t task_vtgid(const struct task_struct *p)
+{
+	return task_tgid(p);
+}
+
+static inline pid_t virt_process_group(const struct task_struct *p)
+{
+	return process_group(p);
+}
+
 extern void free_task(struct task_struct *tsk);
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)

--

