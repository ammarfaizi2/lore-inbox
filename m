Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268165AbUIPXV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268165AbUIPXV4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUIPXFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:05:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21948 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268165AbUIPXET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:04:19 -0400
Date: Thu, 16 Sep 2004 16:04:02 -0700 (PDT)
From: Ray Bryant <raybry@sgi.com>
To: Ray Bryant <raybry@austin.rr.com>, Andrew Morton <akpm@osdl.org>
Cc: Ray Bryant <raybry@sgi.com>, lse-tech@lists.sourceforge.net,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Message-Id: <20040916230402.23023.89478.83475@tomahawk.engr.sgi.com>
In-Reply-To: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com>
References: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com>
Subject: [PATCH 2/3] lockmeter: lockmeter fix for generic_read_trylock
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update lockmeter.c with generic_raw_read_trylock fix.

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
+	_metered_read_lock(lock, __builtin_return_address(0));
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
