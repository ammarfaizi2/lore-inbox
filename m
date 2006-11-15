Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbWKOPDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbWKOPDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbWKOPDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:03:23 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:62360
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030529AbWKOPDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:03:23 -0500
Message-Id: <455B3A91.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 15 Nov 2006 15:04:33 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <patches@x86-64.org>
Subject: [PATCH] x86-64: conditionalize inclusion of some MTRR flavors
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid inclusion of code that's dead for x86-64.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc5/arch/i386/kernel/cpu/mtrr/Makefile	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-x86_64-mtrr/arch/i386/kernel/cpu/mtrr/Makefile	2006-11-09 13:38:13.000000000 +0100
@@ -1,5 +1,3 @@
 obj-y		:= main.o if.o generic.o state.o
-obj-y		+= amd.o
-obj-y		+= cyrix.o
-obj-y		+= centaur.o
+obj-$(CONFIG_X86_32) += amd.o cyrix.o centaur.o
 
--- linux-2.6.19-rc5/arch/i386/kernel/cpu/mtrr/main.c	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-x86_64-mtrr/arch/i386/kernel/cpu/mtrr/main.c	2006-11-10 08:56:35.000000000 +0100
@@ -59,7 +59,11 @@ struct mtrr_ops * mtrr_if = NULL;
 static void set_mtrr(unsigned int reg, unsigned long base,
 		     unsigned long size, mtrr_type type);
 
+#ifndef CONFIG_X86_64
 extern int arr3_protected;
+#else
+#define arr3_protected 0
+#endif
 
 void set_mtrr_ops(struct mtrr_ops * ops)
 {
@@ -544,9 +548,11 @@ extern void centaur_init_mtrr(void);
 
 static void __init init_ifs(void)
 {
+#ifndef CONFIG_X86_64
 	amd_init_mtrr();
 	cyrix_init_mtrr();
 	centaur_init_mtrr();
+#endif
 }
 
 /* The suspend/resume methods are only for CPU without MTRR. CPU using generic


