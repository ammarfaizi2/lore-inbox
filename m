Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTKDHIX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 02:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbTKDHIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 02:08:23 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:32129
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263767AbTKDHIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 02:08:22 -0500
Date: Tue, 4 Nov 2003 02:07:46 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.6] Dont use cpu_has_pse for WP test branch
Message-ID: <Pine.LNX.4.53.0311040155150.20595@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that not all processors which support PSE have the PSE bit set, 
possibly we should be checking with PSE36 too. But instead i've opted to 
simply check for 586+

Celeron (Mendocino): fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr

Opteron 240: fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36 clflush mmx fxsr sse sse2 syscall mmxext lm 3dnowext 3dnow

Index: linux-2.6.0-test9/arch/i386/mm/init.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test9/arch/i386/mm/init.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 init.c
--- linux-2.6.0-test9/arch/i386/mm/init.c	27 Oct 2003 07:12:18 -0000	1.1.1.1
+++ linux-2.6.0-test9/arch/i386/mm/init.c	4 Nov 2003 06:58:30 -0000
@@ -388,8 +388,7 @@ void __init paging_init(void)
 
 void __init test_wp_bit(void)
 {
-	if (cpu_has_pse) {
-		/* Ok, all PSE-capable CPUs are definitely handling the WP bit right. */
+	if (boot_cpu_data.x86_model >= 5) {
 		boot_cpu_data.wp_works_ok = 1;
 		return;
 	}
