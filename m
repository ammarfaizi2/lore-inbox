Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVEAVYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVEAVYs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbVEAVYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:24:34 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:28691 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262693AbVEAVSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:35 -0400
Message-Id: <200505012113.j41LD94P016498@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       bstroesser@fujitsu-siemens.com
Subject: [PATCH 22/22] UML - Header and code cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:13:09 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Remove some definitions and declarations from
arch/um/include/skas_ptrace.h, as they have moved to
arch/um/include/sysdep/skas_ptrace.h
Also, remove PTRACE_SIGPENDING support in UML at all.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -puN arch/um/include/skas_ptrace.h~fix-skas_ptrace.h arch/um/include/skas_ptrace.h
--- linux-2.6.11/arch/um/include/skas_ptrace.h~fix-skas_ptrace.h	2005-04-06 14:22:17.000000000 +0200
+++ linux-2.6.11-root/arch/um/include/skas_ptrace.h	2005-04-06 14:22:17.000000000 +0200
@@ -6,22 +6,11 @@
 #ifndef __SKAS_PTRACE_H
 #define __SKAS_PTRACE_H
 
-struct ptrace_faultinfo {
-	int is_write;
-	unsigned long addr;
-};
-
-struct ptrace_ldt {
-	int func;
-  	void *ptr;
-	unsigned long bytecount;
-};
-
 #define PTRACE_FAULTINFO 52
-#define PTRACE_SIGPENDING 53
-#define PTRACE_LDT 54
 #define PTRACE_SWITCH_MM 55
 
+#include "sysdep/skas_ptrace.h"
+
 #endif
 
 /*
diff -puN arch/um/kernel/ptrace.c~fix-skas_ptrace.h arch/um/kernel/ptrace.c
--- linux-2.6.11/arch/um/kernel/ptrace.c~fix-skas_ptrace.h	2005-04-06 14:22:17.000000000 +0200
+++ linux-2.6.11-root/arch/um/kernel/ptrace.c	2005-04-06 14:22:17.000000000 +0200
@@ -242,11 +242,6 @@ long sys_ptrace(long request, long pid, 
 			break;
 		break;
 	}
-	case PTRACE_SIGPENDING:
-		ret = copy_to_user((unsigned long __user *) data,
-				   &child->pending.signal,
-				   sizeof(child->pending.signal));
-		break;
 
 #ifdef PTRACE_LDT
 	case PTRACE_LDT: {
_

