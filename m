Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbTBLC6T>; Tue, 11 Feb 2003 21:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbTBLC42>; Tue, 11 Feb 2003 21:56:28 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:12553 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S266081AbTBLCzy>; Tue, 11 Feb 2003 21:55:54 -0500
Date: Tue, 11 Feb 2003 20:59:50 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] C99 initializers for kernel/exec_domain.c
Message-ID: <20030212025950.GG914@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch converts the file to C99 initializers to remove warnings if
'-W' is used and to aid readability.

Art Haas

===== kernel/exec_domain.c 1.13 vs edited =====
--- 1.13/kernel/exec_domain.c	Mon Dec 30 11:10:06 2002
+++ edited/kernel/exec_domain.c	Tue Feb 11 10:50:41 2003
@@ -32,11 +32,12 @@
 };
 
 struct exec_domain default_exec_domain = {
-	"Linux",		/* name */
-	default_handler,	/* lcall7 causes a seg fault. */
-	0, 0,			/* PER_LINUX personality. */
-	ident_map,		/* Identity map signals. */
-	ident_map,		/*  - both ways. */
+	.name		= "Linux",		/* name */
+	.handler	= default_handler,	/* lcall7 causes a seg fault. */
+	.pers_low	= 0, 			/* PER_LINUX personality. */
+	.pers_high	= 0,			/* PER_LINUX personality. */
+	.signal_map	= ident_map,		/* Identity map signals. */
+	.signal_invmap	= ident_map,		/*  - both ways. */
 };
 
 
@@ -251,24 +252,66 @@
 int abi_fake_utsname;
 
 static struct ctl_table abi_table[] = {
-	{ABI_DEFHANDLER_COFF, "defhandler_coff", &abi_defhandler_coff,
-		sizeof(int), 0644, NULL, &proc_doulongvec_minmax},
-	{ABI_DEFHANDLER_ELF, "defhandler_elf", &abi_defhandler_elf,
-		sizeof(int), 0644, NULL, &proc_doulongvec_minmax},
-	{ABI_DEFHANDLER_LCALL7, "defhandler_lcall7", &abi_defhandler_lcall7,
-		sizeof(int), 0644, NULL, &proc_doulongvec_minmax},
-	{ABI_DEFHANDLER_LIBCSO, "defhandler_libcso", &abi_defhandler_libcso,
-		sizeof(int), 0644, NULL, &proc_doulongvec_minmax},
-	{ABI_TRACE, "trace", &abi_traceflg,
-		sizeof(u_int), 0644, NULL, &proc_dointvec},
-	{ABI_FAKE_UTSNAME, "fake_utsname", &abi_fake_utsname,
-		sizeof(int), 0644, NULL, &proc_dointvec},
-	{0}
+	{
+		.ctl_name	= ABI_DEFHANDLER_COFF,
+		.procname	= "defhandler_coff",
+		.data		= &abi_defhandler_coff,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_doulongvec_minmax
+	},
+	{
+		.ctl_name	= ABI_DEFHANDLER_ELF,
+		.procname	= "defhandler_elf",
+		.data		= &abi_defhandler_elf,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_doulongvec_minmax
+	},
+	{
+		.ctl_name	= ABI_DEFHANDLER_LCALL7,
+		.procname	= "defhandler_lcall7",
+		.data		= &abi_defhandler_lcall7,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_doulongvec_minmax
+	},
+	{
+		.ctl_name	= ABI_DEFHANDLER_LIBCSO,
+		.procname	= "defhandler_libcso",
+		.data		= &abi_defhandler_libcso,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_doulongvec_minmax
+	},
+	{
+		.ctl_name	= ABI_TRACE,
+		.procname	= "trace",
+		.data		= &abi_traceflg,
+		.maxlen		= sizeof(u_int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= ABI_FAKE_UTSNAME,
+		.procname	= "fake_utsname",
+		.data		= &abi_fake_utsname,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+	{ .ctl_name = 0 }
 };
 
 static struct ctl_table abi_root_table[] = {
-	{CTL_ABI, "abi", NULL, 0, 0555, abi_table},
-	{0}
+	{
+		.ctl_name	= CTL_ABI,
+		.procname	= "abi",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= abi_table
+	},
+	{ .ctl_name = 0 }
 };
 
 static int __init
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
