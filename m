Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbUB0VtI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUB0Vqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:46:38 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:30395 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S263137AbUB0VqH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:46:07 -0500
Date: Fri, 27 Feb 2004 14:46:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net
Subject: [KGDB PATCH][5/7] Fix ppc32 hooks.
Message-ID: <20040227214605.GH1052@smtp.west.cox.net>
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227212548.GD1052@smtp.west.cox.net> <20040227213254.GE1052@smtp.west.cox.net> <20040227214031.GF1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227214031.GF1052@smtp.west.cox.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The following removes the only PPC32 CHK_DEBUGGER statement,
as we've always been making kgdb take over the various debugger pointers.

diff -zrupN linux-2.6.3+config+serial/arch/ppc/mm/fault.c linux-2.6.3+config+serial+sysrq+arch_hooks/arch/ppc/mm/fault.c
--- linux-2.6.3+config+serial/arch/ppc/mm/fault.c	2004-02-27 12:16:13.000000000 -0700
+++ linux-2.6.3+config+serial+sysrq+arch_hooks/arch/ppc/mm/fault.c	2004-02-27 12:16:14.000000000 -0700
@@ -351,13 +351,11 @@ bad_page_fault(struct pt_regs *regs, uns
 	}
 
 	/* kernel has accessed a bad area */
-#if defined(CONFIG_XMON)
+#if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
 	if (debugger_kernel_faults)
 		debugger(regs);
 #endif
 
-	CHK_DEBUGGER(14, sig,0, regs,)
-
 	die("kernel access of bad area", regs, sig);
 }
 

-- 
Tom Rini
http://gate.crashing.org/~trini/
