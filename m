Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVAaHcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVAaHcg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVAaH2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:28:53 -0500
Received: from waste.org ([216.27.176.166]:11500 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261944AbVAaH0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:26:00 -0500
Date: Mon, 31 Jan 2005 01:25:52 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.687457650@selenic.com>
Message-Id: <5.687457650@selenic.com>
Subject: [PATCH 4/8] base-small: shrink PID tables
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BASE_SMALL reduce size of pidmap table for small machines

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tq/include/linux/threads.h
===================================================================
--- tq.orig/include/linux/threads.h	2005-01-25 09:26:16.000000000 -0800
+++ tq/include/linux/threads.h	2005-01-26 15:16:55.000000000 -0800
@@ -7,7 +7,7 @@
  * The default limit for the nr of threads is now in
  * /proc/sys/kernel/threads-max.
  */
- 
+
 /*
  * Maximum supported processors that can run under SMP.  This value is
  * set via configure setting.  The maximum is equal to the size of the
@@ -25,11 +25,12 @@
 /*
  * This controls the default maximum pid allocated to a process
  */
-#define PID_MAX_DEFAULT 0x8000
+#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
 
 /*
  * A maximum of 4 million PIDs should be enough for a while:
  */
-#define PID_MAX_LIMIT (sizeof(long) > 4 ? 4*1024*1024 : PID_MAX_DEFAULT)
+#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
+	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
 
 #endif
