Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269210AbUISKRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269210AbUISKRs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 06:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269212AbUISKRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 06:17:48 -0400
Received: from verein.lst.de ([213.95.11.210]:57001 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269210AbUISKRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 06:17:20 -0400
Date: Sun, 19 Sep 2004 12:17:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] don't include <linux/sysctl.h> in <linux/security.h>
Message-ID: <20040919101712.GA5949@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

security.h gets pulled in in lots of places, so use forward
declarations for struct ctl_table instead of pulling sysctl in
everywhere.


--- 1.38/include/linux/security.h	2004-06-18 20:43:31 +02:00
+++ edited/include/linux/security.h	2004-09-19 11:54:22 +02:00
@@ -27,13 +27,14 @@
 #include <linux/signal.h>
 #include <linux/resource.h>
 #include <linux/sem.h>
-#include <linux/sysctl.h>
 #include <linux/shm.h>
 #include <linux/msg.h>
 #include <linux/sched.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 
+struct ctl_table;
+
 /*
  * These functions are in security/capability.c and are used
  * as the default capabilities functions
@@ -1029,7 +1030,7 @@
			    kernel_cap_t * inheritable,
			    kernel_cap_t * permitted);
	int (*acct) (struct file * file);
-	int (*sysctl) (ctl_table * table, int op);
+	int (*sysctl) (struct ctl_table * table, int op);
	int (*capable) (struct task_struct * tsk, int cap);
	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
	int (*quota_on) (struct file * f);
@@ -1268,7 +1269,7 @@
	return security_ops->acct (file);
 }
 
-static inline int security_sysctl(ctl_table * table, int op)
+static inline int security_sysctl(struct ctl_table *table, int op)
 {
	return security_ops->sysctl(table, op);
 }
@@ -1940,7 +1941,7 @@
	return 0;
 }
 
-static inline int security_sysctl(ctl_table * table, int op)
+static inline int security_sysctl(struct ctl_table *table, int op)
 {
	return 0;
 }
===== security/selinux/hooks.c 1.60 vs edited =====
--- 1.60/security/selinux/hooks.c	2004-08-24 21:43:46 +02:00
+++ edited/security/selinux/hooks.c	2004-09-19 11:55:21 +02:00
@@ -64,6 +64,7 @@
 #include <net/ipv6.h>
 #include <linux/hugetlb.h>
 #include <linux/personality.h>
+#include <linux/sysctl.h>
 
 #include "avc.h"
 #include "objsec.h"

