Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264270AbTCXQeh>; Mon, 24 Mar 2003 11:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264298AbTCXQbL>; Mon, 24 Mar 2003 11:31:11 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:31210 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264269AbTCXQar>; Mon, 24 Mar 2003 11:30:47 -0500
Message-Id: <200303241641.h2OGfv35008200@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:45 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Make cpuid driver preempt safe.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpuid.c linux-2.5/arch/i386/kernel/cpuid.c
--- bk-linus/arch/i386/kernel/cpuid.c	2003-03-08 09:56:25.000000000 +0000
+++ linux-2.5/arch/i386/kernel/cpuid.c	2003-03-18 21:22:12.000000000 +0000
@@ -64,6 +64,7 @@ static inline void do_cpuid(int cpu, u32
 {
   struct cpuid_command cmd;
   
+  preempt_disable();
   if ( cpu == smp_processor_id() ) {
     cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
   } else {
@@ -73,6 +74,7 @@ static inline void do_cpuid(int cpu, u32
     
     smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
   }
+  preempt_enable();
 }
 #else /* ! CONFIG_SMP */
 
