Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbSKVPO1>; Fri, 22 Nov 2002 10:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSKVPO1>; Fri, 22 Nov 2002 10:14:27 -0500
Received: from ip68-0-152-218.tc.ph.cox.net ([68.0.152.218]:19175 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S264954AbSKVPOY>; Fri, 22 Nov 2002 10:14:24 -0500
Date: Fri, 22 Nov 2002 08:21:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][RESEND] Add back in <asm/system.h> and <linux/linkage.h> to <linux/interrupt.h>
Message-ID: <20021122152132.GP779@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following trivial patch adds back <asm/system.h> and
<linux/kernel.h> to <linux/interrupt.h>.  Without it,
<linux/interrupt.h> is relying on <asm/system.h> to be implicitly
included for smb_mb to be defined, and <linux/linkage.h> to be implicitly
included for asmlinkage/FASTCALL/etc.

Apparently RMK sent a similar patch, which did not add in
<linux/linkage.h>.  That patch is incomplete since <linux/interrupt.h>
directly uses FASTCALL, asmlinkage, etc, and on some arches
<linux/linkage.h> will not be implicitly included.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== include/linux/interrupt.h 1.17 vs edited =====
--- 1.17/include/linux/interrupt.h	Sun Nov 17 09:23:25 2002
+++ edited/include/linux/interrupt.h	Tue Nov 19 11:35:47 2002
@@ -3,11 +3,13 @@
 #define _LINUX_INTERRUPT_H
 
 #include <linux/config.h>
+#include <linux/linkage.h>
 #include <linux/bitops.h>
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 #include <asm/ptrace.h>
 #include <asm/softirq.h>
+#include <asm/system.h>
 
 struct irqaction {
 	void (*handler)(int, void *, struct pt_regs *);
