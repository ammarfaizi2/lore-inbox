Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267171AbUG1R0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267171AbUG1R0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 13:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUG1R0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 13:26:50 -0400
Received: from palrel13.hp.com ([156.153.255.238]:30166 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S267357AbUG1R0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 13:26:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16647.57801.568015.688380@napali.hpl.hp.com>
Date: Wed, 28 Jul 2004 10:26:33 -0700
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, roland@redhat.com
Subject: comment "ptrace_list" and "children" members
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago I had a "fun" time sorting out how the "ptrace_children"
and the "children" lists are being used.  I think the two little
comments would help making that process a lot easier (they're based on
an earlier email by Roland).

	--david

Document the purpose of the "ptrace_list/ptrace_children" and
"children/sibling" lists.

Signed-off-by: davidm@hpl.hp.com

===== include/linux/sched.h 1.179 vs edited =====
--- 1.179/include/linux/sched.h	2004-07-06 22:19:25 -07:00
+++ edited/include/linux/sched.h	2004-07-20 21:57:10 -07:00
@@ -410,6 +410,10 @@
 	unsigned int time_slice, first_time_slice;
 
 	struct list_head tasks;
+	/*
+	 * ptrace_list/ptrace_children forms the list of my children
+	 * that were stolen by a ptracer.
+	 */
 	struct list_head ptrace_children;
 	struct list_head ptrace_list;
 
@@ -431,6 +435,10 @@
 	 */
 	struct task_struct *real_parent; /* real parent process (when being debugged) */
 	struct task_struct *parent;	/* parent process */
+	/*
+	 * children/sibling forms the list of my children plus the
+	 * tasks I'm ptracing.
+	 */
 	struct list_head children;	/* list of my children */
 	struct list_head sibling;	/* linkage in my parent's children list */
 	struct task_struct *group_leader;	/* threadgroup leader */
