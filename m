Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTKGW20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTKGW15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:27:57 -0500
Received: from zeus.kernel.org ([204.152.189.113]:64983 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261787AbTKGWCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 17:02:35 -0500
Date: Fri, 7 Nov 2003 15:08:48 -0600
From: Jack Steiner <steiner@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH] - Incorrect cpumask definition in net/core/flow.c
Message-ID: <20031107210848.GA10774@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a problem in net/core/flow.c. 

The field "cpumap" is defined as a "unsigned long". It 
should be a "cpumask_t".



# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1402  -> 1.1403 
#	     net/core/flow.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/07	steiner@attica.americas.sgi.com	1.1403
# Change cpumap definition from "unsigned long" to "cpumask_t". 
# --------------------------------------------
#



diff -Nru a/net/core/flow.c b/net/core/flow.c
--- a/net/core/flow.c	Fri Nov  7 15:04:08 2003
+++ b/net/core/flow.c	Fri Nov  7 15:04:08 2003
@@ -65,7 +65,7 @@
 
 struct flow_flush_info {
 	atomic_t cpuleft;
-	unsigned long cpumap;
+	cpumask_t cpumap;
 	struct completion completion;
 };
 static DEFINE_PER_CPU(struct tasklet_struct, flow_flush_tasklets) = { NULL };
@@ -73,7 +73,7 @@
 #define flow_flush_tasklet(cpu) (&per_cpu(flow_flush_tasklets, cpu))
 
 static DECLARE_MUTEX(flow_cache_cpu_sem);
-static unsigned long flow_cache_cpu_map;
+static cpumask_t flow_cache_cpu_map;
 static unsigned int flow_cache_cpu_count;
 
 static void flow_cache_new_hashrnd(unsigned long arg)



-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


