Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbUKEFIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbUKEFIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 00:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUKEFIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 00:08:04 -0500
Received: from ozlabs.org ([203.10.76.45]:9376 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262605AbUKEFGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 00:06:22 -0500
Date: Fri, 5 Nov 2004 16:04:09 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, pj@sgi.com, colpatch@us.ibm.com,
       akpm@osdl.org
Subject: [PATCH] reset cache_hot_time
Message-ID: <20041105050409.GB8470@krispykreme.ozlabs.ibm.com>
References: <20041104210425.GC1268@krispykreme.ozlabs.ibm.com> <418AD7EC.8020300@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418AD7EC.8020300@yahoo.com.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Don't think so. They should be all in units of sched_clock()
> (ie. ns), so 10ms and 2.5ms are surely the intended values here.

OK how does this look?

Anton

--

Reset cache_hot_time to sane values (in the ms range). Some recent
changes resulted in values in the us range.

Signed-off-by: Anton Blanchard <anton@samba.org>

===== include/asm-i386/topology.h 1.12 vs edited =====
--- 1.12/include/asm-i386/topology.h	2004-10-19 15:26:52 +10:00
+++ edited/include/asm-i386/topology.h	2004-11-05 15:50:13 +11:00
@@ -78,7 +78,7 @@
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000),		\
+	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
===== include/asm-ppc64/topology.h 1.13 vs edited =====
--- 1.13/include/asm-ppc64/topology.h	2004-10-19 15:26:52 +10:00
+++ edited/include/asm-ppc64/topology.h	2004-11-05 15:49:52 +11:00
@@ -46,7 +46,7 @@
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000),		\
+	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
===== include/asm-x86_64/topology.h 1.13 vs edited =====
--- 1.13/include/asm-x86_64/topology.h	2004-10-19 15:26:52 +10:00
+++ edited/include/asm-x86_64/topology.h	2004-11-05 15:49:37 +11:00
@@ -42,7 +42,7 @@
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000),		\
+	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
===== include/linux/topology.h 1.6 vs edited =====
--- 1.6/include/linux/topology.h	2004-10-19 15:26:51 +10:00
+++ edited/include/linux/topology.h	2004-11-05 15:48:15 +11:00
@@ -113,7 +113,7 @@
 	.max_interval		= 4,			\
 	.busy_factor		= 64,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (5*1000/2),		\
+	.cache_hot_time		= (5*1000000/2),	\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\

