Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263697AbUDVHSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUDVHSG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbUDVHR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:17:59 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:36273 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263697AbUDVHJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:09:10 -0400
Date: Thu, 22 Apr 2004 00:07:51 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [Patch 14 of 17] cpumask v4 - Optimize i386 cpumask macro usage.
Message-Id: <20040422000751.5adc3ffc.pj@sgi.com>
In-Reply-To: <20040421232247.22ffe1f2.pj@sgi.com>
References: <20040421232247.22ffe1f2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mask14-cpumask-i386-simplify - Optimize i386 cpumask macro usage.
        Optimize a bit of cpumask code for asm-i386/mach-es7000
        Code untested, unreviewed.  Feedback welcome.

Index: 2.6.5.bitmap/include/asm-i386/mach-es7000/mach_ipi.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-i386/mach-es7000/mach_ipi.h	2004-04-08 04:19:28.000000000 -0700
+++ 2.6.5.bitmap/include/asm-i386/mach-es7000/mach_ipi.h	2004-04-08 04:19:34.000000000 -0700
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
