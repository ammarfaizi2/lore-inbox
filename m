Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262933AbSJIXP0>; Wed, 9 Oct 2002 19:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbSJIXPZ>; Wed, 9 Oct 2002 19:15:25 -0400
Received: from dp.samba.org ([66.70.73.150]:21673 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262933AbSJIXOx>;
	Wed, 9 Oct 2002 19:14:53 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15780.46366.112563.365010@nanango.paulus.ozlabs.org>
Date: Thu, 10 Oct 2002 09:00:46 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] adjust PPC sysctls
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch takes out the unused KERN_PPC_ZEROPAGED sysctl, and
restricts the KERN_PPC_POWERSAVE_NAP and KERN_PPC_L2CR sysctls to be
present only on those PPC processors where they are useful.  This
patch only affects PPC.

Linus, please apply this patch to your tree.

Paul.

diff -urN linux-2.5/kernel/sysctl.c linuxppc-2.5/kernel/sysctl.c
--- linux-2.5/kernel/sysctl.c	2002-09-20 22:31:26.000000000 +1000
+++ linuxppc-2.5/kernel/sysctl.c	2002-09-20 23:03:19.000000000 +1000
@@ -88,8 +88,8 @@
 extern int sysctl_userprocess_debug;
 #endif
 
-#ifdef CONFIG_PPC32
-extern unsigned long zero_paged_on, powersave_nap;
+#if defined(CONFIG_PPC32) && defined(CONFIG_6xx)
+extern unsigned long powersave_nap;
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp);
 #endif
@@ -190,9 +190,7 @@
 	{KERN_SPARC_STOP_A, "stop-a", &stop_a_enabled, sizeof (int),
 	 0644, NULL, &proc_dointvec},
 #endif
-#ifdef CONFIG_PPC32
-	{KERN_PPC_ZEROPAGED, "zero-paged", &zero_paged_on, sizeof(int),
-	 0644, NULL, &proc_dointvec},
+#if defined(CONFIG_PPC32) && defined(CONFIG_6xx)
 	{KERN_PPC_POWERSAVE_NAP, "powersave-nap", &powersave_nap, sizeof(int),
 	 0644, NULL, &proc_dointvec},
 	{KERN_PPC_L2CR, "l2cr", NULL, 0,
