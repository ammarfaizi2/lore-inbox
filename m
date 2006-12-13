Return-Path: <linux-kernel-owner+w=401wt.eu-S965081AbWLMTKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbWLMTKL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWLMTKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:10:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51894 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965081AbWLMTKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:10:09 -0500
X-Greylist: delayed 3002 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 14:10:09 EST
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Date: Wed, 13 Dec 2006 10:19:56 -0800
Message-Id: <20061213181956.6440.15235.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] CONFIG_VM_EVENT_COUNTER comment decrustify
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

The VM event counters, enabled by CONFIG_VM_EVENT_COUNTERS,
which provides VM event counters in /proc/vmstat, has become
more essential to non-EMBEDDED kernel configurations than they
were in the past.  Comments in the code and the Kconfig configuration
explanation were stale, downplaying their role excessively.

Refresh those comments to correctly reflect the current role of
VM event counters.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

Christoph and Andrew (I sure hope) understand what's the truth
here better than I.  I trust they won't hesitate to refine,
hack, mutilate, ignore or extend this patch, as appropriate.
						 - pj

 include/linux/vmstat.h |    5 +++--
 init/Kconfig           |    8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

--- 2.6.19-mm1.orig/include/linux/vmstat.h	2006-12-12 04:12:59.850645800 -0800
+++ 2.6.19-mm1/include/linux/vmstat.h	2006-12-13 10:02:31.205199749 -0800
@@ -10,8 +10,9 @@
 /*
  * Light weight per cpu counter implementation.
  *
- * Counters should only be incremented and no critical kernel component
- * should rely on the counter values.
+ * Counters should only be incremented.  You need to set EMBEDDED
+ * to disable VM_EVENT_COUNTERS.  Things like procps (vmstat,
+ * top, etc) use /proc/vmstat and depend on these counters.
  *
  * Counters are handled completely inline. On many platforms the code
  * generated will simply be the increment of a global address.
--- 2.6.19-mm1.orig/init/Kconfig	2006-12-12 04:12:59.994647698 -0800
+++ 2.6.19-mm1/init/Kconfig	2006-12-13 10:12:17.424473564 -0800
@@ -483,10 +483,10 @@ config VM_EVENT_COUNTERS
 	default y
 	bool "Enable VM event counters for /proc/vmstat" if EMBEDDED
 	help
-	  VM event counters are only needed to for event counts to be
-	  shown. They have no function for the kernel itself. This
-	  option allows the disabling of the VM event counters.
-	  /proc/vmstat will only show page counts.
+	  VM event counters are needed for event counts to be shown.
+	  This option allows the disabling of the VM event counters
+	  on EMBEDDED systems.  /proc/vmstat will only show page counts
+	  if VM event counters are disabled.
 
 endmenu		# General setup
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
