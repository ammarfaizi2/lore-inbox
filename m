Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268399AbTBNM7p>; Fri, 14 Feb 2003 07:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268384AbTBNMzj>; Fri, 14 Feb 2003 07:55:39 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:27918 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268412AbTBNMxe>;
	Fri, 14 Feb 2003 07:53:34 -0500
Date: Fri, 14 Feb 2003 15:58:48 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: i386/KConfig update (13/13)
Message-ID: <20030214125848.GM8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CQDko/0aYvuiEzgn"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CQDko/0aYvuiEzgn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

And finally, attached patch enables visws subarch support 
in kernel config.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--CQDko/0aYvuiEzgn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-kconfig

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/Kconfig linux-2.5.60/arch/i386/Kconfig
--- linux-2.5.60.vanilla/arch/i386/Kconfig	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/Kconfig	Thu Feb 13 20:42:02 2003
@@ -83,18 +83,16 @@
 
 	  If you don't have such a system, you should say N here.
 
-# Visual Workstation support is utterly broken.
-# If you want to see it working mail an VW540 to hch@infradead.org 8)
-#config X86_VISWS
-#	bool "SGI 320/540 (Visual Workstation)"
-#	help
-#	  The SGI Visual Workstation series is an IA32-based workstation
-#	  based on SGI systems chips with some legacy PC hardware attached.
-#
-#	  Say Y here to create a kernel to run on the SGI 320 or 540.
-#
-#	  A kernel compiled for the Visual Workstation will not run on PCs
-#	  and vice versa. See <file:Documentation/sgi-visws.txt> for details.
+config X86_VISWS
+	bool "SGI 320/540 (Visual Workstation)"
+	help
+	  The SGI Visual Workstation series is an IA32-based workstation
+	  based on SGI systems chips with some legacy PC hardware attached.
+
+	  Say Y here to create a kernel to run on the SGI 320 or 540.
+
+	  A kernel compiled for the Visual Workstation will not run on PCs
+	  and vice versa. See <file:Documentation/sgi-visws.txt> for details.
 
 endchoice
 
@@ -422,7 +420,7 @@
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !SMP
-	depends on !X86_VOYAGER
+	depends on !(X86_VISWS || X86_VOYAGER)
 	---help---
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
@@ -1149,7 +1147,7 @@
 
 config PCI_DIRECT
 	bool
-	depends on !X86_VISWS && PCI && (PCI_GODIRECT || PCI_GOANY)
+ 	depends on PCI && ((PCI_GODIRECT || PCI_GOANY) || X86_VISWS)
 	default y
 
 config SCx200
@@ -1642,7 +1640,7 @@
 
 config X86_MPPARSE
 	bool
-	depends on X86_LOCAL_APIC
+	depends on X86_LOCAL_APIC && !X86_VISWS
 	default y
 
 endmenu
@@ -1660,15 +1658,15 @@
 
 config X86_HT
 	bool
-	depends on SMP && !X86_VOYAGER
+	depends on SMP && !(X86_VISWS || X86_VOYAGER)
 	default y
 
 config X86_BIOS_REBOOT
 	bool
-	depends on !X86_VOYAGER
+	depends on !(X86_VISWS || X86_VOYAGER)
 	default y
 
 config X86_TRAMPOLINE
 	bool
-	depends on SMP
+	depends on SMP || X86_VISWS
 	default y

--CQDko/0aYvuiEzgn--
