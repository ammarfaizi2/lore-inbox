Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbTF1UoC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 16:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265438AbTF1UlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 16:41:18 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:787 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S265418AbTF1Uig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 16:38:36 -0400
Subject: Patch 2.4.21 use propper type for pid -IV
To: linux-kernel@vger.kernel.org
Date: Sat, 28 Jun 2003 22:52:51 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19WMgl-000Cqk-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi liste,
this is a small patch to fix functions that do not use the 
correct type for pid. daniele bellucci and i have worked this 
out. 

walter

--- include/linux/sched.h.org	2003-06-27 22:45:18.000000000 +0200
+++ include/linux/sched.h	2003-06-28 22:05:28.000000000 +0200
@@ -74,7 +74,7 @@
 #define CT_TO_USECS(x)	(((x) % HZ) * 1000000/HZ)
 
 extern int nr_running, nr_threads;
-extern int last_pid;
+extern pid_t last_pid;
 
 #include <linux/fs.h>
 #include <linux/time.h>
@@ -549,7 +549,7 @@
 	*p->pidhash_pprev = p->pidhash_next;
 }
 
-static inline struct task_struct *find_task_by_pid(int pid)
+static inline struct task_struct *find_task_by_pid(pid_t pid)
 {
 	struct task_struct *p, **htable = &pidhash[pid_hashfn(pid)];
 
-- 
