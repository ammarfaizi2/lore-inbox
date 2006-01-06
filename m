Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752446AbWAFQcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbWAFQcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbWAFQam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:30:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40639 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752446AbWAFQaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:30:06 -0500
Date: Fri, 6 Jan 2006 16:29:35 GMT
Message-Id: <200601061629.k06GTZ2F011360@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 1/17] FRV: Suppress configuration of certain features for FRV
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch suppresses configuration of certain features for the FRV
arch as they can't be built for FRV at the moment:

 (*) RTC

 (*) HISAX_*

 (*) PARPORT_PC

 (*) VGA_CONSOLE

 (*) BINFMT_ELF

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-deconfig-2615.diff
 drivers/char/Kconfig          |    4 ++--
 drivers/isdn/hisax/Kconfig    |   10 +++++-----
 drivers/parport/Kconfig       |    2 +-
 drivers/video/console/Kconfig |    2 +-
 fs/Kconfig.binfmt             |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15/drivers/char/Kconfig linux-2.6.15-frv/drivers/char/Kconfig
--- /warthog/kernels/linux-2.6.15/drivers/char/Kconfig	2006-01-04 12:39:24.000000000 +0000
+++ linux-2.6.15-frv/drivers/char/Kconfig	2006-01-06 14:45:11.000000000 +0000
@@ -687,7 +687,7 @@ config NVRAM
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64 && !M68K && (!SPARC || PCI)
+	depends on !PPC32 && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -735,7 +735,7 @@ config SGI_IP27_RTC
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC
+	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
diff -uNrp /warthog/kernels/linux-2.6.15/drivers/isdn/hisax/Kconfig linux-2.6.15-frv/drivers/isdn/hisax/Kconfig
--- /warthog/kernels/linux-2.6.15/drivers/isdn/hisax/Kconfig	2006-01-04 12:39:26.000000000 +0000
+++ linux-2.6.15-frv/drivers/isdn/hisax/Kconfig	2006-01-06 14:43:43.000000000 +0000
@@ -110,7 +110,7 @@ config HISAX_16_3
 
 config HISAX_TELESPCI
 	bool "Teles PCI"
-	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K))
+	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
 	help
 	  This enables HiSax support for the Teles PCI.
 	  See <file:Documentation/isdn/README.HiSax> on how to configure it.
@@ -238,7 +238,7 @@ config HISAX_MIC
 
 config HISAX_NETJET
 	bool "NETjet card"
-	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K))
+	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
 	help
 	  This enables HiSax support for the NetJet from Traverse
 	  Technologies.
@@ -249,7 +249,7 @@ config HISAX_NETJET
 
 config HISAX_NETJET_U
 	bool "NETspider U card"
-	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K))
+	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
 	help
 	  This enables HiSax support for the Netspider U interface ISDN card
 	  from Traverse Technologies.
@@ -317,7 +317,7 @@ config HISAX_GAZEL
 
 config HISAX_HFC_PCI
 	bool "HFC PCI-Bus cards"
-	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K))
+	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
 	help
 	  This enables HiSax support for the HFC-S PCI 2BDS0 based cards.
 
@@ -344,7 +344,7 @@ config HISAX_HFC_SX
 
 config HISAX_ENTERNOW_PCI
 	bool "Formula-n enter:now PCI card"
-	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K))
+	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
 	help
 	  This enables HiSax support for the Formula-n enter:now PCI
 	  ISDN card.
diff -uNrp /warthog/kernels/linux-2.6.15/drivers/parport/Kconfig linux-2.6.15-frv/drivers/parport/Kconfig
--- /warthog/kernels/linux-2.6.15/drivers/parport/Kconfig	2005-08-30 13:56:21.000000000 +0100
+++ linux-2.6.15-frv/drivers/parport/Kconfig	2006-01-06 14:43:43.000000000 +0000
@@ -34,7 +34,7 @@ config PARPORT
 
 config PARPORT_PC
 	tristate "PC-style hardware"
-	depends on PARPORT && (!SPARC64 || PCI) && !SPARC32 && !M32R
+	depends on PARPORT && (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV
 	---help---
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
diff -uNrp /warthog/kernels/linux-2.6.15/drivers/video/console/Kconfig linux-2.6.15-frv/drivers/video/console/Kconfig
--- /warthog/kernels/linux-2.6.15/drivers/video/console/Kconfig	2006-01-04 12:39:34.000000000 +0000
+++ linux-2.6.15-frv/drivers/video/console/Kconfig	2006-01-06 14:46:13.000000000 +0000
@@ -6,7 +6,7 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EMBEDDED || !X86
-	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !ARCH_VERSATILE
+	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
diff -uNrp /warthog/kernels/linux-2.6.15/fs/Kconfig.binfmt linux-2.6.15-frv/fs/Kconfig.binfmt
--- /warthog/kernels/linux-2.6.15/fs/Kconfig.binfmt	2006-01-04 12:39:35.000000000 +0000
+++ linux-2.6.15-frv/fs/Kconfig.binfmt	2006-01-06 14:43:43.000000000 +0000
@@ -1,6 +1,6 @@
 config BINFMT_ELF
 	bool "Kernel support for ELF binaries"
-	depends on MMU
+	depends on MMU && (BROKEN || !FRV)
 	default y
 	---help---
 	  ELF (Executable and Linkable Format) is a format for libraries and
