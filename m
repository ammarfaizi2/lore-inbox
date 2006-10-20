Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992564AbWJTHll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992564AbWJTHll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992574AbWJTHll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:41:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31201 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S2992564AbWJTHlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:41:40 -0400
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Paul Jackson <pj@sgi.com>, ak@suse.de, linux-kernel@vger.kernel.org
Date: Fri, 20 Oct 2006 00:41:32 -0700
Message-Id: <20061020074132.26006.32346.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH] cpuset: mempolicy migration typo fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Mistyped an ifdef CONFIG_CPUSETS - fixed.

I doubt that anyone ever noticed.  The impact of this typo was
that if someone:
 1) was using MPOL_BIND to force off node allocations
 2) while using cpusets to constrain memory placement
 3) when that cpuset was migrating that jobs memory
 4) while the tasks in that job were actively forking
then there was a rare chance that future allocations using
that MPOL_BIND policy would be node local, not off node.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

It builds under my cross tool setup, it runs my usual
cpuset tests and it runs my not particularly elaborate
cpuset memory migration test.

 include/linux/mempolicy.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 2.6.19-rc2-mm1.orig/include/linux/mempolicy.h	2006-10-19 23:08:11.396940924 -0700
+++ 2.6.19-rc2-mm1/include/linux/mempolicy.h	2006-10-19 23:26:03.703107004 -0700
@@ -150,7 +150,7 @@ extern void mpol_rebind_mm(struct mm_str
 extern void mpol_fix_fork_child_flag(struct task_struct *p);
 #define set_cpuset_being_rebound(x) (cpuset_being_rebound = (x))
 
-#ifdef CONFIG_CPUSET
+#ifdef CONFIG_CPUSETS
 #define current_cpuset_is_being_rebound() \
 				(cpuset_being_rebound == current->cpuset)
 #else

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
