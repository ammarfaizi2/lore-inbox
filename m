Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbULCTvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbULCTvx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbULCTux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:50:53 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:23044
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262482AbULCT3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:29:42 -0500
Message-Id: <200412032145.iB3LjhZW004720@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - fix update_process_times call
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:45:43 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

In call to update_process_times() set parameter user
correctly. (was from for SKAS).

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/time_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/time_kern.c	2004-12-01 23:43:04.000000000 -0500
+++ 2.6.9/arch/um/kernel/time_kern.c	2004-12-01 23:54:26.000000000 -0500
@@ -170,7 +170,7 @@
 void timer_handler(int sig, union uml_pt_regs *regs)
 {
 	local_irq_disable();
-	update_process_times(user_context(UPT_SP(regs)));
+	update_process_times(CHOOSE_MODE(user_context(UPT_SP(regs)), (regs)->skas.is_user));
 	local_irq_enable();
 	if(current_thread->cpu == 0)
 		timer_irq(regs);

