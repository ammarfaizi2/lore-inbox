Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264680AbUD1H3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264680AbUD1H3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 03:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264683AbUD1H3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 03:29:31 -0400
Received: from math.ut.ee ([193.40.5.125]:39358 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264680AbUD1H32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 03:29:28 -0400
Date: Wed, 28 Apr 2004 10:29:26 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [2.6 PATCH] PPC32: compile error in signal.c
Message-ID: <Pine.GSO.4.44.0404281025070.7699-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      arch/ppc/kernel/signal.o
arch/ppc/kernel/signal.c: In function `handle_signal':
arch/ppc/kernel/signal.c:518: error: `newspp' undeclared (first use in this function)
arch/ppc/kernel/signal.c:518: error: (Each undeclared identifier is reported only once
arch/ppc/kernel/signal.c:518: error: for each function it appears in.)
arch/ppc/kernel/signal.c:518: warning: long unsigned int format, pointer arg (arg 3)

The following patch seems to fix it:

===== arch/ppc/kernel/signal.c 1.31 vs edited =====
--- 1.31/arch/ppc/kernel/signal.c	Thu Apr  8 01:55:06 2004
+++ edited/arch/ppc/kernel/signal.c	Wed Apr 28 10:27:20 2004
@@ -514,8 +514,8 @@

 badframe:
 #ifdef DEBUG_SIG
-	printk("badframe in handle_signal, regs=%p frame=%lx newsp=%lx\n",
-	       regs, frame, *newspp);
+	printk("badframe in handle_signal, regs=%p frame=%p newsp=%lx\n",
+	       regs, frame, newsp);
 #endif
 	if (sig == SIGSEGV)
 		ka->sa.sa_handler = SIG_DFL;


-- 
Meelis Roos (mroos@linux.ee)

