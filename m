Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVLOOoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVLOOoF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVLOOi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:38:27 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:34970 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750721AbVLOOiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:38:21 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143813.600198000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:03 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 06/21] PID Virtualization: Define pid_to_vpid functions
Content-Disposition: inline; filename=F6-define-pid-to-vpid-translation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch we introduce convertion functions to 
translate pids into virtual pids. These are just the APIs
not the implementation yet.
Subsequent patches will utilize these internal functions
to rewrite the task virtual pid/ppid/tgid access functions
such that finally we only have to rewrite these virtual
conversion functions to actually obtain the pid virtualization.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 include/linux/sched.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

Index: linux-2.6.15-rc1/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc1.orig/include/linux/sched.h	2005-11-30 18:08:02.000000000 -0500
+++ linux-2.6.15-rc1/include/linux/sched.h	2005-11-30 18:08:03.000000000 -0500
@@ -866,6 +866,20 @@ static inline pid_t process_group(const 
 }
 
 /**
+ *  pid domain translation functions:
+ *	- from kernel to user pid domain
+ */
+static inline pid_t pid_to_vpid(pid_t pid)
+{
+	return pid;
+}
+
+static inline pid_t pgid_to_vpgid(pid_t pid)
+{
+	return pid;
+}
+
+/**
  * pid_alive - check that a task structure is not stale
  * @p: Task structure to be checked.
  *

--
