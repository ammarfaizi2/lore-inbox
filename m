Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbVIIWka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbVIIWka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030465AbVIIWkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:40:25 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:52340 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932611AbVIIWkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:40:21 -0400
Cc: Sam Ravnborg <sam@mars (none)>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 2/12] kbuild: h8300,m68knommu,sh,sh64 use generic asm-offsets.h support
In-Reply-To: <11263057053061-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Sat, 10 Sep 2005 00:41:46 +0200
Message-Id: <11263057062281-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

h8300, m68knommu, sh and sh64 all used the name asm-offsets.h so minimal
changes required.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/h8300/Makefile     |    8 --------
 arch/m68knommu/Makefile |   10 ----------
 arch/sh/Makefile        |   11 ++---------
 arch/sh64/Makefile      |    8 ++------
 4 files changed, 4 insertions(+), 33 deletions(-)

cca6e6f5f473ec63e85c87dfc77279ce1ca114e6
diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -61,12 +61,6 @@ archmrproper:
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-prepare: include/asm-$(ARCH)/asm-offsets.h
-
-include/asm-$(ARCH)/asm-offsets.h: arch/$(ARCH)/kernel/asm-offsets.s \
-				   include/asm include/linux/version.h
-	$(call filechk,gen-asm-offsets)
-
 vmlinux.srec vmlinux.bin: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
@@ -74,5 +68,3 @@ define archhelp
   echo  'vmlinux.bin  - Create raw binary'
   echo  'vmlinux.srec - Create srec binary'
 endef
-
-CLEAN_FILES += include/asm-$(ARCH)/asm-offsets.h
diff --git a/arch/m68knommu/Makefile b/arch/m68knommu/Makefile
--- a/arch/m68knommu/Makefile
+++ b/arch/m68knommu/Makefile
@@ -102,21 +102,11 @@ CFLAGS += -DUTS_SYSNAME=\"uClinux\"
 
 head-y := arch/m68knommu/platform/$(cpuclass-y)/head.o
 
-CLEAN_FILES := include/asm-$(ARCH)/asm-offsets.h \
-	       arch/$(ARCH)/kernel/asm-offsets.s
-
 core-y	+= arch/m68knommu/kernel/ \
 	   arch/m68knommu/mm/ \
 	   $(CLASSDIR) \
 	   arch/m68knommu/platform/$(PLATFORM)/
 libs-y	+= arch/m68knommu/lib/
 
-prepare: include/asm-$(ARCH)/asm-offsets.h
-
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/m68knommu/boot
-
-include/asm-$(ARCH)/asm-offsets.h: arch/$(ARCH)/kernel/asm-offsets.s \
-				   include/asm include/linux/version.h \
-				   include/config/MARKER
-	$(call filechk,gen-asm-offsets)
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -155,7 +155,7 @@ endif
 prepare: maketools include/asm-sh/.cpu include/asm-sh/.mach
 
 .PHONY: maketools FORCE
-maketools: include/asm-sh/asm-offsets.h include/linux/version.h FORCE
+maketools:  include/linux/version.h FORCE
 	$(Q)$(MAKE) $(build)=arch/sh/tools include/asm-sh/machtypes.h
 
 all: zImage
@@ -168,14 +168,7 @@ compressed: zImage
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-CLEAN_FILES += include/asm-sh/machtypes.h include/asm-sh/asm-offsets.h
-
-arch/sh/kernel/asm-offsets.s: include/asm include/linux/version.h \
-			      include/asm-sh/.cpu include/asm-sh/.mach
-
-include/asm-sh/asm-offsets.h: arch/sh/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
+CLEAN_FILES += include/asm-sh/machtypes.h
 
 define archhelp
 	@echo '  zImage 	           - Compressed kernel image (arch/sh/boot/zImage)'
diff --git a/arch/sh64/Makefile b/arch/sh64/Makefile
--- a/arch/sh64/Makefile
+++ b/arch/sh64/Makefile
@@ -73,11 +73,7 @@ compressed: zImage
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-prepare: include/asm-$(ARCH)/asm-offsets.h arch/$(ARCH)/lib/syscalltab.h
-
-include/asm-$(ARCH)/asm-offsets.h: arch/$(ARCH)/kernel/asm-offsets.s \
-				   include/asm include/linux/version.h
-	$(call filechk,gen-asm-offsets)
+prepare: arch/$(ARCH)/lib/syscalltab.h
 
 define filechk_gen-syscalltab
        (set -e; \
@@ -108,7 +104,7 @@ endef
 arch/$(ARCH)/lib/syscalltab.h: arch/sh64/kernel/syscalls.S
 	$(call filechk,gen-syscalltab)
 
-CLEAN_FILES += include/asm-$(ARCH)/asm-offsets.h arch/$(ARCH)/lib/syscalltab.h
+CLEAN_FILES += arch/$(ARCH)/lib/syscalltab.h
 
 define archhelp
 	@echo '  zImage 	           - Compressed kernel image (arch/sh64/boot/zImage)'


