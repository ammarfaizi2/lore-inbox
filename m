Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSL3Vgj>; Mon, 30 Dec 2002 16:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbSL3Vgj>; Mon, 30 Dec 2002 16:36:39 -0500
Received: from verein.lst.de ([212.34.181.86]:33809 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261506AbSL3Vgh>;
	Mon, 30 Dec 2002 16:36:37 -0500
Date: Mon, 30 Dec 2002 22:44:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       james.bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rename CONFIG_VOYAGER to CONFIG_X86_VOYAGER
Message-ID: <20021230224456.A20753@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	james.bottomley@steeleye.com, linux-kernel@vger.kernel.org
References: <20021230215018.A20215@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021230215018.A20215@lst.de>; from hch@lst.de on Mon, Dec 30, 2002 at 09:50:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 09:50:18PM +0100, Christoph Hellwig wrote:
> The name is just a bit too generic, and we already use the _X86 prefix
> for lots of other stuff in that area.  Dito for the never use CONFIG_PC
> and CONFIG_VISWS.

James noticed that I forgot to update the choice default.  Here's a
new patch:


--- 1.22/arch/i386/Kconfig	Sun Dec 29 21:03:34 2002
+++ edited/arch/i386/Kconfig	Mon Dec 30 21:57:55 2002
@@ -40,14 +40,14 @@
 
 choice
 	prompt "Subarchitecture Type"
-	default PC
+	default X86_PC
 
-config PC
+config X86_PC
 	bool "IBM PC (and compatible)"
 	help
 	  Choose this option if your computer is a standard PC or compatible.
 
-config VOYAGER
+config X86_VOYAGER
 	bool "NCR Voyager"
 	help
 	  Voyager is a MCA based 32 way capable SMP architecture proprietary
@@ -407,7 +407,7 @@
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !SMP
-	depends on !VOYAGER
+	depends on !X86_VOYAGER
 	---help---
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
@@ -737,7 +737,7 @@
 
 
 menu "Power management options (ACPI, APM)"
-	depends on !VOYAGER
+	depends on !X86_VOYAGER
 
 config PM
 	bool "Power Management support"
@@ -1040,18 +1040,18 @@
 
 config X86_VISWS_APIC
 	bool
-	depends on VISWS
+	depends on X86_VISWS
 	default y
 
 config X86_LOCAL_APIC
 	bool
-	depends on ((!VISWS && SMP) || VISWS) && !VOYAGER
+	depends on (X86_VISWS || SMP) && !X86_VOYAGER
 	default y
 
 config PCI
-	bool "PCI support" if !VISWS
-	depends on !VOYAGER
-	default y if VISWS
+	bool "PCI support" if !X86_VISWS
+	depends on !X86_VOYAGER
+	default y if X86_VISWS
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
@@ -1065,12 +1065,12 @@
 
 config X86_IO_APIC
 	bool
-	depends on !VISWS && SMP && !VOYAGER
+	depends on SMP && !(X86_VISWS || X86_VOYAGER)
 	default y
 
 choice
 	prompt "PCI access mode"
-	depends on !VISWS && PCI
+	depends on PCI && !X86_VISWS
 	default PCI_GOANY
 
 config PCI_GOBIOS
@@ -1099,17 +1099,17 @@
 
 config PCI_BIOS
 	bool
-	depends on !VISWS && PCI && (PCI_GOBIOS || PCI_GOANY)
+	depends on !X86_VISWS && PCI && (PCI_GOBIOS || PCI_GOANY)
 	default y
 
 config PCI_DIRECT
 	bool
-	depends on !VISWS && PCI && (PCI_GODIRECT || PCI_GOANY)
+	depends on !X86_VISWS && PCI && (PCI_GODIRECT || PCI_GOANY)
 	default y
 
 config SCx200
 	tristate "NatSemi SCx200 support"
-	depends on !VOYAGER
+	depends on !X86_VOYAGER
 	help
 	  This provides basic support for the National Semiconductor SCx200 
 	  processor.  Right now this is just a driver for the GPIO pins.
@@ -1123,7 +1123,7 @@
 
 config ISA
 	bool "ISA support"
-	depends on !VOYAGER
+	depends on !(X86_VOYAGER || X86_VISWS)
 	help
 	  Find out whether you have ISA slots on your motherboard.  ISA is the
 	  name of a bus system, i.e. the way the CPU talks to the other stuff
@@ -1149,7 +1149,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !VISWS && !VOYAGER
+	depends on !(X86_VISWS || X86_VOYAGER)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
@@ -1157,8 +1157,8 @@
 	  there) before attempting to build an MCA bus kernel.
 
 config MCA
-	depends on VOYAGER
-	default y if VOYAGER
+	depends on X86_VOYAGER
+	default y if X86_VOYAGER
 
 source "drivers/mca/Kconfig"
 
@@ -1626,12 +1626,12 @@
 
 config X86_EXTRA_IRQS
 	bool
-	depends on X86_LOCAL_APIC || VOYAGER
+	depends on X86_LOCAL_APIC || X86_VOYAGER
 	default y
 
 config X86_FIND_SMP_CONFIG
 	bool
-	depends on X86_LOCAL_APIC || VOYAGER
+	depends on X86_LOCAL_APIC || X86_VOYAGER
 	default y
 
 config X86_MPPARSE
@@ -1649,17 +1649,17 @@
 
 config X86_SMP
 	bool
-	depends on SMP && !VOYAGER
+	depends on SMP && !X86_VOYAGER
 	default y
 
 config X86_HT
 	bool
-	depends on SMP && !VOYAGER
+	depends on SMP && !X86_VOYAGER
 	default y
 
 config X86_BIOS_REBOOT
 	bool
-	depends on !VOYAGER
+	depends on !X86_VOYAGER
 	default y
 
 config X86_TRAMPOLINE
