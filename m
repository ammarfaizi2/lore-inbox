Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264754AbTGCP6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTGCP6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:58:09 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:5629 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264754AbTGCP5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:57:19 -0400
Date: Thu, 3 Jul 2003 18:11:44 +0200 (MEST)
Message-Id: <200307031611.h63GBiPn007055@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [PATCH][2.5.74] fix x86_64 breakage on UP with modules
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

2.5.74 added EXPORT_SYMBOL for two TLB flushing procedures.
These aren't real procedures on UP, so the EXPORT_SYMBOLs must
be under #ifdef CONFIG_SMP, just like they are on i386. The
patch below fixes this. Please apply.

Without this patch you get a compile error on x86_64 if you've
configured for UP with modules.

/Mikael

--- linux-2.5.74/arch/x86_64/kernel/x8664_ksyms.c.~1~	2003-07-03 12:32:44.000000000 +0200
+++ linux-2.5.74/arch/x86_64/kernel/x8664_ksyms.c	2003-07-03 17:24:00.422977104 +0200
@@ -121,6 +121,9 @@
 
 EXPORT_SYMBOL(synchronize_irq);
 EXPORT_SYMBOL(smp_call_function);
+
+EXPORT_SYMBOL(flush_tlb_page);
+EXPORT_SYMBOL_GPL(flush_tlb_all);
 #endif
 
 #ifdef CONFIG_VT
@@ -213,6 +216,3 @@
 #endif
 
 EXPORT_SYMBOL(clear_page);
-
-EXPORT_SYMBOL(flush_tlb_page);
-EXPORT_SYMBOL_GPL(flush_tlb_all);
