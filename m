Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbUKURey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbUKURey (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 12:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUKURey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 12:34:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27667 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261696AbUKURb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 12:31:29 -0500
Date: Sun, 21 Nov 2004 18:31:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com,
       pazke@donpac.ru, linux-visws-devel@lists.sf.net
Subject: [2.6 patch] i386 APIC Kconfig cleanups
Message-ID: <20041121173128.GA2924@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following changes to arch/i386/Kconfig:
- update the X86_UP_APIC and X86_UP_IOAPIC help texts:
  - in the SMP case, these options are not visible
  - today, it's no longer only "a small number of uniprocessor systems"
    that have an IO-APIC
- there were two X86_LOCAL_APIC and two X86_IO_APIC options -
  in both cases, merge them
- move X86_VISWS_APIC to the other APIC options

Please review this patch (it shouldn't have any visible effects).


diffstat output:
 arch/i386/Kconfig |   41 +++++++++++++----------------------------
 1 files changed, 13 insertions(+), 28 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2/arch/i386/Kconfig.old	2004-11-21 17:42:31.000000000 +0100
+++ linux-2.6.10-rc2/arch/i386/Kconfig	2004-11-21 18:26:00.000000000 +0100
@@ -514,9 +514,9 @@
 	  or real-time system.  Say N if you are unsure.
 
 config X86_UP_APIC
-	bool "Local APIC support on uniprocessors" if !SMP
-	depends on !(X86_VISWS || X86_VOYAGER)
-	---help---
+	bool "Local APIC support on uniprocessors"
+	depends on !SMP && !(X86_VISWS || X86_VOYAGER)
+	help
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
 	  system which has a processor with a local APIC, you can say Y here to
@@ -526,31 +526,31 @@
 	  performance counters), and the NMI watchdog which detects hard
 	  lockups.
 
-	  If you have a system with several CPUs, you do not need to say Y
-	  here: the local APIC will be used automatically.
-
 config X86_UP_IOAPIC
 	bool "IO-APIC support on uniprocessors"
-	depends on !SMP && X86_UP_APIC
+	depends on X86_UP_APIC
 	help
 	  An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
 	  SMP-capable replacement for PC-style interrupt controllers. Most
-	  SMP systems and a small number of uniprocessor systems have one.
+	  SMP systems and many recent uniprocessor systems have one.
+
 	  If you have a single-CPU system with an IO-APIC, you can say Y here
 	  to use it. If you say Y here even though your machine doesn't have
 	  an IO-APIC, then the kernel will still run with no slowdown at all.
 
-	  If you have a system with several CPUs, you do not need to say Y
-	  here: the IO-APIC will be used automatically.
-
 config X86_LOCAL_APIC
 	bool
-	depends on !SMP && X86_UP_APIC
+	depends on X86_UP_APIC || ((X86_VISWS || SMP) && !X86_VOYAGER)
 	default y
 
 config X86_IO_APIC
 	bool
-	depends on !SMP && X86_UP_IOAPIC
+	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER))
+	default y
+
+config X86_VISWS_APIC
+	bool
+	depends on X86_VISWS
 	default y
 
 config X86_TSC
@@ -1038,21 +1038,6 @@
 
 menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
 
-config X86_VISWS_APIC
-	bool
-	depends on X86_VISWS
-	default y
-
-config X86_LOCAL_APIC
-	bool
-	depends on (X86_VISWS || SMP) && !X86_VOYAGER
-	default y
-
-config X86_IO_APIC
-	bool
-	depends on SMP && !(X86_VISWS || X86_VOYAGER)
-	default y
-
 config PCI
 	bool "PCI support" if !X86_VISWS
 	depends on !X86_VOYAGER
