Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUAWGst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266533AbUAWGqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:46:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24530 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266520AbUAWGgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:36:46 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
From: davej@redhat.com
Subject: Correct CPUs printout on boot.
Message-Id: <E1Ajuub-0000y1-00@hardwired>
Date: Fri, 23 Jan 2004 06:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This currently prints out the maximum number of CPUs the
kernel is configured to support, instead of the actual
number that the kernel brought up. Which results in odd
displays that look like you have more CPUs than you do.

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/init/main.c linux-2.5/init/main.c
--- linux-2.5/init/main.c~	Fri Jan 23 06:24:12 2004
+++ linux-2.5/init/main.c	Fri Jan 23 06:24:44 2004
@@ -339,7 +339,7 @@
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
-	unsigned int i;
+	unsigned int i, j=0;
 
 	/* FIXME: This should be done in userspace --RR */
 	for (i = 0; i < NR_CPUS; i++) {
@@ -348,11 +348,12 @@
 		if (cpu_possible(i) && !cpu_online(i)) {
 			printk("Bringing up %i\n", i);
 			cpu_up(i);
+			j++;
 		}
 	}
 
 	/* Any cleanup work */
-	printk("CPUS done %u\n", max_cpus);
+	printk("CPUS done %u\n", j);
 	smp_cpus_done(max_cpus);
 #if 0
 	/* Get other processors into their bootup holding patterns. */
