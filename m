Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVLZVIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVLZVIF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 16:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVLZVIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 16:08:05 -0500
Received: from host3-98.pool876.interbusiness.it ([87.6.98.3]:51647 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932151AbVLZVIC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 16:08:02 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] PTRACE_SYSEMU: declare only for i386 and avoid clashes
Date: Mon, 26 Dec 2005 22:07:40 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051226210739.13882.10163.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

PTRACE_SYSEMU{,_SINGLESTEP} is actually i386-specific, for now, and the current
allocated number clashes with a ptrace code of frv, i.e. PTRACE_GETFDPIC. So,
make the declaration local to i386 headers. When we'll port this to other archs,
we'll use a better value for the constant (from the arch-independent range).

I should have submitted this much earlier, anyway we get no breakage for the
delay.

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

