Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbUKQNrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbUKQNrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 08:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUKQNrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 08:47:31 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:3043 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262320AbUKQNrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 08:47:17 -0500
Message-ID: <419B64C2.CED2FABC@tv-sign.ru>
Date: Wed, 17 Nov 2004 17:48:34 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] trivial, uninline do_trap(), remove get_cr2()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uninlining do_trap() saves 544 bytes in traps.o.
get_cr2() seems to be unused, remove it.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10-rc2/arch/i386/kernel/traps.c~	Tue Nov 16 14:13:08 2004
+++ 2.6.10-rc2/arch/i386/kernel/traps.c	Wed Nov 17 16:47:41 2004
@@ -358,16 +358,7 @@ static inline void die_if_kernel(const c
 		die(str, regs, err);
 }
 
-static inline unsigned long get_cr2(void)
-{
-	unsigned long address;
-
-	/* get the address */
-	__asm__("movl %%cr2,%0":"=r" (address));
-	return address;
-}
-
-static inline void do_trap(int trapnr, int signr, char *str, int vm86,
+static void do_trap(int trapnr, int signr, char *str, int vm86,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
 	if (regs->eflags & VM_MASK) {
