Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268258AbUIPXqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268258AbUIPXqi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUIPXpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:45:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11996 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268314AbUIPXo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:44:26 -0400
Date: Thu, 16 Sep 2004 16:42:10 -0700 (PDT)
From: Ray Bryant <raybry@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Ray Bryant <raybry@austin.rr.com>, Ray Bryant <raybry@sgi.com>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-Id: <20040916234210.5225.93240.56774@tomahawk.engr.sgi.com>
Subject: [PATCH 2/3] lockmeter: lockmeter fix for generic_read_trylock
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update lockmeter.c with generic_raw_read_trylock fix.
Fixed as per Zwane's comment.

Signed-off-by: Ray Bryant <raybry@sgi.com>

Index: linux-2.6.9-rc2-mm1/kernel/lockmeter.c
===================================================================
--- linux-2.6.9-rc2-mm1.orig/kernel/lockmeter.c	2004-09-16 12:03:20.000000000 -0700
+++ linux-2.6.9-rc2-mm1/kernel/lockmeter.c	2004-09-16 12:29:08.000000000 -0700
@@ -1213,6 +1213,18 @@
  * except for the fact tht calls to _raw_ routines are replaced by
  * corresponding calls to the _metered_ routines
  */
+
+/*
+ * Generic declaration of the raw read_trylock() function,
+ * architectures are supposed to optimize this:
+ */
+int __lockfunc generic_raw_read_trylock(rwlock_t *lock)
+{
+	_raw_read_lock(lock);
+	return 1;
+}
+EXPORT_SYMBOL(generic_raw_read_trylock);
+
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
 	preempt_disable();

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
