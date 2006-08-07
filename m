Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWHGL7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWHGL7D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 07:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWHGL7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 07:59:02 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:25800 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750817AbWHGL7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 07:59:00 -0400
Date: Mon, 7 Aug 2006 17:30:24 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH 2/3] Kprobes: Define retval helper
Message-ID: <20060807120024.GD15253@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20060807115537.GA15253@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807115537.GA15253@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Add the KPROBE_RETVAL macro to help extract the return value on
different architectures, while using function-return probes.

---
Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Prasanna S.P <prasanna@in.ibm.com>


---
 include/asm-i386/kprobes.h    |    2 ++
 include/asm-ia64/kprobes.h    |    2 ++
 include/asm-powerpc/kprobes.h |    2 ++
 include/asm-x86_64/kprobes.h  |    2 ++
 4 files changed, 8 insertions(+)

Index: linux-2.6.18-rc3/include/asm-i386/kprobes.h
===================================================================
--- linux-2.6.18-rc3.orig/include/asm-i386/kprobes.h
+++ linux-2.6.18-rc3/include/asm-i386/kprobes.h
@@ -46,6 +46,8 @@ typedef u8 kprobe_opcode_t;
 #define ARCH_SUPPORTS_KRETPROBES
 #define  ARCH_INACTIVE_KPROBE_COUNT 0
 
+#define KPROBE_RETVAL(regs)	regs->eax
+
 void arch_remove_kprobe(struct kprobe *p);
 void kretprobe_trampoline(void);
 
Index: linux-2.6.18-rc3/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.18-rc3.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.18-rc3/include/asm-ia64/kprobes.h
@@ -84,6 +84,8 @@ struct kprobe_ctlblk {
 #define ARCH_SUPPORTS_KRETPROBES
 #define  ARCH_INACTIVE_KPROBE_COUNT 1
 
+#define KPROBE_RETVAL(regs)	regs->r8
+
 #define SLOT0_OPCODE_SHIFT	(37)
 #define SLOT1_p1_OPCODE_SHIFT	(37 - (64-46))
 #define SLOT2_OPCODE_SHIFT 	(37)
Index: linux-2.6.18-rc3/include/asm-powerpc/kprobes.h
===================================================================
--- linux-2.6.18-rc3.orig/include/asm-powerpc/kprobes.h
+++ linux-2.6.18-rc3/include/asm-powerpc/kprobes.h
@@ -54,6 +54,8 @@ typedef unsigned int kprobe_opcode_t;
 #define ARCH_SUPPORTS_KRETPROBES
 #define  ARCH_INACTIVE_KPROBE_COUNT 1
 
+#define KPROBE_RETVAL(regs)	regs->gpr[3]
+
 void kretprobe_trampoline(void);
 extern void arch_remove_kprobe(struct kprobe *p);
 
Index: linux-2.6.18-rc3/include/asm-x86_64/kprobes.h
===================================================================
--- linux-2.6.18-rc3.orig/include/asm-x86_64/kprobes.h
+++ linux-2.6.18-rc3/include/asm-x86_64/kprobes.h
@@ -45,6 +45,8 @@ typedef u8 kprobe_opcode_t;
 #define ARCH_SUPPORTS_KRETPROBES
 #define  ARCH_INACTIVE_KPROBE_COUNT 1
 
+#define KPROBE_RETVAL(regs)	regs->rax
+
 void kretprobe_trampoline(void);
 extern void arch_remove_kprobe(struct kprobe *p);
 
