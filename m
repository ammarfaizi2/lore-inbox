Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268920AbUJKMov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268920AbUJKMov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268916AbUJKMmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:42:45 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:42945 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S268902AbUJKMlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:41:16 -0400
Message-ID: <416A7F6D.EAF071CB@tv-sign.ru>
Date: Mon, 11 Oct 2004 16:41:17 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc4-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

arch/i386/kernel/traps.c damaged. CONFIG_KGDB stuff
inside print_context_stack().

Oleg.

--- 2.6.9-rc4-mm1/arch/i386/kernel/traps.c~	Mon Oct 11 16:32:07 2004
+++ 2.6.9-rc4-mm1/arch/i386/kernel/traps.c	Mon Oct 11 16:32:55 2004
@@ -105,17 +105,6 @@ int register_die_notifier(struct notifie
 	return err;
 }
 
-static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
-{
-	return	p > (void *)tinfo &&
-		p < (void *)tinfo + THREAD_SIZE - 3;
-}
-
-static inline unsigned long print_context_stack(struct thread_info *tinfo,
-				unsigned long *stack, unsigned long ebp)
-{
-	unsigned long addr;
-
 #ifdef CONFIG_KGDB
 extern void sysenter_past_esp(void);
 #include <asm/kgdb.h>
@@ -149,6 +138,16 @@ void breakpoint(void)
 #define	CHK_REMOTE_DEBUG(trapnr,signr,error_code,regs,after)
 #endif
 
+static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
+{
+	return	p > (void *)tinfo &&
+		p < (void *)tinfo + THREAD_SIZE - 3;
+}
+
+static inline unsigned long print_context_stack(struct thread_info *tinfo,
+				unsigned long *stack, unsigned long ebp)
+{
+	unsigned long addr;
 
 #ifdef	CONFIG_FRAME_POINTER
 	while (valid_stack_ptr(tinfo, (void *)ebp)) {
