Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVAVAVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVAVAVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVAVASh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:18:37 -0500
Received: from waste.org ([216.27.176.166]:34695 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262599AbVAVAJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:09:54 -0500
Date: Fri, 21 Jan 2005 18:09:48 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3.464233479@selenic.com>
Message-Id: <4.464233479@selenic.com>
Subject: [PATCH 3/8] core-small: Collapse chrdevs hash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CORE_SMALL degrade char dev hash table to linked list

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny-queue/fs/char_dev.c
===================================================================
--- tiny-queue.orig/fs/char_dev.c	2005-01-21 09:59:45.000000000 -0800
+++ tiny-queue/fs/char_dev.c	2005-01-21 15:31:52.000000000 -0800
@@ -26,7 +26,11 @@
 
 static struct kobj_map *cdev_map;
 
+#ifdef CONFIG_CORE_SMALL
+#define MAX_PROBE_HASH 1 /* degrade to linked list */
+#else
 #define MAX_PROBE_HASH 255	/* random */
+#endif
 
 static DEFINE_RWLOCK(chrdevs_lock);
 
