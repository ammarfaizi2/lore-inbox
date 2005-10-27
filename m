Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVJ0IyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVJ0IyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbVJ0IyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:54:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58540 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965007AbVJ0IyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:54:01 -0400
Date: Thu, 27 Oct 2005 01:53:47 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20051027085346.27658.76262.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH] sched hardcode non-smp set_cpus_allowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the UP (1 CPU) implementatin of set_cpus_allowed.

The one CPU is hardcoded to be cpu 0 - so just test for
that bit, and avoid having to pick up the cpu_online_map.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/sched.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.14-rc5-mm1.orig/include/linux/sched.h	2005-10-27 00:26:36.000000000 -0700
+++ 2.6.14-rc5-mm1/include/linux/sched.h	2005-10-27 00:35:34.000000000 -0700
@@ -945,7 +945,7 @@ extern int set_cpus_allowed(task_t *p, c
 #else
 static inline int set_cpus_allowed(task_t *p, cpumask_t new_mask)
 {
-	if (!cpus_intersects(new_mask, cpu_online_map))
+	if (!cpu_isset(0, new_mask))
 		return -EINVAL;
 	return 0;
 }

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
