Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbUC2M7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUC2M3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:29:45 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:23482 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262879AbUC2MQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:16:51 -0500
Date: Mon, 29 Mar 2004 04:16:10 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT:  simplify i386/mach-es7000 cpumask use [18/22]
Message-Id: <20040329041610.45510cf5.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_18_of_22 - Optimize i386 cpumask macro usage.
	Optimize a bit of cpumask code for asm-i386/mach-es7000
	Code untested, unreviewed.  Feedback welcome.

diffstat Patch_18_of_22:
 mach_ipi.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1724  -> 1.1725 
#	include/asm-i386/mach-es7000/mach_ipi.h	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/29	pj@sgi.com	1.1725
# Optimize i386 cpumask macro usage.  Code untested and unreviewed.
# Feedback welcome.
# --------------------------------------------
#
diff -Nru a/include/asm-i386/mach-es7000/mach_ipi.h b/include/asm-i386/mach-es7000/mach_ipi.h
--- a/include/asm-i386/mach-es7000/mach_ipi.h	Mon Mar 29 01:04:03 2004
+++ b/include/asm-i386/mach-es7000/mach_ipi.h	Mon Mar 29 01:04:03 2004
@@ -10,9 +10,8 @@
 
 static inline void send_IPI_allbutself(int vector)
 {
-	cpumask_t mask = cpumask_of_cpu(smp_processor_id());
-	cpus_complement(mask);
-	cpus_and(mask, mask, cpu_online_map);
+	cpumask_t mask = cpu_online_map;
+	cpu_clear(smp_processor_id(), mask);
 	if (!cpus_empty(mask))
 		send_IPI_mask(mask, vector);
 }


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
