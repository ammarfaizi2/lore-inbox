Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVAVAS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVAVAS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVAVARl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:17:41 -0500
Received: from waste.org ([216.27.176.166]:36231 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262630AbVAVAJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:09:59 -0500
Date: Fri, 21 Jan 2005 18:09:49 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <8.464233479@selenic.com>
Message-Id: <9.464233479@selenic.com>
Subject: [PATCH 8/8] core-small: Shrink console buffer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CORE_SMALL reduce console transfer buffer

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny-queue/include/linux/vt_kern.h
===================================================================
--- tiny-queue.orig/include/linux/vt_kern.h	2005-01-21 09:59:49.000000000 -0800
+++ tiny-queue/include/linux/vt_kern.h	2005-01-21 15:48:39.000000000 -0800
@@ -84,7 +84,11 @@
  * vc_screen.c shares this temporary buffer with the console write code so that
  * we can easily avoid touching user space while holding the console spinlock.
  */
-#define CON_BUF_SIZE	PAGE_SIZE
+#ifdef CONFIG_CORE_SMALL
+#define CON_BUF_SIZE 512
+#else
+#define CON_BUF_SIZE PAGE_SIZE
+#endif
 extern char con_buf[CON_BUF_SIZE];
 extern struct semaphore con_buf_sem;
 
