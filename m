Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVAaHcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVAaHcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVAaHaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:30:20 -0500
Received: from waste.org ([216.27.176.166]:10988 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261942AbVAaHZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:25:59 -0500
Date: Mon, 31 Jan 2005 01:25:52 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3.687457650@selenic.com>
Message-Id: <4.687457650@selenic.com>
Subject: [PATCH 3/8] base-small: shrink chrdevs hash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BASE_SMALL degrade char dev hash table to linked list

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tq/fs/char_dev.c
===================================================================
--- tq.orig/fs/char_dev.c	2005-01-26 13:06:15.000000000 -0800
+++ tq/fs/char_dev.c	2005-01-26 13:08:37.000000000 -0800
@@ -26,7 +26,8 @@
 
 static struct kobj_map *cdev_map;
 
-#define MAX_PROBE_HASH 255	/* random */
+/* degrade to linked list for small systems */
+#define MAX_PROBE_HASH (CONFIG_BASE_SMALL ? 1 : 255)
 
 static DEFINE_RWLOCK(chrdevs_lock);
 
