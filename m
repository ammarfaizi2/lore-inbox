Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263414AbTDVTz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTDVTz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:55:27 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7297 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263473AbTDVTz0 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:55:26 -0400
Message-Id: <200304222007.h3MK7VLq007351@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk3 #if cleanup (7/6)
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Apr 2003 16:07:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, part 7 of 6.  I missed two cases of '#if !CONFIG' that I've
changed to '#ifndef'

--- linux-2.5.68-bk3/include/linux/interrupt.h.dist	2003-04-22 13:57:47.000000000 -0400
+++ linux-2.5.68-bk3/include/linux/interrupt.h	2003-04-22 15:58:09.227201362 -0400
@@ -49,7 +49,7 @@
 /*
  * Temporary defines for UP kernels, until all code gets fixed.
  */
-#if !CONFIG_SMP
+#ifndef CONFIG_SMP
 # define cli()			local_irq_disable()
 # define sti()			local_irq_enable()
 # define save_flags(x)		local_save_flags(x)
--- linux-2.5.68-bk3/arch/ppc/kernel/process.c.dist	2003-04-22 15:59:37.172062542 -0400
+++ linux-2.5.68-bk3/arch/ppc/kernel/process.c	2003-04-22 16:00:00.026582008 -0400
@@ -550,7 +550,7 @@
 		++count;
 		sp = *(unsigned long *)sp;
 	}
-#if !CONFIG_KALLSYMS
+#ifndef CONFIG_KALLSYMS
 	if (count > 0)
 		printk("\n");
 #endif


