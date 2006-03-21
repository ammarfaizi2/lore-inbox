Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWCUQ3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWCUQ3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWCUQ2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:28:52 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:39436 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030404AbWCUQVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:16 -0500
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 43/46] Kconfig: remove the CONFIG_CC_ALIGN_* options
In-Reply-To: <11429580574142-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:57 +0100
Message-Id: <11429580571198-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see any use case for the CONFIG_CC_ALIGN_* options:
- they are only available if EMBEDDED
- people using EMBEDDED will most likely also enable
  CC_OPTIMIZE_FOR_SIZE
- the default for -Os is to disable alignment

In case someone is doing performance comparisons and discovers that the
default settings gcc chooses aren't good, the only sane thing is to discuss
whether it makes sense to change this, not through offering options to change
this locally.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile     |    7 -------
 init/Kconfig |   37 -------------------------------------
 2 files changed, 0 insertions(+), 44 deletions(-)

8cab77a2f851363e35089b9720373b964f64550e
diff --git a/Makefile b/Makefile
index eca667b..3dbaac6 100644
--- a/Makefile
+++ b/Makefile
@@ -472,13 +472,6 @@ else
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
diff --git a/init/Kconfig b/init/Kconfig
index 38416a1..411600c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -354,43 +354,6 @@ config SHMEM
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
-- 
1.0.GIT


