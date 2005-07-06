Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVGFCbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVGFCbx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVGFCWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:22:18 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:63640 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262050AbVGFCTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:16 -0400
Subject: [PATCH] [17/48] Suspend2 2.1.9.8 for 2.6.12: 500-version-specific-i386.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:41 +1000
Message-Id: <11206164413380@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 501-tlb-flushing-functions.patch-old/arch/i386/kernel/smp.c 501-tlb-flushing-functions.patch-new/arch/i386/kernel/smp.c
--- 501-tlb-flushing-functions.patch-old/arch/i386/kernel/smp.c	2005-07-06 11:24:23.000000000 +1000
+++ 501-tlb-flushing-functions.patch-new/arch/i386/kernel/smp.c	2005-07-04 23:14:19.000000000 +1000
@@ -476,7 +476,7 @@ void flush_tlb_page(struct vm_area_struc
 	preempt_enable();
 }
 
-static void do_flush_tlb_all(void* info)
+void do_flush_tlb_all(void* info)
 {
 	unsigned long cpu = smp_processor_id();
 
diff -ruNp 501-tlb-flushing-functions.patch-old/include/asm-i386/tlbflush.h 501-tlb-flushing-functions.patch-new/include/asm-i386/tlbflush.h
--- 501-tlb-flushing-functions.patch-old/include/asm-i386/tlbflush.h	2004-11-03 21:55:01.000000000 +1100
+++ 501-tlb-flushing-functions.patch-new/include/asm-i386/tlbflush.h	2005-07-04 23:14:19.000000000 +1000
@@ -82,6 +82,7 @@ extern unsigned long pgkern_mask;
 #define flush_tlb() __flush_tlb()
 #define flush_tlb_all() __flush_tlb_all()
 #define local_flush_tlb() __flush_tlb()
+#define local_flush_tlb_all() __flush_tlb_all();
 
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
@@ -114,6 +115,10 @@ extern void flush_tlb_all(void);
 extern void flush_tlb_current_task(void);
 extern void flush_tlb_mm(struct mm_struct *);
 extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
+extern void do_flush_tlb_all(void * info);
+
+#define local_flush_tlb_all() \
+	do_flush_tlb_all(NULL);
 
 #define flush_tlb()	flush_tlb_current_task()
 

