Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbUKATlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbUKATlj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270615AbUKATgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 14:36:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61382 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S291945AbUKATao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:30:44 -0500
Date: Mon, 1 Nov 2004 19:30:22 GMT
Message-Id: <200411011930.iA1JUMgs023243@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 12/14] FRV: Generate more useful debug info
In-Reply-To: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch permits the generation of more useful debugging information
by reducing the optimisation level and by telling the assembler to produce
debug info too.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-debuginfo-2610rc1bk10.diff
 Makefile |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/Makefile linux-2.6.10-rc1-bk10-frv/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-bk10/Makefile	2004-11-01 11:45:20.000000000 +0000
+++ linux-2.6.10-rc1-bk10-frv/Makefile	2004-11-01 11:48:36.397037723 +0000
@@ -497,11 +497,18 @@
 # Defaults vmlinux but it is usually overriden in the arch makefile
 all: vmlinux
 
+
+ifdef CONFIG_DEBUG_INFO
+CFLAGS		+= -g -O1
+AFLAGS		+= -Wa,--gdwarf2
+ASFLAGS		+= -Wa,--gdwarf2
+else
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 CFLAGS		+= -Os
 else
 CFLAGS		+= -O2
 endif
+endif
 
 #Add align options if CONFIG_CC_* is not equal to 0
 add-align = $(if $(filter-out 0,$($(1))),$(cc-option-align)$(2)=$($(1)))
@@ -516,10 +523,6 @@
 CFLAGS		+= -fomit-frame-pointer
 endif
 
-ifdef CONFIG_DEBUG_INFO
-CFLAGS		+= -g
-endif
-
 include $(srctree)/arch/$(ARCH)/Makefile
 
 # warn about C99 declaration after statement
