Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVAVAid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVAVAid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVAVAST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:18:19 -0500
Received: from waste.org ([216.27.176.166]:35207 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262627AbVAVAJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:09:55 -0500
Date: Fri, 21 Jan 2005 18:09:48 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <2.464233479@selenic.com>
Message-Id: <3.464233479@selenic.com>
Subject: [PATCH 2/8] core-small: Collapse major names hash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CORE_SMALL degrade genhd major names hash to linked list

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny-new/drivers/block/genhd.c
===================================================================
--- tiny-new.orig/drivers/block/genhd.c	2004-11-17 00:04:36.000000000 -0800
+++ tiny-new/drivers/block/genhd.c	2004-11-17 10:30:10.992098381 -0800
@@ -15,7 +15,11 @@
 #include <linux/kmod.h>
 #include <linux/kobj_map.h>
 
+#ifdef CONFIG_CORE_SMALL
+#define MAX_PROBE_HASH 1 /* degrade to linked list */
+#else
 #define MAX_PROBE_HASH 255	/* random */
+#endif
 
 static struct subsystem block_subsys;
 
