Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbUC2MQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbUC2MQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:16:23 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:56246 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262844AbUC2MNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:13:55 -0500
Date: Mon, 29 Mar 2004 04:13:15 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT: simplify a couple cpumask uses [8/22]
Message-Id: <20040329041315.765d4dd2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_8_of_22 - Simplify a couple of cpumask checks using cpus_subset
	Simplify a couple of code fragements using cpus_subset.

diffstat Patch_8_of_22:
 i386/kernel/smp.c   |    5 +----
 x86_64/kernel/smp.c |    4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1713  -> 1.1714 
#	arch/i386/kernel/smp.c	1.35    -> 1.36   
#	arch/x86_64/kernel/smp.c	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/28	pj@sgi.com	1.1714
# Simplify two cpumask calculations using new cpus_subset() operator.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c	Mon Mar 29 01:03:40 2004
+++ b/arch/i386/kernel/smp.c	Mon Mar 29 01:03:40 2004
@@ -345,7 +345,6 @@
 static void flush_tlb_others(cpumask_t cpumask, struct mm_struct *mm,
 						unsigned long va)
 {
-	cpumask_t tmp;
 	/*
 	 * A couple of (to be removed) sanity checks:
 	 *
@@ -354,9 +353,7 @@
 	 * - mask must exist :)
 	 */
 	BUG_ON(cpus_empty(cpumask));
-
-	cpus_and(tmp, cpumask, cpu_online_map);
-	BUG_ON(!cpus_equal(cpumask, tmp));
+	BUG_ON(!cpus_subset(cpumask, cpu_online_map));
 	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
 	BUG_ON(!mm);
 
diff -Nru a/arch/x86_64/kernel/smp.c b/arch/x86_64/kernel/smp.c
--- a/arch/x86_64/kernel/smp.c	Mon Mar 29 01:03:40 2004
+++ b/arch/x86_64/kernel/smp.c	Mon Mar 29 01:03:40 2004
@@ -234,7 +234,6 @@
 static void flush_tlb_others(cpumask_t cpumask, struct mm_struct *mm,
 						unsigned long va)
 {
-	cpumask_t tmp;
 	/*
 	 * A couple of (to be removed) sanity checks:
 	 *
@@ -243,8 +242,7 @@
 	 * - mask must exist :)
 	 */
 	BUG_ON(cpus_empty(cpumask));
-	cpus_and(tmp, cpumask, cpu_online_map);
-	BUG_ON(!cpus_equal(tmp, cpumask));
+	BUG_ON(!cpus_subset(cpumask, cpu_online_map));
 	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
 	if (!mm)
 		BUG();


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
