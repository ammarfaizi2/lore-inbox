Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVDLRtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVDLRtB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVDLRrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 13:47:19 -0400
Received: from [151.97.230.9] ([151.97.230.9]:18193 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S262525AbVDLRpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:45:19 -0400
Subject: [patch 1/1] uml: add nfsd syscall when nfsd is modular
To: akpm@osdl.org
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       blaisorblade@yahoo.it, stable@kernel.org
From: blaisorblade@yahoo.it
Date: Tue, 12 Apr 2005 19:52:08 +0200
Message-Id: <20050412175209.10A11126095@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: <stable@kernel.org>

This trick is useless, because sys_ni.c will handle this problem by itself,
like it does even on UML for other syscalls.
Also, it does not provide the NFSD syscall when NFSD is compiled as a module,
which is a big problem.

This should be merged currently in both 2.6.11-stable and the current tree.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 clean-linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

diff -puN arch/um/kernel/sys_call_table.c~uml-nfsd-syscall arch/um/kernel/sys_call_table.c
--- clean-linux-2.6.11/arch/um/kernel/sys_call_table.c~uml-nfsd-syscall	2005-04-10 13:50:29.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c	2005-04-10 13:51:19.000000000 +0200
@@ -14,12 +14,6 @@
 #include "sysdep/syscalls.h"
 #include "kern_util.h"
 
-#ifdef CONFIG_NFSD
-#define NFSSERVCTL sys_nfsservctl
-#else
-#define NFSSERVCTL sys_ni_syscall
-#endif
-
 #define LAST_GENERIC_SYSCALL __NR_keyctl
 
 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
@@ -190,7 +184,7 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_getresuid ] = (syscall_handler_t *) sys_getresuid16,
 	[ __NR_query_module ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_poll ] = (syscall_handler_t *) sys_poll,
-	[ __NR_nfsservctl ] = (syscall_handler_t *) NFSSERVCTL,
+	[ __NR_nfsservctl ] = (syscall_handler_t *) sys_nfsservctl,
 	[ __NR_setresgid ] = (syscall_handler_t *) sys_setresgid16,
 	[ __NR_getresgid ] = (syscall_handler_t *) sys_getresgid16,
 	[ __NR_prctl ] = (syscall_handler_t *) sys_prctl,
_
