Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVA3Qzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVA3Qzd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 11:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVA3Qzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 11:55:32 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:32506 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261728AbVA3QzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 11:55:25 -0500
Date: Mon, 31 Jan 2005 01:55:16 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc2-mm2] mips: fixed restore_sigcontext
Message-Id: <20050131015516.74aaba48.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had fixed restore_sigcontext about MIPS.
This patch is only for 2.6.11-rc2-mm2.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/kernel/signal-common.h a/arch/mips/kernel/signal-common.h
--- a-orig/arch/mips/kernel/signal-common.h	Mon Jan 31 00:42:13 2005
+++ a/arch/mips/kernel/signal-common.h	Mon Jan 31 01:02:19 2005
@@ -62,6 +62,7 @@
 restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
 	int err = 0;
+	unsigned int used_math;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
@@ -86,7 +87,7 @@
 	restore_gp_reg(31);
 #undef restore_gp_reg
 
-	err |= __get_user(!!used_math(), &sc->sc_used_math);
+	err |= __get_user(used_math, &sc->sc_used_math);
 	conditional_used_math(used_math);
 
 	preempt_disable();

