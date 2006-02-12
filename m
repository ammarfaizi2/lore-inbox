Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWBLRsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWBLRsE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWBLRsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:48:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54277 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751321AbWBLRsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:48:03 -0500
Date: Sun, 12 Feb 2006 18:48:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] remove the CONFIG_CC_ALIGN_* options
Message-ID: <20060212174802.GJ30922@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see any use case for the CONFIG_CC_ALIGN_* options:
- they are only available if EMBEDDED
- people using EMBEDDED will most likely also enable 
  CC_OPTIMIZE_FOR_SIZE
- the default for -Os is to disable alignment


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Makefile     |    7 -------
 init/Kconfig |   37 -------------------------------------
 2 files changed, 44 deletions(-)

--- linux-2.6.16-rc2-mm1-full/init/Kconfig.old	2006-02-12 15:30:08.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/init/Kconfig	2006-02-12 15:30:53.000000000 +0100
@@ -353,45 +353,8 @@
 	  to userspace as tmpfs if TMPFS is enabled. Disabling this
 	  option replaces shmem and tmpfs with the much simpler ramfs code,
 	  which may be appropriate on small systems without swap.
 
-config CC_ALIGN_FUNCTIONS
-	int "Function alignment" if EMBEDDED
-	default 0
-	help
-	  Align the start of functions to the next power-of-two greater than n,
-	  skipping up to n bytes.  For instance, 32 aligns functions
-	  to the next 32-byte boundary, but 24 would align to the next
-	  32-byte boundary only if this can be done by skipping 23 bytes or less.
-	  Zero means use compiler's default.
-
-config CC_ALIGN_LABELS
-	int "Label alignment" if EMBEDDED
-	default 0
-	help
-	  Align all branch targets to a power-of-two boundary, skipping
-	  up to n bytes like ALIGN_FUNCTIONS.  This option can easily
-	  make code slower, because it must insert dummy operations for
-	  when the branch target is reached in the usual flow of the code.
-	  Zero means use compiler's default.
-
-config CC_ALIGN_LOOPS
-	int "Loop alignment" if EMBEDDED
-	default 0
-	help
-	  Align loops to a power-of-two boundary, skipping up to n bytes.
-	  Zero means use compiler's default.
-
-config CC_ALIGN_JUMPS
-	int "Jump alignment" if EMBEDDED
-	default 0
-	help
-	  Align branch targets to a power-of-two boundary, for branch
-	  targets where the targets can only be reached by jumping,
-	  skipping up to n bytes like ALIGN_FUNCTIONS.  In this case,
-	  no dummy operations need be executed.
-	  Zero means use compiler's default.
-
 config SLAB
 	default y
 	bool "Use full SLAB allocator" if EMBEDDED
 	help
--- linux-2.6.16-rc2-mm1-full/Makefile.old	2006-02-12 15:30:59.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/Makefile	2006-02-12 15:31:24.000000000 +0100
@@ -473,15 +473,8 @@
 else
 CFLAGS		+= -O2
 endif
 
-#Add align options if CONFIG_CC_* is not equal to 0
-add-align = $(if $(filter-out 0,$($(1))),$(cc-option-align)$(2)=$($(1)))
-CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_FUNCTIONS,-functions)
-CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_LABELS,-labels)
-CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_LOOPS,-loops)
-CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_JUMPS,-jumps)
-
 ifdef CONFIG_FRAME_POINTER
 CFLAGS		+= -fno-omit-frame-pointer $(call cc-option,-fno-optimize-sibling-calls,)
 else
 CFLAGS		+= -fomit-frame-pointer

