Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVHKExP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVHKExP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVHKExO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:53:14 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:27398 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932245AbVHKExN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:53:13 -0400
Date: Wed, 10 Aug 2005 21:53:11 -0700
From: zach@vmware.com
Message-Id: <200508110453.j7B4rBl5019514@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwame@arm.linux.org.uk
Subject: [PATCH 2/14] i386 / Remove ugly tls code
X-OriginalArrivalTime: 11 Aug 2005 04:53:23.0890 (UTC) FILETIME=[9A937120:01C59E30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got too many complaints that this code is ugly.  It is.  Fix it.

Patch-base: 2.6.13-rc5-mm1
Patch-keys: i386 desc cleanup
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/mach-default/mach_desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_desc.h	2005-08-09 18:37:58.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_desc.h	2005-08-10 20:44:46.000000000 -0700
@@ -70,15 +70,9 @@
 	return 0;
 }
 
-#if TLS_SIZE != 24
-# error update this code.
-#endif
-
 static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
 {
-#define C(i) per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
-	C(0); C(1); C(2);
-#undef C
+	memcpy(&per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN], t->tls_array, TLS_SIZE);
 }
-
+  
 #endif
