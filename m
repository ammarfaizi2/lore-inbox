Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267910AbTBRSFx>; Tue, 18 Feb 2003 13:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267883AbTBRSFf>; Tue, 18 Feb 2003 13:05:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38409 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267989AbTBRSEH>; Tue, 18 Feb 2003 13:04:07 -0500
Subject: PATCH: rmeove ide_ioreg_t from PCI ide
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:14:24 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCG8-0006AI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ppc/mpc8xx.c linux-2.5.61-ac2/drivers/ide/ppc/mpc8xx.c
--- linux-2.5.61/drivers/ide/ppc/mpc8xx.c	2003-02-10 18:38:54.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ppc/mpc8xx.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/ide-m8xx.c
+ *  linux/drivers/ide/ppc/ide-m8xx.c
  *
  *  Copyright (C) 2000, 2001 Wolfgang Denk, wd@denx.de
  *  Modified for direct IDE interface
@@ -54,7 +54,7 @@
 
 typedef	struct ide_ioport_desc {
 	unsigned long	base_off;		/* Offset to PCMCIA memory	*/
-	ide_ioreg_t	reg_off[IDE_NR_PORTS];	/* controller register offsets	*/
+	unsigned long	reg_off[IDE_NR_PORTS];	/* controller register offsets	*/
 	int		irq;			/* IRQ				*/
 } ide_ioport_desc_t;
 
@@ -113,7 +113,7 @@
  * IDE stuff.
  */
 static int
-m8xx_ide_default_irq(ide_ioreg_t base)
+m8xx_ide_default_irq(unsigned long base)
 {
 #ifdef CONFIG_BLK_DEV_MPC8xx_IDE
 	if (base >= MAX_HWIFS)
@@ -127,7 +127,7 @@
 #endif
 }
 
-static ide_ioreg_t
+static unsigned long
 m8xx_ide_default_io_base(int index)
 {
         return index;
@@ -161,10 +161,10 @@
  */
 #if defined(CONFIG_IDE_8xx_PCCARD) || defined(CONFIG_IDE_8xx_DIRECT)
 static void
-m8xx_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port, 
-		ide_ioreg_t ctrl_port, int *irq)
+m8xx_ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port, 
+		unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t *p = hw->io_ports;
+	unsigned long *p = hw->io_ports;
 	int i;
 
 	typedef struct {
@@ -346,9 +346,9 @@
  */
 #if defined(CONFIG_IDE_EXT_DIRECT)
 void m8xx_ide_init_hwif_ports (hw_regs_t *hw,
-	ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq)
+	unsigned long data_port, unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t *p = hw->io_ports;
+	unsigned long *p = hw->io_ports;
 	int i;
 
 	u32 ide_phy_base;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ppc/pmac.c linux-2.5.61-ac2/drivers/ide/ppc/pmac.c
--- linux-2.5.61/drivers/ide/ppc/pmac.c	2003-02-10 18:37:58.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ppc/pmac.c	2003-02-18 18:06:19.000000000 +0000
@@ -51,7 +51,7 @@
 #define DMA_WAIT_TIMEOUT	500
 
 typedef struct pmac_ide_hwif {
-	ide_ioreg_t			regbase;
+	unsigned long			regbase;
 	int				irq;
 	int				kind;
 	int				aapl_bus_id;
@@ -267,7 +267,7 @@
  */
 void __pmac
 pmac_ide_init_hwif_ports(hw_regs_t *hw,
-			      ide_ioreg_t data_port, ide_ioreg_t ctrl_port,
+			      unsigned long data_port, unsigned long ctrl_port,
 			      int *irq)
 {
 	int i, ix;
@@ -672,14 +672,14 @@
 	pmif->timings[0] = pmif->timings[1] = value;
 }
 
-ide_ioreg_t __pmac
+unsigned long __pmac
 pmac_ide_get_base(int index)
 {
 	return pmac_ide[index].regbase;
 }
 
 int __pmac
-pmac_ide_check_base(ide_ioreg_t base)
+pmac_ide_check_base(unsigned long base)
 {
 	int ix;
 	
@@ -690,7 +690,7 @@
 }
 
 int __pmac
-pmac_ide_get_irq(ide_ioreg_t base)
+pmac_ide_get_irq(unsigned long base)
 {
 	int ix;
 
