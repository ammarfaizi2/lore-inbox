Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752617AbWAHMlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbWAHMlV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 07:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbWAHMlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 07:41:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45578 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752617AbWAHMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 07:41:21 -0500
Date: Sun, 8 Jan 2006 13:41:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [-mm patch] more UID16 fixes
Message-ID: <20060108124119.GH3774@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the "make UID16 support optional" patch was checked when it 
edited the -tiny tree some time ago, but it wasn't checked whether it
still matches the current situation when it was submitted for inclusion 
in -mm. This patch fixes the following bugs:
- ARCH_S390X does no longer exist, nowadays this has to be expressed
  through (S390 && 64BIT)
- in five architecture specific Kconfig files the UID16 options
  weren't removed

Additionally, it changes the fragile negative dependencies of UID16 to 
positive dependencies (new architectures are more likely to not 
require UID16 support).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/frv/Kconfig    |    4 ----
 arch/m32r/Kconfig   |    4 ----
 arch/s390/Kconfig   |    5 -----
 arch/sh64/Kconfig   |    4 ----
 arch/xtensa/Kconfig |    4 ----
 init/Kconfig        |    4 +---
 6 files changed, 1 insertion(+), 24 deletions(-)

--- linux-2.6.15-mm2-full/init/Kconfig.old	2006-01-08 13:23:18.000000000 +0100
+++ linux-2.6.15-mm2-full/init/Kconfig	2006-01-08 13:29:38.000000000 +0100
@@ -230,9 +230,7 @@
 
 config UID16
 	bool "Enable 16-bit UID system calls" if EMBEDDED
-	depends !ALPHA && !PPC && !PPC64 && !PARISC && !V850 && !ARCH_S390X
-	depends !X86_64 || IA32_EMULATION
-	depends !SPARC64 || SPARC32_COMPAT
+	depends on ARM || CRIS || FRV || H8300 || X86_32 || M68K || (S390 && !64BIT) || SUPERH || SPARC32 || (SPARC64 && SPARC32_COMPAT) || UML || (X86_64 && IA32_EMULATION)
 	default y
 	help
 	  This enables the legacy 16-bit UID syscall wrappers.
--- linux-2.6.15-mm2-full/arch/frv/Kconfig.old	2006-01-08 13:27:51.000000000 +0100
+++ linux-2.6.15-mm2-full/arch/frv/Kconfig	2006-01-08 13:28:00.000000000 +0100
@@ -6,10 +6,6 @@
 	bool
 	default y
 
-config UID16
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
--- linux-2.6.15-mm2-full/arch/m32r/Kconfig.old	2006-01-08 13:28:18.000000000 +0100
+++ linux-2.6.15-mm2-full/arch/m32r/Kconfig	2006-01-08 13:28:24.000000000 +0100
@@ -12,10 +12,6 @@
 config SBUS
 	bool
 
-config UID16
-	bool
-	default n
-
 config GENERIC_ISA_DMA
 	bool
 	default y
--- linux-2.6.15-mm2-full/arch/s390/Kconfig.old	2006-01-08 13:28:32.000000000 +0100
+++ linux-2.6.15-mm2-full/arch/s390/Kconfig	2006-01-08 13:28:49.000000000 +0100
@@ -27,11 +27,6 @@
 	bool
 	default y
 
-config UID16
-	bool
-	default y
-	depends on !64BIT
-
 source "init/Kconfig"
 
 menu "Base setup"
--- linux-2.6.15-mm2-full/arch/sh64/Kconfig.old	2006-01-08 13:30:08.000000000 +0100
+++ linux-2.6.15-mm2-full/arch/sh64/Kconfig	2006-01-08 13:30:15.000000000 +0100
@@ -17,10 +17,6 @@
 	bool
 	default y
 
-config UID16
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
--- linux-2.6.15-mm2-full/arch/xtensa/Kconfig.old	2006-01-08 13:30:36.000000000 +0100
+++ linux-2.6.15-mm2-full/arch/xtensa/Kconfig	2006-01-08 13:30:42.000000000 +0100
@@ -18,10 +18,6 @@
 	  with reasonable minimum requirements.  The Xtensa Linux project has
 	  a home page at <http://xtensa.sourceforge.net/>.
 
-config UID16
-	bool
-	default n
-
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y

