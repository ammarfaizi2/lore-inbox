Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbTDAWMM>; Tue, 1 Apr 2003 17:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbTDAWMM>; Tue, 1 Apr 2003 17:12:12 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:32495 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262881AbTDAWML>; Tue, 1 Apr 2003 17:12:11 -0500
Date: Tue, 1 Apr 2003 23:25:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] -mm traps.c warning
Message-ID: <Pine.LNX.4.44.0304012324090.1730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stop -mm compiler warning when CONFIG_KGDB is off
(you'll forgive an early return in this instance).

--- 2.5.66-mm2/arch/i386/kernel/traps.c	Tue Apr  1 11:25:39 2003
+++ linux/arch/i386/kernel/traps.c	Tue Apr  1 19:22:30 2003
@@ -380,10 +380,8 @@
 #define DO_VM86_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
-	CHK_REMOTE_DEBUG(trapnr,signr,error_code,regs,goto skip_trap)\
+	CHK_REMOTE_DEBUG(trapnr,signr,error_code,regs,return)\
 	do_trap(trapnr, signr, str, 1, regs, error_code, NULL); \
-skip_trap: \
-	return; \
 }
 
 #define DO_VM86_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \

