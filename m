Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVEFXpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVEFXpi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVEFXZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:25:14 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:49670 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261350AbVEFXOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:14:39 -0400
Message-Id: <200505062249.j46MnARu010455@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH 5/12] UML - S390 preparation, save an extra register
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 May 2005 18:49:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

s390 tt-mode needs to save not only syscall number, but an
further register also.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm/arch/um/kernel/tt/syscall_user.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/tt/syscall_user.c	2005-05-06 14:42:20.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/tt/syscall_user.c	2005-05-06 14:49:52.000000000 -0400
@@ -63,6 +63,10 @@
 
 	UPT_SYSCALL_NR(TASK_REGS(task)) = PT_SYSCALL_NR(proc_regs);
 
+#ifdef UPT_ORIGGPR2
+        UPT_ORIGGPR2(TASK_REGS(task)) = REGS_ORIGGPR2(proc_regs);
+#endif
+
 	if(((unsigned long *) PT_IP(proc_regs) >= &_stext) &&
 	   ((unsigned long *) PT_IP(proc_regs) <= &_etext))
 		tracer_panic("I'm tracing myself and I can't get out");

