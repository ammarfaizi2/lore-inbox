Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269216AbUIYDcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269216AbUIYDcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 23:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269222AbUIYDa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 23:30:26 -0400
Received: from holomorphy.com ([207.189.100.168]:57060 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269212AbUIYD3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 23:29:39 -0400
Date: Fri, 24 Sep 2004 20:29:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [sched.h 8/8] move exec_domain declarations to personality.h
Message-ID: <20040925032936.GT9106@holomorphy.com>
References: <20040925024513.GL9106@holomorphy.com> <20040925024917.GM9106@holomorphy.com> <20040925025304.GN9106@holomorphy.com> <20040925030802.GO9106@holomorphy.com> <20040925031912.GP9106@holomorphy.com> <20040925032419.GQ9106@holomorphy.com> <20040925032616.GR9106@holomorphy.com> <20040925032746.GS9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925032746.GS9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 08:27:46PM -0700, William Lee Irwin III wrote:
> This patch removes the inclusion of rbtree.h in sched.h

This patch moves usage of struct exec_domain in sched.h to personality.h


Index: mm3-2.6.9-rc2/include/linux/personality.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/personality.h	2004-09-12 22:32:48.000000000 -0700
+++ mm3-2.6.9-rc2/include/linux/personality.h	2004-09-24 19:34:23.760144000 -0700
@@ -91,6 +91,11 @@
 };
 
 /*
+ * The default (Linux) execution domain.
+ */
+extern struct exec_domain	default_exec_domain;
+
+/*
  * Return the base personality without flags.
  */
 #define personality(pers)	(pers & PER_MASK)
Index: mm3-2.6.9-rc2/include/linux/sched.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/sched.h	2004-09-24 19:23:12.432201360 -0700
+++ mm3-2.6.9-rc2/include/linux/sched.h	2004-09-24 19:33:49.500352280 -0700
@@ -31,8 +31,6 @@
 #include <linux/pid.h>
 #include <linux/percpu.h>
 
-struct exec_domain;
-
 /*
  * cloning flags:
  */
@@ -802,11 +800,6 @@
 
 void yield(void);
 
-/*
- * The default (Linux) execution domain.
- */
-extern struct exec_domain	default_exec_domain;
-
 union thread_union {
 	struct thread_info thread_info;
 	unsigned long stack[THREAD_SIZE/sizeof(long)];
