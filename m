Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267344AbTBPS7e>; Sun, 16 Feb 2003 13:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTBPS7e>; Sun, 16 Feb 2003 13:59:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60945 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267344AbTBPS7d>;
	Sun, 16 Feb 2003 13:59:33 -0500
Date: Sun, 16 Feb 2003 19:09:30 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND 6] sysctls for PA-RISC
Message-ID: <20030216190930.B6290@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can anyone think why Linus isn't applying this patch?  He won't tell
me what's wrong with it, and I'm getting frustrated by the silence.

Add two new sysctls.  The first one handles the soft-power switch
and the second describes what to do when we get an unaligned trap.

--- linus-2.5/include/linux/sysctl.h	Sun Jan  5 11:03:43 2003
+++ parisc-2.5/include/linux/sysctl.h	Sun Jan  5 11:23:43 2003
@@ -129,6 +129,8 @@ enum
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
+	KERN_HPPA_PWRSW=57,	/* int: hppa soft-power enable */
+	KERN_HPPA_UNALIGNED=58,	/* int: hppa unaligned-trap enable */
 };
 
 
--- linus-2.5/kernel/sysctl.c	Sun Jan  5 11:03:50 2003
+++ parisc-2.5/kernel/sysctl.c	Sun Jan  5 11:23:55 2003
@@ -84,6 +84,11 @@ extern char reboot_command [];
 extern int stop_a_enabled;
 #endif
 
+#ifdef __hppa__
+extern int pwrsw_enabled;
+extern int unaligned_enabled;
+#endif
+
 #ifdef CONFIG_ARCH_S390
 #ifdef CONFIG_MATHEMU
 extern int sysctl_ieee_emulation_warnings;
@@ -188,6 +193,12 @@ static ctl_table kern_table[] = {
 	{KERN_SPARC_REBOOT, "reboot-cmd", reboot_command,
 	 256, 0644, NULL, &proc_dostring, &sysctl_string },
 	{KERN_SPARC_STOP_A, "stop-a", &stop_a_enabled, sizeof (int),
+	 0644, NULL, &proc_dointvec},
+#endif
+#ifdef __hppa__
+	{KERN_HPPA_PWRSW, "soft-power", &pwrsw_enabled, sizeof (int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_HPPA_UNALIGNED, "unaligned-trap", &unaligned_enabled, sizeof (int),
 	 0644, NULL, &proc_dointvec},
 #endif
 #if defined(CONFIG_PPC32) && defined(CONFIG_6xx)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
