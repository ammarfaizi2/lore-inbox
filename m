Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268413AbTBNMzK>; Fri, 14 Feb 2003 07:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268393AbTBNMyM>; Fri, 14 Feb 2003 07:54:12 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:24334 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268413AbTBNMxD>;
	Fri, 14 Feb 2003 07:53:03 -0500
Date: Fri, 14 Feb 2003 15:58:16 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: move header file into asm/arch-visws (6/13)
Message-ID: <20030214125816.GF8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Y+xroYBkGM9OatJL"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

This trivial patch moves visws related header files into asm/mach-visws.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-headers

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/include/asm-i386/mach-visws/cobalt.h linux-2.5.60/include/asm-i386/mach-visws/cobalt.h
--- linux-2.5.60.vanilla/include/asm-i386/mach-visws/cobalt.h	Thu Jan  1 03:00:00 1970
+++ linux-2.5.60/include/asm-i386/mach-visws/cobalt.h	Thu Feb 13 20:42:02 2003
@@ -0,0 +1,125 @@
+#ifndef __I386_SGI_COBALT_H
+#define __I386_SGI_COBALT_H
+
+#include <asm/fixmap.h>
+
+/*
+ * Cobalt SGI Visual Workstation system ASIC
+ */ 
+
+#define CO_CPU_NUM_PHYS 0x1e00
+#define CO_CPU_TAB_PHYS (CO_CPU_NUM_PHYS + 2)
+
+#define CO_CPU_MAX 4
+
+#define	CO_CPU_PHYS		0xc2000000
+#define	CO_APIC_PHYS		0xc4000000
+
+/* see set_fixmap() and asm/fixmap.h */
+#define	CO_CPU_VADDR		(fix_to_virt(FIX_CO_CPU))
+#define	CO_APIC_VADDR		(fix_to_virt(FIX_CO_APIC))
+
+/* Cobalt CPU registers -- relative to CO_CPU_VADDR, use co_cpu_*() */
+#define	CO_CPU_REV		0x08
+#define	CO_CPU_CTRL		0x10
+#define	CO_CPU_STAT		0x20
+#define	CO_CPU_TIMEVAL		0x30
+
+/* CO_CPU_CTRL bits */
+#define	CO_CTRL_TIMERUN		0x04		/* 0 == disabled */
+#define	CO_CTRL_TIMEMASK	0x08		/* 0 == unmasked */
+
+/* CO_CPU_STATUS bits */
+#define	CO_STAT_TIMEINTR	0x02	/* (r) 1 == int pend, (w) 0 == clear */
+
+/* CO_CPU_TIMEVAL value */
+#define	CO_TIME_HZ		100000000	/* Cobalt core rate */
+
+/* Cobalt APIC registers -- relative to CO_APIC_VADDR, use co_apic_*() */
+#define	CO_APIC_HI(n)		(((n) * 0x10) + 4)
+#define	CO_APIC_LO(n)		((n) * 0x10)
+#define	CO_APIC_ID		0x0ffc
+
+/* CO_APIC_ID bits */
+#define	CO_APIC_ENABLE		0x00000100
+
+/* CO_APIC_LO bits */
+#define	CO_APIC_MASK		0x00010000	/* 0 = enabled */
+#define	CO_APIC_LEVEL		0x00008000	/* 0 = edge */
+
+/*
+ * Where things are physically wired to Cobalt
+ * #defines with no board _<type>_<rev>_ are common to all (thus far)
+ */
+#define	CO_APIC_IDE0		4
+#define CO_APIC_IDE1		2		/* Only on 320 */
+
+#define	CO_APIC_8259		12		/* serial, floppy, par-l-l */
+
+/* Lithium PCI Bridge A -- "the one with 82557 Ethernet" */
+#define	CO_APIC_PCIA_BASE0	0 /* and 1 */	/* slot 0, line 0 */
+#define	CO_APIC_PCIA_BASE123	5 /* and 6 */	/* slot 0, line 1 */
+
+#define	CO_APIC_PIIX4_USB	7		/* this one is wierd */
+
+/* Lithium PCI Bridge B -- "the one with PIIX4" */
+#define	CO_APIC_PCIB_BASE0	8 /* and 9-12 *//* slot 0, line 0 */
+#define	CO_APIC_PCIB_BASE123	13 /* 14.15 */	/* slot 0, line 1 */
+
+#define	CO_APIC_VIDOUT0		16
+#define	CO_APIC_VIDOUT1		17
+#define	CO_APIC_VIDIN0		18
+#define	CO_APIC_VIDIN1		19
+
+#define	CO_APIC_LI_AUDIO	22
+
+#define	CO_APIC_AS		24
+#define	CO_APIC_RE		25
+
+#define CO_APIC_CPU		28		/* Timer and Cache interrupt */
+#define	CO_APIC_NMI		29
+#define	CO_APIC_LAST		CO_APIC_NMI
+
+/*
+ * This is how irqs are assigned on the Visual Workstation.
+ * Legacy devices get irq's 1-15 (system clock is 0 and is CO_APIC_CPU).
+ * All other devices (including PCI) go to Cobalt and are irq's 16 on up.
+ */
+#define	CO_IRQ_APIC0	16			/* irq of apic entry 0 */
+#define	IS_CO_APIC(irq)	((irq) >= CO_IRQ_APIC0)
+#define	CO_IRQ(apic)	(CO_IRQ_APIC0 + (apic))	/* apic ent to irq */
+#define	CO_APIC(irq)	((irq) - CO_IRQ_APIC0)	/* irq to apic ent */
+#define CO_IRQ_IDE0	14			/* knowledge of... */
+#define CO_IRQ_IDE1	15			/* ... ide driver defaults! */
+#define	CO_IRQ_8259	CO_IRQ(CO_APIC_8259)
+
+#ifdef CONFIG_X86_VISWS_APIC
+extern __inline void co_cpu_write(unsigned long reg, unsigned long v)
+{
+	*((volatile unsigned long *)(CO_CPU_VADDR+reg))=v;
+}
+
+extern __inline unsigned long co_cpu_read(unsigned long reg)
+{
+	return *((volatile unsigned long *)(CO_CPU_VADDR+reg));
+}            
+             
+extern __inline void co_apic_write(unsigned long reg, unsigned long v)
+{
+	*((volatile unsigned long *)(CO_APIC_VADDR+reg))=v;
+}            
+             
+extern __inline unsigned long co_apic_read(unsigned long reg)
+{
+	return *((volatile unsigned long *)(CO_APIC_VADDR+reg));
+}
+#endif
+
+extern char visws_board_type;
+
+#define	VISWS_320	0
+#define	VISWS_540	1
+
+extern char visws_board_rev;
+
+#endif /* __I386_SGI_COBALT_H */
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/include/asm-i386/mach-visws/lithium.h linux-2.5.60/include/asm-i386/mach-visws/lithium.h
--- linux-2.5.60.vanilla/include/asm-i386/mach-visws/lithium.h	Thu Jan  1 03:00:00 1970
+++ linux-2.5.60/include/asm-i386/mach-visws/lithium.h	Thu Feb 13 20:42:02 2003
@@ -0,0 +1,53 @@
+#ifndef __I386_SGI_LITHIUM_H
+#define __I386_SGI_LITHIUM_H
+
+#include <asm/fixmap.h>
+
+/*
+ * Lithium is the SGI Visual Workstation I/O ASIC
+ */
+
+#define	LI_PCI_A_PHYS		0xfc000000	/* Enet is dev 3 */
+#define	LI_PCI_B_PHYS		0xfd000000	/* PIIX4 is here */
+
+/* see set_fixmap() and asm/fixmap.h */
+#define LI_PCIA_VADDR   (fix_to_virt(FIX_LI_PCIA))
+#define LI_PCIB_VADDR   (fix_to_virt(FIX_LI_PCIB))
+
+/* Not a standard PCI? (not in linux/pci.h) */
+#define	LI_PCI_BUSNUM	0x44			/* lo8: primary, hi8: sub */
+#define LI_PCI_INTEN    0x46
+
+/* LI_PCI_INTENT bits */
+#define	LI_INTA_0	0x0001
+#define	LI_INTA_1	0x0002
+#define	LI_INTA_2	0x0004
+#define	LI_INTA_3	0x0008
+#define	LI_INTA_4	0x0010
+#define	LI_INTB		0x0020
+#define	LI_INTC		0x0040
+#define	LI_INTD		0x0080
+
+/* More special purpose macros... */
+extern __inline void li_pcia_write16(unsigned long reg, unsigned short v)
+{
+	*((volatile unsigned short *)(LI_PCIA_VADDR+reg))=v;
+}
+
+extern __inline unsigned short li_pcia_read16(unsigned long reg)
+{
+	 return *((volatile unsigned short *)(LI_PCIA_VADDR+reg));
+}
+
+extern __inline void li_pcib_write16(unsigned long reg, unsigned short v)
+{
+	*((volatile unsigned short *)(LI_PCIB_VADDR+reg))=v;
+}
+
+extern __inline unsigned short li_pcib_read16(unsigned long reg)
+{
+	return *((volatile unsigned short *)(LI_PCIB_VADDR+reg));
+}
+
+#endif
+
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/include/asm-i386/mach-visws/piix4.h linux-2.5.60/include/asm-i386/mach-visws/piix4.h
--- linux-2.5.60.vanilla/include/asm-i386/mach-visws/piix4.h	Thu Jan  1 03:00:00 1970
+++ linux-2.5.60/include/asm-i386/mach-visws/piix4.h	Thu Feb 13 20:42:02 2003
@@ -0,0 +1,107 @@
+#ifndef __I386_SGI_PIIX_H
+#define __I386_SGI_PIIX_H
+
+/*
+ * PIIX4 as used on SGI Visual Workstations
+ */
+
+#define	PIIX_PM_START		0x0F80
+
+#define	SIO_GPIO_START		0x0FC0
+
+#define	SIO_PM_START		0x0FC8
+
+#define	PMBASE			PIIX_PM_START
+#define	GPIREG0			(PMBASE+0x30)
+#define	GPIREG(x)		(GPIREG0+((x)/8))
+#define	GPIBIT(x)		(1 << ((x)%8))
+
+#define	PIIX_GPI_BD_ID1		18
+#define	PIIX_GPI_BD_ID2		19
+#define	PIIX_GPI_BD_ID3		20
+#define	PIIX_GPI_BD_ID4		21
+#define	PIIX_GPI_BD_REG		GPIREG(PIIX_GPI_BD_ID1)
+#define	PIIX_GPI_BD_MASK	(GPIBIT(PIIX_GPI_BD_ID1) | \
+				GPIBIT(PIIX_GPI_BD_ID2) | \
+				GPIBIT(PIIX_GPI_BD_ID3) | \
+				GPIBIT(PIIX_GPI_BD_ID4) )
+
+#define	PIIX_GPI_BD_SHIFT	(PIIX_GPI_BD_ID1 % 8)
+
+#define	SIO_INDEX		0x2e
+#define	SIO_DATA		0x2f
+
+#define	SIO_DEV_SEL		0x7
+#define	SIO_DEV_ENB		0x30
+#define	SIO_DEV_MSB		0x60
+#define	SIO_DEV_LSB		0x61
+
+#define	SIO_GP_DEV		0x7
+
+#define	SIO_GP_BASE		SIO_GPIO_START
+#define	SIO_GP_MSB		(SIO_GP_BASE>>8)
+#define	SIO_GP_LSB		(SIO_GP_BASE&0xff)
+
+#define	SIO_GP_DATA1		(SIO_GP_BASE+0)
+
+#define	SIO_PM_DEV		0x8
+
+#define	SIO_PM_BASE		SIO_PM_START
+#define	SIO_PM_MSB		(SIO_PM_BASE>>8)
+#define	SIO_PM_LSB		(SIO_PM_BASE&0xff)
+#define	SIO_PM_INDEX		(SIO_PM_BASE+0)
+#define	SIO_PM_DATA		(SIO_PM_BASE+1)
+
+#define	SIO_PM_FER2		0x1
+
+#define	SIO_PM_GP_EN		0x80
+
+
+
+/*
+ * This is the dev/reg where generating a config cycle will
+ * result in a PCI special cycle.
+ */
+#define SPECIAL_DEV		0xff
+#define SPECIAL_REG		0x00
+
+/*
+ * PIIX4 needs to see a special cycle with the following data
+ * to be convinced the processor has gone into the stop grant
+ * state.  PIIX4 insists on seeing this before it will power
+ * down a system.
+ */
+#define PIIX_SPECIAL_STOP		0x00120002
+
+#define PIIX4_RESET_PORT	0xcf9
+#define PIIX4_RESET_VAL		0x6
+
+#define PMSTS_PORT		0xf80	// 2 bytes	PM Status
+#define PMEN_PORT		0xf82	// 2 bytes	PM Enable
+#define	PMCNTRL_PORT		0xf84	// 2 bytes	PM Control
+
+#define PM_SUSPEND_ENABLE	0x2000	// start sequence to suspend state
+
+/*
+ * PMSTS and PMEN I/O bit definitions.
+ * (Bits are the same in both registers)
+ */
+#define PM_STS_RSM		(1<<15)	// Resume Status
+#define PM_STS_PWRBTNOR		(1<<11)	// Power Button Override
+#define PM_STS_RTC		(1<<10)	// RTC status
+#define PM_STS_PWRBTN		(1<<8)	// Power Button Pressed?
+#define PM_STS_GBL		(1<<5)	// Global Status
+#define PM_STS_BM		(1<<4)	// Bus Master Status
+#define PM_STS_TMROF		(1<<0)	// Timer Overflow Status.
+
+/*
+ * Stop clock GPI register
+ */
+#define PIIX_GPIREG0			(0xf80 + 0x30)
+
+/*
+ * Stop clock GPI bit in GPIREG0
+ */
+#define	PIIX_GPI_STPCLK		0x4	// STPCLK signal routed back in
+
+#endif
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/include/asm-i386/cobalt.h linux-2.5.60/include/asm-i386/cobalt.h
--- linux-2.5.60.vanilla/include/asm-i386/cobalt.h	Thu Feb 13 20:31:38 2003
+++ linux-2.5.60/include/asm-i386/cobalt.h	Thu Jan  1 03:00:00 1970
@@ -1,117 +0,0 @@
-#include <linux/config.h>
-#ifndef __I386_COBALT_H
-#define __I386_COBALT_H
-
-/*
- * Cobalt is the system ASIC on the SGI 320 and 540 Visual Workstations
- */ 
-
-#define	CO_CPU_PHYS		0xc2000000
-#define	CO_APIC_PHYS		0xc4000000
-
-/* see set_fixmap() and asm/fixmap.h */
-#define	CO_CPU_VADDR		(fix_to_virt(FIX_CO_CPU))
-#define	CO_APIC_VADDR		(fix_to_virt(FIX_CO_APIC))
-
-/* Cobalt CPU registers -- relative to CO_CPU_VADDR, use co_cpu_*() */
-#define	CO_CPU_REV		0x08
-#define	CO_CPU_CTRL		0x10
-#define	CO_CPU_STAT		0x20
-#define	CO_CPU_TIMEVAL		0x30
-
-/* CO_CPU_CTRL bits */
-#define	CO_CTRL_TIMERUN		0x04	/* 0 == disabled */
-#define	CO_CTRL_TIMEMASK	0x08	/* 0 == unmasked */
-
-/* CO_CPU_STATUS bits */
-#define	CO_STAT_TIMEINTR	0x02	/* (r) 1 == int pend, (w) 0 == clear */
-
-/* CO_CPU_TIMEVAL value */
-#define	CO_TIME_HZ		100000000 /* Cobalt core rate */
-
-/* Cobalt APIC registers -- relative to CO_APIC_VADDR, use co_apic_*() */
-#define	CO_APIC_HI(n)		(((n) * 0x10) + 4)
-#define	CO_APIC_LO(n)		((n) * 0x10)
-#define	CO_APIC_ID		0x0ffc
-
-/* CO_APIC_ID bits */
-#define	CO_APIC_ENABLE		0x00000100
-
-/* CO_APIC_LO bits */
-#define	CO_APIC_LEVEL		0x08000		/* 0 = edge */
-
-/*
- * Where things are physically wired to Cobalt
- * #defines with no board _<type>_<rev>_ are common to all (thus far)
- */
-#define CO_APIC_0_5_IDE0	5
-#define	CO_APIC_0_5_SERIAL	13	 /* XXX not really...h/w bug! */
-#define CO_APIC_0_5_PARLL	4
-#define CO_APIC_0_5_FLOPPY	6
-
-#define	CO_APIC_0_6_IDE0	4
-#define	CO_APIC_0_6_USB	7	/* PIIX4 USB */
-
-#define	CO_APIC_1_2_IDE0	4
-
-#define CO_APIC_0_5_IDE1	2
-#define CO_APIC_0_6_IDE1	2
-
-/* XXX */
-#define	CO_APIC_IDE0	CO_APIC_0_5_IDE0
-#define	CO_APIC_IDE1	CO_APIC_0_5_IDE1
-#define	CO_APIC_SERIAL	CO_APIC_0_5_SERIAL
-/* XXX */
-
-#define CO_APIC_ENET	3	/* Lithium PCI Bridge A, Device 3 */
-#define	CO_APIC_8259	12	/* serial, floppy, par-l-l, audio */
-
-#define	CO_APIC_VIDOUT0	16
-#define	CO_APIC_VIDOUT1	17
-#define	CO_APIC_VIDIN0	18
-#define	CO_APIC_VIDIN1	19
-
-#define CO_APIC_CPU	28	/* Timer and Cache interrupt */
-
-/*
- * This is the "irq" arg to request_irq(), just a unique cookie.
- */
-#define	CO_IRQ_TIMER	0
-#define CO_IRQ_ENET	3
-#define CO_IRQ_SERIAL	4
-#define CO_IRQ_FLOPPY	6	/* Same as drivers/block/floppy.c:FLOPPY_IRQ */
-#define	CO_IRQ_PARLL	7
-#define	CO_IRQ_POWER	9
-#define CO_IRQ_IDE	14
-#define	CO_IRQ_8259	12
-
-#ifdef CONFIG_X86_VISWS_APIC
-static __inline void co_cpu_write(unsigned long reg, unsigned long v)
-{
-	*((volatile unsigned long *)(CO_CPU_VADDR+reg))=v;
-}
-
-static __inline unsigned long co_cpu_read(unsigned long reg)
-{
-	return *((volatile unsigned long *)(CO_CPU_VADDR+reg));
-}            
-             
-static __inline void co_apic_write(unsigned long reg, unsigned long v)
-{
-	*((volatile unsigned long *)(CO_APIC_VADDR+reg))=v;
-}            
-             
-static __inline unsigned long co_apic_read(unsigned long reg)
-{
-	return *((volatile unsigned long *)(CO_APIC_VADDR+reg));
-}
-#endif
-
-extern char visws_board_type;
-
-#define	VISWS_320	0
-#define	VISWS_540	1
-
-extern char visws_board_rev;
-
-#endif
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/include/asm-i386/lithium.h linux-2.5.60/include/asm-i386/lithium.h
--- linux-2.5.60.vanilla/include/asm-i386/lithium.h	Thu Feb 13 20:31:39 2003
+++ linux-2.5.60/include/asm-i386/lithium.h	Thu Jan  1 03:00:00 1970
@@ -1,45 +0,0 @@
-#ifndef __I386_LITHIUM_H
-#define __I386_LITHIUM_H
-
-#include <linux/config.h>
-
-/*
- * Lithium is the I/O ASIC on the SGI 320 and 540 Visual Workstations
- */
-
-#define	LI_PCI_A_PHYS		0xfc000000	/* Enet is dev 3 */
-#define	LI_PCI_B_PHYS		0xfd000000	/* PIIX4 is here */
-
-/* see set_fixmap() and asm/fixmap.h */
-#define LI_PCIA_VADDR   (fix_to_virt(FIX_LI_PCIA))
-#define LI_PCIB_VADDR   (fix_to_virt(FIX_LI_PCIB))
-
-/* Not a standard PCI? (not in linux/pci.h) */
-#define	LI_PCI_BUSNUM	0x44			/* lo8: primary, hi8: sub */
-#define LI_PCI_INTEN    0x46
-
-#ifdef CONFIG_X86_VISWS_APIC
-/* More special purpose macros... */
-static __inline void li_pcia_write16(unsigned long reg, unsigned short v)
-{
-	*((volatile unsigned short *)(LI_PCIA_VADDR+reg))=v;
-}
-
-static __inline unsigned short li_pcia_read16(unsigned long reg)
-{
-	 return *((volatile unsigned short *)(LI_PCIA_VADDR+reg));
-}
-
-static __inline void li_pcib_write16(unsigned long reg, unsigned short v)
-{
-	*((volatile unsigned short *)(LI_PCIB_VADDR+reg))=v;
-}
-
-static __inline unsigned short li_pcib_read16(unsigned long reg)
-{
-	return *((volatile unsigned short *)(LI_PCIB_VADDR+reg));
-}
-#endif
-
-#endif
-

--Y+xroYBkGM9OatJL--
