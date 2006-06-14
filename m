Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWFNORs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWFNORs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWFNORr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:17:47 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:17841 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S964967AbWFNORq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:17:46 -0400
Date: Wed, 14 Jun 2006 16:17:33 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/8] lock validator: s390 CONFIG_FRAME_POINTER support
Message-ID: <20060614141733.GC1241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

CONFIG_FRAME_POINTER support for s390.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/Makefile |    5 +++++
 lib/Kconfig.debug  |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff -purN a/arch/s390/Makefile b/arch/s390/Makefile
--- a/arch/s390/Makefile	2006-06-14 10:56:55.000000000 +0200
+++ b/arch/s390/Makefile	2006-06-14 12:51:12.000000000 +0200
@@ -38,6 +38,11 @@ cflags-$(CONFIG_MARCH_G5)   += $(call cc
 cflags-$(CONFIG_MARCH_Z900) += $(call cc-option,-march=z900)
 cflags-$(CONFIG_MARCH_Z990) += $(call cc-option,-march=z990)
 
+#
+# Prevent tail-call optimizations, to get clearer backtraces:
+#
+cflags-$(CONFIG_FRAME_POINTER) += -fno-optimize-sibling-calls
+
 # old style option for packed stacks
 ifeq ($(call cc-option-yn,-mkernel-backchain),y)
 cflags-$(CONFIG_PACK_STACK)  += -mkernel-backchain -D__PACK_STACK
diff -purN a/lib/Kconfig.debug b/lib/Kconfig.debug
--- a/lib/Kconfig.debug	2006-06-14 10:57:14.000000000 +0200
+++ b/lib/Kconfig.debug	2006-06-14 12:51:51.000000000 +0200
@@ -503,7 +503,7 @@ config DEBUG_VM
 
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
-	depends on DEBUG_KERNEL && (X86 || CRIS || M68K || M68KNOMMU || FRV || UML)
+	depends on DEBUG_KERNEL && (X86 || CRIS || M68K || M68KNOMMU || FRV || UML || S390)
 	default y
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
