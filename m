Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTIBOgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 10:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbTIBOgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 10:36:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40321 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263758AbTIBOed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 10:34:33 -0400
Date: Tue, 2 Sep 2003 15:34:24 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_64_BIT
Message-ID: <20030902143424.GO13467@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What do people think of CONFIG_64_BIT?  It saves us from using
!(IA64 || MIPS64 || PARISC64 || S390X || SPARC64 || X86_64) or
the X86_64 people deciding their architecture is more important.

I also considered CONFIG_ILP32 vs CONFIG_LP64 (since that's the real
problem with, eg, megaraid), but that requires more explanation and
offers people several ways to get it wrong (should I depend on ILP32
or !LP64?)

Index: arch/alpha/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/alpha/Kconfig,v
retrieving revision 1.3
diff -u -p -r1.3 Kconfig
--- arch/alpha/Kconfig	23 Aug 2003 02:46:12 -0000	1.3
+++ arch/alpha/Kconfig	2 Sep 2003 14:24:46 -0000
@@ -11,6 +11,9 @@ config ALPHA
 	  now Hewlett-Packard.  The Alpha Linux project has a home page at
 	  <http://www.alphalinux.org/>.
 
+config 64_BIT
+	def_bool y
+
 config MMU
 	bool
 	default y
Index: arch/ia64/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ia64/Kconfig,v
retrieving revision 1.2
diff -u -p -r1.2 Kconfig
--- arch/ia64/Kconfig	12 Aug 2003 19:10:49 -0000	1.2
+++ arch/ia64/Kconfig	2 Sep 2003 14:24:46 -0000
@@ -18,6 +18,9 @@ config IA64
 	  page at <http://www.linuxia64.org/> and a mailing list at
 	  linux-ia64@linuxia64.org.
 
+config 64_BIT
+	def_bool y
+
 config MMU
 	bool
 	default y
Index: arch/mips/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/mips/Kconfig,v
retrieving revision 1.2
diff -u -p -r1.2 Kconfig
--- arch/mips/Kconfig	12 Aug 2003 19:10:50 -0000	1.2
+++ arch/mips/Kconfig	2 Sep 2003 14:24:47 -0000
@@ -11,6 +11,9 @@ config MIPS64
 	  64-bit processing, otherwise say N.  You must say Y for kernels for
 	  SGI IP27 (Origin 200 and 2000).  If in doubt say N.
 
+config 64_BIT
+	def_bool MIPS64
+
 config MIPS32
 	bool
 	depends on MIPS64 = 'n'
Index: arch/parisc/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/parisc/Kconfig,v
retrieving revision 1.6
diff -u -p -r1.6 Kconfig
--- arch/parisc/Kconfig	23 Aug 2003 02:56:56 -0000	1.6
+++ arch/parisc/Kconfig	2 Sep 2003 14:24:47 -0000
@@ -103,6 +103,9 @@ config PARISC64
 	  enable this option otherwise. The 64bit kernel is significantly bigger
 	  and slower than the 32bit one.
 
+config 64_BIT
+	def_bool PARISC64
+
 config PDC_NARROW
 	bool "32-bit firmware"
 	depends on PARISC64
Index: arch/ppc64/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ppc64/Kconfig,v
retrieving revision 1.3
diff -u -p -r1.3 Kconfig
--- arch/ppc64/Kconfig	23 Aug 2003 02:46:30 -0000	1.3
+++ arch/ppc64/Kconfig	2 Sep 2003 14:24:47 -0000
@@ -3,6 +3,9 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+config 64_BIT
+	def_bool y
+
 config MMU
 	bool
 	default y
Index: arch/s390/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/s390/Kconfig,v
retrieving revision 1.2
diff -u -p -r1.2 Kconfig
--- arch/s390/Kconfig	12 Aug 2003 19:10:57 -0000	1.2
+++ arch/s390/Kconfig	2 Sep 2003 14:24:47 -0000
@@ -40,6 +40,9 @@ config ARCH_S390X
 	  Select this option if you have a 64 bit IBM zSeries machine
 	  and want to use the 64 bit addressing mode.
 
+config 64_BIT
+	def_bool ARCH_S390X
+
 config ARCH_S390_31
 	bool
 	depends on ARCH_S390X = 'n'
Index: arch/sparc64/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/sparc64/Kconfig,v
retrieving revision 1.3
diff -u -p -r1.3 Kconfig
--- arch/sparc64/Kconfig	12 Aug 2003 19:10:57 -0000	1.3
+++ arch/sparc64/Kconfig	2 Sep 2003 14:24:47 -0000
@@ -5,6 +5,9 @@
 
 mainmenu "Linux/UltraSPARC Kernel Configuration"
 
+config 64_BIT
+	def_bool y
+
 config MMU
 	bool
 	default y
Index: arch/x86_64/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/x86_64/Kconfig,v
retrieving revision 1.2
diff -u -p -r1.2 Kconfig
--- arch/x86_64/Kconfig	12 Aug 2003 19:10:59 -0000	1.2
+++ arch/x86_64/Kconfig	2 Sep 2003 14:24:47 -0000
@@ -16,6 +16,9 @@ config X86_64
 	  Port to the x86-64 architecture. x86-64 is a 64-bit extension to the
 	  classical 32-bit x86 architecture. For details see http://www.x86-64.org
 
+config 64_BIT
+	def_bool y
+
 config X86
 	bool
 	default y
Index: drivers/scsi/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/scsi/Kconfig,v
retrieving revision 1.3
diff -u -p -r1.3 Kconfig
--- drivers/scsi/Kconfig	25 Aug 2003 19:49:06 -0000	1.3
+++ drivers/scsi/Kconfig	2 Sep 2003 14:24:48 -0000
@@ -355,7 +355,7 @@ source "drivers/scsi/aic7xxx/Kconfig.aic
 # All the I2O code and drivers do not seem to be 64bit safe.
 config SCSI_DPT_I2O
 	tristate "Adaptec I2O RAID support "
-	depends on !X86_64 && SCSI
+	depends on !64_BIT && SCSI
 	help
 	  This driver supports all of Adaptec's I2O based RAID controllers as 
 	  well as the DPT SmartRaid V cards.  This is an Adaptec maintained
@@ -416,7 +416,7 @@ config SCSI_AM53C974
 
 config SCSI_MEGARAID
 	tristate "AMI MegaRAID support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && !64_BIT
 	help
 	  This driver supports the AMI MegaRAID 418, 428, 438, 466, 762, 490
 	  and 467 SCSI host adapters.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

What do people think of CONFIG_64_BIT?  It saves us from using
!(IA64 || MIPS64 || PARISC64 || S390X || SPARC64 || X86_64) or
the X86_64 people deciding their architecture is more important.

I also considered CONFIG_ILP32 vs CONFIG_LP64 (since that's the real
problem with, eg, megaraid), but that requires more explanation and
offers people several ways to get it wrong (should I depend on ILP32
or !LP64?)

Index: arch/alpha/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/alpha/Kconfig,v
retrieving revision 1.3
diff -u -p -r1.3 Kconfig
--- arch/alpha/Kconfig	23 Aug 2003 02:46:12 -0000	1.3
+++ arch/alpha/Kconfig	2 Sep 2003 14:24:46 -0000
@@ -11,6 +11,9 @@ config ALPHA
 	  now Hewlett-Packard.  The Alpha Linux project has a home page at
 	  <http://www.alphalinux.org/>.
 
+config 64_BIT
+	def_bool y
+
 config MMU
 	bool
 	default y
Index: arch/ia64/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ia64/Kconfig,v
retrieving revision 1.2
diff -u -p -r1.2 Kconfig
--- arch/ia64/Kconfig	12 Aug 2003 19:10:49 -0000	1.2
+++ arch/ia64/Kconfig	2 Sep 2003 14:24:46 -0000
@@ -18,6 +18,9 @@ config IA64
 	  page at <http://www.linuxia64.org/> and a mailing list at
 	  linux-ia64@linuxia64.org.
 
+config 64_BIT
+	def_bool y
+
 config MMU
 	bool
 	default y
Index: arch/mips/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/mips/Kconfig,v
retrieving revision 1.2
diff -u -p -r1.2 Kconfig
--- arch/mips/Kconfig	12 Aug 2003 19:10:50 -0000	1.2
+++ arch/mips/Kconfig	2 Sep 2003 14:24:47 -0000
@@ -11,6 +11,9 @@ config MIPS64
 	  64-bit processing, otherwise say N.  You must say Y for kernels for
 	  SGI IP27 (Origin 200 and 2000).  If in doubt say N.
 
+config 64_BIT
+	def_bool MIPS64
+
 config MIPS32
 	bool
 	depends on MIPS64 = 'n'
Index: arch/parisc/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/parisc/Kconfig,v
retrieving revision 1.6
diff -u -p -r1.6 Kconfig
--- arch/parisc/Kconfig	23 Aug 2003 02:56:56 -0000	1.6
+++ arch/parisc/Kconfig	2 Sep 2003 14:24:47 -0000
@@ -103,6 +103,9 @@ config PARISC64
 	  enable this option otherwise. The 64bit kernel is significantly bigger
 	  and slower than the 32bit one.
 
+config 64_BIT
+	def_bool PARISC64
+
 config PDC_NARROW
 	bool "32-bit firmware"
 	depends on PARISC64
Index: arch/ppc64/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ppc64/Kconfig,v
retrieving revision 1.3
diff -u -p -r1.3 Kconfig
--- arch/ppc64/Kconfig	23 Aug 2003 02:46:30 -0000	1.3
+++ arch/ppc64/Kconfig	2 Sep 2003 14:24:47 -0000
@@ -3,6 +3,9 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+config 64_BIT
+	def_bool y
+
 config MMU
 	bool
 	default y
Index: arch/s390/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/s390/Kconfig,v
retrieving revision 1.2
diff -u -p -r1.2 Kconfig
--- arch/s390/Kconfig	12 Aug 2003 19:10:57 -0000	1.2
+++ arch/s390/Kconfig	2 Sep 2003 14:24:47 -0000
@@ -40,6 +40,9 @@ config ARCH_S390X
 	  Select this option if you have a 64 bit IBM zSeries machine
 	  and want to use the 64 bit addressing mode.
 
+config 64_BIT
+	def_bool ARCH_S390X
+
 config ARCH_S390_31
 	bool
 	depends on ARCH_S390X = 'n'
Index: arch/sparc64/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/sparc64/Kconfig,v
retrieving revision 1.3
diff -u -p -r1.3 Kconfig
--- arch/sparc64/Kconfig	12 Aug 2003 19:10:57 -0000	1.3
+++ arch/sparc64/Kconfig	2 Sep 2003 14:24:47 -0000
@@ -5,6 +5,9 @@
 
 mainmenu "Linux/UltraSPARC Kernel Configuration"
 
+config 64_BIT
+	def_bool y
+
 config MMU
 	bool
 	default y
Index: arch/x86_64/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/x86_64/Kconfig,v
retrieving revision 1.2
diff -u -p -r1.2 Kconfig
--- arch/x86_64/Kconfig	12 Aug 2003 19:10:59 -0000	1.2
+++ arch/x86_64/Kconfig	2 Sep 2003 14:24:47 -0000
@@ -16,6 +16,9 @@ config X86_64
 	  Port to the x86-64 architecture. x86-64 is a 64-bit extension to the
 	  classical 32-bit x86 architecture. For details see http://www.x86-64.org
 
+config 64_BIT
+	def_bool y
+
 config X86
 	bool
 	default y
Index: drivers/scsi/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/scsi/Kconfig,v
retrieving revision 1.3
diff -u -p -r1.3 Kconfig
--- drivers/scsi/Kconfig	25 Aug 2003 19:49:06 -0000	1.3
+++ drivers/scsi/Kconfig	2 Sep 2003 14:24:48 -0000
@@ -355,7 +355,7 @@ source "drivers/scsi/aic7xxx/Kconfig.aic
 # All the I2O code and drivers do not seem to be 64bit safe.
 config SCSI_DPT_I2O
 	tristate "Adaptec I2O RAID support "
-	depends on !X86_64 && SCSI
+	depends on !64_BIT && SCSI
 	help
 	  This driver supports all of Adaptec's I2O based RAID controllers as 
 	  well as the DPT SmartRaid V cards.  This is an Adaptec maintained
@@ -416,7 +416,7 @@ config SCSI_AM53C974
 
 config SCSI_MEGARAID
 	tristate "AMI MegaRAID support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && !64_BIT
 	help
 	  This driver supports the AMI MegaRAID 418, 428, 438, 466, 762, 490
 	  and 467 SCSI host adapters.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
