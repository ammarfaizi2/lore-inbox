Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSFEQgb>; Wed, 5 Jun 2002 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315528AbSFEQga>; Wed, 5 Jun 2002 12:36:30 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:16564
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315525AbSFEQg1>; Wed, 5 Jun 2002 12:36:27 -0400
Date: Wed, 5 Jun 2002 09:36:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Cleanup i386 <linux/init.h> abuses
Message-ID: <20020605163614.GF1335@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch cleans up the i386 usage of <linux/init.h>.
This remove <linux/init.h> from <asm-i386/system.h> which did not need
it, <asm-i386/highmem.h> which only had it due to an extern using
__init, which is not needed.
This adds <linux/init.h> to <asm-i386/bugs.h> which actually has
numerous __init functions and adds <linux/init.h> to 9 files inside of
arch/i386 which were indirectly including <linux/init.h> previously.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/i386/kernel/setup-visws.c 1.1 vs edited =====
--- 1.1/arch/i386/kernel/setup-visws.c	Tue Feb  5 16:59:42 2002
+++ edited/arch/i386/kernel/setup-visws.c	Wed Jun  5 09:15:52 2002
@@ -3,6 +3,8 @@
  *  Split out from setup.c by davej@suse.de
  */
 
+#include <linux/init.h>
+
 char visws_board_type = -1;
 char visws_board_rev = -1;
 
===== arch/i386/mm/ioremap.c 1.8 vs edited =====
--- 1.8/arch/i386/mm/ioremap.c	Fri May  3 05:26:39 2002
+++ edited/arch/i386/mm/ioremap.c	Wed Jun  5 09:02:02 2002
@@ -9,6 +9,7 @@
  */
 
 #include <linux/vmalloc.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/fixmap.h>
===== arch/i386/pci/acpi.c 1.7 vs edited =====
--- 1.7/arch/i386/pci/acpi.c	Wed May 29 15:54:35 2002
+++ edited/arch/i386/pci/acpi.c	Wed Jun  5 09:11:10 2002
@@ -1,5 +1,6 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <linux/init.h>
 #include "pci.h"
 
 static int __init pci_acpi_init(void)
===== arch/i386/pci/common.c 1.31 vs edited =====
--- 1.31/arch/i386/pci/common.c	Wed May 29 15:54:35 2002
+++ edited/arch/i386/pci/common.c	Wed Jun  5 09:11:18 2002
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/pci.h>
 #include <linux/ioport.h>
+#include <linux/init.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
===== arch/i386/pci/direct.c 1.6 vs edited =====
--- 1.6/arch/i386/pci/direct.c	Tue May  7 10:27:29 2002
+++ edited/arch/i386/pci/direct.c	Wed Jun  5 09:08:16 2002
@@ -3,6 +3,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/init.h>
 #include "pci.h"
 
 /*
===== arch/i386/pci/fixup.c 1.9 vs edited =====
--- 1.9/arch/i386/pci/fixup.c	Tue Jun  4 01:21:43 2002
+++ edited/arch/i386/pci/fixup.c	Wed Jun  5 09:11:20 2002
@@ -3,6 +3,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/init.h>
 #include "pci.h"
 
 
===== arch/i386/pci/legacy.c 1.6 vs edited =====
--- 1.6/arch/i386/pci/legacy.c	Wed May 29 15:54:35 2002
+++ edited/arch/i386/pci/legacy.c	Wed Jun  5 09:11:22 2002
@@ -1,6 +1,7 @@
 /*
  * legacy.c - traditional, old school PCI bus probing
  */
+#include <linux/init.h>
 #include <linux/pci.h>
 #include "pci.h"
 
===== arch/i386/pci/numa.c 1.7 vs edited =====
--- 1.7/arch/i386/pci/numa.c	Wed May 29 15:54:35 2002
+++ edited/arch/i386/pci/numa.c	Wed Jun  5 09:11:28 2002
@@ -2,6 +2,7 @@
  * numa.c - Low-level PCI access for NUMA-Q machines
  */
 #include <linux/pci.h>
+#include <linux/init.h>
 
 #include "pci.h"
 
===== arch/i386/pci/pcbios.c 1.6 vs edited =====
--- 1.6/arch/i386/pci/pcbios.c	Tue May  7 10:27:29 2002
+++ edited/arch/i386/pci/pcbios.c	Wed Jun  5 09:07:11 2002
@@ -3,6 +3,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/init.h>
 #include "pci.h"
 
 
===== include/asm-i386/bugs.h 1.6 vs edited =====
--- 1.6/include/asm-i386/bugs.h	Mon May 20 16:07:18 2002
+++ edited/include/asm-i386/bugs.h	Wed Jun  5 08:48:57 2002
@@ -21,6 +21,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/init.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/msr.h>
===== include/asm-i386/highmem.h 1.6 vs edited =====
--- 1.6/include/asm-i386/highmem.h	Thu Apr  4 21:51:47 2002
+++ edited/include/asm-i386/highmem.h	Wed Jun  5 08:48:57 2002
@@ -21,7 +21,6 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <asm/kmap_types.h>
 #include <asm/tlbflush.h>
@@ -33,7 +32,7 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void) __init;
+extern void kmap_init(void);
 
 /*
  * Right now we initialize only a single pte table. It can be extended
===== include/asm-i386/system.h 1.11 vs edited =====
--- 1.11/include/asm-i386/system.h	Tue Feb 12 09:53:18 2002
+++ edited/include/asm-i386/system.h	Wed Jun  5 08:48:57 2002
@@ -3,7 +3,6 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <asm/segment.h>
 #include <linux/bitops.h> /* for LOCK_PREFIX */
 
