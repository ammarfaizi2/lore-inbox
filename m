Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbULYNmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbULYNmC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 08:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbULYNln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 08:41:43 -0500
Received: from golobica.uni-mb.si ([164.8.100.4]:44240 "EHLO
	golobica.uni-mb.si") by vger.kernel.org with ESMTP id S261467AbULYNla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 08:41:30 -0500
Subject: [patch 2/4] delete unused file
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 25 Dec 2004 14:41:32 +0100
Message-Id: <20041225134123.083C04DC19A@golobica.uni-mb.si>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/arch/alpha/lib/dbg_stackkill.S |   35 -----------------------------------
 1 files changed, 35 deletions(-)

diff -L arch/alpha/lib/dbg_stackkill.S -puN arch/alpha/lib/dbg_stackkill.S~remove_file-arch_alpha_lib_dbg_stackkill.S /dev/null
--- kj/arch/alpha/lib/dbg_stackkill.S
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,35 +0,0 @@
-/*
- * arch/alpha/lib/killstack.S
- * Contributed by Richard Henderson (rth@cygnus.com)
- *
- * Clobber the balance of the kernel stack, hoping to catch
- * uninitialized local variables in the act.
- */
-
-#include <asm/asm_offsets.h>
-
-	.text
-	.set noat
-
-	.align 5
-	.globl _mcount
-	.ent _mcount
-_mcount:
-	.frame $30, 0, $28, 0
-	.prologue 0
-
-	ldi	$0, 0xdeadbeef
-	lda	$2, -STACK_SIZE
-	sll	$0, 32, $1
-	and	$30, $2, $2
-	or	$0, $1, $0
-	lda	$2, TASK_SIZE($2)
-	cmpult	$2, $30, $1
-	beq	$1, 2f
-1:	stq	$0, 0($2)
-	addq	$2, 8, $2
-	cmpult	$2, $30, $1
-	bne	$1, 1b
-2:	ret	($28)
-
-	.end _mcount
_
