Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269214AbUIYD2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269214AbUIYD2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 23:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269213AbUIYD1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 23:27:04 -0400
Received: from holomorphy.com ([207.189.100.168]:55012 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269211AbUIYD0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 23:26:22 -0400
Date: Fri, 24 Sep 2004 20:26:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [sched.h 6/8] move aio include to mm.h
Message-ID: <20040925032616.GR9106@holomorphy.com>
References: <20040925024513.GL9106@holomorphy.com> <20040925024917.GM9106@holomorphy.com> <20040925025304.GN9106@holomorphy.com> <20040925030802.GO9106@holomorphy.com> <20040925031912.GP9106@holomorphy.com> <20040925032419.GQ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925032419.GQ9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 08:24:19PM -0700, William Lee Irwin III wrote:
> This patch moves mm_struct and the helpers to handle it into mm.h

This patch moves the aio inclusion from sched.h to mm.h, while leaving
workqueue.h directly included by sched.h; a large sweep is required to
clean up drivers including workqueue.h indirectly via sched.h


-- wli

Index: mm3-2.6.9-rc2/fs/ext3/file.c
===================================================================
--- mm3-2.6.9-rc2.orig/fs/ext3/file.c	2004-09-24 17:37:18.000000000 -0700
+++ mm3-2.6.9-rc2/fs/ext3/file.c	2004-09-24 19:22:09.556759880 -0700
@@ -23,6 +23,7 @@
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
+#include <linux/aio.h>
 #include "xattr.h"
 #include "acl.h"
 
Index: mm3-2.6.9-rc2/include/linux/mm.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/mm.h	2004-09-24 19:08:34.310696120 -0700
+++ mm3-2.6.9-rc2/include/linux/mm.h	2004-09-24 19:17:00.863688360 -0700
@@ -13,6 +13,7 @@
 #include <linux/rbtree.h>
 #include <linux/prio_tree.h>
 #include <linux/fs.h>
+#include <linux/aio.h>
 
 struct mempolicy;
 struct anon_vma;
Index: mm3-2.6.9-rc2/include/linux/sched.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/sched.h	2004-09-24 19:07:27.493853824 -0700
+++ mm3-2.6.9-rc2/include/linux/sched.h	2004-09-24 19:16:49.428426784 -0700
@@ -14,6 +14,7 @@
 #include <linux/thread_info.h>
 #include <linux/cpumask.h>
 #include <linux/nodemask.h>
+#include <linux/workqueue.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
@@ -176,8 +177,6 @@
 
 extern int sysctl_max_map_count;
 
-#include <linux/aio.h>
-
 struct sighand_struct {
 	atomic_t		count;
 	struct k_sigaction	action[_NSIG];
