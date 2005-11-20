Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVKTTKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVKTTKE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 14:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKTTKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 14:10:03 -0500
Received: from host222-100.pool871.interbusiness.it ([87.1.100.222]:30148 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750794AbVKTTKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 14:10:01 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/2] PTRACE_SYSEMU is only for i386 and clashes with other ptrace codes of other archs
Date: Sun, 20 Nov 2005 20:09:09 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051120190908.4091.86123.stgit@zion.home.lan>
In-Reply-To: <20051120190905.4091.60463.stgit@zion.home.lan>
References: <20051120190905.4091.60463.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

PTRACE_SYSEMU{,_SINGLESTEP} is actually arch specific, for now, and the current
allocated number clashes with a ptrace code of frv, i.e. PTRACE_GETFDPIC. I
should have submitted this much earlier, anyway we get no breakage for this.

CC: Daniel Jacobowitz <dan@debian.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-i386/ptrace.h |    3 +++
 include/linux/ptrace.h    |    2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-i386/ptrace.h b/include/asm-i386/ptrace.h
index 7e0f294..f324c53 100644
--- a/include/asm-i386/ptrace.h
+++ b/include/asm-i386/ptrace.h
@@ -54,6 +54,9 @@ struct pt_regs {
 #define PTRACE_GET_THREAD_AREA    25
 #define PTRACE_SET_THREAD_AREA    26
 
+#define PTRACE_SYSEMU		  31
+#define PTRACE_SYSEMU_SINGLESTEP  32
+
 #ifdef __KERNEL__
 
 #include <asm/vm86.h>
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index b2b3dba..8b64478 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -20,8 +20,6 @@
 #define PTRACE_DETACH		0x11
 
 #define PTRACE_SYSCALL		  24
-#define PTRACE_SYSEMU		  31
-#define PTRACE_SYSEMU_SINGLESTEP  32
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200

