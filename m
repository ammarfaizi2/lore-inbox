Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVL2QmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVL2QmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVL2QlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:41:15 -0500
Received: from host3-98.pool876.interbusiness.it ([87.6.98.3]:52898 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750818AbVL2Qks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:40:48 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 5/5] uml: fix compilation with CONFIG_MODE_TT disabled
Date: Thu, 29 Dec 2005 17:40:02 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051229164001.4985.66325.stgit@zion.home.lan>
In-Reply-To: <20051229163803.4985.66742.stgit@zion.home.lan>
References: <20051229163803.4985.66742.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix UML compilation when SKAS mode is disabled. Indeed, we were compiling
SKAS-only object files, which failed due to some SKAS-only headers being
excluded from the search path.

Thanks to the bug report from Pekka J Enberg.

Acked-by: Pekka J Enberg <penberg (at) cs ! helsinki ! fi>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/sys-i386/Makefile   |    8 +++++---
 arch/um/sys-x86_64/Makefile |    5 +++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/um/sys-i386/Makefile b/arch/um/sys-i386/Makefile
index 150059d..f5fd5b0 100644
--- a/arch/um/sys-i386/Makefile
+++ b/arch/um/sys-i386/Makefile
@@ -1,6 +1,8 @@
-obj-y = bitops.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
-	ptrace_user.o semaphore.o signal.o sigcontext.o stub.o stub_segv.o \
-	syscalls.o sysrq.o sys_call_table.o
+obj-y := bitops.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
+	ptrace_user.o semaphore.o signal.o sigcontext.o syscalls.o sysrq.o \
+	sys_call_table.o
+
+obj-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
diff --git a/arch/um/sys-x86_64/Makefile b/arch/um/sys-x86_64/Makefile
index 00b2025..a351091 100644
--- a/arch/um/sys-x86_64/Makefile
+++ b/arch/um/sys-x86_64/Makefile
@@ -6,8 +6,9 @@
 
 #XXX: why into lib-y?
 lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o ldt.o mem.o memcpy.o \
-	ptrace.o ptrace_user.o sigcontext.o signal.o stub.o \
-	stub_segv.o syscalls.o syscall_table.o sysrq.o thunk.o
+	ptrace.o ptrace_user.o sigcontext.o signal.o syscalls.o \
+	syscall_table.o sysrq.o thunk.o
+lib-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
 
 obj-y := ksyms.o
 obj-$(CONFIG_MODULES) += module.o um_module.o

