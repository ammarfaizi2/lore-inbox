Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313922AbSDPVpl>; Tue, 16 Apr 2002 17:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313923AbSDPVpk>; Tue, 16 Apr 2002 17:45:40 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:45964 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S313922AbSDPVpf>; Tue, 16 Apr 2002 17:45:35 -0400
Date: Tue, 16 Apr 2002 12:57:17 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] 2.5.8 fix for percpu area
Message-ID: <20020416125716.A31123@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu area stuff is broken in two places -

Missing stub for setup_per_cpu_areas() in the UP case
and missing definition of __per_cpu_data attribute in percpu.h.
Here is a patch that fixes these. Please apply.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


[percpufix-2.5.8-1.patch]


diff -urN linux-2.5.8-base/include/asm-generic/percpu.h linux-2.5.8-percpufix/include/asm-generic/percpu.h
--- linux-2.5.8-base/include/asm-generic/percpu.h	Mon Apr 15 00:48:47 2002
+++ linux-2.5.8-percpufix/include/asm-generic/percpu.h	Tue Apr 16 11:49:28 2002
@@ -4,6 +4,8 @@
 #define __GENERIC_PER_CPU
 #include <linux/compiler.h>
 
+#define __per_cpu_data  __attribute__((section(".data.percpu")))
+
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
 /* var is in discarded region: offset to particular copy we want */
diff -urN linux-2.5.8-base/init/main.c linux-2.5.8-percpufix/init/main.c
--- linux-2.5.8-base/init/main.c	Mon Apr 15 00:48:46 2002
+++ linux-2.5.8-percpufix/init/main.c	Tue Apr 16 11:50:57 2002
@@ -272,6 +272,10 @@
 #define smp_init()	do { } while (0)
 #endif
 
+static inline void setup_per_cpu_areas(void)
+{
+}
+
 #else
 
 #ifdef __GENERIC_PER_CPU
