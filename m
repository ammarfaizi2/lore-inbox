Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUIMNNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUIMNNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUIMNNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:13:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11196 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266674AbUIMNNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:13:01 -0400
Date: Mon, 13 Sep 2004 06:12:54 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Barnes <jbarnes@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Message-Id: <20040913131255.27931.99206.77908@sam.engr.sgi.com>
Subject: [Patch] Fix sched make domain setup overridable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Builds of 2.6.9-rc1-mm5 ia64 NUMA configs fail, with many
complaints that SD_NODE_INIT is defined twice, in asm/processor.h
and linux/sched.h.

I guess that the preprocessor conditionals were wrong when Nick
added the per-arch override ability again of SD_NODE_INIT were wrong.
At least this change lets me rebuild ia64 again.

Someone with more clues in this than I should check this.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.9-rc1-mm5/include/linux/sched.h
===================================================================
--- 2.6.9-rc1-mm5.orig/include/linux/sched.h	2004-09-13 04:20:41.000000000 -0700
+++ 2.6.9-rc1-mm5/include/linux/sched.h	2004-09-13 04:51:49.000000000 -0700
@@ -528,7 +528,7 @@ extern void cpu_attach_domain(struct sch
 	.nr_balance_failed	= 0,			\
 }
 
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) && !defined(SD_NODE_INIT)
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
