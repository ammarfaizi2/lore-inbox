Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSFQMXW>; Mon, 17 Jun 2002 08:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSFQMXV>; Mon, 17 Jun 2002 08:23:21 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:60086 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311885AbSFQMXU>; Mon, 17 Jun 2002 08:23:20 -0400
Date: Mon, 17 Jun 2002 13:55:50 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Hanno =?ISO-8859-1?Q?B=F6ck?= <hanno@gmx.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>
Subject: [PATCH][2.5] Make SMP/APIC config option earlier
In-Reply-To: <20020617125905.5511b12c.hanno@gmx.de>
Message-ID: <Pine.LNX.4.44.0206171351420.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to reorder the APIC configuration so that dependencies are 
determined beforehand for MCE. Keith Owens pointed this out a whiles back 
actually.

Please apply,
	Zwane

--- linux-2.5.22-mk/arch/i386/config.in.orig	Mon Jun 17 13:55:08 2002
+++ linux-2.5.22-mk/arch/i386/config.in	Mon Jun 17 14:03:16 2002
@@ -153,9 +153,24 @@
    define_bool CONFIG_X86_OOSTORE y
 fi
 
+bool 'Symmetric multi-processing support' CONFIG_SMP
+bool 'Preemptible Kernel' CONFIG_PREEMPT
+if [ "$CONFIG_SMP" != "y" ]; then
+   bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
+   dep_bool 'IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC $CONFIG_X86_UP_APIC
+   if [ "$CONFIG_X86_UP_APIC" = "y" ]; then
+      define_bool CONFIG_X86_LOCAL_APIC y
+   fi
+   if [ "$CONFIG_X86_UP_IOAPIC" = "y" ]; then
+      define_bool CONFIG_X86_IO_APIC y
+   fi
+else
+   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+fi
+
 bool 'Machine Check Exception' CONFIG_X86_MCE
 dep_bool 'Check for non-fatal errors on Athlon/Duron' CONFIG_X86_MCE_NONFATAL $CONFIG_X86_MCE
-dep_bool 'check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_LOCAL_APIC
+dep_bool 'check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_UP_APIC
 
 
 tristate 'Toshiba Laptop support' CONFIG_TOSHIBA
@@ -185,20 +200,6 @@
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
-bool 'Symmetric multi-processing support' CONFIG_SMP
-bool 'Preemptible Kernel' CONFIG_PREEMPT
-if [ "$CONFIG_SMP" != "y" ]; then
-   bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
-   dep_bool 'IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC $CONFIG_X86_UP_APIC
-   if [ "$CONFIG_X86_UP_APIC" = "y" ]; then
-      define_bool CONFIG_X86_LOCAL_APIC y
-   fi
-   if [ "$CONFIG_X86_UP_IOAPIC" = "y" ]; then
-      define_bool CONFIG_X86_IO_APIC y
-   fi
-else
-   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
-fi
 
 if [ "$CONFIG_SMP" = "y" -o "$CONFIG_PREEMPT" = "y" ]; then
    if [ "$CONFIG_X86_CMPXCHG" = "y" ]; then

		

