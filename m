Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbVIIWmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbVIIWmH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbVIIWlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:41:52 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:53875 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1030458AbVIIWkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:40:24 -0400
Cc: Sam Ravnborg <sam@mars (none)>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 8/12] kbuild: ia64 use generic asm-offsets.h support
In-Reply-To: <11263057063890-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Sat, 10 Sep 2005 00:41:46 +0200
Message-Id: <11263057062211-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Delete obsolete stuff from arch Makefile
Rename file to asm-offsets.h
The trick used in the arch Makefile to circumvent the circular
dependency is kept.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/ia64/Makefile          |   21 +++++++--------------
 arch/ia64/ia32/ia32_entry.S |    2 +-
 arch/ia64/kernel/entry.S    |    2 +-
 arch/ia64/kernel/fsys.S     |    2 +-
 arch/ia64/kernel/gate.S     |    2 +-
 arch/ia64/kernel/head.S     |    2 +-
 arch/ia64/kernel/ivt.S      |    2 +-
 7 files changed, 13 insertions(+), 20 deletions(-)

39e01cb874cbf694bd0b0c44f54c4f270e2aa556
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -82,25 +82,18 @@ unwcheck: vmlinux
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-CLEAN_FILES += include/asm-ia64/.offsets.h.stamp vmlinux.gz bootloader
-
-MRPROPER_FILES += include/asm-ia64/offsets.h
-
-prepare: include/asm-ia64/offsets.h
-
-arch/ia64/kernel/asm-offsets.s: include/asm include/linux/version.h include/config/MARKER
-
-include/asm-ia64/offsets.h: arch/ia64/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-arch/ia64/kernel/asm-offsets.s: include/asm-ia64/.offsets.h.stamp
+prepare:  include/asm-ia64/.offsets.h.stamp
 
 include/asm-ia64/.offsets.h.stamp:
 	mkdir -p include/asm-ia64
-	[ -s include/asm-ia64/offsets.h ] \
-	 || echo "#define IA64_TASK_SIZE 0" > include/asm-ia64/offsets.h
+	[ -s include/asm-ia64/asm-offsets.h ] \
+	|| echo "#define IA64_TASK_SIZE 0" > include/asm-ia64/asm-offsets.h
 	touch $@
 
+
+
+CLEAN_FILES += vmlinux.gz bootloader include/asm-ia64/.offsets.h.stamp
+
 boot:	lib/lib.a vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
diff --git a/arch/ia64/ia32/ia32_entry.S b/arch/ia64/ia32/ia32_entry.S
--- a/arch/ia64/ia32/ia32_entry.S
+++ b/arch/ia64/ia32/ia32_entry.S
@@ -1,6 +1,6 @@
 #include <asm/asmmacro.h>
 #include <asm/ia32.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/signal.h>
 #include <asm/thread_info.h>
 
diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
--- a/arch/ia64/kernel/entry.S
+++ b/arch/ia64/kernel/entry.S
@@ -37,7 +37,7 @@
 #include <asm/cache.h>
 #include <asm/errno.h>
 #include <asm/kregs.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/percpu.h>
 #include <asm/processor.h>
diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
--- a/arch/ia64/kernel/fsys.S
+++ b/arch/ia64/kernel/fsys.S
@@ -14,7 +14,7 @@
 
 #include <asm/asmmacro.h>
 #include <asm/errno.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/percpu.h>
 #include <asm/thread_info.h>
 #include <asm/sal.h>
diff --git a/arch/ia64/kernel/gate.S b/arch/ia64/kernel/gate.S
--- a/arch/ia64/kernel/gate.S
+++ b/arch/ia64/kernel/gate.S
@@ -10,7 +10,7 @@
 
 #include <asm/asmmacro.h>
 #include <asm/errno.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/sigcontext.h>
 #include <asm/system.h>
 #include <asm/unistd.h>
diff --git a/arch/ia64/kernel/head.S b/arch/ia64/kernel/head.S
--- a/arch/ia64/kernel/head.S
+++ b/arch/ia64/kernel/head.S
@@ -25,7 +25,7 @@
 #include <asm/fpu.h>
 #include <asm/kregs.h>
 #include <asm/mmu_context.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/pal.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
diff --git a/arch/ia64/kernel/ivt.S b/arch/ia64/kernel/ivt.S
--- a/arch/ia64/kernel/ivt.S
+++ b/arch/ia64/kernel/ivt.S
@@ -44,7 +44,7 @@
 #include <asm/break.h>
 #include <asm/ia32.h>
 #include <asm/kregs.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>


