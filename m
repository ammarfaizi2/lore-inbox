Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287450AbSASWDP>; Sat, 19 Jan 2002 17:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287531AbSASWBT>; Sat, 19 Jan 2002 17:01:19 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:56836 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S287539AbSASV7N>;
	Sat, 19 Jan 2002 16:59:13 -0500
Date: Sat, 19 Jan 2002 16:59:10 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>
Subject: [PATCH] Andre's IDE Patch (7/7)
Message-ID: <Pine.LNX.4.33.0201191504580.14950-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the seventh of seven patches against 2.4.18-pre4, beginning the breakup
of Andre Hedrick's IDE patch into smaller chunks.

Description of patch 7:
This patch touches 15 files, include/asm-*/ide.h.  There are no major
functional changes, only the addition of the control_t union to all
architectures.  This patch was compiled only on i386.

Regards,
Rob Radez

diff -ruN linux-2.4.18-pre3/include/asm-alpha/ide.h linux-2.4.18-pre3-ide-rr/include/asm-alpha/ide.h
--- linux-2.4.18-pre3/include/asm-alpha/ide.h	Wed May 24 11:40:41 2000
+++ linux-2.4.18-pre3-ide-rr/include/asm-alpha/ide.h	Mon Jan 14 18:28:54 2002
@@ -91,7 +91,19 @@
 		unsigned lba		: 1;	/* using LBA instead of CHS */
 		unsigned bit7		: 1;	/* always 1 */
 	} b;
-	} select_t;
+} select_t;
+
+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned bit0		: 1;
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned reserved456	: 3;
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+	} b;
+} control_t;

 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
 #define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
diff -ruN linux-2.4.18-pre3/include/asm-arm/ide.h linux-2.4.18-pre3-ide-rr/include/asm-arm/ide.h
--- linux-2.4.18-pre3/include/asm-arm/ide.h	Thu Jun 17 04:11:35 1999
+++ linux-2.4.18-pre3-ide-rr/include/asm-arm/ide.h	Mon Jan 14 18:28:54 2002
@@ -30,7 +30,19 @@
 		unsigned lba		: 1;	/* using LBA instead of CHS */
 		unsigned bit7		: 1;	/* always 1 */
 	} b;
-	} select_t;
+} select_t;
+
+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned bit0		: 1;
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned reserved456	: 3;
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+	} b;
+} control_t;

 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
 #define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
diff -ruN linux-2.4.18-pre3/include/asm-cris/ide.h linux-2.4.18-pre3-ide-rr/include/asm-cris/ide.h
--- linux-2.4.18-pre3/include/asm-cris/ide.h	Tue Feb 13 17:13:44 2001
+++ linux-2.4.18-pre3-ide-rr/include/asm-cris/ide.h	Mon Jan 14 18:28:55 2002
@@ -97,7 +97,19 @@
 		unsigned lba		: 1;	/* using LBA instead of CHS */
 		unsigned bit7		: 1;	/* always 1 */
 	} b;
-	} select_t;
+} select_t;
+
+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned bit0		: 1;
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned reserved456	: 3;
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+	} b;
+} control_t;

 /* some configuration options we don't need */

diff -ruN linux-2.4.18-pre3/include/asm-i386/ide.h linux-2.4.18-pre3-ide-rr/include/asm-i386/ide.h
--- linux-2.4.18-pre3/include/asm-i386/ide.h	Thu Nov 22 14:46:58 2001
+++ linux-2.4.18-pre3-ide-rr/include/asm-i386/ide.h	Mon Jan 14 18:28:54 2002
@@ -95,7 +95,19 @@
 		unsigned lba		: 1;	/* using LBA instead of CHS */
 		unsigned bit7		: 1;	/* always 1 */
 	} b;
-	} select_t;
+} select_t;
+
+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned bit0		: 1;
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned reserved456	: 3;
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+	} b;
+} control_t;

 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
 #define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
diff -ruN linux-2.4.18-pre3/include/asm-ia64/ide.h linux-2.4.18-pre3-ide-rr/include/asm-ia64/ide.h
--- linux-2.4.18-pre3/include/asm-ia64/ide.h	Wed May 24 11:40:41 2000
+++ linux-2.4.18-pre3-ide-rr/include/asm-ia64/ide.h	Mon Jan 14 18:28:54 2002
@@ -101,7 +101,19 @@
 		unsigned lba		: 1;	/* using LBA instead of CHS */
 		unsigned bit7		: 1;	/* always 1 */
 	} b;
-	} select_t;
+} select_t;
+
+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned bit0		: 1;
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned reserved456	: 3;
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+	} b;
+} control_t;

 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
 #define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
diff -ruN linux-2.4.18-pre3/include/asm-m68k/ide.h linux-2.4.18-pre3-ide-rr/include/asm-m68k/ide.h
--- linux-2.4.18-pre3/include/asm-m68k/ide.h	Mon Jun 11 22:15:27 2001
+++ linux-2.4.18-pre3-ide-rr/include/asm-m68k/ide.h	Mon Jan 14 18:28:54 2002
@@ -89,7 +89,19 @@
 		unsigned unit		: 1;	/* drive select number, 0 or 1 */
 		unsigned head		: 4;	/* always zeros here */
 	} b;
-	} select_t;
+} select_t;
+
+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+		unsigned reserved456	: 3;
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned bit0		: 1;
+	} b;
+} control_t;

 static __inline__ int ide_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
 			unsigned long flags, const char *device, void *dev_id)
diff -ruN linux-2.4.18-pre3/include/asm-mips/ide.h linux-2.4.18-pre3-ide-rr/include/asm-mips/ide.h
--- linux-2.4.18-pre3/include/asm-mips/ide.h	Sun Sep  9 13:43:01 2001
+++ linux-2.4.18-pre3-ide-rr/include/asm-mips/ide.h	Mon Jan 14 18:28:54 2002
@@ -92,6 +92,26 @@
 	} b;
 } select_t;

+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+#ifdef __MIPSEB__
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+		unsigned reserved456	: 3;
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned bit0		: 1;
+#else
+		unsigned bit0		: 1;
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned reserved456	: 3;
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+#endif
+	} b;
+} control_t;
+
 static __inline__ int ide_request_irq(unsigned int irq, void (*handler)(int,void *, struct pt_regs *),
 			unsigned long flags, const char *device, void *dev_id)
 {
diff -ruN linux-2.4.18-pre3/include/asm-mips64/ide.h linux-2.4.18-pre3-ide-rr/include/asm-mips64/ide.h
--- linux-2.4.18-pre3/include/asm-mips64/ide.h	Sun Sep  9 13:43:02 2001
+++ linux-2.4.18-pre3-ide-rr/include/asm-mips64/ide.h	Mon Jan 14 18:28:54 2002
@@ -85,7 +85,19 @@
 		unsigned lba		: 1;	/* using LBA instead of CHS */
 		unsigned bit7		: 1;	/* always 1 */
 	} b;
-	} select_t;
+} select_t;
+
+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned bit0		: 1;
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned reserved456	: 3;
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+	} b;
+} control_t;

 static __inline__ int ide_request_irq(unsigned int irq, void (*handler)(int,void *, struct pt_regs *),
 			unsigned long flags, const char *device, void *dev_id)
diff -ruN linux-2.4.18-pre3/include/asm-parisc/ide.h linux-2.4.18-pre3-ide-rr/include/asm-parisc/ide.h
--- linux-2.4.18-pre3/include/asm-parisc/ide.h	Tue Dec  5 15:29:39 2000
+++ linux-2.4.18-pre3-ide-rr/include/asm-parisc/ide.h	Mon Jan 14 18:28:55 2002
@@ -90,7 +90,19 @@
 		unsigned lba		: 1;	/* using LBA instead of CHS */
 		unsigned bit7		: 1;	/* always 1 */
 	} b;
-	} select_t;
+} select_t;
+
+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned bit0		: 1;
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned reserved456	: 3;
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+	} b;
+} control_t;

 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
 #define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
diff -ruN linux-2.4.18-pre3/include/asm-ppc/ide.h linux-2.4.18-pre3-ide-rr/include/asm-ppc/ide.h
--- linux-2.4.18-pre3/include/asm-ppc/ide.h	Mon Oct  8 14:40:13 2001
+++ linux-2.4.18-pre3-ide-rr/include/asm-ppc/ide.h	Mon Jan 14 18:28:54 2002
@@ -129,6 +129,18 @@
 	} b;
 } select_t;

+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+		unsigned reserved456	: 3;
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned bit0		: 1;
+	} b;
+} control_t;
+
 #if !defined(ide_request_irq)
 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
 #endif
diff -ruN linux-2.4.18-pre3/include/asm-s390/ide.h linux-2.4.18-pre3-ide-rr/include/asm-s390/ide.h
--- linux-2.4.18-pre3/include/asm-s390/ide.h	Fri May 12 14:41:44 2000
+++ linux-2.4.18-pre3-ide-rr/include/asm-s390/ide.h	Mon Jan 14 18:28:55 2002
@@ -26,7 +26,19 @@
 		unsigned lba		: 1;	/* using LBA instead of CHS */
 		unsigned bit7		: 1;	/* always 1 */
 	} b;
-	} select_t;
+} select_t;
+
+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned bit0		: 1;
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned reserved456	: 3;
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+	} b;
+} control_t;

 #define ide_request_irq(irq,hand,flg,dev,id)	do {} while (0)
 #define ide_free_irq(irq,dev_id)		do {} while (0)
diff -ruN linux-2.4.18-pre3/include/asm-s390x/ide.h linux-2.4.18-pre3-ide-rr/include/asm-s390x/ide.h
--- linux-2.4.18-pre3/include/asm-s390x/ide.h	Tue Feb 13 17:13:44 2001
+++ linux-2.4.18-pre3-ide-rr/include/asm-s390x/ide.h	Mon Jan 14 18:28:55 2002
@@ -26,7 +26,19 @@
 		unsigned lba		: 1;	/* using LBA instead of CHS */
 		unsigned bit7		: 1;	/* always 1 */
 	} b;
-	} select_t;
+} select_t;
+
+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned bit0		: 1;
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned reserved456	: 3;
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+	} b;
+} control_t;

 #define ide_request_irq(irq,hand,flg,dev,id)	do {} while (0)
 #define ide_free_irq(irq,dev_id)		do {} while (0)
diff -ruN linux-2.4.18-pre3/include/asm-sh/ide.h linux-2.4.18-pre3-ide-rr/include/asm-sh/ide.h
--- linux-2.4.18-pre3/include/asm-sh/ide.h	Sat Sep  8 15:29:09 2001
+++ linux-2.4.18-pre3-ide-rr/include/asm-sh/ide.h	Mon Jan 14 18:28:54 2002
@@ -116,7 +116,19 @@
 		unsigned lba		: 1;	/* using LBA instead of CHS */
 		unsigned bit7		: 1;	/* always 1 */
 	} b;
-	} select_t;
+} select_t;
+
+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned bit0		: 1;
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned reserved456	: 3;
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+	} b;
+} control_t;

 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
 #define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
diff -ruN linux-2.4.18-pre3/include/asm-sparc/ide.h linux-2.4.18-pre3-ide-rr/include/asm-sparc/ide.h
--- linux-2.4.18-pre3/include/asm-sparc/ide.h	Mon Jun 19 20:59:39 2000
+++ linux-2.4.18-pre3-ide-rr/include/asm-sparc/ide.h	Mon Jan 14 18:28:54 2002
@@ -84,6 +84,18 @@
 	} b;
 } select_t;

+typedef union {
+	unsigned int all		: 8;	/* all of the bits together */
+	struct {
+		unsigned int HOB	: 1;	/* 48-bit address ordering */
+		unsigned int reserved456: 3;
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned int SRST	: 1;	/* host soft reset bit */
+		unsigned int nIEN	: 1;	/* device INTRQ to host *
+		unsigned int bit0	: 1;
+	} b;
+} control_t;
+
 static __inline__ int ide_request_irq(unsigned int irq,
 				      void (*handler)(int, void *, struct pt_regs *),
 				      unsigned long flags, const char *name, void *devid)
diff -ruN linux-2.4.18-pre3/include/asm-sparc64/ide.h linux-2.4.18-pre3-ide-rr/include/asm-sparc64/ide.h
--- linux-2.4.18-pre3/include/asm-sparc64/ide.h	Mon Oct  1 12:19:56 2001
+++ linux-2.4.18-pre3-ide-rr/include/asm-sparc64/ide.h	Mon Jan 14 18:28:54 2002
@@ -80,6 +80,18 @@
 	} b;
 } select_t;

+typedef union {
+	unsigned int all		: 8;	/* all of the bits together */
+	struct {
+		unsigned int HOB	: 1;	/* 48-bit address ordering */
+		unsigned int reserved456: 3;
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned int SRST	: 1;	/* host soft reset bit */
+		unsigned int nIEN	: 1;	/* device INTRQ to host *
+		unsigned int bit0	: 1;
+	} b;
+} control_t;
+
 static __inline__ int ide_request_irq(unsigned int irq,
 				      void (*handler)(int, void *, struct pt_regs *),
 				      unsigned long flags, const char *name, void *devid)




