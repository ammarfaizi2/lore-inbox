Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWDCSzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWDCSzU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 14:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWDCSzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 14:55:20 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:32017 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750955AbWDCSzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 14:55:19 -0400
Date: Mon, 3 Apr 2006 20:55:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86_64: fix CONFIG_REORDER
Message-ID: <20060403185503.GA22440@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix CONFIG_REORDER.
Value of cflags-y was assined to CFLAGS before cflags-y was
assinged the value used for CONFIG_REORDER.
Use cflags-y for all CFLAGS options in the Makefile to avoid this
happening again.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
index 585fd4a..7bc501e 100644
--- a/arch/x86_64/Makefile
+++ b/arch/x86_64/Makefile
@@ -24,37 +24,37 @@
 LDFLAGS		:= -m elf_x86_64
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux :=
-
 CHECKFLAGS      += -D__x86_64__ -m64
 
+cflags-y	:=
 cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
 cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
 cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
-CFLAGS += $(cflags-y)
 
-CFLAGS += -m64
-CFLAGS += -mno-red-zone
-CFLAGS += -mcmodel=kernel
-CFLAGS += -pipe
+cflags-y += -m64
+cflags-y += -mno-red-zone
+cflags-y += -mcmodel=kernel
+cflags-y += -pipe
 cflags-$(CONFIG_REORDER) += -ffunction-sections
 # this makes reading assembly source easier, but produces worse code
 # actually it makes the kernel smaller too.
-CFLAGS += -fno-reorder-blocks	
-CFLAGS += -Wno-sign-compare
+cflags-y += -fno-reorder-blocks
+cflags-y += -Wno-sign-compare
 ifneq ($(CONFIG_UNWIND_INFO),y)
-CFLAGS += -fno-asynchronous-unwind-tables
+cflags-y += -fno-asynchronous-unwind-tables
 endif
 ifneq ($(CONFIG_DEBUG_INFO),y)
 # -fweb shrinks the kernel a bit, but the difference is very small
 # it also messes up debugging, so don't use it for now.
-#CFLAGS += $(call cc-option,-fweb)
+#cflags-y += $(call cc-option,-fweb)
 endif
 # -funit-at-a-time shrinks the kernel .text considerably
 # unfortunately it makes reading oopses harder.
-CFLAGS += $(call cc-option,-funit-at-a-time)
+cflags-y += $(call cc-option,-funit-at-a-time)
 # prevent gcc from generating any FP code by mistake
-CFLAGS += $(call cc-option,-mno-sse -mno-mmx -mno-sse2 -mno-3dnow,)
+cflags-y += $(call cc-option,-mno-sse -mno-mmx -mno-sse2 -mno-3dnow,)
 
+CFLAGS += $(cflags-y)
 AFLAGS += -m64
 
 head-y := arch/x86_64/kernel/head.o arch/x86_64/kernel/head64.o arch/x86_64/kernel/init_task.o
