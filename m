Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVLOOpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVLOOpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVLOOiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:38:14 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:24986 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750711AbVLOOh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:37:58 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143751.053659000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:35:59 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 02/21] PID Virtualization: task virtual pid access functions
Content-Disposition: inline; filename=F2-define-task-virt-access-functions.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce task access functions for the virtual pid domain
for pid/ppid/tgid/process_group/sessionids

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 include/linux/sched.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)

Index: linux-2.6.15-rc1/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc1.orig/include/linux/sched.h	2005-11-30 18:08:02.000000000 -0500
+++ linux-2.6.15-rc1/include/linux/sched.h	2005-11-30 18:08:02.000000000 -0500
@@ -888,6 +888,26 @@ static inline pid_t task_tgid(const stru
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
