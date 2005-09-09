Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbVIIWmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbVIIWmG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbVIIWly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:41:54 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:35351 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1030455AbVIIWkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:40:24 -0400
Cc: Sam Ravnborg <sam@mars (none)>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 6/12] kbuild: alpha,x86_64 use generic asm-offsets.h support
In-Reply-To: <11263057061819-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Sat, 10 Sep 2005 00:41:46 +0200
Message-Id: <11263057061063-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Delete obsolete stuff from arch makefiles
Rename .h file to asm-offsets.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/alpha/Makefile                  |   11 -----------
 arch/alpha/kernel/entry.S            |    2 +-
 arch/alpha/kernel/head.S             |    2 +-
 arch/alpha/lib/dbg_stackcheck.S      |    2 +-
 arch/alpha/lib/dbg_stackkill.S       |    2 +-
 arch/x86_64/Makefile                 |   10 ----------
 arch/x86_64/ia32/ia32entry.S         |    2 +-
 arch/x86_64/ia32/vsyscall-syscall.S  |    2 +-
 arch/x86_64/ia32/vsyscall-sysenter.S |    2 +-
 arch/x86_64/kernel/entry.S           |    2 +-
 arch/x86_64/kernel/suspend_asm.S     |    2 +-
 arch/x86_64/lib/copy_user.S          |    2 +-
 arch/x86_64/lib/getuser.S            |    2 +-
 arch/x86_64/lib/putuser.S            |    2 +-
 include/asm-x86_64/current.h         |    2 +-
 15 files changed, 13 insertions(+), 34 deletions(-)

e2d5df935d8a82cb7a2c50726628fa928aa89b9b
diff --git a/arch/alpha/Makefile b/arch/alpha/Makefile
--- a/arch/alpha/Makefile
+++ b/arch/alpha/Makefile
@@ -108,20 +108,9 @@ $(boot)/vmlinux.gz: vmlinux
 bootimage bootpfile bootpzfile: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-
-prepare: include/asm-$(ARCH)/asm_offsets.h
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/asm_offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-CLEAN_FILES += include/asm-$(ARCH)/asm_offsets.h
-
 define archhelp
   echo '* boot		- Compressed kernel image (arch/alpha/boot/vmlinux.gz)'
   echo '  bootimage	- SRM bootable image (arch/alpha/boot/bootimage)'
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -5,7 +5,7 @@
  */
 
 #include <linux/config.h>
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/pal.h>
 #include <asm/errno.h>
diff --git a/arch/alpha/kernel/head.S b/arch/alpha/kernel/head.S
--- a/arch/alpha/kernel/head.S
+++ b/arch/alpha/kernel/head.S
@@ -9,7 +9,7 @@
 
 #include <linux/config.h>
 #include <asm/system.h>
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 
 .globl swapper_pg_dir
 .globl _stext
diff --git a/arch/alpha/lib/dbg_stackcheck.S b/arch/alpha/lib/dbg_stackcheck.S
--- a/arch/alpha/lib/dbg_stackcheck.S
+++ b/arch/alpha/lib/dbg_stackcheck.S
@@ -5,7 +5,7 @@
  * Verify that we have not overflowed the stack.  Oops if we have.
  */
 
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 
 	.text
 	.set noat
diff --git a/arch/alpha/lib/dbg_stackkill.S b/arch/alpha/lib/dbg_stackkill.S
--- a/arch/alpha/lib/dbg_stackkill.S
+++ b/arch/alpha/lib/dbg_stackkill.S
@@ -6,7 +6,7 @@
  * uninitialized local variables in the act.
  */
 
-#include <asm/asm_offsets.h>
+#include <asm/asm-offsets.h>
 
 	.text
 	.set noat
diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
--- a/arch/x86_64/Makefile
+++ b/arch/x86_64/Makefile
@@ -86,16 +86,6 @@ install fdimage fdimage144 fdimage288: v
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-prepare: include/asm-$(ARCH)/offset.h
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/offset.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES += include/asm-$(ARCH)/offset.h
-
 define archhelp
   echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
   echo  '  install	- Install kernel using'
diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -6,7 +6,7 @@
 
 #include <asm/dwarf2.h>
 #include <asm/calling.h>
-#include <asm/offset.h>
+#include <asm/asm-offsets.h>
 #include <asm/current.h>
 #include <asm/errno.h>
 #include <asm/ia32_unistd.h>	
diff --git a/arch/x86_64/ia32/vsyscall-syscall.S b/arch/x86_64/ia32/vsyscall-syscall.S
--- a/arch/x86_64/ia32/vsyscall-syscall.S
+++ b/arch/x86_64/ia32/vsyscall-syscall.S
@@ -3,7 +3,7 @@
  */
 
 #include <asm/ia32_unistd.h>
-#include <asm/offset.h>
+#include <asm/asm-offsets.h>
 #include <asm/segment.h>
 
 	.text
diff --git a/arch/x86_64/ia32/vsyscall-sysenter.S b/arch/x86_64/ia32/vsyscall-sysenter.S
--- a/arch/x86_64/ia32/vsyscall-sysenter.S
+++ b/arch/x86_64/ia32/vsyscall-sysenter.S
@@ -3,7 +3,7 @@
  */
 
 #include <asm/ia32_unistd.h>
-#include <asm/offset.h>
+#include <asm/asm-offsets.h>
 
 	.text
 	.section .text.vsyscall,"ax"
diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
--- a/arch/x86_64/kernel/entry.S
+++ b/arch/x86_64/kernel/entry.S
@@ -36,7 +36,7 @@
 #include <asm/errno.h>
 #include <asm/dwarf2.h>
 #include <asm/calling.h>
-#include <asm/offset.h>
+#include <asm/asm-offsets.h>
 #include <asm/msr.h>
 #include <asm/unistd.h>
 #include <asm/thread_info.h>
diff --git a/arch/x86_64/kernel/suspend_asm.S b/arch/x86_64/kernel/suspend_asm.S
--- a/arch/x86_64/kernel/suspend_asm.S
+++ b/arch/x86_64/kernel/suspend_asm.S
@@ -14,7 +14,7 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/page.h>
-#include <asm/offset.h>
+#include <asm/asm-offsets.h>
 
 ENTRY(swsusp_arch_suspend)
 
diff --git a/arch/x86_64/lib/copy_user.S b/arch/x86_64/lib/copy_user.S
--- a/arch/x86_64/lib/copy_user.S
+++ b/arch/x86_64/lib/copy_user.S
@@ -7,7 +7,7 @@
 #define FIX_ALIGNMENT 1
 		
 	#include <asm/current.h>
-	#include <asm/offset.h>
+	#include <asm/asm-offsets.h>
 	#include <asm/thread_info.h>
 	#include <asm/cpufeature.h>
 
diff --git a/arch/x86_64/lib/getuser.S b/arch/x86_64/lib/getuser.S
--- a/arch/x86_64/lib/getuser.S
+++ b/arch/x86_64/lib/getuser.S
@@ -29,7 +29,7 @@
 #include <linux/linkage.h>
 #include <asm/page.h>
 #include <asm/errno.h>
-#include <asm/offset.h>
+#include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 
 	.text
diff --git a/arch/x86_64/lib/putuser.S b/arch/x86_64/lib/putuser.S
--- a/arch/x86_64/lib/putuser.S
+++ b/arch/x86_64/lib/putuser.S
@@ -27,7 +27,7 @@
 #include <linux/linkage.h>
 #include <asm/page.h>
 #include <asm/errno.h>
-#include <asm/offset.h>
+#include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 
 	.text
diff --git a/include/asm-x86_64/current.h b/include/asm-x86_64/current.h
--- a/include/asm-x86_64/current.h
+++ b/include/asm-x86_64/current.h
@@ -17,7 +17,7 @@ static inline struct task_struct *get_cu
 #else
 
 #ifndef ASM_OFFSET_H
-#include <asm/offset.h> 
+#include <asm/asm-offsets.h> 
 #endif
 
 #define GET_CURRENT(reg) movq %gs:(pda_pcurrent),reg


