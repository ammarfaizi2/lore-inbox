Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWJQS0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWJQS0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWJQS0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:26:13 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:48394 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S1750997AbWJQS0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:26:12 -0400
Date: Tue, 17 Oct 2006 14:17:47 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Randy Dunlap <rdunlap@xenotime.net>
cc: Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH] Restore sysctl syscall option for non-embedded users
In-Reply-To: <20061017091901.7193312a.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0610171401130.10587@lancer.cnet.absolutedigital.net>
References: <453519EE.76E4.0078.0@novell.com> <20061017091901.7193312a.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006, Randy Dunlap wrote:

> On Tue, 17 Oct 2006 16:59:10 +0100 Jan Beulich wrote:
> 
> > What is the purpose of
> > 
> > config SYSCTL_SYSCALL
> > 	bool "Sysctl syscall support" if EMBEDDED
> > 	default n
> > 
> > Allowing only embedded to turn this *on* ? Normally, you want
> > embedded to have more freedom in turning stuff off, so this
> > looks odd to me (and on one of my older boxes I definitely have
> > at least one OS-provided tool that uses this syscall, so I'd like
> > to be able to turn it on.
> 
> You can't enable it (after enabling EMBEDDED)?
> 
> Feel free to send a patch to remove /if EMBEDDED/
> and move the Kconfig entry up above all of the EMBEDDED options.

My dmesg gets spammed to all hell with these warnings. Can we keep this 
option easily visible till it gets ripped out Jan of 2007 (see 
Documentation/feature-removal-schedule.txt for reference)?

From: Cal Peake <cp@absolutedigital.net>

Restore the deprecated sysctl system call option for non-embedded users 
and mark it clearly deprecated.

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- ./init/Kconfig~orig	2006-10-17 13:52:05.000000000 -0400
+++ ./init/Kconfig	2006-10-17 13:58:25.000000000 -0400
@@ -286,24 +286,8 @@ config TASK_XACCT
 config SYSCTL
 	bool
 
-menuconfig EMBEDDED
-	bool "Configure standard kernel features (for small systems)"
-	help
-	  This option allows certain base kernel options and settings
-          to be disabled or tweaked. This is for specialized
-          environments which can tolerate a "non-standard" kernel.
-          Only use this if you really know what you are doing.
-
-config UID16
-	bool "Enable 16-bit UID system calls" if EMBEDDED
-	depends on ARM || CRIS || FRV || H8300 || X86_32 || M68K || (S390 && !64BIT) || SUPERH || SPARC32 || (SPARC64 && SPARC32_COMPAT) || UML || (X86_64 && IA32_EMULATION)
-	default y
-	help
-	  This enables the legacy 16-bit UID syscall wrappers.
-
 config SYSCTL_SYSCALL
-	bool "Sysctl syscall support" if EMBEDDED
-	default n
+	bool "Sysctl syscall support (DEPRECATED)"
 	select SYSCTL
 	---help---
 	  Enable the deprecated sysctl system call.  sys_sysctl uses
@@ -318,6 +302,21 @@ config SYSCTL_SYSCALL
 	  Unless you have an application that uses the sys_sysctl interface
  	  you should probably say N here.
 
+menuconfig EMBEDDED
+	bool "Configure standard kernel features (for small systems)"
+	help
+	  This option allows certain base kernel options and settings
+          to be disabled or tweaked. This is for specialized
+          environments which can tolerate a "non-standard" kernel.
+          Only use this if you really know what you are doing.
+
+config UID16
+	bool "Enable 16-bit UID system calls" if EMBEDDED
+	depends on ARM || CRIS || FRV || H8300 || X86_32 || M68K || (S390 && !64BIT) || SUPERH || SPARC32 || (SPARC64 && SPARC32_COMPAT) || UML || (X86_64 && IA32_EMULATION)
+	default y
+	help
+	  This enables the legacy 16-bit UID syscall wrappers.
+
 config KALLSYMS
 	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
 	 default y
