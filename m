Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265262AbUFAWct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265262AbUFAWct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbUFAWbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:31:18 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13221 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265261AbUFAWaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:30:21 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update [8/10]
Date: Wed, 2 Jun 2004 00:21:13 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406020021.13072.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: add IDE_ARCH_OBSOLETE_DEFAULTS

per jgarzik's suggestion

Define it in <asm/ide.h> if ide_default_io_base(),
ide_default_irq() and ide_init_default_irq() are needed.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc2-bk2-bzolnier/include/asm-alpha/ide.h             |    2 +
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-arm/ide.h               |    9 ------
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-arm26/ide.h             |    9 ------
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-h8300/ide.h             |    5 ---
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-i386/ide.h              |    2 +
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-ia64/ide.h              |    2 +
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-m68k/ide.h              |   13 ----------
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-mips/mach-generic/ide.h |    2 +
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-parisc/ide.h            |    5 ---
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-ppc/ide.h               |    2 +
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-ppc64/ide.h             |    5 ---
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-sh/ide.h                |    2 +
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-sparc/ide.h             |   12 ---------
 linux-2.6.7-rc2-bk2-bzolnier/include/asm-sparc64/ide.h           |   12 ---------
 linux-2.6.7-rc2-bk2-bzolnier/include/linux/ide.h                 |    7 +++++
 15 files changed, 19 insertions(+), 70 deletions(-)

diff -puN include/asm-alpha/ide.h~ide_arch_obsolete_defaults include/asm-alpha/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-alpha/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.104065296 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-alpha/ide.h	2004-06-01 19:57:47.175054504 +0200
@@ -19,6 +19,8 @@
 #define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
 #endif
 
+#define IDE_ARCH_OBSOLETE_DEFAULTS
+
 static inline int ide_default_irq(unsigned long base)
 {
 	switch (base) {
diff -puN include/asm-arm/ide.h~ide_arch_obsolete_defaults include/asm-arm/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-arm/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.108064688 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-arm/ide.h	2004-06-01 19:57:47.176054352 +0200
@@ -21,13 +21,6 @@
 # include <asm/arch/ide.h>	/* obsolete + broken */
 #endif
 
-/*
- * We always use the new IDE port registering,
- * so these are fixed here.
- */
-#define ide_default_io_base(i)		(0)
-#define ide_default_irq(b)		(0)
-
 #if !defined(CONFIG_ARCH_L7200) && !defined(CONFIG_ARCH_LH7A40X)
 # define IDE_ARCH_OBSOLETE_INIT
 # ifdef CONFIG_ARCH_CLPS7500
@@ -37,8 +30,6 @@
 # endif
 #endif /* !ARCH_L7200 && !ARCH_LH7A40X */
 
-#define ide_init_default_irq(base)	(0)
-
 #define __ide_mm_insw(port,addr,len)	readsw(port,addr,len)
 #define __ide_mm_insl(port,addr,len)	readsl(port,addr,len)
 #define __ide_mm_outsw(port,addr,len)	writesw(port,addr,len)
diff -puN include/asm-arm26/ide.h~ide_arch_obsolete_defaults include/asm-arm26/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-arm26/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.112064080 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-arm26/ide.h	2004-06-01 19:57:47.177054200 +0200
@@ -26,15 +26,6 @@
 #define __ide_mm_outsw(port,addr,len)   writesw(port,addr,len)
 #define __ide_mm_outsl(port,addr,len)   writesl(port,addr,len)
 
-#define ide_init_default_irq(base)	(0)
-
-/*
- * We always use the new IDE port registering,
- * so these are fixed here.
- */
-#define ide_default_io_base(i)		(0)
-#define ide_default_irq(b)		(0)
-
 #define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	(0)
 
diff -puN include/asm-h8300/ide.h~ide_arch_obsolete_defaults include/asm-h8300/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-h8300/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.116063472 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-h8300/ide.h	2004-06-01 19:57:47.177054200 +0200
@@ -16,11 +16,6 @@
 #ifdef __KERNEL__
 /****************************************************************************/
 
-#define ide_default_irq(base)		(0)
-#define ide_default_io_base(index)	(0)
-
-#define ide_init_default_irq(base)	(0)
-
 #define MAX_HWIFS	1
 
 #include <asm-generic/ide_iops.h>
diff -puN include/asm-i386/ide.h~ide_arch_obsolete_defaults include/asm-i386/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-i386/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.122062560 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-i386/ide.h	2004-06-01 19:57:47.178054048 +0200
@@ -23,6 +23,8 @@
 # endif
 #endif
 
+#define IDE_ARCH_OBSOLETE_DEFAULTS
+
 static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
diff -puN include/asm-ia64/ide.h~ide_arch_obsolete_defaults include/asm-ia64/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-ia64/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.126061952 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-ia64/ide.h	2004-06-01 19:57:47.178054048 +0200
@@ -25,6 +25,8 @@
 # endif
 #endif
 
+#define IDE_ARCH_OBSOLETE_DEFAULTS
+
 static inline int ide_default_irq(unsigned long base)
 {
 	switch (base) {
diff -puN include/asm-m68k/ide.h~ide_arch_obsolete_defaults include/asm-m68k/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-m68k/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.129061496 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-m68k/ide.h	2004-06-01 19:57:47.179053896 +0200
@@ -50,19 +50,6 @@
 #define MAX_HWIFS	4	/* same as the other archs */
 #endif
 
-
-static __inline__ int ide_default_irq(unsigned long base)
-{
-	  return 0;
-}
-
-static __inline__ unsigned long ide_default_io_base(int index)
-{
-          return 0;
-}
-
-#define ide_init_default_irq(base)	(0)
-
 /*
  * Get rid of defs from io.h - ide has its private and conflicting versions
  * Since so far no single m68k platform uses ISA/PCI I/O space for IDE, we
diff -puN include/asm-mips/mach-generic/ide.h~ide_arch_obsolete_defaults include/asm-mips/mach-generic/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-mips/mach-generic/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.133060888 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-mips/mach-generic/ide.h	2004-06-01 19:57:47.182053440 +0200
@@ -20,6 +20,8 @@
 # endif
 #endif
 
+#define IDE_ARCH_OBSOLETE_DEFAULTS
+
 static inline int ide_default_irq(unsigned long base)
 {
 	switch (base) {
diff -puN include/asm-parisc/ide.h~ide_arch_obsolete_defaults include/asm-parisc/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-parisc/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.136060432 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-parisc/ide.h	2004-06-01 19:57:47.185052984 +0200
@@ -19,14 +19,9 @@
 #define MAX_HWIFS	2
 #endif
 
-#define ide_default_irq(base) (0)
-#define ide_default_io_base(index) (0)
-
 #define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
-#define ide_init_default_irq(base)	(0)
-
 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
 #define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
 #define ide_check_region(from,extent)		check_region((from), (extent))
diff -puN include/asm-ppc/ide.h~ide_arch_obsolete_defaults include/asm-ppc/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-ppc/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.142059520 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-ppc/ide.h	2004-06-01 19:57:47.186052832 +0200
@@ -43,6 +43,8 @@ extern struct ide_machdep_calls ppc_ide_
 #undef	SUPPORT_SLOW_DATA_PORTS
 #define	SUPPORT_SLOW_DATA_PORTS	0
 
+#define IDE_ARCH_OBSOLETE_DEFAULTS
+
 static __inline__ int ide_default_irq(unsigned long base)
 {
 	if (ppc_ide_md.default_irq)
diff -puN include/asm-ppc64/ide.h~ide_arch_obsolete_defaults include/asm-ppc64/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-ppc64/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.146058912 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-ppc64/ide.h	2004-06-01 19:57:47.187052680 +0200
@@ -22,14 +22,9 @@
 # define MAX_HWIFS	4
 #endif
 
-static inline int ide_default_irq(unsigned long base) { return 0; }
-static inline unsigned long ide_default_io_base(int index) { return 0; }
-
 #define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
-#define ide_init_default_irq(base)	(0)
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASMPPC64_IDE_H */
diff -puN include/asm-sh/ide.h~ide_arch_obsolete_defaults include/asm-sh/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-sh/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.150058304 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-sh/ide.h	2004-06-01 19:57:47.188052528 +0200
@@ -22,6 +22,8 @@
 #define MAX_HWIFS	2
 #endif
 
+#define IDE_ARCH_OBSOLETE_DEFAULTS
+
 static inline int ide_default_irq_hp600(unsigned long base)
 {
 	switch (base) {
diff -puN include/asm-sparc/ide.h~ide_arch_obsolete_defaults include/asm-sparc/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-sparc/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.154057696 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-sparc/ide.h	2004-06-01 19:57:47.189052376 +0200
@@ -19,21 +19,9 @@
 #undef  MAX_HWIFS
 #define MAX_HWIFS	2
 
-static __inline__ int ide_default_irq(unsigned long base)
-{
-	return 0;
-}
-
-static __inline__ unsigned long ide_default_io_base(int index)
-{
-	return 0;
-}
-
 #define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
-#define ide_init_default_irq(base)	(0)
-
 #define __ide_insl(data_reg, buffer, wcount) \
 	__ide_insw(data_reg, buffer, (wcount)<<1)
 #define __ide_outsl(data_reg, buffer, wcount) \
diff -puN include/asm-sparc64/ide.h~ide_arch_obsolete_defaults include/asm-sparc64/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-sparc64/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.158057088 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-sparc64/ide.h	2004-06-01 19:57:47.221047512 +0200
@@ -24,21 +24,9 @@
 # endif
 #endif
 
-static __inline__ int ide_default_irq(unsigned long base)
-{
-	return 0;
-}
-
-static __inline__ unsigned long ide_default_io_base(int index)
-{
-	return 0;
-}
-
 #define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
-#define ide_init_default_irq(base)	(0)
-
 #define __ide_insl(data_reg, buffer, wcount) \
 	__ide_insw(data_reg, buffer, (wcount)<<1)
 #define __ide_outsl(data_reg, buffer, wcount) \
diff -puN include/linux/ide.h~ide_arch_obsolete_defaults include/linux/ide.h
--- linux-2.6.7-rc2-bk2/include/linux/ide.h~ide_arch_obsolete_defaults	2004-06-01 19:57:47.162056480 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/linux/ide.h	2004-06-01 19:57:47.223047208 +0200
@@ -305,6 +305,13 @@ static inline void ide_std_init_ports(hw
 
 #include <asm/ide.h>
 
+/* needed on alpha, x86/x86_64, ia64, mips, ppc32 and sh */
+#ifndef IDE_ARCH_OBSOLETE_DEFAULTS
+# define ide_default_io_base(index)	(0)
+# define ide_default_irq(base)		(0)
+# define ide_init_default_irq(base)	(0)
+#endif
+
 /*
  * ide_init_hwif_ports() is OBSOLETE and will be removed in 2.7 series.
  * New ports shouldn't define IDE_ARCH_OBSOLETE_INIT in <asm/ide.h>.

_

