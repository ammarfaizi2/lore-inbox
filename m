Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277363AbRJEMJW>; Fri, 5 Oct 2001 08:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277367AbRJEMJN>; Fri, 5 Oct 2001 08:09:13 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:23558 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277363AbRJEMJF>;
	Fri, 5 Oct 2001 08:09:05 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [patch] 2.4.11-pre4 ASSEMBLY name space pollution
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Oct 2001 22:09:20 +1000
Message-ID: <8547.1002283760@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ASSEMBLY has crept back into the kernel, instead of __ASSEMBLY__.

include/asm-alpha/page.h
include/asm-i386/smp.h
arch/parisc/hpux/entry_hpux.S
arch/s390/kernel/entry.S
arch/i386/kernel/entry.S
arch/s390x/kernel/entry.S

Index: 11-pre4.1/include/asm-alpha/page.h
--- 11-pre4.1/include/asm-alpha/page.h Fri, 25 May 2001 14:11:21 +1000 kaos (linux-2.4/Q/11_page.h 1.3 644)
+++ 11-pre4.1(w)/include/asm-alpha/page.h Fri, 05 Oct 2001 22:04:54 +1000 kaos (linux-2.4/Q/11_page.h 1.3 644)
@@ -80,7 +80,7 @@ extern __inline__ int get_order(unsigned
 	return order;
 }
 
-#endif /* !ASSEMBLY */
+#endif /* !__ASSEMBLY__ */
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
Index: 11-pre4.1/include/asm-i386/smp.h
--- 11-pre4.1/include/asm-i386/smp.h Fri, 05 Oct 2001 15:05:09 +1000 kaos (linux-2.4/U/28_smp.h 1.3 644)
+++ 11-pre4.1(w)/include/asm-i386/smp.h Fri, 05 Oct 2001 22:04:20 +1000 kaos (linux-2.4/U/28_smp.h 1.3 644)
@@ -4,14 +4,14 @@
 /*
  * We need the APIC definitions automatically as part of 'smp.h'
  */
-#ifndef ASSEMBLY
+#ifndef __ASSEMBLY__
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/ptrace.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
-#ifndef ASSEMBLY
+#ifndef __ASSEMBLY__
 #include <asm/fixmap.h>
 #include <asm/bitops.h>
 #include <asm/mpspec.h>
@@ -35,7 +35,7 @@
 #endif
 
 #ifdef CONFIG_SMP
-#ifndef ASSEMBLY
+#ifndef __ASSEMBLY__
 
 /*
  * Private routines/data
@@ -114,7 +114,7 @@ extern __inline int logical_smp_processo
 	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
 }
 
-#endif /* !ASSEMBLY */
+#endif /* !__ASSEMBLY__ */
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
Index: 11-pre4.1/arch/parisc/hpux/entry_hpux.S
--- 11-pre4.1/arch/parisc/hpux/entry_hpux.S Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/l/c/40_entry_hpux 1.1 644)
+++ 11-pre4.1(w)/arch/parisc/hpux/entry_hpux.S Fri, 05 Oct 2001 22:05:37 +1000 kaos (linux-2.4/l/c/40_entry_hpux 1.1 644)
@@ -6,8 +6,6 @@
  */
 
 
-#define ASSEMBLY
-
 #include <linux/sys.h>
 #include <linux/linkage.h>
 #include <asm/unistd.h>
Index: 11-pre4.1/arch/s390/kernel/entry.S
--- 11-pre4.1/arch/s390/kernel/entry.S Mon, 13 Aug 2001 14:14:10 +1000 kaos (linux-2.4/n/c/32_entry.S 1.2.1.2.1.3 644)
+++ 11-pre4.1(w)/arch/s390/kernel/entry.S Fri, 05 Oct 2001 22:05:42 +1000 kaos (linux-2.4/n/c/32_entry.S 1.2.1.2.1.3 644)
@@ -9,8 +9,6 @@
  *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
  */
 
-#define ASSEMBLY
-
 #include <linux/sys.h>
 #include <linux/linkage.h>
 #include <linux/config.h>
Index: 11-pre4.1/arch/i386/kernel/entry.S
--- 11-pre4.1/arch/i386/kernel/entry.S Mon, 01 Oct 2001 12:23:40 +1000 kaos (linux-2.4/S/c/24_entry.S 1.1.5.5 644)
+++ 11-pre4.1(w)/arch/i386/kernel/entry.S Fri, 05 Oct 2001 22:04:20 +1000 kaos (linux-2.4/S/c/24_entry.S 1.1.5.5 644)
@@ -44,7 +44,6 @@
 #include <linux/sys.h>
 #include <linux/linkage.h>
 #include <asm/segment.h>
-#define ASSEMBLY
 #include <asm/smp.h>
 
 EBX		= 0x00
Index: 11-pre4.1/arch/s390x/kernel/entry.S
--- 11-pre4.1/arch/s390x/kernel/entry.S Mon, 13 Aug 2001 14:14:10 +1000 kaos (linux-2.4/p/d/45_entry.S 1.1.1.2.1.3 644)
+++ 11-pre4.1(w)/arch/s390x/kernel/entry.S Fri, 05 Oct 2001 22:05:47 +1000 kaos (linux-2.4/p/d/45_entry.S 1.1.1.2.1.3 644)
@@ -9,8 +9,6 @@
  *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
  */
 
-#define ASSEMBLY
-
 #include <linux/sys.h>
 #include <linux/linkage.h>
 #include <linux/config.h>

