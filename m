Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbVIIWk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbVIIWk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbVIIWk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:40:28 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:20885 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932612AbVIIWkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:40:21 -0400
Cc: Sam Ravnborg <sam@mars (none)>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 3/12] kbuild: arm26,sparc use generic asm-offset support
In-Reply-To: <11263057062281-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Sat, 10 Sep 2005 00:41:46 +0200
Message-Id: <11263057062389-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename all includes to use asm-offsets.h to match generic name

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/arm26/Makefile                  |   10 ----------
 arch/arm26/kernel/entry.S            |    2 +-
 arch/arm26/lib/copy_page.S           |    2 +-
 arch/arm26/lib/csumpartialcopyuser.S |    2 +-
 arch/arm26/lib/getuser.S             |    2 +-
 arch/arm26/lib/putuser.S             |    2 +-
 arch/arm26/mm/proc-funcs.S           |    2 +-
 arch/arm26/nwfpe/entry.S             |    2 +-
 arch/sparc/Makefile                  |   12 +-----------
 arch/sparc/kernel/entry.S            |    2 +-
 arch/sparc/kernel/sclow.S            |    2 +-
 arch/sparc/mm/hypersparc.S           |    2 +-
 arch/sparc/mm/swift.S                |    2 +-
 arch/sparc/mm/tsunami.S              |    2 +-
 arch/sparc/mm/viking.S               |    2 +-
 include/asm-sparc/ptrace.h           |    4 ++--
 16 files changed, 16 insertions(+), 36 deletions(-)

47003497dd819b10874a2291e54df7dc5cf8be57
diff --git a/arch/arm26/Makefile b/arch/arm26/Makefile
--- a/arch/arm26/Makefile
+++ b/arch/arm26/Makefile
@@ -49,10 +49,6 @@ all: zImage
 
 boot := arch/arm26/boot
 
-prepare: include/asm-$(ARCH)/asm_offsets.h
-CLEAN_FILES += include/asm-$(ARCH)/asm_offsets.h
-
-
 .PHONY: maketools FORCE
 maketools: FORCE
 	
@@ -94,12 +90,6 @@ zi:;	$(Q)$(MAKE) $(build)=$(boot) zinsta
 	fi; \
 	)
 
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/asm_offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
 define archhelp
   echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
diff --git a/arch/arm26/kernel/entry.S b/arch/arm26/kernel/entry.S
--- a/arch/arm26/kernel/entry.S
+++ b/arch/arm26/kernel/entry.S
@@ -10,7 +10,7 @@
 #include <linux/linkage.h>
 
 #include <asm/assembler.h>
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/errno.h>
 #include <asm/hardware.h>
 #include <asm/sysirq.h>
diff --git a/arch/arm26/lib/copy_page.S b/arch/arm26/lib/copy_page.S
--- a/arch/arm26/lib/copy_page.S
+++ b/arch/arm26/lib/copy_page.S
@@ -11,7 +11,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 
 		.text
 		.align	5
diff --git a/arch/arm26/lib/csumpartialcopyuser.S b/arch/arm26/lib/csumpartialcopyuser.S
--- a/arch/arm26/lib/csumpartialcopyuser.S
+++ b/arch/arm26/lib/csumpartialcopyuser.S
@@ -11,7 +11,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/errno.h>
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 
 		.text
 
diff --git a/arch/arm26/lib/getuser.S b/arch/arm26/lib/getuser.S
--- a/arch/arm26/lib/getuser.S
+++ b/arch/arm26/lib/getuser.S
@@ -26,7 +26,7 @@
  * Note that ADDR_LIMIT is either 0 or 0xc0000000.
  * Note also that it is intended that __get_user_bad is not global.
  */
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/errno.h>
 
diff --git a/arch/arm26/lib/putuser.S b/arch/arm26/lib/putuser.S
--- a/arch/arm26/lib/putuser.S
+++ b/arch/arm26/lib/putuser.S
@@ -26,7 +26,7 @@
  * Note that ADDR_LIMIT is either 0 or 0xc0000000
  * Note also that it is intended that __put_user_bad is not global.
  */
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/errno.h>
 
diff --git a/arch/arm26/mm/proc-funcs.S b/arch/arm26/mm/proc-funcs.S
--- a/arch/arm26/mm/proc-funcs.S
+++ b/arch/arm26/mm/proc-funcs.S
@@ -14,7 +14,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/procinfo.h>
 #include <asm/ptrace.h>
 
diff --git a/arch/arm26/nwfpe/entry.S b/arch/arm26/nwfpe/entry.S
--- a/arch/arm26/nwfpe/entry.S
+++ b/arch/arm26/nwfpe/entry.S
@@ -20,7 +20,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 
 /* This is the kernel's entry point into the floating point emulator.
 It is called from the kernel with code similar to this:
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -59,17 +59,7 @@ image tftpboot.img: vmlinux
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-prepare: include/asm-$(ARCH)/asm_offsets.h
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/asm_offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES +=	include/asm-$(ARCH)/asm_offsets.h	\
-		arch/$(ARCH)/kernel/asm-offsets.s	\
-		arch/$(ARCH)/boot/System.map
+CLEAN_FILES += arch/$(ARCH)/boot/System.map
 
 # Don't use tabs in echo arguments.
 define archhelp
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -17,7 +17,7 @@
 #include <asm/kgdb.h>
 #include <asm/contregs.h>
 #include <asm/ptrace.h>
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/psr.h>
 #include <asm/vaddrs.h>
 #include <asm/memreg.h>
diff --git a/arch/sparc/kernel/sclow.S b/arch/sparc/kernel/sclow.S
--- a/arch/sparc/kernel/sclow.S
+++ b/arch/sparc/kernel/sclow.S
@@ -7,7 +7,7 @@
  */
 
 #include <asm/ptrace.h>
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/errno.h>
 #include <asm/winmacro.h>
 #include <asm/thread_info.h>
diff --git a/arch/sparc/mm/hypersparc.S b/arch/sparc/mm/hypersparc.S
--- a/arch/sparc/mm/hypersparc.S
+++ b/arch/sparc/mm/hypersparc.S
@@ -6,7 +6,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/psr.h>
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/asi.h>
 #include <asm/page.h>
 #include <asm/pgtsrmmu.h>
diff --git a/arch/sparc/mm/swift.S b/arch/sparc/mm/swift.S
--- a/arch/sparc/mm/swift.S
+++ b/arch/sparc/mm/swift.S
@@ -9,7 +9,7 @@
 #include <asm/asi.h>
 #include <asm/page.h>
 #include <asm/pgtsrmmu.h>
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 
 	.text
 	.align	4
diff --git a/arch/sparc/mm/tsunami.S b/arch/sparc/mm/tsunami.S
--- a/arch/sparc/mm/tsunami.S
+++ b/arch/sparc/mm/tsunami.S
@@ -6,7 +6,7 @@
 
 #include <linux/config.h>
 #include <asm/ptrace.h>
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/psr.h>
 #include <asm/asi.h>
 #include <asm/page.h>
diff --git a/arch/sparc/mm/viking.S b/arch/sparc/mm/viking.S
--- a/arch/sparc/mm/viking.S
+++ b/arch/sparc/mm/viking.S
@@ -9,7 +9,7 @@
 #include <linux/config.h>
 #include <asm/ptrace.h>
 #include <asm/psr.h>
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/asi.h>
 #include <asm/mxcc.h>
 #include <asm/page.h>
diff --git a/include/asm-sparc/ptrace.h b/include/asm-sparc/ptrace.h
--- a/include/asm-sparc/ptrace.h
+++ b/include/asm-sparc/ptrace.h
@@ -73,11 +73,11 @@ extern void show_regs(struct pt_regs *);
 #endif
 
 /*
- * The asm_offsets.h is a generated file, so we cannot include it.
+ * The asm-offsets.h is a generated file, so we cannot include it.
  * It may be OK for glibc headers, but it's utterly pointless for C code.
  * The assembly code using those offsets has to include it explicitly.
  */
-/* #include <asm/asm_offsets.h> */
+/* #include <asm/asm-offsets.h> */
 
 /* These are for pt_regs. */
 #define PT_PSR    0x0


