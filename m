Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWGKPWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWGKPWH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWGKPWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:22:06 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:4750 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751281AbWGKPWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:22:03 -0400
Date: Tue, 11 Jul 2006 17:22:02 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Don't randomize stack unless current->personality permits it
Message-ID: <20060711152202.GA18149@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not randomize stack location unless current->personality permits it.

Signed-off-by: Frank van Maarseveen <frankvm@frankvm.com>
---

The problem seems also present in

	arch/um/kernel/process_kern.c
	arch/x86_64/kernel/process.c

 arch/i386/kernel/process.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -rup a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	2006-06-23 16:08:13.000000000 +0200
+++ b/arch/i386/kernel/process.c	2006-07-11 14:39:20.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
 #include <linux/random.h>
+#include <linux/personality.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -898,7 +899,7 @@ asmlinkage int sys_get_thread_area(struc
 
 unsigned long arch_align_stack(unsigned long sp)
 {
-	if (randomize_va_space)
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
 		sp -= get_random_int() % 8192;
 	return sp & ~0xf;
 }

