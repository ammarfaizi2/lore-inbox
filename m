Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTJ1Qjm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 11:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbTJ1Qjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 11:39:42 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:33366 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264039AbTJ1Qjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 11:39:40 -0500
Date: Tue, 28 Oct 2003 11:39:36 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: James Morris <jmorris@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] make selinux LSM vm_enough_memory call stackable
Message-ID: <Pine.LNX.4.44.0310281138041.24733-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stephen, James,

the following (trivial, but untested) patch makes the
selinux LSM vm_enough_memory callback stackable. This
is useful for the virtual context work I'm looking at
now.

The patch is against a very recent bk tree.

===== security/selinux/hooks.c 1.8 vs edited =====
--- 1.8/security/selinux/hooks.c	Thu Oct  2 03:12:10 2003
+++ edited/security/selinux/hooks.c	Tue Oct 28 11:30:01 2003
@@ -1270,6 +1270,10 @@
 	int rc;
 	struct task_security_struct *tsec = current->security;
 
+	rc = secondary_ops->vm_enough_memory(pages);
+	if (rc)
+		return rc;
+
 	vm_acct_memory(pages);
 
         /*

