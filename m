Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSJNWb4>; Mon, 14 Oct 2002 18:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263081AbSJNWar>; Mon, 14 Oct 2002 18:30:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:54778 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262722AbSJNW1g>; Mon, 14 Oct 2002 18:27:36 -0400
Date: Mon, 14 Oct 2002 15:27:38 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Summit support for 2.5 - now with subarch! [1/5]
Message-ID: <77030000.1034634458@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just adds the config option for summit, and it's Config.help entry,
puts the hooks for the new mach_apic.h subarch file into the right
places, and creates empty shells of the header files.


diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/Config.help subarch-1/arch/i386/Config.help
--- virgin/arch/i386/Config.help	Fri Oct 11 21:21:31 2002
+++ subarch-1/arch/i386/Config.help	Sun Oct 13 20:16:03 2002
@@ -73,6 +73,12 @@ CONFIG_X86_CYCLONE
   If you are suffering from time skew using a multi-CEC system, say YES.
   Otherwise it is safe to say NO.
 
+CONFIG_X86_SUMMIT
+  This option is needed for IBM systems that use the Summit/EXA chipset.
+  In particular, it is needed for the x440.
+
+  If you don't have one of these computers, you should say N here.
+
 CONFIG_X86_UP_IOAPIC
   An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
   SMP-capable replacement for PC-style interrupt controllers. Most
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/config.in subarch-1/arch/i386/config.in
--- virgin/arch/i386/config.in	Fri Oct 11 21:21:38 2002
+++ subarch-1/arch/i386/config.in	Sun Oct 13 20:16:03 2002
@@ -172,7 +172,8 @@ else
   if [ "$CONFIG_X86_NUMA" = "y" ]; then
      #Platform Choices
      bool 'Multiquad (IBM/Sequent) NUMAQ support' CONFIG_X86_NUMAQ
-     if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
+     bool 'IBM x440 (Summit/EXA) support' CONFIG_X86_SUMMIT
+     if [ "$CONFIG_X86_NUMAQ" = "y" -o "$CONFIG_X86_SUMMIT" = "y" ]; then
         define_bool CONFIG_CLUSTERED_APIC y
      fi
      # Common NUMA Features
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/apic.c subarch-1/arch/i386/kernel/apic.c
--- virgin/arch/i386/kernel/apic.c	Fri Oct 11 21:22:46 2002
+++ subarch-1/arch/i386/kernel/apic.c	Sun Oct 13 20:16:03 2002
@@ -31,6 +31,7 @@
 #include <asm/pgalloc.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
+#include "mach_apic.h"
 
 void __init apic_intr_init(void)
 {
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/io_apic.c subarch-1/arch/i386/kernel/io_apic.c
--- virgin/arch/i386/kernel/io_apic.c	Fri Oct 11 21:21:38 2002
+++ subarch-1/arch/i386/kernel/io_apic.c	Sun Oct 13 20:16:03 2002
@@ -35,6 +35,7 @@
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/desc.h>
+#include "mach_apic.h"
 
 #undef APIC_LOCKUP_DEBUG
 
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/mach-generic/mach_apic.h subarch-1/arch/i386/mach-generic/mach_apic.h
--- virgin/arch/i386/mach-generic/mach_apic.h	Wed Dec 31 16:00:00 1969
+++ subarch-1/arch/i386/mach-generic/mach_apic.h	Sun Oct 13 20:16:21 2002
@@ -0,0 +1,4 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
+#endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/mach-summit/mach_apic.h subarch-1/arch/i386/mach-summit/mach_apic.h
--- virgin/arch/i386/mach-summit/mach_apic.h	Wed Dec 31 16:00:00 1969
+++ subarch-1/arch/i386/mach-summit/mach_apic.h	Sun Oct 13 20:16:52 2002
@@ -0,0 +1,4 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
+#endif /* __ASM_MACH_APIC_H */

