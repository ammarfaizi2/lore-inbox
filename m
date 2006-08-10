Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWHJTfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWHJTfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWHJTfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:35:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:19691 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932472AbWHJTfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:43 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [29/145] x86_64: Clean up asm/smp.h includes
Message-Id: <20060810193542.AC54213C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:42 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

No need to include it from entry.S
Drop all the #ifdef __ASSEMBLY__

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/entry.S |    2 --
 include/asm-x86_64/smp.h   |   12 ------------
 2 files changed, 14 deletions(-)

Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -27,10 +27,8 @@
  * - schedule it carefully for the final hardware.
  */
 
-#define ASSEMBLY 1
 #include <linux/linkage.h>
 #include <asm/segment.h>
-#include <asm/smp.h>
 #include <asm/cache.h>
 #include <asm/errno.h>
 #include <asm/dwarf2.h>
Index: linux/include/asm-x86_64/smp.h
===================================================================
--- linux.orig/include/asm-x86_64/smp.h
+++ linux/include/asm-x86_64/smp.h
@@ -4,15 +4,12 @@
 /*
  * We need the APIC definitions automatically as part of 'smp.h'
  */
-#ifndef __ASSEMBLY__
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 #include <linux/bitops.h>
 extern int disable_apic;
-#endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
-#ifndef __ASSEMBLY__
 #include <asm/fixmap.h>
 #include <asm/mpspec.h>
 #ifdef CONFIG_X86_IO_APIC
@@ -21,10 +18,8 @@ extern int disable_apic;
 #include <asm/apic.h>
 #include <asm/thread_info.h>
 #endif
-#endif
 
 #ifdef CONFIG_SMP
-#ifndef ASSEMBLY
 
 #include <asm/pda.h>
 
@@ -83,13 +78,10 @@ extern void prefill_possible_map(void);
 extern unsigned num_processors;
 extern unsigned disabled_cpus;
 
-#endif /* !ASSEMBLY */
-
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
 #endif
 
-#ifndef ASSEMBLY
 /*
  * Some lowlevel functions might want to know about
  * the real APIC ID <-> CPU # mapping.
@@ -111,8 +103,6 @@ static inline int cpu_present_to_apicid(
 		return BAD_APICID;
 }
 
-#endif /* !ASSEMBLY */
-
 #ifndef CONFIG_SMP
 #define stack_smp_processor_id() 0
 #define safe_smp_processor_id() 0
@@ -127,7 +117,6 @@ static inline int cpu_present_to_apicid(
 })
 #endif
 
-#ifndef __ASSEMBLY__
 static __inline int logical_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */
@@ -146,6 +135,5 @@ static inline int smp_call_function_sing
 	return 0;
 }
 #endif /* !CONFIG_SMP */
-#endif /* !__ASSEMBLY */
 #endif
 
