Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267987AbUIKIdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267987AbUIKIdB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 04:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUIKIaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 04:30:55 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:39852 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267860AbUIKI3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 04:29:06 -0400
Date: Sat, 11 Sep 2004 01:28:32 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20040911082834.10372.51697.75658@sam.engr.sgi.com>
In-Reply-To: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
Subject: [Patch 4/4] cpusets top mask just online, not all possible
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the top cpuset to only have the online
CPUs and Nodes, rather than all possible.  This
seems more natural to the observer.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.9-rc1-mm4/kernel/cpuset.c
===================================================================
--- 2.6.9-rc1-mm4.orig/kernel/cpuset.c	2004-09-10 15:27:30.000000000 -0700
+++ 2.6.9-rc1-mm4/kernel/cpuset.c	2004-09-10 15:27:32.000000000 -0700
@@ -1271,7 +1271,9 @@ int __init cpuset_init(void)
 	struct dentry *root;
 	int err;
 
-	top_cpuset.mems_allowed = node_possible_map;
+	top_cpuset.cpus_allowed = CPU_MASK_ALL;
+	top_cpuset.mems_allowed = NODE_MASK_ALL;
+
 	atomic_inc(&cpuset_mems_generation);
 	top_cpuset.mems_generation = atomic_read(&cpuset_mems_generation);
 
@@ -1300,12 +1302,13 @@ out:
 /**
  * cpuset_init_smp - initialize cpus_allowed
  *
- * Description: Initialize cpus_allowed after cpu_possible_map is initialized
+ * Description: Finish top cpuset after cpu, node maps are initialized
  **/
 
 void __init cpuset_init_smp(void)
 {
-	top_cpuset.cpus_allowed = cpu_possible_map;
+	top_cpuset.cpus_allowed = cpu_online_map;
+	top_cpuset.mems_allowed = node_online_map;
 }
 
 /**

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
