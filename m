Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUDGXyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUDGXyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:54:50 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49638 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261234AbUDGXyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:54:06 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] obsolete asm/hdreg.h [3/5]
Date: Thu, 8 Apr 2004 00:23:04 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404080023.04460.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] asm/ide.h: ide_ioreg_t cleanup

ide_ioreg_t is deprecated and hasn't been used by IDE driver for some time.
Use unsigned long directly on alpha, arm26, arm, mips, parisc, ppc64 and sh.

asm-ia64/ide.h (ide_ioreg_t is unsigned short) and asm-m68knommu/ide.h
(broken - ide_ioreg_t is not defined) are the only users of ide_ioreg_t left.

 linux-2.6.5-root/include/asm-alpha/ide.h             |    9 +++++----
 linux-2.6.5-root/include/asm-arm/arch-cl7500/ide.h   |    6 +++---
 linux-2.6.5-root/include/asm-arm/arch-ebsa285/ide.h  |    8 ++++----
 linux-2.6.5-root/include/asm-arm/arch-iop3xx/ide.h   |   10 ++++------
 linux-2.6.5-root/include/asm-arm/arch-l7200/ide.h    |    4 ++--
 linux-2.6.5-root/include/asm-arm/arch-nexuspci/ide.h |    8 ++++----
 linux-2.6.5-root/include/asm-arm/arch-pxa/ide.h      |   10 ++++------
 linux-2.6.5-root/include/asm-arm/arch-rpc/ide.h      |    8 ++++----
 linux-2.6.5-root/include/asm-arm/arch-sa1100/ide.h   |   16 +++++++---------
 linux-2.6.5-root/include/asm-arm/arch-shark/ide.h    |    8 ++++----
 linux-2.6.5-root/include/asm-arm/ide.h               |    2 +-
 linux-2.6.5-root/include/asm-arm26/ide.h             |   10 +++++-----
 linux-2.6.5-root/include/asm-mips/mach-generic/ide.h |    2 +-
 linux-2.6.5-root/include/asm-parisc/ide.h            |    7 ++++---
 linux-2.6.5-root/include/asm-ppc64/ide.h             |    9 +++++----
 linux-2.6.5-root/include/asm-sh/ide.h                |   13 +++++++------
 16 files changed, 64 insertions(+), 66 deletions(-)

diff -puN include/asm-alpha/ide.h~ide_ioreg_t include/asm-alpha/ide.h
--- linux-2.6.5/include/asm-alpha/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-alpha/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -19,7 +19,7 @@
 #define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
 #endif
 
-static __inline__ int ide_default_irq(ide_ioreg_t base)
+static inline int ide_default_irq(unsigned long base)
 {
 	switch (base) {
 		case 0x1f0: return 14;
@@ -31,7 +31,7 @@ static __inline__ int ide_default_irq(id
 	}
 }
 
-static __inline__ ide_ioreg_t ide_default_io_base(int index)
+static inline unsigned long ide_default_io_base(int index)
 {
 	switch (index) {
 		case 0:	return 0x1f0;
@@ -43,9 +43,10 @@ static __inline__ ide_ioreg_t ide_defaul
 	}
 }
 
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg = data_port;
+	unsigned long reg = data_port;
 	int i;
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
diff -puN include/asm-arm26/ide.h~ide_ioreg_t include/asm-arm26/ide.h
--- linux-2.6.5/include/asm-arm26/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-arm26/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -30,17 +30,17 @@
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
  */
-static __inline__ void
-ide_init_hwif_ports(hw_regs_t *hw, int data_port, int ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-        ide_ioreg_t reg = (ide_ioreg_t) data_port;
+	unsigned long reg = data_port;
         int i;
 
         for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
                 hw->io_ports[i] = reg;
                 reg += 1;
         }
-        hw->io_ports[IDE_CONTROL_OFFSET] = (ide_ioreg_t) ctrl_port;
+	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
         if (irq)
                 *irq = 0;
 }
@@ -67,7 +67,7 @@ static __inline__ void ide_init_default_
  * We always use the new IDE port registering,
  * so these are fixed here.
  */
-#define ide_default_io_base(i)		((ide_ioreg_t)0)
+#define ide_default_io_base(i)		(0)
 #define ide_default_irq(b)		(0)
 
 #endif /* __KERNEL__ */
diff -puN include/asm-arm/arch-cl7500/ide.h~ide_ioreg_t include/asm-arm/arch-cl7500/ide.h
--- linux-2.6.5/include/asm-arm/arch-cl7500/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-arm/arch-cl7500/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -13,10 +13,10 @@
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
  */
-static __inline__ void
-ide_init_hwif_ports(hw_regs_t *hw, int data_port, int ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg = data_port;
+	unsigned long reg = data_port;
 	int i;
 
 	memset(hw, 0, sizeof(*hw));
diff -puN include/asm-arm/arch-ebsa285/ide.h~ide_ioreg_t include/asm-arm/arch-ebsa285/ide.h
--- linux-2.6.5/include/asm-arm/arch-ebsa285/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-arm/arch-ebsa285/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -16,17 +16,17 @@
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
  */
-static __inline__ void
-ide_init_hwif_ports(hw_regs_t *hw, int data_port, int ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg = (ide_ioreg_t) data_port;
+	unsigned long reg = data_port;
 	int i;
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
 		hw->io_ports[i] = reg;
 		reg += 1;
 	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = (ide_ioreg_t) ctrl_port;
+	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
 	if (irq)
 		*irq = 0;
 }
diff -puN include/asm-arm/arch-iop3xx/ide.h~ide_ioreg_t include/asm-arm/arch-iop3xx/ide.h
--- linux-2.6.5/include/asm-arm/arch-iop3xx/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-arm/arch-iop3xx/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -18,23 +18,21 @@
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
  */
-static __inline__ void
-ide_init_hwif_ports(hw_regs_t *hw, int data_port, int ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg;
+	unsigned long reg = data_port;
 	int i;
 	int regincr = 1;
 
 	memset(hw, 0, sizeof(*hw));
 
-	reg = (ide_ioreg_t)data_port;
-
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
 		hw->io_ports[i] = reg;
 		reg += regincr;
 	}
 
-	hw->io_ports[IDE_CONTROL_OFFSET] = (ide_ioreg_t) ctrl_port;
+	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
 
 	if (irq) *irq = 0;
 }
diff -puN include/asm-arm/arch-l7200/ide.h~ide_ioreg_t include/asm-arm/arch-l7200/ide.h
--- linux-2.6.5/include/asm-arm/arch-l7200/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-arm/arch-l7200/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -12,8 +12,8 @@
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
  */
-static __inline__ void
-ide_init_hwif_ports(hw_regs_t *hw, int data_port, int ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
 }
 
diff -puN include/asm-arm/arch-nexuspci/ide.h~ide_ioreg_t include/asm-arm/arch-nexuspci/ide.h
--- linux-2.6.5/include/asm-arm/arch-nexuspci/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-arm/arch-nexuspci/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -12,17 +12,17 @@
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
  */
-static __inline__ void
-ide_init_hwif_ports(hw_regs_t *hw, int data_port, int ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg = (ide_ioreg_t) data_port;
+	unsigned long reg = data_port;
 	int i;
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
 		hw->io_ports[i] = reg;
 		reg += 1;
 	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = (ide_ioreg_t) ctrl_port;
+	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
 	if (irq)
 		*irq = 0;
 }
diff -puN include/asm-arm/arch-pxa/ide.h~ide_ioreg_t include/asm-arm/arch-pxa/ide.h
--- linux-2.6.5/include/asm-arm/arch-pxa/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-arm/arch-pxa/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -23,23 +23,21 @@
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
  */
-static __inline__ void
-ide_init_hwif_ports(hw_regs_t *hw, int data_port, int ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg;
+	unsigned long reg = data_port;
 	int i;
 	int regincr = 1;
 
 	memset(hw, 0, sizeof(*hw));
 
-	reg = (ide_ioreg_t)data_port;
-
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
 		hw->io_ports[i] = reg;
 		reg += regincr;
 	}
 
-	hw->io_ports[IDE_CONTROL_OFFSET] = (ide_ioreg_t) ctrl_port;
+	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
 
 	if (irq)
 		*irq = 0;
diff -puN include/asm-arm/arch-rpc/ide.h~ide_ioreg_t include/asm-arm/arch-rpc/ide.h
--- linux-2.6.5/include/asm-arm/arch-rpc/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-arm/arch-rpc/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -16,10 +16,10 @@
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
  */
-static __inline__ void
-ide_init_hwif_ports(hw_regs_t *hw, int data_port, int ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg = (ide_ioreg_t) data_port;
+	unsigned long reg = data_port;
 	int i;
 
 	memset(hw, 0, sizeof(*hw));
@@ -28,7 +28,7 @@ ide_init_hwif_ports(hw_regs_t *hw, int d
 		hw->io_ports[i] = reg;
 		reg += 1;
 	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = (ide_ioreg_t) ctrl_port;
+	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
 	if (irq)
 		*irq = 0;
 }
diff -puN include/asm-arm/arch-sa1100/ide.h~ide_ioreg_t include/asm-arm/arch-sa1100/ide.h
--- linux-2.6.5/include/asm-arm/arch-sa1100/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-arm/arch-sa1100/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -19,13 +19,13 @@
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
  */
-static __inline__ void
-ide_init_hwif_ports(hw_regs_t *hw, int data_port, int ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg;
+	unsigned long reg = data_port;
 	int i;
 	int regincr = 1;
-	
+
 	/* The Empeg board has the first two address lines unused */
 	if (machine_is_empeg())
 		regincr = 1 << 2;
@@ -36,15 +36,13 @@ ide_init_hwif_ports(hw_regs_t *hw, int d
 
 	memset(hw, 0, sizeof(*hw));
 
-	reg = (ide_ioreg_t)data_port;
-
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
 		hw->io_ports[i] = reg;
 		reg += regincr;
 	}
-	
-	hw->io_ports[IDE_CONTROL_OFFSET] = (ide_ioreg_t) ctrl_port;
-	
+
+	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
+
 	if (irq)
 		*irq = 0;
 }
diff -puN include/asm-arm/arch-shark/ide.h~ide_ioreg_t include/asm-arm/arch-shark/ide.h
--- linux-2.6.5/include/asm-arm/arch-shark/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-arm/arch-shark/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -14,10 +14,10 @@
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
  */
-static __inline__ void
-ide_init_hwif_ports(hw_regs_t *hw, int data_port, int ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg = (ide_ioreg_t) data_port;
+	unsigned long reg = data_port;
 	int i;
 
 	memset(hw, 0, sizeof(*hw));
@@ -26,7 +26,7 @@ ide_init_hwif_ports(hw_regs_t *hw, int d
 		hw->io_ports[i] = reg;
 		reg += 1;
 	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = (ide_ioreg_t) ctrl_port;
+	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
 	if (irq)
 		*irq = 0;
 }
diff -puN include/asm-arm/ide.h~ide_ioreg_t include/asm-arm/ide.h
--- linux-2.6.5/include/asm-arm/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-arm/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -23,7 +23,7 @@
  * We always use the new IDE port registering,
  * so these are fixed here.
  */
-#define ide_default_io_base(i)		((ide_ioreg_t)0)
+#define ide_default_io_base(i)		(0)
 #define ide_default_irq(b)		(0)
 
 #define __ide_mm_insw(port,addr,len)	readsw(port,addr,len)
diff -puN include/asm-mips/mach-generic/ide.h~ide_ioreg_t include/asm-mips/mach-generic/ide.h
--- linux-2.6.5/include/asm-mips/mach-generic/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-mips/mach-generic/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -34,7 +34,7 @@ static inline int ide_default_irq(unsign
 	}
 }
 
-static inline ide_ioreg_t ide_default_io_base(int index)
+static inline unsigned long ide_default_io_base(int index)
 {
 	switch (index) {
 		case 0: return 0x1f0;
diff -puN include/asm-parisc/ide.h~ide_ioreg_t include/asm-parisc/ide.h
--- linux-2.6.5/include/asm-parisc/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-parisc/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -20,11 +20,12 @@
 #endif
 
 #define ide_default_irq(base) (0)
-#define ide_default_io_base(index) ((ide_ioreg_t)0)
+#define ide_default_io_base(index) (0)
 
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg = data_port;
+	unsigned long reg = data_port;
 	int i;
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
diff -puN include/asm-ppc64/ide.h~ide_ioreg_t include/asm-ppc64/ide.h
--- linux-2.6.5/include/asm-ppc64/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-ppc64/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -22,12 +22,13 @@
 # define MAX_HWIFS	4
 #endif
 
-static __inline__ int ide_default_irq(ide_ioreg_t base) { return 0; }
-static __inline__ ide_ioreg_t ide_default_io_base(int index) { return 0; }
+static inline int ide_default_irq(unsigned long base) { return 0; }
+static inline unsigned long ide_default_io_base(int index) { return 0; }
 
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg = data_port;
+	unsigned long reg = data_port;
 	int i;
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
diff -puN include/asm-sh/ide.h~ide_ioreg_t include/asm-sh/ide.h
--- linux-2.6.5/include/asm-sh/ide.h~ide_ioreg_t	2004-04-06 02:19:14.000000000 +0200
+++ linux-2.6.5-root/include/asm-sh/ide.h	2004-04-06 02:19:14.000000000 +0200
@@ -22,7 +22,7 @@
 #define MAX_HWIFS	2
 #endif
 
-static __inline__ int ide_default_irq_hp600(ide_ioreg_t base)
+static inline int ide_default_irq_hp600(unsigned long base)
 {
 	switch (base) {
 		case 0x01f0: return 93;
@@ -32,7 +32,7 @@ static __inline__ int ide_default_irq_hp
 	}
 }
 
-static __inline__ int ide_default_irq(ide_ioreg_t base)
+static inline int ide_default_irq(unsigned long base)
 {
 	if (MACH_HP600) {
 		return ide_default_irq_hp600(base);
@@ -45,7 +45,7 @@ static __inline__ int ide_default_irq(id
 	}
 }
 
-static __inline__ ide_ioreg_t ide_default_io_base_hp600(int index)
+static inline unsigned long ide_default_io_base_hp600(int index)
 {
 	switch (index) {
 		case 0:	
@@ -57,7 +57,7 @@ static __inline__ ide_ioreg_t ide_defaul
 	}
 }
 
-static __inline__ ide_ioreg_t ide_default_io_base(int index)
+static inline unsigned long ide_default_io_base(int index)
 {
 	if (MACH_HP600) {
 		return ide_default_io_base_hp600(index);
@@ -72,9 +72,10 @@ static __inline__ ide_ioreg_t ide_defaul
 	}
 }
 
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg = data_port;
+	unsigned long reg = data_port;
 	int i;
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {

_

