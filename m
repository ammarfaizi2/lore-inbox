Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUJRSJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUJRSJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbUJRSJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:09:19 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:37381 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S267285AbUJRSHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:07:38 -0400
Date: Mon, 18 Oct 2004 19:03:46 +0100 (BST)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: PATCH re CONFIG_DUMMY_CONSOLE on sparc platfoms. My Console was
 going blank as startup. (fwd)
Message-ID: <Pine.LNX.4.10.10410181901410.29938-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Opps. Sorry, I did not get to the bottom of the list of things to do to
submit a patch.

---------- Forwarded message ----------
Date: Sun, 17 Oct 2004 22:00:03 +0100 (BST)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: wli@holomorphy.com, davem@davemloft.net, ecd@skynet.be,
     jj@sunsite.ms.mff.cuni.cz, anton@samba.org
Subject: My Console was going blank as startup.

Hi all,

I am currently trying to get a sparc kernel up and running on my sparc1
clone. I have a hacked 2.2.14 kernel that start up but I decided that
seeing as I am upgrading all my linux systems, I would upgrade to the
latest kernel.

The new kernel turned the console off and then ... (power up reset
required at this point).

I looked through the code to try and get some diagnostics out of the
system at an early stage and found that the 'prom console' conswitchp was
never going to be setup for a prom console as CONFIG_DUMMY_CONSOLE is
always set.

The attached patch changes this. It has allowd me to get one step
further (a watchdog timeout followed be a return to the prom monitor) but
I still do not have a working kernel.

Any advice on sparc kernel configuration (sparc1 sun4c + CG3) would be
appreciated as I would like to get a system up and running soon to test
out come cross compilation problems I have been gaving with GCC.

Is the latest kernel still bootable using the SunOS 4.1 boot program ?

Note: I am using binutils-2.15 and gcc-3.4.2 with Dan Kegel's cross
compilation patches applied.

Regards
	Mark Fortescue.

##############################################################################
#
# Mark Fortescue (mark@mtfhpc.demon.co.uk) Kernel Updates, 17th Oct 2004.
#
# (from 2.6.8.1 with patch-2.6.9-rc2 and patch-2.6.9-rc2-bk6 applied.)
#
# Prom Console Modification.
#
# I was getting a blank screen so I could not tell what was going on
# when my sparc (32) kernel faild during init.
# CONFIG_DUMMY_CONSOLE is always set so the CONFIG_PROM_CONSOLE was
# never tested. Changing the order make the code make sense and is
# similar to the VGA versions.
#
# I Checked the sparc64 version and have updated this as well.
# Someone needs to check that what I have done is correct as I
# do not have a sparc64 system and my sparc kernel does not boot.
#
##############################################################################
diff -ruNpd linux-2.6.8.1/arch/sparc/kernel/setup.c linux-2.6.8.1-p02/arch/sparc/kernel/setup.c
--- linux-2.6.8.1/arch/sparc/kernel/setup.c	Fri Oct 15 20:14:06 2004
+++ linux-2.6.8.1-p02/arch/sparc/kernel/setup.c	Sun Oct 17 01:52:16 2004
@@ -304,10 +304,10 @@ void __init setup_arch(char **cmdline_p)
 		break;
 	};
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#elif defined(CONFIG_PROM_CONSOLE)
+#ifdef CONFIG_PROM_CONSOLE
 	conswitchp = &prom_con;
+#elif defined(CONFIG_DUMMY_CONSOLE)
+	conswitchp = &dummy_con;
 #endif
 	boot_flags_init(*cmdline_p);
 
diff -ruNpd linux-2.6.8.1/arch/sparc64/kernel/setup.c linux-2.6.8.1-p02/arch/sparc64/kernel/setup.c
--- linux-2.6.8.1/arch/sparc64/kernel/setup.c	Fri Oct 15 20:14:07 2004
+++ linux-2.6.8.1-p02/arch/sparc64/kernel/setup.c	Sun Oct 17 01:53:35 2004
@@ -479,10 +479,10 @@ void __init setup_arch(char **cmdline_p)
 
 	printk("ARCH: SUN4U\n");
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#elif defined(CONFIG_PROM_CONSOLE)
+#ifdef CONFIG_PROM_CONSOLE
 	conswitchp = &prom_con;
+#elif defined(CONFIG_DUMMY_CONSOLE)
+	conswitchp = &dummy_con;
 #endif
 
 #ifdef CONFIG_SMP
----------------------------------------------------------------------------


