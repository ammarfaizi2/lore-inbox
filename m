Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbUKXN14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbUKXN14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUKXN10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:27:26 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:405 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262662AbUKXNDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:03:30 -0500
Subject: Suspend 2 merge: 31/51: Export tlb flushing
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101297506.5805.314.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:59:50 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a do_flush_tlb_all function that does the
SMP-appropriate thing for suspend after the image is restored.

diff -ruN 818-tlb-flushing-functions-old/arch/i386/kernel/smp.c 818-tlb-flushing-functions-new/arch/i386/kernel/smp.c
--- 818-tlb-flushing-functions-old/arch/i386/kernel/smp.c	2004-11-06 09:27:19.225681536 +1100
+++ 818-tlb-flushing-functions-new/arch/i386/kernel/smp.c	2004-11-04 16:27:41.000000000 +1100
@@ -476,7 +476,7 @@
 	preempt_enable();
 }
 
-static void do_flush_tlb_all(void* info)
+void do_flush_tlb_all(void* info)
 {
 	unsigned long cpu = smp_processor_id();
 
diff -ruN 818-tlb-flushing-functions-old/include/asm-i386/tlbflush.h 818-tlb-flushing-functions-new/include/asm-i386/tlbflush.h
--- 818-tlb-flushing-functions-old/include/asm-i386/tlbflush.h	2004-11-03 21:55:01.000000000 +1100
+++ 818-tlb-flushing-functions-new/include/asm-i386/tlbflush.h	2004-11-04 16:27:41.000000000 +1100
@@ -82,6 +82,7 @@
 #define flush_tlb() __flush_tlb()
 #define flush_tlb_all() __flush_tlb_all()
 #define local_flush_tlb() __flush_tlb()
+#define local_flush_tlb_all() __flush_tlb_all();
 
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
@@ -114,6 +115,10 @@
 extern void flush_tlb_current_task(void);
 extern void flush_tlb_mm(struct mm_struct *);
 extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
+extern void do_flush_tlb_all(void * info);
+
+#define local_flush_tlb_all() \
+	do_flush_tlb_all(NULL);
 
 #define flush_tlb()	flush_tlb_current_task()
 


