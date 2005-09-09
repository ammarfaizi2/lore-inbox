Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbVIIWnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbVIIWnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbVIIWlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:41:50 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:54604 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1030459AbVIIWkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:40:24 -0400
Cc: Sam Ravnborg <sam@mars (none)>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 10/12] kbuild: cris use generic asm-offsets.h support
In-Reply-To: <11263057061465-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Sat, 10 Sep 2005 00:41:46 +0200
Message-Id: <11263057062257-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cris has a dedicated asm-offsets.c file per subarchitecture.
So a symlink is created to put the desired asm-offsets.c file
in $(ARCH)/kernel
This is absolutely not good practice, but it was the trick
used in the rest of the cris code.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/cris/Makefile                |   10 ++--------
 arch/cris/arch-v10/kernel/entry.S |    2 +-
 arch/cris/arch-v32/kernel/entry.S |    2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

5a0773698c51fdcec7eb361b6b819669ed1d249e
diff --git a/arch/cris/Makefile b/arch/cris/Makefile
--- a/arch/cris/Makefile
+++ b/arch/cris/Makefile
@@ -107,8 +107,7 @@ archclean:
 	rm -f timage vmlinux.bin decompress.bin rescue.bin cramfs.img
 	rm -rf $(LD_SCRIPT).tmp
 
-prepare: $(SRC_ARCH)/.links $(srctree)/include/asm-$(ARCH)/.arch \
-	 include/asm-$(ARCH)/$(SARCH)/offset.h
+prepare: $(SRC_ARCH)/.links $(srctree)/include/asm-$(ARCH)/.arch
 
 # Create some links to make all tools happy
 $(SRC_ARCH)/.links:
@@ -120,6 +119,7 @@ $(SRC_ARCH)/.links:
 	@ln -sfn $(SRC_ARCH)/$(SARCH)/lib $(SRC_ARCH)/lib
 	@ln -sfn $(SRC_ARCH)/$(SARCH) $(SRC_ARCH)/arch
 	@ln -sfn $(SRC_ARCH)/$(SARCH)/vmlinux.lds.S $(SRC_ARCH)/kernel/vmlinux.lds.S
+	@ln -sfn $(SRC_ARCH)/$(SARCH)/asm-offsets.c $(SRC_ARCH)/kernel/asm-offsets.c
 	@touch $@
 
 # Create link to sub arch includes
@@ -128,9 +128,3 @@ $(srctree)/include/asm-$(ARCH)/.arch: $(
 	@rm -f include/asm-$(ARCH)/arch
 	@ln -sf $(srctree)/include/asm-$(ARCH)/$(SARCH) $(srctree)/include/asm-$(ARCH)/arch
 	@touch $@
-
-arch/$(ARCH)/$(SARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-					include/config/MARKER
-
-include/asm-$(ARCH)/$(SARCH)/offset.h: arch/$(ARCH)/$(SARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
diff --git a/arch/cris/arch-v10/kernel/entry.S b/arch/cris/arch-v10/kernel/entry.S
--- a/arch/cris/arch-v10/kernel/entry.S
+++ b/arch/cris/arch-v10/kernel/entry.S
@@ -270,7 +270,7 @@
 #include <asm/arch/sv_addr_ag.h>
 #include <asm/errno.h>
 #include <asm/thread_info.h>
-#include <asm/arch/offset.h>
+#include <asm/asm-offsets.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
diff --git a/arch/cris/arch-v32/kernel/entry.S b/arch/cris/arch-v32/kernel/entry.S
--- a/arch/cris/arch-v32/kernel/entry.S
+++ b/arch/cris/arch-v32/kernel/entry.S
@@ -23,7 +23,7 @@
 #include <asm/unistd.h>
 #include <asm/errno.h>
 #include <asm/thread_info.h>
-#include <asm/arch/offset.h>
+#include <asm/asm-offsets.h>
 
 #include <asm/arch/hwregs/asm/reg_map_asm.h>
 #include <asm/arch/hwregs/asm/intr_vect_defs_asm.h>


