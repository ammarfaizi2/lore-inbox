Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVAaHca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVAaHca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVAaHa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:30:29 -0500
Received: from waste.org ([216.27.176.166]:11244 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261943AbVAaHZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:25:59 -0500
Date: Mon, 31 Jan 2005 01:25:52 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.687457650@selenic.com>
Message-Id: <6.687457650@selenic.com>
Subject: [PATCH 5/8] base-small: shrink UID hash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BASE_SMALL reduce UID lookup hash

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tq/kernel/user.c
===================================================================
--- tq.orig/kernel/user.c	2005-01-25 09:31:58.000000000 -0800
+++ tq/kernel/user.c	2005-01-26 13:11:10.000000000 -0800
@@ -18,7 +18,8 @@
  * UID task count cache, to get fast user lookup in "alloc_uid"
  * when changing user ID's (ie setuid() and friends).
  */
-#define UIDHASH_BITS		8
+
+#define UIDHASH_BITS (CONFIG_BASE_SMALL ? 3 : 8)
 #define UIDHASH_SZ		(1 << UIDHASH_BITS)
 #define UIDHASH_MASK		(UIDHASH_SZ - 1)
 #define __uidhashfn(uid)	(((uid >> UIDHASH_BITS) + uid) & UIDHASH_MASK)
