Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVDXSUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVDXSUT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 14:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVDXSUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 14:20:18 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:9629 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262366AbVDXSUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 14:20:10 -0400
Subject: [patch 2/6] uml: add nfsd syscall when nfsd is modular [for 2.6.12]
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sun, 24 Apr 2005 20:09:58 +0200
Message-Id: <20050424180959.3F78A55CFB@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This trick is useless, because sys_ni.c will handle this problem by itself,
like it does even on UML for other syscalls.
Also, it does not provide the NFSD syscall when NFSD is compiled as a module,
which is a big problem.

This should be merged currently in both 2.6.11-stable and the current tree.

I already sent it for -stable, it's already in -mm but not in -rc3, now it
should be merged in 2.6.12. It has already been tested in 2.6.11-bs4 and it's
fairly trivial.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/kernel/sys_call_table.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

diff -puN arch/um/kernel/sys_call_table.c~uml-nfsd-syscall arch/um/kernel/sys_call_table.c
--- linux-2.6.12/arch/um/kernel/sys_call_table.c~uml-nfsd-syscall	2005-04-24 19:32:15.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/sys_call_table.c	2005-04-24 19:32:15.000000000 +0200
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
@@ -189,7 +183,7 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_getresuid ] = (syscall_handler_t *) sys_getresuid16,
 	[ __NR_query_module ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_poll ] = (syscall_handler_t *) sys_poll,
-	[ __NR_nfsservctl ] = (syscall_handler_t *) NFSSERVCTL,
+	[ __NR_nfsservctl ] = (syscall_handler_t *) sys_nfsservctl,
 	[ __NR_setresgid ] = (syscall_handler_t *) sys_setresgid16,
 	[ __NR_getresgid ] = (syscall_handler_t *) sys_getresgid16,
 	[ __NR_prctl ] = (syscall_handler_t *) sys_prctl,
_
