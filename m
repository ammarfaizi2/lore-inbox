Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291345AbSBXVTI>; Sun, 24 Feb 2002 16:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291346AbSBXVSw>; Sun, 24 Feb 2002 16:18:52 -0500
Received: from [195.63.194.11] ([195.63.194.11]:14355 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291345AbSBXVSb>; Sun, 24 Feb 2002 16:18:31 -0500
Message-ID: <3C795880.1040304@evision-ventures.com>
Date: Sun, 24 Feb 2002 22:17:52 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE clean 13
In-Reply-To: <UTC200202241352.g1ODqeb08003.aeb@apps.cwi.nl> <3C79435E.8030208@evision-ventures.com> <3C7945DC.8050009@evision-ventures.com>
Content-Type: multipart/mixed;
 boundary="------------090702080408050407020507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090702080408050407020507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Silly me I have been testing the new flag field by an bitwise
or instead of the proper & :-). Can't imagine how this did slip in...
Corrected patch attached.

--------------090702080408050407020507
Content-Type: text/plain;
 name="ide-clean-13a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-13a.diff"

diff -ur linux-2.5.5/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.5/drivers/ide/ide-pci.c	Sun Feb 24 16:32:54 2002
+++ linux/drivers/ide/ide-pci.c	Sun Feb 24 19:50:32 2002
@@ -44,11 +44,6 @@
 extern unsigned int ata66_aec62xx(ide_hwif_t *);
 extern void ide_init_aec62xx(ide_hwif_t *);
 extern void ide_dmacapable_aec62xx(ide_hwif_t *, unsigned long);
-#else
-# define pci_init_aec62xx	NULL
-# define ata66_aec62xx		NULL
-# define ide_init_aec62xx	IDE_NO_DRIVER
-# define ide_dmacapable_aec62xx	NULL
 #endif
 
 #ifdef CONFIG_BLK_DEV_ALI15X3
@@ -56,11 +51,6 @@
 extern unsigned int ata66_ali15x3(ide_hwif_t *);
 extern void ide_init_ali15x3(ide_hwif_t *);
 extern void ide_dmacapable_ali15x3(ide_hwif_t *, unsigned long);
-#else
-# define pci_init_ali15x3	NULL
-# define ata66_ali15x3		NULL
-# define ide_init_ali15x3	IDE_NO_DRIVER
-# define ide_dmacapable_ali15x3	NULL
 #endif
 
 #ifdef CONFIG_BLK_DEV_AMD74XX
@@ -68,11 +58,6 @@
 extern unsigned int ata66_amd74xx(ide_hwif_t *);
 extern void ide_init_amd74xx(ide_hwif_t *);
 extern void ide_dmacapable_amd74xx(ide_hwif_t *, unsigned long);
-#else
-# define pci_init_amd74xx	NULL
-# define ata66_amd74xx		NULL
-# define ide_init_amd74xx	IDE_NO_DRIVER
-# define ide_dmacapable_amd74xx	NULL
 #endif
 
 #ifdef CONFIG_BLK_DEV_CMD64X
@@ -80,38 +65,21 @@
 extern unsigned int ata66_cmd64x(ide_hwif_t *);
 extern void ide_init_cmd64x(ide_hwif_t *);
 extern void ide_dmacapable_cmd64x(ide_hwif_t *, unsigned long);
-#else
-# define pci_init_cmd64x    NULL
-# define ata66_cmd64x	    NULL
-# ifdef __sparc_v9__
-#  define ide_init_cmd64x   IDE_IGNORE
-# else
-#  define ide_init_cmd64x   IDE_NO_DRIVER
-# endif
 #endif
 
 #ifdef CONFIG_BLK_DEV_CY82C693
 extern unsigned int pci_init_cy82c693(struct pci_dev *);
 extern void ide_init_cy82c693(ide_hwif_t *);
-#else
-# define pci_init_cy82c693  NULL
-# define ide_init_cy82c693  IDE_NO_DRIVER
 #endif
 
 #ifdef CONFIG_BLK_DEV_CS5530
 extern unsigned int pci_init_cs5530(struct pci_dev *);
 extern void ide_init_cs5530(ide_hwif_t *);
-#else
-# define pci_init_cs5530    NULL
-# define ide_init_cs5530    IDE_NO_DRIVER
 #endif
 
 #ifdef CONFIG_BLK_DEV_HPT34X
 extern unsigned int pci_init_hpt34x(struct pci_dev *);
 extern void ide_init_hpt34x(ide_hwif_t *);
-#else
-# define pci_init_hpt34x    NULL
-# define ide_init_hpt34x    IDE_IGNORE
 #endif
 
 #ifdef CONFIG_BLK_DEV_HPT366
@@ -123,25 +91,17 @@
 extern void ide_init_hpt366(ide_hwif_t *);
 extern void ide_dmacapable_hpt366(ide_hwif_t *, unsigned long);
 #else
+/* FIXME: those have to be killed */
 static byte hpt363_shared_irq;
 static byte hpt363_shared_pin;
-
-# define pci_init_hpt366	NULL
-# define ata66_hpt366		NULL
-# define ide_init_hpt366	IDE_NO_DRIVER
-# define ide_dmacapable_hpt366	NULL
 #endif
 
 #ifdef CONFIG_BLK_DEV_NS87415
 extern void ide_init_ns87415(ide_hwif_t *);
-#else
-# define ide_init_ns87415   IDE_IGNORE
 #endif
 
 #ifdef CONFIG_BLK_DEV_OPTI621
 extern void ide_init_opti621(ide_hwif_t *);
-#else
-# define ide_init_opti621   IDE_NO_DRIVER
 #endif
 
 #ifdef CONFIG_BLK_DEV_PDC_ADMA
@@ -149,97 +109,55 @@
 extern unsigned int ata66_pdcadma(ide_hwif_t *);
 extern void ide_init_pdcadma(ide_hwif_t *);
 extern void ide_dmacapable_pdcadma(ide_hwif_t *, unsigned long);
-#else
-# define pci_init_pdcadma	NULL
-# define ata66_pdcadma		NULL
-# define ide_init_pdcadma	IDE_IGNORE
-# define ide_dmacapable_pdcadma	NULL
 #endif
 
 #ifdef CONFIG_BLK_DEV_PDC202XX
 extern unsigned int pci_init_pdc202xx(struct pci_dev *);
 extern unsigned int ata66_pdc202xx(ide_hwif_t *);
 extern void ide_init_pdc202xx(ide_hwif_t *);
-#else
-# define pci_init_pdc202xx  NULL
-# define ata66_pdc202xx	    NULL
-# define ide_init_pdc202xx  IDE_IGNORE
 #endif
 
 #ifdef CONFIG_BLK_DEV_PIIX
 extern unsigned int pci_init_piix(struct pci_dev *);
 extern unsigned int ata66_piix(ide_hwif_t *);
 extern void ide_init_piix(ide_hwif_t *);
-#else
-# define pci_init_piix	NULL
-# define ata66_piix	NULL
-# define ide_init_piix	IDE_NO_DRIVER
 #endif
 
 #ifdef CONFIG_BLK_DEV_IT8172
 extern unsigned int pci_init_it8172(struct pci_dev *);
-
-/* We assume that this function has not been added to the global setup lists
- * due to a patch merge error.
- */
-extern unsigned int ata66_it8172(ide_hwif_t *);
 extern void ide_init_it8172(ide_hwif_t *);
-#else
-# define pci_init_it8172    NULL
-# define ata66_it8172	    NULL
-# define ide_init_it8172    IDE_NO_DRIVER
 #endif
 
 #ifdef CONFIG_BLK_DEV_RZ1000
 extern void ide_init_rz1000(ide_hwif_t *);
-#else
-# define ide_init_rz1000    IDE_IGNORE
 #endif
 
 #ifdef CONFIG_BLK_DEV_SVWKS
 extern unsigned int pci_init_svwks(struct pci_dev *);
 extern unsigned int ata66_svwks(ide_hwif_t *);
 extern void ide_init_svwks(ide_hwif_t *);
-#else
-# define pci_init_svwks	NULL
-# define ata66_svwks	NULL
-# define ide_init_svwks	IDE_NO_DRIVER
 #endif
 
 #ifdef CONFIG_BLK_DEV_SIS5513
 extern unsigned int pci_init_sis5513(struct pci_dev *);
 extern unsigned int ata66_sis5513(ide_hwif_t *);
 extern void ide_init_sis5513(ide_hwif_t *);
-#else
-# define pci_init_sis5513   NULL
-# define ata66_sis5513	    NULL
-# define ide_init_sis5513   IDE_NO_DRIVER
 #endif
 
 #ifdef CONFIG_BLK_DEV_SLC90E66
 extern unsigned int pci_init_slc90e66(struct pci_dev *);
 extern unsigned int ata66_slc90e66(ide_hwif_t *);
 extern void ide_init_slc90e66(ide_hwif_t *);
-#else
-# define pci_init_slc90e66  NULL
-# define ata66_slc90e66	    NULL
-# define ide_init_slc90e66  IDE_NO_DRIVER
 #endif
 
 #ifdef CONFIG_BLK_DEV_SL82C105
 extern unsigned int pci_init_sl82c105(struct pci_dev *);
 extern void dma_init_sl82c105(ide_hwif_t *, unsigned long);
 extern void ide_init_sl82c105(ide_hwif_t *);
-#else
-# define pci_init_sl82c105  NULL
-# define dma_init_sl82c105  NULL
-# define ide_init_sl82c105  IDE_IGNORE
 #endif
 
 #ifdef CONFIG_BLK_DEV_TRM290
 extern void ide_init_trm290(ide_hwif_t *);
-#else
-# define ide_init_trm290    IDE_IGNORE
 #endif
 
 #ifdef CONFIG_BLK_DEV_VIA82CXXX
@@ -247,11 +165,6 @@
 extern unsigned int ata66_via82cxxx(ide_hwif_t *);
 extern void ide_init_via82cxxx(ide_hwif_t *);
 extern void ide_dmacapable_via82cxxx(ide_hwif_t *, unsigned long);
-#else
-# define pci_init_via82cxxx	    NULL
-# define ata66_via82cxxx	    NULL
-# define ide_init_via82cxxx	    IDE_NO_DRIVER
-# define ide_dmacapable_via82cxxx   NULL
 #endif
 
 typedef struct ide_pci_enablebit_s {
@@ -260,6 +173,17 @@
 	byte	val;	/* value of masked reg when "enabled" */
 } ide_pci_enablebit_t;
 
+/* Flags used to untangle quirk handling.
+ */
+#define ATA_F_DMA	0x01
+#define ATA_F_NODMA	0x02	/* no DMA mode supported at all */
+#define ATA_F_NOADMA	0x04	/* DMA has to be enabled explicitely */
+#define ATA_F_FIXIRQ	0x08	/* fixed irq wiring */
+#define ATA_F_SER	0x10	/* serialize on first and second channel interrupts */
+#define ATA_F_IRQ	0x20	/* trust IRQ information from config */
+#define ATA_F_PHACK	0x40	/* apply PROMISE hacks */
+#define ATA_F_HPTHACK	0x80	/* apply HPT366 hacks */
+
 typedef struct ide_pci_device_s {
 	unsigned short		vendor;
 	unsigned short		device;
@@ -268,114 +192,139 @@
 	void			(*init_hwif)(ide_hwif_t *hwif);
 	void			(*dma_init)(ide_hwif_t *hwif, unsigned long dmabase);
 	ide_pci_enablebit_t	enablebits[2];
-	byte			bootable;
+	unsigned int		bootable;
 	unsigned int		extra;
+	unsigned int		flags;
 } ide_pci_device_t;
 
 static ide_pci_device_t pci_chipsets[] __initdata = {
-	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371FB_0,	    NULL,		NULL,		    ide_init_piix,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82371FB_1,	    NULL,		NULL,		    ide_init_piix,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82371MX,	    NULL,		NULL,		    ide_init_piix,	NULL,			    {{0x6D,0x80,0x80}, {0x6F,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82371SB_1,	    pci_init_piix,	NULL,		    ide_init_piix,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82371AB,	    pci_init_piix,	NULL,		    ide_init_piix,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AB_1,	    pci_init_piix,	NULL,		    ide_init_piix,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82443MX_1,	    pci_init_piix,	NULL,		    ide_init_piix,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AA_1,	    pci_init_piix,	ata66_piix,	    ide_init_piix,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82372FB_1,	    pci_init_piix,	ata66_piix,	    ide_init_piix,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82451NX,	    pci_init_piix,	NULL,		    ide_init_piix,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_9,	    pci_init_piix,	ata66_piix,	    ide_init_piix,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_8,	    pci_init_piix,	ata66_piix,	    ide_init_piix,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_10,	    pci_init_piix,	ata66_piix,	    ide_init_piix,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C561,	    NULL,		NULL,		    NULL,		NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C576_1,	    pci_init_via82cxxx, ata66_via82cxxx,    ide_init_via82cxxx,	ide_dmacapable_via82cxxx,   {{0x40,0x02,0x02}, {0x40,0x01,0x01}},   ON_BOARD,	0 },
-	{PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C586_1,	    pci_init_via82cxxx, ata66_via82cxxx,    ide_init_via82cxxx,	ide_dmacapable_via82cxxx,   {{0x40,0x02,0x02}, {0x40,0x01,0x01}},   ON_BOARD,	0 },
-#ifdef CONFIG_PDC202XX_FORCE
-        {PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20246,	    pci_init_pdc202xx,  NULL,		    ide_init_pdc202xx,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,	16 },
-        {PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20262,	    pci_init_pdc202xx,  ata66_pdc202xx,	    ide_init_pdc202xx,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,	48 },
-        {PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20265,	    pci_init_pdc202xx,  ata66_pdc202xx,	    ide_init_pdc202xx,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	48 },
-        {PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20267,	    pci_init_pdc202xx,  ata66_pdc202xx,	    ide_init_pdc202xx,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,	48 },
-#else /* !CONFIG_PDC202XX_FORCE */
-	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20246,	    pci_init_pdc202xx,  NULL,		    ide_init_pdc202xx,	NULL,			    {{0x50,0x02,0x02}, {0x50,0x04,0x04}},   OFF_BOARD,	16 },
-	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20262,	    pci_init_pdc202xx,  ata66_pdc202xx,	    ide_init_pdc202xx,	NULL,			    {{0x50,0x02,0x02}, {0x50,0x04,0x04}},   OFF_BOARD,	48 },
-	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20265,	    pci_init_pdc202xx,  ata66_pdc202xx,	    ide_init_pdc202xx,	NULL,			    {{0x50,0x02,0x02}, {0x50,0x04,0x04}},   OFF_BOARD,	48 },
-	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20267,	    pci_init_pdc202xx,  ata66_pdc202xx,	    ide_init_pdc202xx,	NULL,			    {{0x50,0x02,0x02}, {0x50,0x04,0x04}},   OFF_BOARD,	48 },
+#ifdef CONFIG_BLK_DEV_PIIX
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_0, NULL, NULL, ide_init_piix,	NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_1, NULL, NULL, ide_init_piix,	NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX, NULL, NULL, ide_init_piix, NULL, {{0x6D,0x80,0x80}, {0x6F,0x80,0x80}}, ON_BOARD, 0, ATA_F_NODMA },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_1, pci_init_piix, NULL, ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB, pci_init_piix, NULL,	ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_1, pci_init_piix, NULL, ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_1, pci_init_piix, NULL, ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_1, pci_init_piix, ata66_piix, ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82372FB_1, pci_init_piix, ata66_piix, ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82451NX, pci_init_piix, NULL,	ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, ATA_F_NOADMA },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_9, pci_init_piix, ata66_piix,	ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_8, pci_init_piix, ata66_piix,	ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, pci_init_piix, ata66_piix, ide_init_piix,	NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
 #endif
-	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268,	    pci_init_pdc202xx,  ata66_pdc202xx,	    ide_init_pdc202xx,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,	0 },
+#ifdef CONFIG_BLK_DEV_VIA82CXXX
+	{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1,	pci_init_via82cxxx, ata66_via82cxxx, ide_init_via82cxxx, ide_dmacapable_via82cxxx, {{0x40,0x02,0x02}, {0x40,0x01,0x01}}, ON_BOARD, 0, ATA_F_NOADMA },
+	{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,	pci_init_via82cxxx, ata66_via82cxxx, ide_init_via82cxxx, ide_dmacapable_via82cxxx, {{0x40,0x02,0x02}, {0x40,0x01,0x01}}, ON_BOARD, 0, ATA_F_NOADMA },
+#endif
+#ifdef CONFIG_BLK_DEV_PDC202XX
+# ifdef CONFIG_PDC202XX_FORCE
+        {PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20246, pci_init_pdc202xx, NULL, ide_init_pdc202xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD,	16, ATA_F_IRQ | ATA_F_DMA },
+        {PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20262, pci_init_pdc202xx, ata66_pdc202xx, ide_init_pdc202xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 48, ATA_F_IRQ | ATA_F_PHACK | ATA_F_DMA},
+        {PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20265, pci_init_pdc202xx, ata66_pdc202xx, ide_init_pdc202xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 48, ATA_F_IRQ | ATA_F_PHACK | ATA_F_DMA},
+        {PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20267, pci_init_pdc202xx, ata66_pdc202xx, ide_init_pdc202xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 48, ATA_F_IRQ | ATA_F_DMA },
+# else
+	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20246, pci_init_pdc202xx, NULL, ide_init_pdc202xx, NULL, {{0x50,0x02,0x02}, {0x50,0x04,0x04}}, OFF_BOARD, 16, ATA_F_IRQ | ATA_F_DMA },
+	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20262, pci_init_pdc202xx, ata66_pdc202xx, ide_init_pdc202xx, NULL, {{0x50,0x02,0x02}, {0x50,0x04,0x04}}, OFF_BOARD, 48, ATA_F_IRQ | ATA_F_PHACK | ATA_F_DMA },
+	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20265, pci_init_pdc202xx, ata66_pdc202xx, ide_init_pdc202xx, NULL, {{0x50,0x02,0x02}, {0x50,0x04,0x04}}, OFF_BOARD, 48, ATA_F_IRQ | ATA_F_PHACK  | ATA_F_DMA },
+	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20267, pci_init_pdc202xx, ata66_pdc202xx, ide_init_pdc202xx, NULL, {{0x50,0x02,0x02}, {0x50,0x04,0x04}}, OFF_BOARD, 48, ATA_F_IRQ  | ATA_F_DMA },
+# endif
+	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268, pci_init_pdc202xx, ata66_pdc202xx, ide_init_pdc202xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_IRQ | ATA_F_DMA },
 	/* Promise used a different PCI ident for the raid card apparently to try and
 	   prevent Linux detecting it and using our own raid code. We want to detect
 	   it for the ataraid drivers, so we have to list both here.. */
-	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268R,	    pci_init_pdc202xx,  ata66_pdc202xx,	    ide_init_pdc202xx,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,	    0 },
-	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269,	    pci_init_pdc202xx,  ata66_pdc202xx,	    ide_init_pdc202xx,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,	    0 },
-	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20275,	    pci_init_pdc202xx,  ata66_pdc202xx,	    ide_init_pdc202xx,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,	    0 },
-	{PCI_VENDOR_ID_PCTECH,  PCI_DEVICE_ID_PCTECH_RZ1000,	    NULL,		NULL,		    ide_init_rz1000,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_PCTECH,  PCI_DEVICE_ID_PCTECH_RZ1001,	    NULL,		NULL,		    ide_init_rz1000,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_PCTECH,  PCI_DEVICE_ID_PCTECH_SAMURAI_IDE,   NULL,		NULL,		    NULL,		NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_CMD,     PCI_DEVICE_ID_CMD_640,		    NULL,		NULL,		    IDE_IGNORE,		NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_NS,      PCI_DEVICE_ID_NS_87410,		    NULL,		NULL,		    NULL,		NULL,			    {{0x43,0x08,0x08}, {0x47,0x08,0x08}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_SI,      PCI_DEVICE_ID_SI_5513,		    pci_init_sis5513,   ata66_sis5513,	    ide_init_sis5513,	NULL,			    {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_CMD,     PCI_DEVICE_ID_CMD_643,		    pci_init_cmd64x,	NULL,		    ide_init_cmd64x,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_CMD,     PCI_DEVICE_ID_CMD_646,		    pci_init_cmd64x,	NULL,		    ide_init_cmd64x,	NULL,			    {{0x00,0x00,0x00}, {0x51,0x80,0x80}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_CMD,     PCI_DEVICE_ID_CMD_648,		    pci_init_cmd64x,	ata66_cmd64x,	    ide_init_cmd64x,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_CMD,     PCI_DEVICE_ID_CMD_649,		    pci_init_cmd64x,	ata66_cmd64x,	    ide_init_cmd64x,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_CMD,     PCI_DEVICE_ID_CMD_680,		    pci_init_cmd64x,	ata66_cmd64x,	    ide_init_cmd64x,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_HOLTEK,  PCI_DEVICE_ID_HOLTEK_6565,	    NULL,		NULL,		    NULL,		NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_OPTI,    PCI_DEVICE_ID_OPTI_82C621,	    NULL,		NULL,		    ide_init_opti621,	NULL,			    {{0x45,0x80,0x00}, {0x40,0x08,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_OPTI,    PCI_DEVICE_ID_OPTI_82C825,	    NULL,		NULL,		    ide_init_opti621,	NULL,			    {{0x45,0x80,0x00}, {0x40,0x08,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_TEKRAM,  PCI_DEVICE_ID_TEKRAM_DC290,	    NULL,		NULL,		    ide_init_trm290,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_NS,      PCI_DEVICE_ID_NS_87415,		    NULL,		NULL,		    ide_init_ns87415,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_ARTOP,   PCI_DEVICE_ID_ARTOP_ATP850UF,	    pci_init_aec62xx,   NULL,		    ide_init_aec62xx,	ide_dmacapable_aec62xx,	    {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},   OFF_BOARD,	    0 },
-	{PCI_VENDOR_ID_ARTOP,   PCI_DEVICE_ID_ARTOP_ATP860,	    pci_init_aec62xx,   ata66_aec62xx,	    ide_init_aec62xx,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   NEVER_BOARD,    0 },
-	{PCI_VENDOR_ID_ARTOP,   PCI_DEVICE_ID_ARTOP_ATP860R,	    pci_init_aec62xx,   ata66_aec62xx,	    ide_init_aec62xx,	NULL,			    {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},   OFF_BOARD,	    0 },
-	{PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,	    pci_init_sl82c105,  NULL,		    ide_init_sl82c105,	dma_init_sl82c105,	    {{0x40,0x01,0x01}, {0x40,0x10,0x10}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_UMC,     PCI_DEVICE_ID_UMC_UM8673F,	    NULL,		NULL,		    NULL,		NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_UMC,     PCI_DEVICE_ID_UMC_UM8886A,	    NULL,		NULL,		    NULL,		NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_UMC,     PCI_DEVICE_ID_UMC_UM8886BF,	    NULL,		NULL,		    NULL,		NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_TTI,     PCI_DEVICE_ID_TTI_HPT343,	    pci_init_hpt34x,	NULL,		    ide_init_hpt34x,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   NEVER_BOARD,    16 },
-	{PCI_VENDOR_ID_TTI,     PCI_DEVICE_ID_TTI_HPT366,	    pci_init_hpt366,	ata66_hpt366,	    ide_init_hpt366,	ide_dmacapable_hpt366,	    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,	    240 },
-	{PCI_VENDOR_ID_AL,      PCI_DEVICE_ID_AL_M5229,		    pci_init_ali15x3,   ata66_ali15x3,	    ide_init_ali15x3,	ide_dmacapable_ali15x3,	    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_CONTAQ,  PCI_DEVICE_ID_CONTAQ_82C693,	    pci_init_cy82c693,  NULL,		    ide_init_cy82c693,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_HINT,	PCI_DEVICE_ID_HINT,		    NULL,		NULL,		    NULL,		NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_CYRIX,   PCI_DEVICE_ID_CYRIX_5530_IDE,	    pci_init_cs5530,	NULL,		    ide_init_cs5530,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_COBRA_7401,	    NULL,		NULL,		    NULL,		ide_dmacapable_amd74xx,	    {{0x40,0x01,0x01}, {0x40,0x02,0x02}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_VIPER_7409,	    pci_init_amd74xx,   ata66_amd74xx,	    ide_init_amd74xx,	ide_dmacapable_amd74xx,	    {{0x40,0x01,0x01}, {0x40,0x02,0x02}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_VIPER_7411,	    pci_init_amd74xx,   ata66_amd74xx,	    ide_init_amd74xx,	ide_dmacapable_amd74xx,	    {{0x40,0x01,0x01}, {0x40,0x02,0x02}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_VIPER_7441,	    pci_init_amd74xx,   ata66_amd74xx,	    ide_init_amd74xx,	ide_dmacapable_amd74xx,	    {{0x40,0x01,0x01}, {0x40,0x02,0x02}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_PDC,     PCI_DEVICE_ID_PDC_1841,		    pci_init_pdcadma,   ata66_pdcadma,	    ide_init_pdcadma,	ide_dmacapable_pdcadma,	    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,	    0 },
-	{PCI_VENDOR_ID_EFAR,    PCI_DEVICE_ID_EFAR_SLC90E66_1,	    pci_init_slc90e66,  ata66_slc90e66,	    ide_init_slc90e66,	NULL,			    {{0x41,0x80,0x80}, {0x43,0x80,0x80}},   ON_BOARD,	    0 },
-        {PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE, pci_init_svwks,  ata66_svwks,	    ide_init_svwks,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, pci_init_svwks,  ata66_svwks,	    ide_init_svwks,	NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 },
-	{PCI_VENDOR_ID_ITE,     PCI_DEVICE_ID_ITE_IT8172G,	    pci_init_it8172,	NULL,		    ide_init_it8172,	NULL,			    {{0x00,0x00,0x00}, {0x40,0x00,0x01}},   ON_BOARD,	    0 },
-	{0,			0,				    NULL,		NULL,		    NULL,		NULL,			    {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,	    0 }};
+	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268R, pci_init_pdc202xx, ata66_pdc202xx, ide_init_pdc202xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_IRQ  | ATA_F_DMA },
+	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269, pci_init_pdc202xx, ata66_pdc202xx, ide_init_pdc202xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_IRQ | ATA_F_DMA },
+	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20275, pci_init_pdc202xx, ata66_pdc202xx,	ide_init_pdc202xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_IRQ | ATA_F_DMA },
+#endif
+#ifdef CONFIG_BLK_DEV_RZ1000
+	{PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1000, NULL, NULL,	ide_init_rz1000, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1001, NULL, NULL,	ide_init_rz1000, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+#endif
+#ifdef CONFIG_BLK_DEV_SIS5513
+	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, pci_init_sis5513, ata66_sis5513, ide_init_sis5513, NULL, {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}}, ON_BOARD, 0, ATA_F_NOADMA },
+#endif
+#ifdef CONFIG_BLK_DEV_CMD64X
+	{PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_643, pci_init_cmd64x, NULL, ide_init_cmd64x, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_646, pci_init_cmd64x, NULL, ide_init_cmd64x, NULL, {{0x00,0x00,0x00}, {0x51,0x80,0x80}}, ON_BOARD, 0, ATA_F_DMA },
+	{PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_648, pci_init_cmd64x, ata66_cmd64x, ide_init_cmd64x, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_DMA },
+	{PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_649, pci_init_cmd64x, ata66_cmd64x, ide_init_cmd64x, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_DMA },
+	{PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_680, pci_init_cmd64x, ata66_cmd64x, ide_init_cmd64x, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_DMA },
+#endif
+#ifdef CONFIG_BLK_DEV_OPTI621
+	{PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C621, NULL, NULL, ide_init_opti621, NULL, {{0x45,0x80,0x00}, {0x40,0x08,0x00}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C825, NULL, NULL, ide_init_opti621, NULL, {{0x45,0x80,0x00}, {0x40,0x08,0x00}}, ON_BOARD, 0, 0 },
+#endif
+#ifdef CONFIG_BLK_DEV_TRM290
+	{PCI_VENDOR_ID_TEKRAM, PCI_DEVICE_ID_TEKRAM_DC290, NULL, NULL, ide_init_trm290,	NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+#endif
+#ifdef CONFIG_BLK_DEV_NS87415
+	{PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415, NULL, NULL, ide_init_ns87415, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+#endif
+#ifdef CONFIG_BLK_DEV_AEC62XX
+	{PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP850UF, pci_init_aec62xx, NULL, ide_init_aec62xx, ide_dmacapable_aec62xx, {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}}, OFF_BOARD, 0, ATA_F_SER | ATA_F_IRQ | ATA_F_DMA },
+	{PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860, pci_init_aec62xx, ata66_aec62xx, ide_init_aec62xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, NEVER_BOARD, 0, ATA_F_IRQ | ATA_F_NOADMA | ATA_F_DMA },
+	{PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860R, pci_init_aec62xx, ata66_aec62xx, ide_init_aec62xx, NULL, {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}}, OFF_BOARD, 0, ATA_F_IRQ | ATA_F_DMA },
+#endif
+#ifdef CONFIG_BLK_DEV_SL82C105
+	{PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105, pci_init_sl82c105, NULL, ide_init_sl82c105, dma_init_sl82c105, {{0x40,0x01,0x01}, {0x40,0x10,0x10}}, ON_BOARD, 0, 0 },
+#endif
+#ifdef CONFIG_BLK_DEV_HPT34X
+	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT343, pci_init_hpt34x, NULL, ide_init_hpt34x, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, NEVER_BOARD, 16, ATA_F_NOADMA | ATA_F_DMA },
+#endif
+#ifdef CONFIG_BLK_DEV_HPT366
+	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, pci_init_hpt366, ata66_hpt366, ide_init_hpt366, ide_dmacapable_hpt366, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 240, ATA_F_IRQ | ATA_F_HPTHACK | ATA_F_DMA },
+#endif
+#ifdef CONFIG_BLK_DEV_ALI15X3
+	{PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5229, pci_init_ali15x3, ata66_ali15x3, ide_init_ali15x3, ide_dmacapable_ali15x3, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+#endif
+#ifdef CONFIG_BLK_DEV_CY82C693
+	{PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693, pci_init_cy82c693, NULL, ide_init_cy82c693,	NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_DMA },
+#endif
+#ifdef CONFIG_BLK_DEV_CS5530
+	{PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_IDE, pci_init_cs5530, NULL, ide_init_cs5530, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_DMA },
+#endif
+#ifdef CONFIG_BLK_DEV_AMD74XX
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_COBRA_7401, NULL, NULL, NULL, ide_dmacapable_amd74xx, {{0x40,0x01,0x01}, {0x40,0x02,0x02}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7409, pci_init_amd74xx, ata66_amd74xx, ide_init_amd74xx, ide_dmacapable_amd74xx, {{0x40,0x01,0x01}, {0x40,0x02,0x02}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7411, pci_init_amd74xx, ata66_amd74xx, ide_init_amd74xx, ide_dmacapable_amd74xx, {{0x40,0x01,0x01}, {0x40,0x02,0x02}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7441, pci_init_amd74xx, ata66_amd74xx, ide_init_amd74xx, ide_dmacapable_amd74xx, {{0x40,0x01,0x01}, {0x40,0x02,0x02}}, ON_BOARD, 0, 0 },
+#endif
+#ifdef CONFIG_BLK_DEV_PDC_ADMA
+	{PCI_VENDOR_ID_PDC, PCI_DEVICE_ID_PDC_1841, pci_init_pdcadma, ata66_pdcadma, ide_init_pdcadma, ide_dmacapable_pdcadma, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_NODMA },
+#endif
+#ifdef CONFIG_BLK_DEV_SLC90E66
+	{PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1, pci_init_slc90e66, ata66_slc90e66, ide_init_slc90e66, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+#endif
+#ifdef CONFIG_BLK_DEV_SVWKS
+        {PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE, pci_init_svwks, ata66_svwks, ide_init_svwks, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_DMA },
+	{PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, pci_init_svwks, ata66_svwks, ide_init_svwks, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+#endif
+#ifdef CONFIG_BLK_DEV_IT8172
+	{PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_IT8172G, pci_init_it8172,	NULL, ide_init_it8172, NULL, {{0x00,0x00,0x00}, {0x40,0x00,0x01}}, ON_BOARD, 0, 0 },
+#endif
+	/* Those are id's of chips we don't deal currently with. */
+	{PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_640, NULL, NULL, IDE_IGNORE, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410, NULL, NULL, NULL, NULL, {{0x43,0x08,0x08}, {0x47,0x08,0x08}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_HINT, PCI_DEVICE_ID_HINT, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_HOLTEK, PCI_DEVICE_ID_HOLTEK_6565, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8673F, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
+	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886A, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
+	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886BF, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
+	{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C561, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_NOADMA },
+	{0, 0, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0 }};
 
 /*
  * This allows offboard ide-pci cards the enable a BIOS, verify interrupt
  * settings of split-mirror pci-config space, place chipset into init-mode,
  * and/or preserve an interrupt if the card is not native ide support.
  */
-static unsigned int __init trust_pci_irq(struct pci_dev *dev)
+static unsigned int __init trust_pci_irq(ide_pci_device_t *d, struct pci_dev *dev)
 {
-	if (dev->vendor == PCI_VENDOR_ID_TTI && dev->device == PCI_DEVICE_ID_TTI_HPT366)
+	if (d->flags & ATA_F_IRQ)
 		return dev->irq;
-	else if (dev->vendor == PCI_VENDOR_ID_PROMISE) {
-		switch(dev->device) {
-			case PCI_DEVICE_ID_PROMISE_20246:
-			case PCI_DEVICE_ID_PROMISE_20262:
-			case PCI_DEVICE_ID_PROMISE_20265:
-			case PCI_DEVICE_ID_PROMISE_20267:
-			case PCI_DEVICE_ID_PROMISE_20268:
-			case PCI_DEVICE_ID_PROMISE_20268R:
-			case PCI_DEVICE_ID_PROMISE_20269:
-			case PCI_DEVICE_ID_PROMISE_20275:
-				return dev->irq;
-		}
-	} else if (dev->vendor == PCI_VENDOR_ID_ARTOP) {
-		switch(dev->device) {
-			case PCI_DEVICE_ID_ARTOP_ATP850UF:
-			case PCI_DEVICE_ID_ARTOP_ATP860:
-			case PCI_DEVICE_ID_ARTOP_ATP860R:
-				return dev->irq;
-		}
-	}
+
 	return 0;
 }
 
@@ -505,14 +454,12 @@
 		 * enabled by the bios for raid purposes.  Skip the normal "is
 		 * it enabled" test for those.
 		 */
-		if ((d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20265) ||
-		    (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20262))
+		if (d->flags & ATA_F_PHACK)
 			goto controller_ok;
 	}
 
 	/* Test whatever the port is enabled.
 	 */
-
 	if (e->reg) {
 		if (pci_read_config_byte(dev, e->reg, &tmp))
 			return 0; /* error! */
@@ -520,10 +467,10 @@
 			return 0;
 	}
 
+	/* Nothing to be done for the second port.
+	 */
 	if (port == 1) {
-		/* Nothing to be done for the second port. */
-		if ((d->vendor == PCI_VENDOR_ID_TTI && d->device == PCI_DEVICE_ID_TTI_HPT366)
-				&& (class_rev < 0x03))
+		if ((d->flags & ATA_F_HPTHACK) && (class_rev < 0x03))
 			return 0;
 	}
 controller_ok:
@@ -567,25 +514,23 @@
 	if (!hwif->irq)
 		hwif->irq = pciirq;
 
+	/* Setup the mate interface if we have two channels.
+	 */
 	if (*mate) {
 		hwif->mate = *mate;
 		(*mate)->mate = hwif;
-		if (d->vendor == PCI_VENDOR_ID_ARTOP && d->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
+		if (d->flags & ATA_F_SER) {
 			hwif->serialized = 1;
 			(*mate)->serialized = 1;
 		}
 	}
 
-	if ((d->vendor == PCI_VENDOR_ID_UMC && d->device == PCI_DEVICE_ID_UMC_UM8886A) ||
-	    (d->vendor == PCI_VENDOR_ID_UMC && d->device == PCI_DEVICE_ID_UMC_UM8886BF) ||
-	    (d->vendor == PCI_VENDOR_ID_UMC && d->device == PCI_DEVICE_ID_UMC_UM8673F)) {
-
-		/* Fixed IRQ wiring */
+	/* Hard wired IRQ lines on UMC chips and no DMA transfers.*/
+	if (d->flags & ATA_F_FIXIRQ) {
 		hwif->irq = hwif->channel ? 15 : 14;
 		goto no_dma;
 	}
-	if ((d->vendor == PCI_VENDOR_ID_INTEL && d->device == PCI_DEVICE_ID_INTEL_82371MX) ||
-	    (d->vendor == PCI_VENDOR_ID_PDC && d->device == PCI_DEVICE_ID_PDC_1841))
+	if (d->flags & ATA_F_NODMA)
 		goto no_dma;
 
 	/* Check whatever this interface is UDMA4 mode capable. */
@@ -596,39 +541,13 @@
 			hwif->udma_four = d->ata66_check(hwif);
 	}
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if ((d->vendor == PCI_VENDOR_ID_SI && d->device == PCI_DEVICE_ID_SI_5513) ||
-	    (d->vendor == PCI_VENDOR_ID_ARTOP && d->device == PCI_DEVICE_ID_ARTOP_ATP860) ||
-	    (d->vendor == PCI_VENDOR_ID_INTEL && d->device == PCI_DEVICE_ID_INTEL_82451NX) ||
-	    (d->vendor == PCI_VENDOR_ID_TTI && d->device == PCI_DEVICE_ID_TTI_HPT343)  ||
-	    (d->vendor == PCI_VENDOR_ID_VIA && d->device == PCI_DEVICE_ID_VIA_82C561) ||
-	    (d->vendor == PCI_VENDOR_ID_VIA && d->device == PCI_DEVICE_ID_VIA_82C576_1) ||
-	    (d->vendor == PCI_VENDOR_ID_VIA && d->device == PCI_DEVICE_ID_VIA_82C586_1))
+	if (d->flags & ATA_F_NOADMA)
 		autodma = 0;
 
 	if (autodma)
 		hwif->autodma = 1;
 
-	if ((d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20246) ||
-	    (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20262) ||
-	    (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20265) ||
-	    (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20267) ||
-	    (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20268) ||
-	    (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20268R) ||
-	    (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20269) ||
-	    (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20275) ||
-	    (d->vendor == PCI_VENDOR_ID_ARTOP && d->device == PCI_DEVICE_ID_ARTOP_ATP850UF) ||
-	    (d->vendor == PCI_VENDOR_ID_ARTOP && d->device == PCI_DEVICE_ID_ARTOP_ATP860) ||
-	    (d->vendor == PCI_VENDOR_ID_ARTOP && d->device == PCI_DEVICE_ID_ARTOP_ATP860R) ||
-	    (d->vendor == PCI_VENDOR_ID_TTI && d->device == PCI_DEVICE_ID_TTI_HPT343) ||
-	    (d->vendor == PCI_VENDOR_ID_TTI && d->device == PCI_DEVICE_ID_TTI_HPT366) ||
-	    (d->vendor == PCI_VENDOR_ID_CYRIX && d->device == PCI_DEVICE_ID_CYRIX_5530_IDE) ||
-	    (d->vendor == PCI_VENDOR_ID_CONTAQ && d->device == PCI_DEVICE_ID_CONTAQ_82C693) ||
-	    (d->vendor == PCI_VENDOR_ID_CMD && d->device == PCI_DEVICE_ID_CMD_646) ||
-	    (d->vendor == PCI_VENDOR_ID_CMD && d->device == PCI_DEVICE_ID_CMD_648) ||
-	    (d->vendor == PCI_VENDOR_ID_CMD && d->device == PCI_DEVICE_ID_CMD_649) ||
-	    (d->vendor == PCI_VENDOR_ID_CMD && d->device == PCI_DEVICE_ID_CMD_680) ||
-	    (d->vendor == PCI_VENDOR_ID_SERVERWORKS && d->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) ||
-	    ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 0x80))) {
+	if ((d->flags & ATA_F_DMA) || ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 0x80))) {
 		unsigned long dma_base;
 
 		dma_base = ide_get_or_set_dma_base(hwif, (!*mate && d->extra) ? d->extra : 0, dev->name);
@@ -769,7 +688,7 @@
 		if (d->init_chipset)
 			pciirq = d->init_chipset(dev);
 		else
-			pciirq = trust_pci_irq(dev);
+			pciirq = trust_pci_irq(d, dev);
 	} else if (tried_config) {
 		printk("%s: will probe irqs later\n", dev->name);
 		pciirq = 0;
@@ -799,9 +718,9 @@
 	struct pci_dev *dev2 = NULL, *findev;
 	ide_pci_device_t *d2;
 
-	if ((dev->bus->self &&
-	     dev->bus->self->vendor == PCI_VENDOR_ID_DEC) &&
-	    (dev->bus->self->device == PCI_DEVICE_ID_DEC_21150)) {
+	if (dev->bus->self &&
+	    dev->bus->self->vendor == PCI_VENDOR_ID_DEC &&
+	    dev->bus->self->device == PCI_DEVICE_ID_DEC_21150) {
 		if (PCI_SLOT(dev->devfn) & 2) {
 			return;
 		}
@@ -855,8 +774,8 @@
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin1);
 	pci_for_each_dev(findev) {
-		if ((findev->vendor == dev->vendor) &&
-		    (findev->device == dev->device) &&
+		if (findev->vendor == dev->vendor &&
+		    findev->device == dev->device &&
 		    ((findev->devfn - dev->devfn) == 1) &&
 		    (PCI_FUNC(findev->devfn) & 1)) {
 			dev2 = findev;
@@ -905,7 +824,7 @@
 		++d;
 
 	if (d->init_hwif == IDE_IGNORE)
-		printk("%s: has been ignored PCI bus scan\n", dev->name);
+		printk("%s: has been ignored by PCI bus scan\n", dev->name);
 	else if ((d->vendor == PCI_VENDOR_ID_OPTI && d->device == PCI_DEVICE_ID_OPTI_82C558) && !(PCI_FUNC(dev->devfn) & 1))
 		return;
 	else if ((d->vendor == PCI_VENDOR_ID_CONTAQ && d->device == PCI_DEVICE_ID_CONTAQ_82C693) && (!(PCI_FUNC(dev->devfn) & 1) || !((dev->class >> 8) == PCI_CLASS_STORAGE_IDE)))
@@ -914,7 +833,7 @@
 		return;	/* IT8172G is also more than only an IDE controller */
 	else if ((d->vendor == PCI_VENDOR_ID_UMC && d->device == PCI_DEVICE_ID_UMC_UM8886A) && !(PCI_FUNC(dev->devfn) & 1))
 		return;	/* UM8886A/BF pair */
-	else if ((d->vendor == PCI_VENDOR_ID_TTI && d->device == PCI_DEVICE_ID_TTI_HPT366))
+	else if (d->flags & ATA_F_HPTHACK)
 		hpt366_device_order_fixup(dev, d);
 	else if (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20268R)
 		pdc20270_device_order_fixup(dev, d);
diff -ur linux-2.5.5/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.5/include/linux/ide.h	Sun Feb 24 16:32:54 2002
+++ linux/include/linux/ide.h	Sun Feb 24 19:51:20 2002
@@ -551,7 +551,7 @@
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
 	int		irq;		/* our irq number */
 	byte		major;		/* our major number */
-	char 		name[6];	/* name of interface, eg. "ide0" */
+	char 		name[80];	/* name of interface */
 	byte		index;		/* 0 for ide0; 1 for ide1; ... */
 	hwif_chipset_t	chipset;	/* sub-module for tuning.. */
 	unsigned	noprobe    : 1;	/* don't probe for this interface */

--------------090702080408050407020507--

