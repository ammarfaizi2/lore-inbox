Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267185AbSKSSoi>; Tue, 19 Nov 2002 13:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbSKSSoF>; Tue, 19 Nov 2002 13:44:05 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:48863 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S267185AbSKSSm6>; Tue, 19 Nov 2002 13:42:58 -0500
Date: Tue, 19 Nov 2002 11:50:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH][TRIVIAL] Add back in <asm/system.h> and <linux/linkage.h> to <linux/interrupt.h>
Message-ID: <20021119184959.GF779@opus.bloom.county>
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
