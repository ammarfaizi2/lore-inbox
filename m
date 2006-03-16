Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWCPDeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWCPDeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWCPDeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:34:17 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:9151 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932291AbWCPDeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:34:16 -0500
Date: Thu, 16 Mar 2006 12:33:09 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [13/19] ppc
Message-Id: <20060316123309.1e997091.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.16-rc6-mm1/arch/ppc/kernel/setup.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/ppc/kernel/setup.c
+++ linux-2.6.16-rc6-mm1/arch/ppc/kernel/setup.c
@@ -711,7 +711,7 @@ int __init ppc_init(void)
 	if ( ppc_md.progress ) ppc_md.progress("             ", 0xffff);
 
 	/* register CPU devices */
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		register_cpu(&cpu_devices[i], i, NULL);
 
 	/* call platform init */
Index: linux-2.6.16-rc6-mm1/arch/ppc/kernel/smp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/ppc/kernel/smp.c
+++ linux-2.6.16-rc6-mm1/arch/ppc/kernel/smp.c
@@ -311,7 +311,7 @@ void __init smp_prepare_cpus(unsigned in
 	/* Backup CPU 0 state */
 	__save_cpu_setup();
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		if (cpu == smp_processor_id())
 			continue;
 		/* create a process for the processor */
