Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267917AbTBRSID>; Tue, 18 Feb 2003 13:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267874AbTBRSGi>; Tue, 18 Feb 2003 13:06:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40713 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267902AbTBRSFv>; Tue, 18 Feb 2003 13:05:51 -0500
Subject: PATCH: exterminate unused io_ops structures and switch to ulong
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:16:11 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCHr-0006Ah-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iops struct may be a good idea in the longer run but right now its
unused and its mess that can be restored neatly later on.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/include/linux/ide.h linux-2.5.61-ac2/include/linux/ide.h
--- linux-2.5.61/include/linux/ide.h	2003-02-10 18:38:20.000000000 +0000
+++ linux-2.5.61-ac2/include/linux/ide.h	2003-02-18 18:02:56.000000000 +0000
@@ -297,36 +305,18 @@
 		ide_pmac,	ide_etrax100,	ide_acorn
 } hwif_chipset_t;
 
-typedef struct ide_io_ops_s {
-	/* insert io operations here! */
-	void (*OUTB)(u8 value, ide_ioreg_t port);
-	void (*OUTW)(u16 value, ide_ioreg_t port);
-	void (*OUTL)(u32 value, ide_ioreg_t port);
-	void (*OUTSW)(ide_ioreg_t port, void *addr, u32 count);
-	void (*OUTSL)(ide_ioreg_t port, void *addr, u32 count);
-
-	u8  (*INB)(ide_ioreg_t port);
-	u16 (*INW)(ide_ioreg_t port);
-	u32 (*INL)(ide_ioreg_t port);
-	void (*INSW)(ide_ioreg_t port, void *addr, u32 count);
-	void (*INSL)(ide_ioreg_t port, void *addr, u32 count);
-} ide_io_ops_t;
-
 /*
  * Structure to hold all information about the location of this port
  */
 typedef struct hw_regs_s {
-	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
+	unsigned long	io_ports[IDE_NR_PORTS];	/* task file registers */
 	int		irq;			/* our irq number */
 	int		dma;			/* our dma entry */
 	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
 	void		*priv;			/* interface specific data */
 	hwif_chipset_t  chipset;
-#if 0
-	ide_io_ops_t	*iops;			/* */
-#endif
-	sata_ioreg_t	sata_scr[SATA_NR_PORTS];
-	sata_ioreg_t	sata_misc[SATA_NR_PORTS];
+	unsigned long	sata_scr[SATA_NR_PORTS];
+	unsigned long	sata_misc[SATA_NR_PORTS];
 } hw_regs_t;
 
 /*
@@ -338,10 +328,10 @@
  * Set up hw_regs_t structure before calling ide_register_hw (optional)
  */
 void ide_setup_ports(	hw_regs_t *hw,
-			ide_ioreg_t base,
+			unsigned long base,
 			int *offsets,
-			ide_ioreg_t ctrl,
-			ide_ioreg_t intr,
+			unsigned long ctrl,
+			unsigned long intr,
 			ide_ack_intr_t *ack_intr,
 #if 0
 			ide_io_ops_t *iops,
