Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVAVASa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVAVASa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVAVARz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:17:55 -0500
Received: from waste.org ([216.27.176.166]:35719 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262629AbVAVAJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:09:56 -0500
Date: Fri, 21 Jan 2005 18:09:48 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5.464233479@selenic.com>
Message-Id: <6.464233479@selenic.com>
Subject: [PATCH 5/8] core-small: Shrink uid hash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CORE_SMALL reduce UID lookup hash

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny/kernel/user.c
===================================================================
--- tiny.orig/kernel/user.c	2004-12-04 15:42:41.000000000 -0800
+++ tiny/kernel/user.c	2004-12-04 19:42:32.462123939 -0800
@@ -18,7 +18,11 @@
  * UID task count cache, to get fast user lookup in "alloc_uid"
  * when changing user ID's (ie setuid() and friends).
  */
+#ifdef CONFIG_CORE_SMALL
+#define UIDHASH_BITS		3
+#else
 #define UIDHASH_BITS		8
+#endif
 #define UIDHASH_SZ		(1 << UIDHASH_BITS)
 #define UIDHASH_MASK		(UIDHASH_SZ - 1)
 #define __uidhashfn(uid)	(((uid >> UIDHASH_BITS) + uid) & UIDHASH_MASK)
