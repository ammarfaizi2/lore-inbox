Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266515AbUAWGiw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUAWGgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:36:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20690 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266515AbUAWGgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:36:43 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
From: davej@redhat.com
Subject: Restore 2.4 MTRR feature.
Message-Id: <E1Ajuub-0000xI-00@hardwired>
Date: Fri, 23 Jan 2004 06:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the CPU doesn't support MTRRs, don't create a /proc/mtrr

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mtrr/if.c linux-2.5/arch/i386/kernel/cpu/mtrr/if.c
--- bk-linus/arch/i386/kernel/cpu/mtrr/if.c	2003-09-29 19:45:18.000000000 +0100
+++ linux-2.5/arch/i386/kernel/cpu/mtrr/if.c	2003-11-27 17:04:42.000000000 +0000
@@ -352,6 +352,14 @@ static int mtrr_seq_show(struct seq_file
 
 static int __init mtrr_if_init(void)
 {
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	if ((!cpu_has(c, X86_FEATURE_MTRR)) &&
+		(!cpu_has(c, X86_FEATURE_K6_MTRR)) &&
+		(!cpu_has(c, X86_FEATURE_CYRIX_ARR)) &&
+		(!cpu_has(c, X86_FEATURE_CENTAUR_MCR)))
+	return -ENODEV;
+
 	proc_root_mtrr =
 	    create_proc_entry("mtrr", S_IWUSR | S_IRUGO, &proc_root);
 	if (proc_root_mtrr) {
