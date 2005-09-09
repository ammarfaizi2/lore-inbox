Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbVIIWkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbVIIWkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030465AbVIIWkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:40:33 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:29473 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932624AbVIIWkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:40:22 -0400
Cc: Sam Ravnborg <sam@mars (none)>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 5/12] kbuild: arm - use generic asm-offsets.h support
In-Reply-To: <11263057063978-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Sat, 10 Sep 2005 00:41:46 +0200
Message-Id: <11263057061819-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Delete obsoleted stuff from arch Makefile and rename
constants.h to asm-offsets.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/arm/Makefile                  |    9 ++-------
 arch/arm/kernel/entry-header.S     |    2 +-
 arch/arm/kernel/head.S             |    2 +-
 arch/arm/kernel/iwmmxt.S           |    2 +-
 arch/arm/lib/copy_page.S           |    2 +-
 arch/arm/lib/csumpartialcopyuser.S |    2 +-
 arch/arm/lib/getuser.S             |    2 +-
 arch/arm/lib/putuser.S             |    2 +-
 arch/arm/mm/copypage-v3.S          |    2 +-
 arch/arm/mm/copypage-v4wb.S        |    2 +-
 arch/arm/mm/copypage-v4wt.S        |    2 +-
 arch/arm/mm/proc-arm1020.S         |    2 +-
 arch/arm/mm/proc-arm1020e.S        |    2 +-
 arch/arm/mm/proc-arm1022.S         |    2 +-
 arch/arm/mm/proc-arm1026.S         |    2 +-
 arch/arm/mm/proc-arm6_7.S          |    2 +-
 arch/arm/mm/proc-arm720.S          |    2 +-
 arch/arm/mm/proc-macros.S          |    2 +-
 arch/arm/mm/proc-sa110.S           |    2 +-
 arch/arm/mm/proc-sa1100.S          |    2 +-
 arch/arm/mm/proc-v6.S              |    2 +-
 arch/arm/mm/tlb-v3.S               |    2 +-
 arch/arm/mm/tlb-v4.S               |    2 +-
 arch/arm/mm/tlb-v4wb.S             |    2 +-
 arch/arm/mm/tlb-v4wbi.S            |    2 +-
 arch/arm/mm/tlb-v6.S               |    2 +-
 arch/arm/nwfpe/entry26.S           |    2 +-
 arch/arm/vfp/entry.S               |    2 +-
 28 files changed, 29 insertions(+), 34 deletions(-)

e6ae744dd2eae8e00af328b11b1fe77cb0931136
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -178,7 +178,7 @@ endif
 prepare: maketools include/asm-arm/.arch
 
 .PHONY: maketools FORCE
-maketools: include/asm-arm/constants.h include/linux/version.h FORCE
+maketools: include/linux/version.h FORCE
 	$(Q)$(MAKE) $(build)=arch/arm/tools include/asm-arm/mach-types.h
 
 # Convert bzImage to zImage
@@ -190,7 +190,7 @@ zImage Image xipImage bootpImage uImage:
 zinstall install: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
-CLEAN_FILES += include/asm-arm/constants.h* include/asm-arm/mach-types.h \
+CLEAN_FILES += include/asm-arm/mach-types.h \
 	       include/asm-arm/arch include/asm-arm/.arch
 
 # We use MRPROPER_FILES and CLEAN_FILES now
@@ -201,11 +201,6 @@ archclean:
 bp:;	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/bootpImage
 i zi:;	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/asm-arm/.arch
-
-include/asm-$(ARCH)/constants.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
 
 define archhelp
   echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -3,7 +3,7 @@
 #include <linux/linkage.h>
 
 #include <asm/assembler.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/errno.h>
 #include <asm/thread_info.h>
 
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -20,7 +20,7 @@
 #include <asm/mach-types.h>
 #include <asm/procinfo.h>
 #include <asm/ptrace.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/system.h>
 
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -17,7 +17,7 @@
 #include <linux/linkage.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 
 #define MMX_WR0		 	(0x00)
 #define MMX_WR1		 	(0x08)
diff --git a/arch/arm/lib/copy_page.S b/arch/arm/lib/copy_page.S
--- a/arch/arm/lib/copy_page.S
+++ b/arch/arm/lib/copy_page.S
@@ -11,7 +11,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 
 #define COPY_COUNT (PAGE_SZ/64 PLD( -1 ))
 
diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -13,7 +13,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/errno.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 
 		.text
 
diff --git a/arch/arm/lib/getuser.S b/arch/arm/lib/getuser.S
--- a/arch/arm/lib/getuser.S
+++ b/arch/arm/lib/getuser.S
@@ -26,7 +26,7 @@
  * Note that ADDR_LIMIT is either 0 or 0xc0000000.
  * Note also that it is intended that __get_user_bad is not global.
  */
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/errno.h>
 
diff --git a/arch/arm/lib/putuser.S b/arch/arm/lib/putuser.S
--- a/arch/arm/lib/putuser.S
+++ b/arch/arm/lib/putuser.S
@@ -26,7 +26,7 @@
  * Note that ADDR_LIMIT is either 0 or 0xc0000000
  * Note also that it is intended that __put_user_bad is not global.
  */
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/errno.h>
 
diff --git a/arch/arm/mm/copypage-v3.S b/arch/arm/mm/copypage-v3.S
--- a/arch/arm/mm/copypage-v3.S
+++ b/arch/arm/mm/copypage-v3.S
@@ -12,7 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 
 		.text
 		.align	5
diff --git a/arch/arm/mm/copypage-v4wb.S b/arch/arm/mm/copypage-v4wb.S
--- a/arch/arm/mm/copypage-v4wb.S
+++ b/arch/arm/mm/copypage-v4wb.S
@@ -11,7 +11,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 
 	.text
 	.align	5
diff --git a/arch/arm/mm/copypage-v4wt.S b/arch/arm/mm/copypage-v4wt.S
--- a/arch/arm/mm/copypage-v4wt.S
+++ b/arch/arm/mm/copypage-v4wt.S
@@ -14,7 +14,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 
 	.text
 	.align	5
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -28,7 +28,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/procinfo.h>
 #include <asm/ptrace.h>
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -28,7 +28,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/procinfo.h>
 #include <asm/ptrace.h>
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -17,7 +17,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/procinfo.h>
 #include <asm/ptrace.h>
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -17,7 +17,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/procinfo.h>
 #include <asm/ptrace.h>
diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
--- a/arch/arm/mm/proc-arm6_7.S
+++ b/arch/arm/mm/proc-arm6_7.S
@@ -13,7 +13,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/procinfo.h>
 #include <asm/ptrace.h>
diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
--- a/arch/arm/mm/proc-arm720.S
+++ b/arch/arm/mm/proc-arm720.S
@@ -33,7 +33,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/procinfo.h>
 #include <asm/ptrace.h>
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -4,7 +4,7 @@
  *  VMA_VM_FLAGS
  *  VM_EXEC
  */
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 
 /*
diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
--- a/arch/arm/mm/proc-sa110.S
+++ b/arch/arm/mm/proc-sa110.S
@@ -15,7 +15,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/procinfo.h>
 #include <asm/hardware.h>
 #include <asm/pgtable.h>
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -20,7 +20,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/procinfo.h>
 #include <asm/hardware.h>
 #include <asm/pgtable.h>
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -11,7 +11,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/procinfo.h>
 #include <asm/pgtable.h>
 
diff --git a/arch/arm/mm/tlb-v3.S b/arch/arm/mm/tlb-v3.S
--- a/arch/arm/mm/tlb-v3.S
+++ b/arch/arm/mm/tlb-v3.S
@@ -13,7 +13,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/tlbflush.h>
 #include "proc-macros.S"
 
diff --git a/arch/arm/mm/tlb-v4.S b/arch/arm/mm/tlb-v4.S
--- a/arch/arm/mm/tlb-v4.S
+++ b/arch/arm/mm/tlb-v4.S
@@ -14,7 +14,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/tlbflush.h>
 #include "proc-macros.S"
 
diff --git a/arch/arm/mm/tlb-v4wb.S b/arch/arm/mm/tlb-v4wb.S
--- a/arch/arm/mm/tlb-v4wb.S
+++ b/arch/arm/mm/tlb-v4wb.S
@@ -14,7 +14,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/tlbflush.h>
 #include "proc-macros.S"
 
diff --git a/arch/arm/mm/tlb-v4wbi.S b/arch/arm/mm/tlb-v4wbi.S
--- a/arch/arm/mm/tlb-v4wbi.S
+++ b/arch/arm/mm/tlb-v4wbi.S
@@ -14,7 +14,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/tlbflush.h>
 #include "proc-macros.S"
 
diff --git a/arch/arm/mm/tlb-v6.S b/arch/arm/mm/tlb-v6.S
--- a/arch/arm/mm/tlb-v6.S
+++ b/arch/arm/mm/tlb-v6.S
@@ -11,7 +11,7 @@
  *  These assume a split I/D TLB.
  */
 #include <linux/linkage.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/page.h>
 #include <asm/tlbflush.h>
 #include "proc-macros.S"
diff --git a/arch/arm/nwfpe/entry26.S b/arch/arm/nwfpe/entry26.S
--- a/arch/arm/nwfpe/entry26.S
+++ b/arch/arm/nwfpe/entry26.S
@@ -20,7 +20,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 
 /* This is the kernel's entry point into the floating point emulator.
 It is called from the kernel with code similar to this:
diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -17,7 +17,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <asm/constants.h>
+#include <asm/asm-offsets.h>
 #include <asm/vfpmacros.h>
 
 	.globl	do_vfp


