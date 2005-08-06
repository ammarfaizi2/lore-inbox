Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVHFIOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVHFIOr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 04:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVHFIOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 04:14:47 -0400
Received: from mail27.sea5.speakeasy.net ([69.17.117.29]:14757 "EHLO
	mail27.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S261527AbVHFIOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 04:14:41 -0400
Subject: [PATCH][TRIVIAL] make visual workstation subarch compile again
From: Tom Duffy <thomas.duffy.99@alumni.brown.edu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 06 Aug 2005 01:16:35 -0700
Message-Id: <1123316195.15674.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the compile error when the i386 subarch visual
workstation is turned on:

In file included from linux-2.6.13-rc5/arch/i386/kernel/timers/timer_pit.c:20:
linux-2.6.13-rc5/include/asm-i386/mach-visws/do_timer.h: In function `do_timer_overflow':
linux-2.6.13-rc5/include/asm-i386/mach-visws/do_timer.h:32: error: `i8259A_lock' undeclared (first use in this function)
linux-2.6.13-rc5/include/asm-i386/mach-visws/do_timer.h:32: error: (Each undeclared identifier is reported only once
linux-2.6.13-rc5/include/asm-i386/mach-visws/do_timer.h:32: error: for each function it appears in.)
make[3]: *** [arch/i386/kernel/timers/timer_pit.o] Error 1
make[2]: *** [arch/i386/kernel/timers] Error 2
make[1]: *** [arch/i386/kernel] Error 2
make: *** [_all] Error 2

Signed-off-by: Tom Duffy <thomas.duffy.99@alumni.brown.edu>

diff -Nur linux-2.6.13-rc5/include/asm-i386/mach-visws/do_timer.h linux-2.6.13-rc5/include/asm-i386/mach-visws/do_timer.h
--- linux-2.6.13-rc5/include/asm-i386/mach-visws/do_timer.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.13-rc5/include/asm-i386/mach-visws/do_timer.h	2005-08-06 00:44:12.978605200 -0700
@@ -1,6 +1,7 @@
 /* defines for inline arch setup functions */
 
 #include <asm/fixmap.h>
+#include <asm/i8259.h>
 #include "cobalt.h"
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)


