Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVC3Svs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVC3Svs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVC3Svs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:51:48 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:18062 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262391AbVC3SvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:51:21 -0500
Subject: [patch 4/8] uml: fixes a build failure with CONFIG_MODE_SKAS disabled [for 2.6.12]
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 30 Mar 2005 19:33:52 +0200
Message-Id: <20050330173352.720FDEFED2@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes a build failure (and also some warnings) when CONFIG_MODE_SKAS is
disabled.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/include/sysdep-i386/ptrace.h   |   16 +++++++-------
 linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/ptrace.h |    6 ++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff -puN arch/um/include/sysdep-i386/ptrace.h~uml-fix-comp-failure-config-mode-skas-disabled arch/um/include/sysdep-i386/ptrace.h
--- linux-2.6.11/arch/um/include/sysdep-i386/ptrace.h~uml-fix-comp-failure-config-mode-skas-disabled	2005-03-29 17:02:34.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/include/sysdep-i386/ptrace.h	2005-03-29 17:02:34.000000000 +0200
@@ -9,15 +9,11 @@
 #include "uml-config.h"
 #include "user_constants.h"
 
-#ifdef UML_CONFIG_MODE_TT
-#include "sysdep/sc.h"
-#endif
-
-#ifdef UML_CONFIG_MODE_SKAS
-
 #define MAX_REG_NR (UM_FRAME_SIZE / sizeof(unsigned long))
 #define MAX_REG_OFFSET (UM_FRAME_SIZE)
 
+extern void update_debugregs(int seq);
+
 /* syscall emulation path in ptrace */
 
 #ifndef PTRACE_SYSEMU
@@ -28,9 +24,13 @@ void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
 
-#include "skas_ptregs.h"
+#ifdef UML_CONFIG_MODE_TT
+#include "sysdep/sc.h"
+#endif
 
-extern void update_debugregs(int seq);
+#ifdef UML_CONFIG_MODE_SKAS
+
+#include "skas_ptregs.h"
 
 #define REGS_IP(r) ((r)[HOST_IP])
 #define REGS_SP(r) ((r)[HOST_SP])
diff -puN arch/um/include/sysdep-x86_64/ptrace.h~uml-fix-comp-failure-config-mode-skas-disabled arch/um/include/sysdep-x86_64/ptrace.h
--- linux-2.6.11/arch/um/include/sysdep-x86_64/ptrace.h~uml-fix-comp-failure-config-mode-skas-disabled	2005-03-29 17:02:34.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/ptrace.h	2005-03-29 17:02:34.000000000 +0200
@@ -10,6 +10,9 @@
 #include "uml-config.h"
 #include "user_constants.h"
 
+#define MAX_REG_OFFSET (UM_FRAME_SIZE)
+#define MAX_REG_NR ((MAX_REG_OFFSET) / sizeof(unsigned long))
+
 #ifdef UML_CONFIG_MODE_TT
 #include "sysdep/sc.h"
 #endif
@@ -17,9 +20,6 @@
 #ifdef UML_CONFIG_MODE_SKAS
 #include "skas_ptregs.h"
 
-#define MAX_REG_OFFSET (UM_FRAME_SIZE)
-#define MAX_REG_NR ((MAX_REG_OFFSET) / sizeof(unsigned long))
-
 #define REGS_IP(r) ((r)[HOST_IP])
 #define REGS_SP(r) ((r)[HOST_SP])
 
_
