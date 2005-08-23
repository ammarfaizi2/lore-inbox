Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVHWVof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVHWVof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVHWVof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:44:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11446 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932435AbVHWVoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:13 -0400
To: torvalds@osdl.org
Subject: [PATCH] (30/43) m32r smp.h gcc4 fixes
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1E7gc1-0007DR-3o@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:47:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

extern on physid_2_cpu[] does not belong in smp.h - the thing is static.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-alpha-constraints/arch/m32r/kernel/smpboot.c RC13-rc6-git13-m32r-smp/arch/m32r/kernel/smpboot.c
--- RC13-rc6-git13-alpha-constraints/arch/m32r/kernel/smpboot.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-m32r-smp/arch/m32r/kernel/smpboot.c	2005-08-21 13:17:12.000000000 -0400
@@ -91,6 +91,7 @@
 
 /* which physical physical ID maps to which logical CPU number */
 static volatile int physid_2_cpu[NR_CPUS];
+#define physid_to_cpu(physid)	physid_2_cpu[physid]
 
 /* which logical CPU number maps to which physical ID */
 volatile int cpu_2_physid[NR_CPUS];
diff -urN RC13-rc6-git13-alpha-constraints/include/asm-m32r/smp.h RC13-rc6-git13-m32r-smp/include/asm-m32r/smp.h
--- RC13-rc6-git13-alpha-constraints/include/asm-m32r/smp.h	2005-08-10 10:37:53.000000000 -0400
+++ RC13-rc6-git13-m32r-smp/include/asm-m32r/smp.h	2005-08-21 13:17:12.000000000 -0400
@@ -61,9 +61,7 @@
  * Some lowlevel functions might want to know about
  * the real CPU ID <-> CPU # mapping.
  */
-extern volatile int physid_2_cpu[NR_CPUS];
 extern volatile int cpu_2_physid[NR_CPUS];
-#define physid_to_cpu(physid)	physid_2_cpu[physid]
 #define cpu_to_physid(cpu_id)	cpu_2_physid[cpu_id]
 
 #define raw_smp_processor_id()	(current_thread_info()->cpu)
