Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVAVASa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVAVASa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVAVARs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:17:48 -0500
Received: from waste.org ([216.27.176.166]:35975 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262631AbVAVAJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:09:58 -0500
Date: Fri, 21 Jan 2005 18:09:49 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <7.464233479@selenic.com>
Message-Id: <8.464233479@selenic.com>
Subject: [PATCH 7/8] core-small: Shrink timer lists
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CORE_SMALL reduce timer list hashes

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny-queue/kernel/timer.c
===================================================================
--- tiny-queue.orig/kernel/timer.c	2005-01-21 09:59:50.000000000 -0800
+++ tiny-queue/kernel/timer.c	2005-01-21 15:31:58.000000000 -0800
@@ -50,8 +50,14 @@
 /*
  * per-CPU timer vector definitions:
  */
+
+#ifdef CONFIG_CORE_SMALL
+#define TVN_BITS 4
+#define TVR_BITS 6
+#else
 #define TVN_BITS 6
 #define TVR_BITS 8
+#endif
 #define TVN_SIZE (1 << TVN_BITS)
 #define TVR_SIZE (1 << TVR_BITS)
 #define TVN_MASK (TVN_SIZE - 1)
