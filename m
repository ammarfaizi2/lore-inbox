Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVLLInw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVLLInw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 03:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVLLInw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 03:43:52 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:39399 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751136AbVLLInv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 03:43:51 -0500
Date: Mon, 12 Dec 2005 00:43:30 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Simon Derr <Simon.Derr@bull.net>, Andi Kleen <ak@suse.de>,
       Paul Jackson <pj@sgi.com>, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051212084330.3242.54457.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Cpuset: rcu slab cache optimization rcu_dereference comment
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment noting that unlike usual, we do not need to
guard a dereference of an rcu guarded pointer with a
call to rcu_dereference(), because we don't care if we
see out of order results.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |    6 ++++++
 1 files changed, 6 insertions(+)

--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-11 22:35:39.051718313 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-12 00:38:25.301117045 -0800
@@ -632,6 +632,12 @@ static void guarantee_online_mems(const 
  * unmapped.  It's ok if attach_task() replaces our cpuset with
  * another while we are reading mems_generation, and even frees it.
  *
+ * We do -not- need to guard the 'cs' pointer dereference within the
+ * rcu_read_lock section with rcu_dereference(), because we don't
+ * mind getting bogus out-of-order results.  New cpuset pointer and
+ * old mems_generation is ok - we'll realize that our cpuset memory
+ * placement changed the next time through here.
+ *
  * This routine is needed to update the per-task mems_allowed data,
  * within the tasks context, when it is trying to allocate memory
  * (in various mm/mempolicy.c routines) and notices that some other

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
