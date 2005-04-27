Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVD0BRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVD0BRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 21:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVD0BRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 21:17:48 -0400
Received: from 70-56-217-9.albq.qwest.net ([70.56.217.9]:42216 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261845AbVD0BRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 21:17:44 -0400
Date: Tue, 26 Apr 2005 19:20:23 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpuid x87 bit on AMD falsely marked as PNI
Message-ID: <Pine.LNX.4.61.0504261851070.12903@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=4426

vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP
stepping        : 0
cpu MHz         : 2204.807
<snipped>
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse pni syscall mmxext 3dnowext 3dnow
bogomips        : 4358.14

We're marking bit 0 of extended function 0x80000001 cpuid as PNI support 
on AMD processors, when it actually denotes x87 FPU present. Patch for 
i386 and x86_64 below.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.12-rc2-mm3/arch/i386/kernel/cpu/proc.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.12-rc2-mm3/arch/i386/kernel/cpu/proc.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 proc.c
--- linux-2.6.12-rc2-mm3/arch/i386/kernel/cpu/proc.c	17 Apr 2005 14:03:42 -0000	1.1.1.1
+++ linux-2.6.12-rc2-mm3/arch/i386/kernel/cpu/proc.c	27 Apr 2005 00:46:18 -0000
@@ -25,7 +25,7 @@ static int show_cpuinfo(struct seq_file 
 	        "fxsr", "sse", "sse2", "ss", "ht", "tm", "ia64", "pbe",
 
 		/* AMD-defined */
-		"pni", NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, "syscall", NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, "mp", "nx", NULL, "mmxext", NULL,
 		NULL, "fxsr_opt", NULL, NULL, NULL, "lm", "3dnowext", "3dnow",
Index: linux-2.6.12-rc2-mm3/arch/x86_64/kernel/setup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.12-rc2-mm3/arch/x86_64/kernel/setup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 setup.c
--- linux-2.6.12-rc2-mm3/arch/x86_64/kernel/setup.c	17 Apr 2005 14:03:51 -0000	1.1.1.1
+++ linux-2.6.12-rc2-mm3/arch/x86_64/kernel/setup.c	27 Apr 2005 00:46:31 -0000
@@ -1103,7 +1103,7 @@ static int show_cpuinfo(struct seq_file 
 	        "fxsr", "sse", "sse2", "ss", "ht", "tm", "ia64", NULL,
 
 		/* AMD-defined */
-		"pni", NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, "syscall", NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, "nx", NULL, "mmxext", NULL,
 		NULL, "fxsr_opt", NULL, NULL, NULL, "lm", "3dnowext", "3dnow",
