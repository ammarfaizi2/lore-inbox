Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSJLUSZ>; Sat, 12 Oct 2002 16:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbSJLUSZ>; Sat, 12 Oct 2002 16:18:25 -0400
Received: from mx2.airmail.net ([209.196.77.99]:26885 "EHLO mx2.airmail.net")
	by vger.kernel.org with ESMTP id <S261346AbSJLUSX>;
	Sat, 12 Oct 2002 16:18:23 -0400
Date: Sat, 12 Oct 2002 14:21:54 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 designated initializers for arch/i386
Message-ID: <20021012192154.GB2682@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a set of patches that switch arch/i386 to use C99 named
initiailzers. The patches are all against 2.5.42.

Art Haas


--- linux-2.5.42/arch/i386/kernel/cpu/intel.c.old	2002-10-12 09:46:27.000000000 -0500
+++ linux-2.5.42/arch/i386/kernel/cpu/intel.c	2002-10-12 09:53:20.000000000 -0500
@@ -366,7 +366,7 @@
 static struct cpu_dev intel_cpu_dev __initdata = {
 	.c_vendor	= "Intel",
 	.c_ident 	= { "GenuineIntel" },
-	c_models: {
+	.c_models = {
 		{ X86_VENDOR_INTEL,	4,
 		  { 
 			  [0] "486 DX-25/33", 
--- linux-2.5.42/arch/i386/kernel/cpu/rise.c.old	2002-08-27 19:10:37.000000000 -0500
+++ linux-2.5.42/arch/i386/kernel/cpu/rise.c	2002-10-12 09:53:20.000000000 -0500
@@ -31,7 +31,7 @@
 static struct cpu_dev rise_cpu_dev __initdata = {
 	.c_vendor	= "Rise",
 	.c_ident	= { "RiseRiseRise" },
-	c_models: {
+	.c_models = {
 		{ X86_VENDOR_RISE,	5,
 		  { 
 			  [0] "iDragon", 
--- linux-2.5.42/arch/i386/kernel/cpu/umc.c.old	2002-08-27 19:10:37.000000000 -0500
+++ linux-2.5.42/arch/i386/kernel/cpu/umc.c	2002-10-12 09:53:20.000000000 -0500
@@ -13,7 +13,7 @@
 static struct cpu_dev umc_cpu_dev __initdata = {
 	.c_vendor	= "UMC",
 	.c_ident 	= { "UMC UMC UMC" },
-	c_models: {
+	.c_models = {
 		{ X86_VENDOR_UMC,	4,
 		  { 
 			  [1] "U5D", 
--- linux-2.5.42/arch/i386/kernel/cpu/nexgen.c.old	2002-08-27 19:10:37.000000000 -0500
+++ linux-2.5.42/arch/i386/kernel/cpu/nexgen.c	2002-10-12 09:53:20.000000000 -0500
@@ -44,7 +44,7 @@
 static struct cpu_dev nexgen_cpu_dev __initdata = {
 	.c_vendor	= "Nexgen",
 	.c_ident	= { "NexGenDriven" },
-	c_models: {
+	.c_models = {
 		{ X86_VENDOR_NEXGEN,5, { [1] "Nx586" } },
 	},
 	.c_init		= init_nexgen,
--- linux-2.5.42/arch/i386/kernel/cpu/amd.c.old	2002-10-12 09:46:27.000000000 -0500
+++ linux-2.5.42/arch/i386/kernel/cpu/amd.c	2002-10-12 09:53:20.000000000 -0500
@@ -173,7 +173,7 @@
 static struct cpu_dev amd_cpu_dev __initdata = {
 	.c_vendor	= "AMD",
 	.c_ident 	= { "AuthenticAMD" },
-	c_models: {
+	.c_models = {
 		{ X86_VENDOR_AMD,	4,
 		  {
 			  [3] "486 DX/2",
--- linux-2.5.41/arch/i386/kernel/time.c.old	2002-10-01 11:45:31.000000000 -0500
+++ linux-2.5.41/arch/i386/kernel/time.c	2002-10-07 15:54:48.000000000 -0500
@@ -645,7 +645,7 @@
 }
 
 static struct notifier_block time_cpufreq_notifier_block = {
-	notifier_call:	time_cpufreq_notifier
+	.notifier_call	= time_cpufreq_notifier
 };
 #endif
 
--- linux-2.5.42/arch/i386/kernel/timers/timer_tsc.c.old	2002-10-12 09:46:27.000000000 -0500
+++ linux-2.5.42/arch/i386/kernel/timers/timer_tsc.c	2002-10-12 09:53:20.000000000 -0500
@@ -205,7 +205,7 @@
 }
 
 static struct notifier_block time_cpufreq_notifier_block = {
-	notifier_call:	time_cpufreq_notifier
+	.notifier_call	= time_cpufreq_notifier
 };
 #endif
 
--- linux-2.5.42/arch/i386/pci/numa.c.old	2002-08-31 21:57:11.000000000 -0500
+++ linux-2.5.42/arch/i386/pci/numa.c	2002-10-12 09:53:17.000000000 -0500
@@ -84,8 +84,8 @@
 }
 
 static struct pci_ops pci_direct_conf1_mq = {
-	read:	pci_conf1_mq_read,
-	write:	pci_conf1_mq_write
+	.read	= pci_conf1_mq_read,
+	.write	= pci_conf1_mq_write
 };
 
 
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
