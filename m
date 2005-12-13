Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbVLMVB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVLMVB0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbVLMVBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:01:25 -0500
Received: from fmr24.intel.com ([143.183.121.16]:44424 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030206AbVLMVBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:01:25 -0500
Message-Id: <20051213203901.071468453@csdlinux-2.jf.intel.com>
References: <20051213203547.649087523@csdlinux-2.jf.intel.com>
Date: Tue, 13 Dec 2005 12:35:49 -0800
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: ananth@in.ibm.com, akpm@osdl.org, paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [patch 2/4] Kprobes - cleanup include_asm_kprobes_h
Content-Disposition: inline; filename=cleanup_arch_kprobe_h.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] kprobes - cleanup include_asm_kprobes_h

The arch specific kprobes.h files never gets included
when CONFIG_KPROBES is turned off. Hence check for
CONFIG_KPROBES is not appropriate here in this 
arch specific kprobes.h files.

Also the below defined function kprobes_exception_notify()
is not needed when CONFIG_KPROBES is off.

Compile tested for both CONFIG_KPROBES=y and N.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
--------------------------------------------------------------------

 include/asm-i386/kprobes.h    |    8 --------
 include/asm-ia64/kprobes.h    |    8 --------
 include/asm-powerpc/kprobes.h |    8 --------
 include/asm-sparc64/kprobes.h |    9 ---------
 4 files changed, 33 deletions(-)

Index: linux-2.6.15-rc5-mm2/include/asm-i386/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-i386/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/asm-i386/kprobes.h
@@ -76,14 +76,6 @@ static inline void restore_interrupts(st
 		local_irq_enable();
 }
 
-#ifdef CONFIG_KPROBES
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
-#else				/* !CONFIG_KPROBES */
-static inline int kprobe_exceptions_notify(struct notifier_block *self,
-					   unsigned long val, void *data)
-{
-	return 0;
-}
-#endif
 #endif				/* _ASM_KPROBES_H */
Index: linux-2.6.15-rc5-mm2/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/asm-ia64/kprobes.h
@@ -115,7 +115,6 @@ static inline void arch_copy_kprobe(stru
 {
 }
 
-#ifdef CONFIG_KPROBES
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
 
@@ -124,11 +123,4 @@ static inline void jprobe_return(void)
 {
 }
 
-#else				/* !CONFIG_KPROBES */
-static inline int kprobe_exceptions_notify(struct notifier_block *self,
-					   unsigned long val, void *data)
-{
-	return 0;
-}
-#endif
 #endif				/* _ASM_KPROBES_H */
Index: linux-2.6.15-rc5-mm2/include/asm-powerpc/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-powerpc/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/asm-powerpc/kprobes.h
@@ -70,14 +70,6 @@ struct kprobe_ctlblk {
 	struct prev_kprobe prev_kprobe;
 };
 
-#ifdef CONFIG_KPROBES
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
-#else				/* !CONFIG_KPROBES */
-static inline int kprobe_exceptions_notify(struct notifier_block *self,
-					   unsigned long val, void *data)
-{
-	return 0;
-}
-#endif
 #endif	/* _ASM_POWERPC_KPROBES_H */
Index: linux-2.6.15-rc5-mm2/include/asm-sparc64/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-sparc64/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/asm-sparc64/kprobes.h
@@ -38,15 +38,6 @@ struct kprobe_ctlblk {
 	struct prev_kprobe prev_kprobe;
 };
 
-#ifdef CONFIG_KPROBES
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
-#else				/* !CONFIG_KPROBES */
-static inline int kprobe_exceptions_notify(struct notifier_block *self,
-					   unsigned long val, void *data)
-{
-	return 0;
-}
-#endif
-
 #endif /* _SPARC64_KPROBES_H */

--

