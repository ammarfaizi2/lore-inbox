Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVAaH2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVAaH2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVAaH0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:26:05 -0500
Received: from waste.org ([216.27.176.166]:9452 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261936AbVAaHZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:25:54 -0500
Date: Mon, 31 Jan 2005 01:25:51 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.687457650@selenic.com>
Message-Id: <3.687457650@selenic.com>
Subject: [PATCH 2/8] base-small: shrink major_names hash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BASE_SMALL degrade genhd major names hash to linked list

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tq/drivers/block/genhd.c
===================================================================
--- tq.orig/drivers/block/genhd.c	2005-01-26 13:06:16.000000000 -0800
+++ tq/drivers/block/genhd.c	2005-01-26 13:08:23.000000000 -0800
@@ -15,7 +15,8 @@
 #include <linux/kmod.h>
 #include <linux/kobj_map.h>
 
-#define MAX_PROBE_HASH 255	/* random */
+/* degrade to linked list for small systems */
+#define MAX_PROBE_HASH (CONFIG_BASE_SMALL ? 1 : 255)
 
 static struct subsystem block_subsys;
 
