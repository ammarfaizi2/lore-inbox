Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVAQDkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVAQDkD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVAQDhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:37:47 -0500
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]:17412
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262674AbVAQDdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:33:45 -0500
Message-Id: <200501170556.j0H5uEkY006067@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/10] UML - Change for_each_cpu to for_each_online_cpu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jan 2005 00:56:14 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/kernel/irq.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/irq.c	2005-01-11 12:18:51.000000000 -0500
+++ 2.6.10/arch/um/kernel/irq.c	2005-01-11 13:04:52.000000000 -0500
@@ -45,7 +45,7 @@
 
 	if (i == 0) {
 		seq_printf(p, "           ");
-		for_each_cpu(j)
+		for_each_online_cpu(j)
 			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
@@ -59,7 +59,7 @@
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for_each_cpu(j)
+		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
Index: 2.6.10/arch/um/kernel/smp.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/smp.c	2005-01-10 17:36:31.000000000 -0500
+++ 2.6.10/arch/um/kernel/smp.c	2005-01-11 13:04:58.000000000 -0500
@@ -247,7 +247,7 @@
 	func = _func;
 	info = _info;
 
-	for_each_cpu(i)
+	for_each_online_cpu(i)
 		os_write_file(cpu_data[i].ipi_pipe[1], "C", 1);
 
 	while (atomic_read(&scf_started) != cpus)

