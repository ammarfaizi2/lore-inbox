Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267902AbTBRSI4>; Tue, 18 Feb 2003 13:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267918AbTBRSIW>; Tue, 18 Feb 2003 13:08:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41737 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267902AbTBRSG6>; Tue, 18 Feb 2003 13:06:58 -0500
Subject: PATCH: kill more ioregs, add OUTBSYNC
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:17:19 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCIx-0006Az-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/include/linux/ide.h linux-2.5.61-ac2/include/linux/ide.h
--- linux-2.5.61/include/linux/ide.h	2003-02-10 18:38:20.000000000 +0000
+++ linux-2.5.61-ac2/include/linux/ide.h	2003-02-18 18:02:56.000000000 +0000
@@ -894,9 +885,9 @@
 	char name[6];			/* name of interface, eg. "ide0" */
 
 		/* task file registers for pata and sata */
-	ide_ioreg_t	io_ports[IDE_NR_PORTS];
-	sata_ioreg_t	sata_scr[SATA_NR_PORTS];
-	sata_ioreg_t	sata_misc[SATA_NR_PORTS];
+	unsigned long	io_ports[IDE_NR_PORTS];
+	unsigned long	sata_scr[SATA_NR_PORTS];
+	unsigned long	sata_misc[SATA_NR_PORTS];
 
 	hw_regs_t	hw;		/* Hardware info */
 	ide_drive_t	drives[MAX_DRIVES];	/* drive info */
@@ -960,9 +951,6 @@
 	void (*atapi_output_bytes)(ide_drive_t *, void *, u32);
 #endif
 
-#if 0
-	ide_dma_ops_t	*dmaops;
-#else
 	int (*ide_dma_read)(ide_drive_t *drive);
 	int (*ide_dma_write)(ide_drive_t *drive);
 	int (*ide_dma_begin)(ide_drive_t *drive);
@@ -988,23 +976,19 @@
 	ide_startstop_t (*ide_dma_queued_read)(ide_drive_t *drive);
 	ide_startstop_t (*ide_dma_queued_write)(ide_drive_t *drive);
 	ide_startstop_t (*ide_dma_queued_start)(ide_drive_t *drive);
-#endif
 
-#if 0
-	ide_io_ops_t	*iops;
-#else
-	void (*OUTB)(u8 addr, ide_ioreg_t port);
-	void (*OUTW)(u16 addr, ide_ioreg_t port);
-	void (*OUTL)(u32 addr, ide_ioreg_t port);
-	void (*OUTSW)(ide_ioreg_t port, void *addr, u32 count);
-	void (*OUTSL)(ide_ioreg_t port, void *addr, u32 count);
-
-	u8  (*INB)(ide_ioreg_t port);
-	u16 (*INW)(ide_ioreg_t port);
-	u32 (*INL)(ide_ioreg_t port);
-	void (*INSW)(ide_ioreg_t port, void *addr, u32 count);
-	void (*INSL)(ide_ioreg_t port, void *addr, u32 count);
-#endif
+	void (*OUTB)(u8 addr, unsigned long port);
+	void (*OUTBSYNC)(u8 addr, unsigned long port);
+	void (*OUTW)(u16 addr, unsigned long port);
+	void (*OUTL)(u32 addr, unsigned long port);
+	void (*OUTSW)(unsigned long port, void *addr, u32 count);
+	void (*OUTSL)(unsigned long port, void *addr, u32 count);
+
+	u8  (*INB)(unsigned long port);
+	u16 (*INW)(unsigned long port);
+	u32 (*INL)(unsigned long port);
+	void (*INSW)(unsigned long port, void *addr, u32 count);
+	void (*INSL)(unsigned long port, void *addr, u32 count);
 
 	/* dma physical region descriptor table (cpu view) */
 	unsigned int	*dmatable_cpu;
