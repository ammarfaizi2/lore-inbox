Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVAVAic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVAVAic (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVAVASL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:18:11 -0500
Received: from waste.org ([216.27.176.166]:34951 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262610AbVAVAJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:09:55 -0500
Date: Fri, 21 Jan 2005 18:09:48 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4.464233479@selenic.com>
Message-Id: <5.464233479@selenic.com>
Subject: [PATCH 4/8] core-small: Shrink PID lookup tables
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CORE_SMALL reduce size of pidmap table for small machines

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny/include/linux/threads.h
===================================================================
--- tiny.orig/include/linux/threads.h	2004-12-04 15:42:35.000000000 -0800
+++ tiny/include/linux/threads.h	2004-12-04 19:42:19.032212529 -0800
@@ -25,11 +25,19 @@
 /*
  * This controls the default maximum pid allocated to a process
  */
+#ifdef CONFIG_CORE_SMALL
+#define PID_MAX_DEFAULT 0x1000
+#else
 #define PID_MAX_DEFAULT 0x8000
+#endif
 
 /*
  * A maximum of 4 million PIDs should be enough for a while:
  */
+#ifdef CONFIG_CORE_SMALL
+#define PID_MAX_LIMIT (PAGE_SIZE*8) /* one pidmap entry */
+#else
 #define PID_MAX_LIMIT (sizeof(long) > 4 ? 4*1024*1024 : PID_MAX_DEFAULT)
+#endif
 
 #endif
