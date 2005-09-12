Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVILF5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVILF5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 01:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVILF5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 01:57:24 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:25314 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP
	id S1750749AbVILF5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 01:57:24 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Sam Ravnborg'" <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Cc: "'Sam Ravnborg'" <sam@mars (none)>
Subject: RE: [PATCH 10/12] kbuild: cris use generic asm-offsets.h support
Date: Mon, 12 Sep 2005 07:57:15 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668030B4E3F@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66803377FF8@exmail1.se.axis.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, that is consistent with rest of the CRIS stuff. What would you consider
to be good practice?

Acked-by: Mikael Starvik <starvik@axis.com>

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Sam Ravnborg
Sent: Saturday, September 10, 2005 12:42 AM
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg; Sam Ravnborg
Subject: [PATCH 10/12] kbuild: cris use generic asm-offsets.h support


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
 	@ln -sfn $(SRC_ARCH)/$(SARCH)/vmlinux.lds.S
$(SRC_ARCH)/kernel/vmlinux.lds.S
+	@ln -sfn $(SRC_ARCH)/$(SARCH)/asm-offsets.c
$(SRC_ARCH)/kernel/asm-offsets.c
 	@touch $@
 
 # Create link to sub arch includes
@@ -128,9 +128,3 @@ $(srctree)/include/asm-$(ARCH)/.arch: $(
 	@rm -f include/asm-$(ARCH)/arch
 	@ln -sf $(srctree)/include/asm-$(ARCH)/$(SARCH)
$(srctree)/include/asm-$(ARCH)/arch
 	@touch $@
-
-arch/$(ARCH)/$(SARCH)/kernel/asm-offsets.s: include/asm
include/linux/version.h \
-					include/config/MARKER
-
-include/asm-$(ARCH)/$(SARCH)/offset.h:
arch/$(ARCH)/$(SARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
diff --git a/arch/cris/arch-v10/kernel/entry.S
b/arch/cris/arch-v10/kernel/entry.S
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
 
diff --git a/arch/cris/arch-v32/kernel/entry.S
b/arch/cris/arch-v32/kernel/entry.S
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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

