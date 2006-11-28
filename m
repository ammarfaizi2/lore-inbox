Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758656AbWK1NOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758656AbWK1NOK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 08:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758659AbWK1NOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 08:14:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:13247 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758656AbWK1NOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 08:14:09 -0500
Subject: [PATCH] KVM: AMD SVM: Avoid three more new instructions
From: Avi Kivity <avi@qumranet.com>
Date: Tue, 28 Nov 2006 13:13:45 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Message-Id: <20061128131345.2356525015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The clgi, stgi, and invlpga instructions are all too new to unleash on
the world's assemblers.  Replace them with the opcode sequences.

Signed-off-by: Avi Kivity <avi@qumranet.com>

diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/svm.c /home/avi/kvm-release/kernel/svm.c
--- linux-2.6/drivers/kvm/svm.c	2006-11-28 14:31:03.000000000 +0200
+++ linux-2.6/drivers/kvm/svm.c	2006-11-28 15:08:19.000000000 +0200
@@ -102,17 +102,17 @@
 
 static inline void clgi(void)
 {
-	asm volatile ("clgi");
+	asm volatile (SVM_CLGI);
 }
 
 static inline void stgi(void)
 {
-	asm volatile ("stgi");
+	asm volatile (SVM_STGI);
 }
 
 static inline void invlpga(unsigned long addr, u32 asid)
 {
-	asm volatile ("invlpga" :: "a"(addr), "c"(asid));
+	asm volatile (SVM_INVLPGA :: "a"(addr), "c"(asid));
 }
 
 static inline unsigned long read_cr2(void)
diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/svm.h /home/avi/kvm-release/kernel/svm.h
--- linux-2.6/drivers/kvm/svm.h	2006-11-28 14:14:17.000000000 +0200
+++ linux-2.6/drivers/kvm/svm.h	2006-11-28 15:09:17.000000000 +0200
@@ -307,6 +307,9 @@
 #define SVM_VMLOAD ".byte 0x0f, 0x01, 0xda"
 #define SVM_VMRUN  ".byte 0x0f, 0x01, 0xd8"
 #define SVM_VMSAVE ".byte 0x0f, 0x01, 0xdb"
+#define SVM_CLGI   ".byte 0x0f, 0x01, 0xdd"
+#define SVM_STGI   ".byte 0x0f, 0x01, 0xdc"
+#define SVM_INVLPGA ".byte 0x0f, 0x01, 0xdf"
 
 #endif
 
