Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267363AbSKPVIs>; Sat, 16 Nov 2002 16:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267364AbSKPVIr>; Sat, 16 Nov 2002 16:08:47 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35574 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267363AbSKPVIp>; Sat, 16 Nov 2002 16:08:45 -0500
Date: Sat, 16 Nov 2002 22:15:36 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: James.Bottomley@HansenPartnership.com
Cc: linux-kernel@vger.kernel.org
Subject: RFC: [2.5 patch] Create a "Subarchitecture" menu
Message-ID: <20021116211536.GF28356@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My impression is that it's currently easy to accidentially activate the
Voyager support in 2.5.47 by typing once too often "y" which results in
a kernel that doesn't boot on a PC. The patch below is a suggestion to
to create a "Subarchitecture" choice.

The wording might not be perfect and it might make sense to add other
subarchs there, too. I'm interested in comments whether this is a good
idea or whether there are reasons why this is a bad idea.

TIA
Adrian


--- linux-2.5.47-full/arch/i386/Kconfig.old	2002-11-16 21:36:44.000000000 +0100
+++ linux-2.5.47-full/arch/i386/Kconfig	2002-11-16 22:02:47.000000000 +0100
@@ -39,7 +39,33 @@
 menu "Processor type and features"
 
 choice
+	prompt "Subarchitecture"
+	default PC
+
+config PC
+	bool "PC"
+	help
+	  Choose this option if your computer is a PC.
+
+	  Choose this option unless you really know what you are doing.
+
+config VOYAGER
+	bool "Support for the NCR Voyager Architecture"
+	help
+	  Voyager is a MCA based 32 way capable SMP architecture proprietary
+	  to NCR Corp.  Machine classes 345x/35xx/4100/51xx are voyager based.
+  
+	  *** WARNING ***
+
+	  If you do not specifically know you have a Voyager based machine,
+	  don't choose this option otherwise the kernel you build will not
+	  be bootable.
+
+endchoice
+
+choice
 	prompt "Processor family"
+	depends on PC
 	default M686
 
 config M386
@@ -980,17 +1006,6 @@
 
 menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
 
-config VOYAGER
-	bool "Support for the NCR Voyager Architecture"
-	depends on MCA
-	help
-	  Voyager is a MCA based 32 way capable SMP architecture proprietary
-	  to NCR Corp.  Machine classes 345x/35xx/4100/51xx are voyager based.
-  
-	  *** WARNING ***
-
-	  If you do not specifically know you have a Voyager based machine,
-	  say N here otherwise the kernel you build will not be bootable.
 
 # Visual Workstation support is utterly broken.
 # If you want to see it working mail an VW540 to hch@infradead.org 8)
@@ -1102,8 +1117,12 @@
 	  Otherwise, say N.
 
 config MCA
+	bool
+	depends on VOYAGER
+
+config MCA
 	bool "MCA support"
-	depends on !VISWS
+	depends on !VISWS && !VOYAGER
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
