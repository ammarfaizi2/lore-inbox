Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbUC3Fld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUC3Fld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:41:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:55445 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263164AbUC3Fl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:41:28 -0500
Subject: [PATCH] ppc32: Allow PREEMPT with SMP in KConfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080625278.1213.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 15:41:18 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On ppc32, CONFIG_PREEMPT wasn't settable along with CONFIG_SMP
for historical reasons (smp_processor_id() races). Those races have
been fixes since then (well, should have been at least) so it's now
safe to allow both options.

Ben.

===== arch/ppc/Kconfig 1.56 vs edited =====
--- 1.56/arch/ppc/Kconfig	Fri Mar 19 17:04:54 2004
+++ edited/arch/ppc/Kconfig	Tue Mar 30 15:39:41 2004
@@ -696,14 +696,10 @@
 
 config PREEMPT
 	bool "Preemptible Kernel"
-	depends on !SMP
 	help
 	  This option reduces the latency of the kernel when reacting to
 	  real-time or interactive events by allowing a low priority process to
 	  be preempted even if it is in kernel mode executing a system call.
-	  Unfortunately the kernel code has some race conditions if both
-	  CONFIG_SMP and CONFIG_PREEMPT are enabled, so this option is
-	  currently disabled if you are building an SMP kernel.
 
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.


