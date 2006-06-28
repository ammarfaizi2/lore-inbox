Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423343AbWF1ORz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423343AbWF1ORz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423348AbWF1ORy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:17:54 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:3771 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423343AbWF1ORx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:17:53 -0400
Date: Wed, 28 Jun 2006 16:17:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] s390: remove export of sys_call_table
Message-ID: <20060628141747.GD14375@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] remove export of sys_call_table

Remove export of the sys_call_table symbol to prevent the misuse of it.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/entry.S   |    1 -
 arch/s390/kernel/entry64.S |    2 --
 2 files changed, 3 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2006-06-28 16:16:28.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2006-06-28 16:16:43.000000000 +0200
@@ -993,7 +993,6 @@ cleanup_io_leave_insn:
                .quad  __critical_end
 
 #define SYSCALL(esa,esame,emu)	.long esame
-	.globl  sys_call_table
 sys_call_table:
 #include "syscalls.S"
 #undef SYSCALL
@@ -1001,7 +1000,6 @@ sys_call_table:
 #ifdef CONFIG_COMPAT
 
 #define SYSCALL(esa,esame,emu)	.long emu
-	.globl  sys_call_table_emu
 sys_call_table_emu:
 #include "syscalls.S"
 #undef SYSCALL
diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2006-06-28 16:16:28.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2006-06-28 16:16:43.000000000 +0200
@@ -1019,7 +1019,6 @@ cleanup_io_leave_insn:
                .long  cleanup_critical
 
 #define SYSCALL(esa,esame,emu)	.long esa
-	.globl  sys_call_table
 sys_call_table:
 #include "syscalls.S"
 #undef SYSCALL
