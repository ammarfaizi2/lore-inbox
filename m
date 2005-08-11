Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVHKExz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVHKExz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVHKExz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:53:55 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:32006 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932254AbVHKExx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:53:53 -0400
Date: Wed, 10 Aug 2005 21:53:51 -0700
From: zach@vmware.com
Message-Id: <200508110453.j7B4rpe9019530@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwame@arm.linux.org.uk
Subject: [PATCH 4/14] i386 / Clean up asm and volatile keywords in desc
X-OriginalArrivalTime: 11 Aug 2005 04:54:04.0015 (UTC) FILETIME=[B27E07F0:01C59E30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using extra underscores on asm and volatiles, that is just silly.
Also, make lgdt/lidt/sgdt/sldt explicitly "l".

Patch-base: 2.6.13-rc5-mm1
Patch-keys: i386 desc cleanup
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/mach-default/mach_desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_desc.h	2005-08-09 18:38:14.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_desc.h	2005-08-10 20:42:03.000000000 -0700
@@ -24,30 +24,30 @@
 #ifndef __MACH_DESC_H
 #define __MACH_DESC_H
 
-#define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
-#define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
+#define load_TR_desc() asm volatile("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
+#define load_LDT_desc() asm volatile("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
 
-#define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
-#define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))
-#define load_tr(tr) __asm__ __volatile("ltr %0"::"mr" (tr))
-#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"mr" (ldt))
-
-#define store_gdt(dtr) __asm__ ("sgdt %0":"=m" (*dtr))
-#define store_idt(dtr) __asm__ ("sidt %0":"=m" (*dtr))
-#define store_tr(tr) __asm__ ("str %0":"=mr" (tr))
-#define store_ldt(ldt) __asm__ ("sldt %0":"=mr" (ldt))
+#define load_gdt(dtr) asm volatile("lgdtl %0"::"m" (*dtr))
+#define load_idt(dtr) asm volatile("lidtl %0"::"m" (*dtr))
+#define load_tr(tr) asm volatile("ltr %0"::"mr" (tr))
+#define load_ldt(ldt) asm volatile("lldt %0"::"mr" (ldt))
+
+#define store_gdt(dtr) asm ("sgdtl %0":"=m" (*dtr))
+#define store_idt(dtr) asm ("sidtl %0":"=m" (*dtr))
+#define store_tr(tr) asm ("str %0":"=mr" (tr))
+#define store_ldt(ldt) asm ("sldt %0":"=mr" (ldt))
 
 static inline unsigned int get_TR_desc(void)
 {
 	unsigned int tr;
-	__asm__ ("str %w0":"=q" (tr));
+	asm ("str %w0":"=q" (tr));
 	return tr;
 }
 
 static inline unsigned int get_LDT_desc(void)
 {
 	unsigned int ldt;
-	__asm__ ("sldt %w0":"=q" (ldt));
+	asm ("sldt %w0":"=q" (ldt));
 	return ldt;
 }
 
