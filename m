Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUDAV30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUDAV3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:29:03 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:14390 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263207AbUDAVO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:14:29 -0500
Date: Thu, 1 Apr 2004 13:12:58 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 20/23] mask v2 - Optimize i386 cpumask macro usage
Message-Id: <20040401131258.0955bd9c.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_20_of_23 - Optimize i386 cpumask macro usage.
	Optimize a bit of cpumask code for asm-i386/mach-es7000
	Code untested, unreviewed.  Feedback welcome.

Diffstat Patch_20_of_23:
 mach_ipi.h                     |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

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
