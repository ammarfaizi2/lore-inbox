Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318896AbSG1DN1>; Sat, 27 Jul 2002 23:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318897AbSG1DN1>; Sat, 27 Jul 2002 23:13:27 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:13564 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S318896AbSG1DN0>; Sat, 27 Jul 2002 23:13:26 -0400
Message-ID: <3D436218.5150A206@attbi.com>
Date: Sat, 27 Jul 2002 23:16:40 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
CC: sfr@canb.auug.org.au
Subject: [PATCH] 2.5.29 fix for undef num_possible_cpus
Content-Type: multipart/mixed;
 boundary="------------FCE1E33D6ED336E2D2374671"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FCE1E33D6ED336E2D2374671
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Linus,
APM changes in 2.5.29 replaced num_online_cpus with
num_possible_cpus.  I cannot find num_possible_cpus
defined anywhere.
Please revert back to num_online_cpus to link successfully.
Thanks,
Albert
--- linux/arch/i386/kernel/apm.c.orig   2002-07-27 14:31:23.000000000 -0400
+++ linux/arch/i386/kernel/apm.c        2002-07-27 14:32:27.000000000 -0400
@@ -1589,7 +1589,7 @@
 
        p = buf;
 
-       if ((num_possible_cpus() == 1) &&
+       if ((num_online_cpus() == 1) &&
            !(error = apm_get_power_status(&bx, &cx, &dx))) {
                ac_line_status = (bx >> 8) & 0xff;
                battery_status = bx & 0xff;
@@ -1720,7 +1720,7 @@
                }
        }
 
-       if (debug && (num_possible_cpus() == 1)) {
+       if (debug && (num_online_cpus() == 1)) {
                error = apm_get_power_status(&bx, &cx, &dx);
                if (error)
                        printk(KERN_INFO "apm: power status not available\n");
@@ -1764,7 +1764,7 @@
                pm_power_off = apm_power_off;
        register_sysrq_key('o', &sysrq_poweroff_op);
 
-       if (num_possible_cpus() == 1) {
+       if (num_online_cpus() == 1) {
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
                console_blank_hook = apm_console_blank;
 #endif
@@ -1907,7 +1907,7 @@
                printk(KERN_NOTICE "apm: disabled on user request.\n");
                return -ENODEV;
        }
-       if ((num_possible_cpus() > 1) && !power_off) {
+       if ((num_online_cpus() > 1) && !power_off) {
                printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
                return -ENODEV;
        }
@@ -1964,7 +1964,7 @@
 
        kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 
-       if (num_possible_cpus() > 1) {
+       if (num_online_cpus() > 1) {
                printk(KERN_NOTICE
                   "apm: disabled - APM is not SMP safe (power off active).\n");
                return 0;

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
--------------FCE1E33D6ED336E2D2374671
Content-Type: text/plain; charset=us-ascii;
 name="a"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a"

--- linux/arch/i386/kernel/apm.c.orig	2002-07-27 14:31:23.000000000 -0400
+++ linux/arch/i386/kernel/apm.c	2002-07-27 14:32:27.000000000 -0400
@@ -1589,7 +1589,7 @@
 
 	p = buf;
 
-	if ((num_possible_cpus() == 1) &&
+	if ((num_online_cpus() == 1) &&
 	    !(error = apm_get_power_status(&bx, &cx, &dx))) {
 		ac_line_status = (bx >> 8) & 0xff;
 		battery_status = bx & 0xff;
@@ -1720,7 +1720,7 @@
 		}
 	}
 
-	if (debug && (num_possible_cpus() == 1)) {
+	if (debug && (num_online_cpus() == 1)) {
 		error = apm_get_power_status(&bx, &cx, &dx);
 		if (error)
 			printk(KERN_INFO "apm: power status not available\n");
@@ -1764,7 +1764,7 @@
 		pm_power_off = apm_power_off;
 	register_sysrq_key('o', &sysrq_poweroff_op);
 
-	if (num_possible_cpus() == 1) {
+	if (num_online_cpus() == 1) {
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 		console_blank_hook = apm_console_blank;
 #endif
@@ -1907,7 +1907,7 @@
 		printk(KERN_NOTICE "apm: disabled on user request.\n");
 		return -ENODEV;
 	}
-	if ((num_possible_cpus() > 1) && !power_off) {
+	if ((num_online_cpus() > 1) && !power_off) {
 		printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
 		return -ENODEV;
 	}
@@ -1964,7 +1964,7 @@
 
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 
-	if (num_possible_cpus() > 1) {
+	if (num_online_cpus() > 1) {
 		printk(KERN_NOTICE
 		   "apm: disabled - APM is not SMP safe (power off active).\n");
 		return 0;

--------------FCE1E33D6ED336E2D2374671--

