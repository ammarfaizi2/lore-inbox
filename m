Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbUJXMM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUJXMM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 08:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbUJXMM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 08:12:27 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:40172 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261453AbUJXMIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 08:08:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=pfyrBDSug+sPK+zAzQdfx53sIPMF0xSeDdl1tqaoy+1zt8zLO99A+R7XoE8w0is8I7+m9Tbyl8gXJKOjS1vGGJe62QeR8bD9rLyr1H/sJZp5xmAf0cyXKajH6ijHfKzOyuPrPRKlwRcIs3JQVH3itc75hPSY0Iw3ChIk74bTJQc=
Message-ID: <58cb370e04102405081d62bf40@mail.gmail.com>
Date: Sun, 24 Oct 2004 14:08:15 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: torvalds@osdl.org
Subject: [BK PATCHES] ide-2.6 update
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill most of /proc/ide/<chipset> bloat.

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/pci/aec62xx.c      |  110 --------------------------
 drivers/ide/pci/aec62xx.h      |    2 
 drivers/ide/pci/atiixp.c       |  118 ----------------------------
 drivers/ide/pci/cs5520.c       |   74 +-----------------
 drivers/ide/pci/cs5530.c       |   58 --------------
 drivers/ide/pci/hpt366.c       |   72 -----------------
 drivers/ide/pci/hpt366.h       |    2 
 drivers/ide/pci/pdc202xx_new.c |   64 ---------------
 drivers/ide/pci/pdc202xx_new.h |    2 
 drivers/ide/pci/pdc202xx_old.c |  130 -------------------------------
 drivers/ide/pci/pdc202xx_old.h |   37 ---------
 drivers/ide/pci/piix.c         |  167 ----------------------------------------
 drivers/ide/pci/piix.h         |    4 
 drivers/ide/pci/sc1200.c       |   65 ---------------
 drivers/ide/pci/serverworks.c  |  168 -----------------------------------------
 drivers/ide/pci/serverworks.h  |    2 
 drivers/ide/pci/slc90e66.c     |  111 ---------------------------
 17 files changed, 12 insertions(+), 1174 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/10/23 1.2039)
   [ide] slc90e66: kill /proc/ide/slc90e66
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/23 1.2038)
   [ide] serverworks: kill /proc/ide/svwks
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/23 1.2037)
   [ide] sc1200: kill /proc/ide/sc1200
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/23 1.2036)
   [ide] piix: kill /proc/ide/piix
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/23 1.2035)
   [ide] pdc202xx_old: kill /proc/ide/pdc202xx
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/23 1.2034)
   [ide] pdc202xx_new: kill /proc/ide/pdcnew
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/23 1.2033)
   [ide] hpt366: kill /proc/ide/hpt366
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/23 1.2032)
   [ide] cs5530: kill /proc/ide/cs5530
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/23 1.2031)
   [ide] cs5520: kill /proc/ide/cs5520
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/23 1.2030)
   [ide] atiixp: kill /proc/ide/atiixp
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/23 1.2029)
   [ide] aec62xx: kill /proc/ide/aec62xx
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/pci/aec62xx.c b/drivers/ide/pci/aec62xx.c
--- a/drivers/ide/pci/aec62xx.c	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/aec62xx.c	2004-10-23 23:29:01 +02:00
@@ -18,52 +18,7 @@
 
 #include "aec62xx.h"
 
-#if defined(DISPLAY_AEC62XX_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 aec62xx_proc = 0;
-
-#define AEC_MAX_DEVS		5
-
-static struct pci_dev *aec_devs[AEC_MAX_DEVS];
-static int n_aec_devs;
-
-static int aec62xx_get_info (char *buffer, char **addr, off_t offset,
int count)
-{
-	char *p = buffer;
-	char *chipset_nums[] = {"error", "error", "error", "error",
-				"error", "error", "850UF",   "860",
-				 "860R",   "865",  "865R", "error"  };
-	int len;
-	int i;
-
-	for (i = 0; i < n_aec_devs; i++) {
-		struct pci_dev *dev	= aec_devs[i];
-		unsigned long iobase = pci_resource_start(dev, 4);
-		u8 c0 = 0, c1 = 0, art	= 0;
-
-		c0 = inb(iobase + 0x02);
-		c1 = inb(iobase + 0x0a);
-
-		p += sprintf(p, "\nController: %d\n", i);
-		p += sprintf(p, "Chipset: AEC%s\n", chipset_nums[dev->device]);
-
-		p += sprintf(p, "--------------- Primary Channel "
-				"---------------- Secondary Channel "
-				"-------------\n");
-		(void) pci_read_config_byte(dev, 0x4a, &art);
-		p += sprintf(p, "                %sabled ",
-			(art&0x02)?" en":"dis");
-		p += sprintf(p, "                        %sabled\n",
-			(art&0x04)?" en":"dis");
-		p += sprintf(p, "--------------- drive0 --------- drive1 "
-				"-------- drive0 ---------- drive1 ------\n");
-		p += sprintf(p, "DMA enabled:    %s              %s ",
-			(c0&0x20)?"yes":"no ",(c0&0x40)?"yes":"no ");
-		p += sprintf(p, "            %s               %s\n",
-			(c1&0x20)?"yes":"no ",(c1&0x40)?"yes":"no ");
-
+#if 0
 		if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
 			(void) pci_read_config_byte(dev, 0x54, &art);
 			p += sprintf(p, "DMA Mode:       %s(%s)",
@@ -79,59 +34,7 @@
 				(c1&0x40)?((art&0xc0)?"UDMA":" DMA"):" PIO",
 				(art&0x80)?"2":(art&0x40)?"1":"0");
 		} else {
-			/*
-			 * case PCI_DEVICE_ID_ARTOP_ATP860:
-			 * case PCI_DEVICE_ID_ARTOP_ATP860R:
-			 * case PCI_DEVICE_ID_ARTOP_ATP865:
-			 * case PCI_DEVICE_ID_ARTOP_ATP865R:
-			 */
-			(void) pci_read_config_byte(dev, 0x44, &art);
-			p += sprintf(p, "DMA Mode:       %s(%s)",
-				(c0&0x20)?((art&0x07)?"UDMA":" DMA"):" PIO",
-				((art&0x07)==0x07)?"6":
-				((art&0x06)==0x06)?"5":
-				((art&0x05)==0x05)?"4":
-				((art&0x04)==0x04)?"3":
-				((art&0x03)==0x03)?"2":
-				((art&0x02)==0x02)?"1":
-				((art&0x01)==0x01)?"0":"?");
-			p += sprintf(p, "          %s(%s)",
-				(c0&0x40)?((art&0x70)?"UDMA":" DMA"):" PIO",
-				((art&0x70)==0x70)?"6":
-				((art&0x60)==0x60)?"5":
-				((art&0x50)==0x50)?"4":
-				((art&0x40)==0x40)?"3":
-				((art&0x30)==0x30)?"2":
-				((art&0x20)==0x20)?"1":
-				((art&0x10)==0x10)?"0":"?");
-			(void) pci_read_config_byte(dev, 0x45, &art);
-			p += sprintf(p, "         %s(%s)",
-				(c1&0x20)?((art&0x07)?"UDMA":" DMA"):" PIO",
-				((art&0x07)==0x07)?"6":
-				((art&0x06)==0x06)?"5":
-				((art&0x05)==0x05)?"4":
-				((art&0x04)==0x04)?"3":
-				((art&0x03)==0x03)?"2":
-				((art&0x02)==0x02)?"1":
-				((art&0x01)==0x01)?"0":"?");
-			p += sprintf(p, "           %s(%s)\n",
-				(c1&0x40)?((art&0x70)?"UDMA":" DMA"):" PIO",
-				((art&0x70)==0x70)?"6":
-				((art&0x60)==0x60)?"5":
-				((art&0x50)==0x50)?"4":
-				((art&0x40)==0x40)?"3":
-				((art&0x30)==0x30)?"2":
-				((art&0x20)==0x20)?"1":
-				((art&0x10)==0x10)?"0":"?");
-		}
-	}
-	/* p - buffer must be less than 4k! */
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-	
-	return len > count ? count : len;
-}
-#endif	/* defined(DISPLAY_AEC62xx_TIMINGS) && defined(CONFIG_PROC_FS) */
+#endif
 
 /*
  * TO DO: active tuning and correction of cards without a bios.
@@ -374,15 +277,6 @@
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
 		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
dev->resource[PCI_ROM_RESOURCE].start);
 	}
-
-#if defined(DISPLAY_AEC62XX_TIMINGS) && defined(CONFIG_PROC_FS)
-	aec_devs[n_aec_devs++] = dev;
-
-	if (!aec62xx_proc) {
-		aec62xx_proc = 1;
-		ide_pci_create_host_proc("aec62xx", aec62xx_get_info);
-	}
-#endif /* DISPLAY_AEC62XX_TIMINGS && CONFIG_PROC_FS */
 
 	if (bus_speed <= 33)
 		pci_set_drvdata(dev, (void *) aec6xxx_33_base);
diff -Nru a/drivers/ide/pci/aec62xx.h b/drivers/ide/pci/aec62xx.h
--- a/drivers/ide/pci/aec62xx.h	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/aec62xx.h	2004-10-23 23:29:01 +02:00
@@ -5,8 +5,6 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-#define DISPLAY_AEC62XX_TIMINGS
-
 struct chipset_bus_clock_list_entry {
 	byte		xfer_speed;
 	byte		chipset_settings;
diff -Nru a/drivers/ide/pci/atiixp.c b/drivers/ide/pci/atiixp.c
--- a/drivers/ide/pci/atiixp.c	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/atiixp.c	2004-10-23 23:29:01 +02:00
@@ -47,102 +47,6 @@
 
 static int save_mdma_mode[4];
 
-#define DISPLAY_ATIIXP_TIMINGS
-
-#if defined(DISPLAY_ATIIXP_TIMINGS) && defined(CONFIG_PROC_FS)
-
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 atiixp_proc;
-static struct pci_dev *bmide_dev;
-
-/**
- *	atiixp_get_info		-	fill in /proc for ATIIXP IDE
- *	@buffer: buffer to fill
- *	@addr: address of user start in buffer
- *	@offset: offset into 'file'
- *	@count: buffer count
- *
- *	Output summary data on the tuning.
- */
-
-static int atiixp_get_info(char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	struct pci_dev *dev = bmide_dev;
-	unsigned long bibma = pci_resource_start(dev, 4);
-	u32 mdma_timing = 0;
-	u16 udma_mode = 0, pio_mode = 0;
-	u8 c0, c1, udma_control = 0;
-
-	p += sprintf(p, "\n                          ATI ");
-	p += sprintf(p, "ATIIXP Ultra100 IDE Chipset.\n");
-
-	pci_read_config_byte(dev, ATIIXP_IDE_UDMA_CONTROL, &udma_control);
-	pci_read_config_word(dev, ATIIXP_IDE_UDMA_MODE, &udma_mode);
-	pci_read_config_word(dev, ATIIXP_IDE_PIO_MODE, &pio_mode);
-	pci_read_config_dword(dev, ATIIXP_IDE_MDMA_TIMING, &mdma_timing);
-
-	/*
-	 * at that point bibma+0x2 et bibma+0xa are byte registers
-	 * to investigate:
-	 */
-	c0 = inb(bibma + 0x02);
-	c1 = inb(bibma + 0x0a);
-
-	p += sprintf(p, "--------------- Primary Channel "
-			"---------------- Secondary Channel "
-			"-------------\n");
-	p += sprintf(p, "                %sabled "
-			"                        %sabled\n",
-			(c0 & 0x80) ? "dis" : " en",
-			(c1 & 0x80) ? "dis" : " en");
-	p += sprintf(p, "--------------- drive0 --------- drive1 "
-			"-------- drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:    %s              %s "
-			"            %s               %s\n",
-			(c0 & 0x20) ? "yes" : "no ",
-			(c0 & 0x40) ? "yes" : "no ",
-			(c1 & 0x20) ? "yes" : "no ",
-			(c1 & 0x40) ? "yes" : "no " );
-	p += sprintf(p, "UDMA enabled:   %s              %s "
-			"            %s               %s\n",
-			(udma_control & 0x01) ? "yes" : "no ",
-			(udma_control & 0x02) ? "yes" : "no ",
-			(udma_control & 0x04) ? "yes" : "no ",
-			(udma_control & 0x08) ? "yes" : "no " );
-	p += sprintf(p, "UDMA mode:      %c                %c "
-			"              %c                 %c\n",
-			(udma_control & 0x01) ?
-			((udma_mode & 0x07) + 48) : 'X',
-			(udma_control & 0x02) ?
-			(((udma_mode >> 4) & 0x07) + 48) : 'X',
-			(udma_control & 0x04) ?
-			(((udma_mode >> 8) & 0x07) + 48) : 'X',
-			(udma_control & 0x08) ?
-			(((udma_mode >> 12) & 0x07) + 48) : 'X');
-	p += sprintf(p, "MDMA mode:      %c                %c "
-			"              %c                 %c\n",
-			(save_mdma_mode[0] && (c0 & 0x20)) ?
-			((save_mdma_mode[0] & 0xf) + 48) : 'X',
-			(save_mdma_mode[1] && (c0 & 0x40)) ?
-			((save_mdma_mode[1] & 0xf) + 48) : 'X',
-			(save_mdma_mode[2] && (c1 & 0x20)) ?
-			((save_mdma_mode[2] & 0xf) + 48) : 'X',
-			(save_mdma_mode[3] && (c1 & 0x40)) ?
-			((save_mdma_mode[3] & 0xf) + 48) : 'X');
-	p += sprintf(p, "PIO mode:       %c                %c "
-			"              %c                 %c\n",
-			(c0 & 0x20) ? 'X' : ((pio_mode & 0x07) + 48),
-			(c0 & 0x40) ? 'X' : (((pio_mode >> 4) & 0x07) + 48),
-			(c1 & 0x20) ? 'X' : (((pio_mode >> 8) & 0x07) + 48),
-			(c1 & 0x40) ? 'X' : (((pio_mode >> 12) & 0x07) + 48));
-
-	return p - buffer;	/* => must be less than 4k! */
-}
-#endif  /* defined(DISPLAY_ATIIXP_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 /**
  *	atiixp_ratemask		-	compute rate mask for ATIIXP IDE
  *	@drive: IDE drive to compute for
@@ -397,27 +301,6 @@
 }
 
 /**
- *	init_chipset_atiixp	-	set up the ATIIXP chipset
- *	@dev: PCI device to set up
- *	@name: Name of the device
- *
- *	Initialize the PCI device as required. For the ATIIXP this turns
- *	out to be nice and simple
- */
-
-static unsigned int __devinit init_chipset_atiixp(struct pci_dev
*dev, const char *name)
-{
-#if defined(DISPLAY_ATIIXP_TIMINGS) && defined(CONFIG_PROC_FS)
-	if (!atiixp_proc) {
-		atiixp_proc = 1;
-		bmide_dev = dev;
-		ide_pci_create_host_proc("atiixp", atiixp_get_info);
-	}
-#endif /* DISPLAY_ATIIXP_TIMINGS && CONFIG_PROC_FS */
-	return 0;
-}
-
-/**
  *	init_hwif_atiixp		-	fill in the hwif for the ATIIXP
  *	@hwif: IDE interface
  *
@@ -459,7 +342,6 @@
 static ide_pci_device_t atiixp_pci_info[] __devinitdata = {
 	{	/* 0 */
 		.name		= "ATIIXP",
-		.init_chipset	= init_chipset_atiixp,
 		.init_hwif	= init_hwif_atiixp,
 		.channels	= 2,
 		.autodma	= AUTODMA,
diff -Nru a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
--- a/drivers/ide/pci/cs5520.c	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/cs5520.c	2004-10-23 23:29:01 +02:00
@@ -51,57 +51,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#define DISPLAY_CS5520_TIMINGS
-
-#if defined(DISPLAY_CS5520_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 cs5520_proc = 0;
-static struct pci_dev *bmide_dev;
-
-static int cs5520_get_info(char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	unsigned long bmiba = pci_resource_start(bmide_dev, 2);
-	int len;
-	u8 c0 = 0, c1 = 0;
-	u16 reg16;
-	u32 reg32;
-
-	/*
-	 * at that point bibma+0x2 et bibma+0xa are byte registers
-	 * to investigate:
-	 */
-	c0 = inb(bmiba + 0x02);
-	c1 = inb(bmiba + 0x0a);
-	
-	p += sprintf(p, "\nCyrix CS55x0 IDE\n");
-	p += sprintf(p, "--------------- Primary Channel "
-			"---------------- Secondary Channel "
-			"-------------\n");
-	p += sprintf(p, "                %sabled "
-			"                        %sabled\n",
-			(c0&0x80) ? "dis" : " en",
-			(c1&0x80) ? "dis" : " en");
-			
-	p += sprintf(p, "\n\nTimings: \n");
-	
-	pci_read_config_word(bmide_dev, 0x62, &reg16);
-	p += sprintf(p, "8bit CAT/CRT   : %04x\n", reg16);
-	pci_read_config_dword(bmide_dev, 0x64, &reg32);
-	p += sprintf(p, "16bit Primary  : %08x\n", reg32);
-	pci_read_config_dword(bmide_dev, 0x68, &reg32);
-	p += sprintf(p, "16bit Secondary: %08x\n", reg32);
-	
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-	
-	return len > count ? count : len;
-}
-
-#endif
-
 struct pio_clocks
 {
 	int address;
@@ -144,12 +93,14 @@
 	printk("PIO clocking = %d\n", pio);
 	
 	/* FIXME: if DMA = 1 do we need to set the DMA bit here ? */
-	
-	/* 8bit command timing for channel */
+
+	/* 8bit CAT/CRT - 8bit command timing for channel */
 	pci_write_config_byte(pdev, 0x62 + controller, 
 		(cs5520_pio_clocks[pio].recovery << 4) |
 		(cs5520_pio_clocks[pio].assert));
-		
+
+	/* 0x64 - 16bit Primary, 0x68 - 16bit Secondary */
+
 	/* FIXME: should these use address ? */
 	/* Data read timing */
 	pci_write_config_byte(pdev, 0x64 + 4*controller + (drive->dn&1),
@@ -188,19 +139,6 @@
 	/* Then tell the core to use DMA operations */
 	return hwif->ide_dma_on(drive);
 }
-	
-	
-static unsigned int __devinit init_chipset_cs5520(struct pci_dev
*dev, const char *name)
-{
-#if defined(DISPLAY_CS5520_TIMINGS) && defined(CONFIG_PROC_FS)
-	if (!cs5520_proc) {
-		cs5520_proc = 1;
-		bmide_dev = dev;
-		ide_pci_create_host_proc("cs5520", cs5520_get_info);
-	}
-#endif /* DISPLAY_CS5520_TIMINGS && CONFIG_PROC_FS */
-	return 0;
-}
 
 /*
  *	We provide a callback for our nonstandard DMA location
@@ -255,7 +193,6 @@
 #define DECLARE_CS_DEV(name_str)				\
 	{							\
 		.name		= name_str,			\
-		.init_chipset	= init_chipset_cs5520,		\
 		.init_setup_dma = cs5520_init_setup_dma,	\
 		.init_hwif	= init_hwif_cs5520,		\
 		.channels	= 2,				\
@@ -294,7 +231,6 @@
 		printk(KERN_WARNING "cs5520: No suitable DMA available.\n");
 		return -ENODEV;
 	}
-	init_chipset_cs5520(dev, d->name);
 
 	index.all = 0xf0f0;
 
diff -Nru a/drivers/ide/pci/cs5530.c b/drivers/ide/pci/cs5530.c
--- a/drivers/ide/pci/cs5530.c	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/cs5530.c	2004-10-23 23:29:01 +02:00
@@ -31,56 +31,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#define DISPLAY_CS5530_TIMINGS
-
-#if defined(DISPLAY_CS5530_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 cs5530_proc = 0;
-
-static struct pci_dev *bmide_dev;
-
-static int cs5530_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	unsigned long bibma = pci_resource_start(bmide_dev, 4);
-	u8  c0 = 0, c1 = 0;
-
-	/*
-	 * at that point bibma+0x2 et bibma+0xa are byte registers
-	 * to investigate:
-	 */
-
-	c0 = inb_p((u16)bibma + 0x02);
-	c1 = inb_p((u16)bibma + 0x0a);
-
-	p += sprintf(p, "\n                                "
-			"Cyrix 5530 Chipset.\n");
-	p += sprintf(p, "--------------- Primary Channel "
-			"---------------- Secondary Channel "
-			"-------------\n");
-	p += sprintf(p, "                %sabled "
-			"                        %sabled\n",
-			(c0&0x80) ? "dis" : " en",
-			(c1&0x80) ? "dis" : " en");
-	p += sprintf(p, "--------------- drive0 --------- drive1 "
-			"-------- drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:    %s              %s "
-			"            %s               %s\n",
-			(c0&0x20) ? "yes" : "no ",
-			(c0&0x40) ? "yes" : "no ",
-			(c1&0x20) ? "yes" : "no ",
-			(c1&0x40) ? "yes" : "no " );
-
-	p += sprintf(p, "UDMA\n");
-	p += sprintf(p, "DMA\n");
-	p += sprintf(p, "PIO\n");
-
-	return p-buffer;
-}
-#endif /* DISPLAY_CS5530_TIMINGS && CONFIG_PROC_FS */
-
 /**
  *	cs5530_xfer_set_mode	-	set a new transfer mode at the drive
  *	@drive: drive to tune
@@ -271,14 +221,6 @@
 {
 	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL;
 	unsigned long flags;
-
-#if defined(DISPLAY_CS5530_TIMINGS) && defined(CONFIG_PROC_FS)
-	if (!cs5530_proc) {
-		cs5530_proc = 1;
-		bmide_dev = dev;
-		ide_pci_create_host_proc("cs5530", cs5530_get_info);
-	}
-#endif /* DISPLAY_CS5530_TIMINGS && CONFIG_PROC_FS */
 
 	dev = NULL;
 	while ((dev = pci_find_device(PCI_VENDOR_ID_CYRIX, PCI_ANY_ID, dev))
!= NULL) {
diff -Nru a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
--- a/drivers/ide/pci/hpt366.c	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/hpt366.c	2004-10-23 23:29:01 +02:00
@@ -72,49 +72,6 @@
 
 #include "hpt366.h"
 
-#if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-#endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
-
-static unsigned int hpt_revision(struct pci_dev *dev);
-static unsigned int hpt_minimum_revision(struct pci_dev *dev, int revision);
-
-#if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
-
-static u8 hpt366_proc = 0;
-static struct pci_dev *hpt_devs[HPT366_MAX_DEVS];
-static int n_hpt_devs;
-
-static int hpt366_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p	= buffer;
-	char *chipset_nums[] = {"366", "366",  "368",
-				"370", "370A", "372",
-				"302", "371",  "374" };
-	int i, len;
-
-	p += sprintf(p, "\n                             "
-		"HighPoint HPT366/368/370/372/374\n");
-	for (i = 0; i < n_hpt_devs; i++) {
-		struct pci_dev *dev = hpt_devs[i];
-		unsigned long iobase = dev->resource[4].start;
-		u32 class_rev = hpt_revision(dev);
-		u8 c0, c1;
-
-		p += sprintf(p, "\nController: %d\n", i);
-		p += sprintf(p, "Chipset: HPT%s\n", chipset_nums[class_rev]);
-		p += sprintf(p, "--------------- Primary Channel "
-				"--------------- Secondary Channel "
-				"--------------\n");
-
-		/* get the bus master status registers */
-		c0 = inb(iobase + 0x2);
-		c1 = inb(iobase + 0xa);
-		p += sprintf(p, "Enabled:        %s"
-				"                             %s\n",
-			(c0 & 0x80) ? "no" : "yes",
-			(c1 & 0x80) ? "no" : "yes");
 #if 0
 		if (hpt_minimum_revision(dev, 3)) {
 			u8 cbl;
@@ -128,16 +85,6 @@
 				(cbl & 0x01) ? 33 : 66);
 			p += sprintf(p, "\n");
 		}
-#endif
-		p += sprintf(p, "--------------- drive0 --------- drive1 "
-				"------- drive0 ---------- drive1 -------\n");
-		p += sprintf(p, "DMA capable:    %s              %s" 
-				"            %s               %s\n",
-			(c0 & 0x20) ? "yes" : "no ", 
-			(c0 & 0x40) ? "yes" : "no ",
-			(c1 & 0x20) ? "yes" : "no ", 
-			(c1 & 0x40) ? "yes" : "no ");
-
 		{
 			u8 c2, c3;
 			/* older revs don't have these registers mapped 
@@ -159,15 +106,7 @@
 					(c3 & 0x80) ? "PIO " : "off ");
 		}
 	}
-	p += sprintf(p, "\n");
-
-	/* p - buffer must be less than 4k! */
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-	
-	return len > count ? count : len;
-}
-#endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
+#endif
 
 static u32 hpt_revision (struct pci_dev *dev)
 {
@@ -1105,15 +1044,6 @@
 	}
 	if (ret)
 		return ret;
-	
-#if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
-	hpt_devs[n_hpt_devs++] = dev;
-
-	if (!hpt366_proc) {
-		hpt366_proc = 1;
-		ide_pci_create_host_proc("hpt366", hpt366_get_info);
-	}
-#endif /* DISPLAY_HPT366_TIMINGS && CONFIG_PROC_FS */
 
 	return dev->irq;
 }
diff -Nru a/drivers/ide/pci/hpt366.h b/drivers/ide/pci/hpt366.h
--- a/drivers/ide/pci/hpt366.h	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/hpt366.h	2004-10-23 23:29:01 +02:00
@@ -5,8 +5,6 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-#define DISPLAY_HPT366_TIMINGS
-
 /* various tuning parameters */
 #define HPT_RESET_STATE_ENGINE
 #undef HPT_DELAY_INTERRUPT
diff -Nru a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_new.c
--- a/drivers/ide/pci/pdc202xx_new.c	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/pdc202xx_new.c	2004-10-23 23:29:01 +02:00
@@ -41,61 +41,6 @@
 
 #define PDC202_DEBUG_CABLE	0
 
-#if defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 pdcnew_proc = 0;
-#define PDC202_MAX_DEVS		5
-static struct pci_dev *pdc202_devs[PDC202_MAX_DEVS];
-static int n_pdc202_devs;
-
-static char * pdcnew_info(char *buf, struct pci_dev *dev)
-{
-	char *p = buf;
-
-	p += sprintf(p, "\n                                ");
-	switch(dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20277:
-			p += sprintf(p, "SBFastTrak 133 Lite"); break;
-		case PCI_DEVICE_ID_PROMISE_20276:
-			p += sprintf(p, "MBFastTrak 133 Lite"); break;
-		case PCI_DEVICE_ID_PROMISE_20275:
-			p += sprintf(p, "MBUltra133"); break;
-		case PCI_DEVICE_ID_PROMISE_20271:
-			p += sprintf(p, "FastTrak TX2000"); break;
-		case PCI_DEVICE_ID_PROMISE_20270:
-			p += sprintf(p, "FastTrak LP/TX2/TX4"); break;
-		case PCI_DEVICE_ID_PROMISE_20269:
-			p += sprintf(p, "Ultra133 TX2"); break;
-		case PCI_DEVICE_ID_PROMISE_20268:
-			p += sprintf(p, "Ultra100 TX2"); break;
-		default:
-			p += sprintf(p, "Ultra series"); break;
-			break;
-	}
-	p += sprintf(p, " Chipset.\n");
-	return (char *)p;
-}
-
-static int pdcnew_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	int i, len;
-
-	for (i = 0; i < n_pdc202_devs; i++) {
-		struct pci_dev *dev	= pdc202_devs[i];
-		p = pdcnew_info(buffer, dev);
-	}
-	/* p - buffer must be less than 4k! */
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-	
-	return len > count ? count : len;
-}
-#endif  /* defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS) */
-
-
 static u8 pdcnew_ratemask (ide_drive_t *drive)
 {
 	u8 mode;
@@ -416,15 +361,6 @@
 #ifdef CONFIG_PPC_PMAC
 	apple_kiwi_init(dev);
 #endif
-
-#if defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS)
-	pdc202_devs[n_pdc202_devs++] = dev;
-
-	if (!pdcnew_proc) {
-		pdcnew_proc = 1;
-		ide_pci_create_host_proc("pdcnew", pdcnew_get_info);
-	}
-#endif /* DISPLAY_PDC202XX_TIMINGS && CONFIG_PROC_FS */
 
 	return dev->irq;
 }
diff -Nru a/drivers/ide/pci/pdc202xx_new.h b/drivers/ide/pci/pdc202xx_new.h
--- a/drivers/ide/pci/pdc202xx_new.h	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/pdc202xx_new.h	2004-10-23 23:29:01 +02:00
@@ -43,8 +43,6 @@
 		set_2regs(0x13,(c));			\
 	} while(0)
 
-#define DISPLAY_PDC202XX_TIMINGS
-
 static void init_setup_pdcnew(struct pci_dev *, ide_pci_device_t *);
 static void init_setup_pdc20270(struct pci_dev *, ide_pci_device_t *);
 static void init_setup_pdc20276(struct pci_dev *dev, ide_pci_device_t *d);
diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/pdc202xx_old.c	2004-10-23 23:29:01 +02:00
@@ -50,68 +50,14 @@
 
 #define PDC202_DEBUG_CABLE	0
 
-#if defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 pdc202xx_proc = 0;
-#define PDC202_MAX_DEVS		5
-static struct pci_dev *pdc202_devs[PDC202_MAX_DEVS];
-static int n_pdc202_devs;
-
-static char * pdc202xx_info (char *buf, struct pci_dev *dev)
-{
-	char *p = buf;
-
+#if 0
 	unsigned long bibma  = pci_resource_start(dev, 4);
-	u32 reg60h = 0, reg64h = 0, reg68h = 0, reg6ch = 0;
-	u16 reg50h = 0, pmask = (1<<10), smask = (1<<11);
 	u8 hi = 0, lo = 0;
 
-        /*
-         * at that point bibma+0x2 et bibma+0xa are byte registers
-         * to investigate:
-         */
-	u8 c0	= inb_p((u16)bibma + 0x02);
-	u8 c1	= inb_p((u16)bibma + 0x0a);
-
-	u8 sc11	= inb_p((u16)bibma + 0x11);
-	u8 sc1a	= inb_p((u16)bibma + 0x1a);
-	u8 sc1b	= inb_p((u16)bibma + 0x1b);
 	u8 sc1c	= inb_p((u16)bibma + 0x1c); 
-	u8 sc1d	= inb_p((u16)bibma + 0x1d);
 	u8 sc1e	= inb_p((u16)bibma + 0x1e);
 	u8 sc1f	= inb_p((u16)bibma + 0x1f);
 
-	pci_read_config_word(dev, 0x50, &reg50h);
-	pci_read_config_dword(dev, 0x60, &reg60h);
-	pci_read_config_dword(dev, 0x64, &reg64h);
-	pci_read_config_dword(dev, 0x68, &reg68h);
-	pci_read_config_dword(dev, 0x6c, &reg6ch);
-
-	p += sprintf(p, "\n                                ");
-	switch(dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20267:
-			p += sprintf(p, "Ultra100"); break;
-		case PCI_DEVICE_ID_PROMISE_20265:
-			p += sprintf(p, "Ultra100 on M/B"); break;
-		case PCI_DEVICE_ID_PROMISE_20263:
-			p += sprintf(p, "FastTrak 66"); break;
-		case PCI_DEVICE_ID_PROMISE_20262:
-			p += sprintf(p, "Ultra66"); break;
-		case PCI_DEVICE_ID_PROMISE_20246:
-			p += sprintf(p, "Ultra33");
-			reg50h |= 0x0c00;
-			break;
-		default:
-			p += sprintf(p, "Ultra Series"); break;
-	}
-	p += sprintf(p, " Chipset.\n");
-
-	p += sprintf(p, "------------------------------- General Status "
-			"---------------------------------\n");
-	p += sprintf(p, "Burst Mode                           : %sabled\n",
-		(sc1f & 0x01) ? "en" : "dis");
 	p += sprintf(p, "Host Mode                            : %s\n",
 		(sc1f & 0x08) ? "Tri-Stated" : "Normal");
 	p += sprintf(p, "Bus Clocking                         : %s\n",
@@ -126,70 +72,7 @@
 	SPLIT_BYTE(sc1e, hi, lo);
 	p += sprintf(p, "Status Polling Period                : %d\n", hi);
 	p += sprintf(p, "Interrupt Check Status Polling Delay : %d\n", lo);
-	p += sprintf(p, "--------------- Primary Channel "
-			"---------------- Secondary Channel "
-			"-------------\n");
-	p += sprintf(p, "                %s                         %s\n",
-		(c0&0x80)?"disabled":"enabled ",
-		(c1&0x80)?"disabled":"enabled ");
-	p += sprintf(p, "66 Clocking     %s                         %s\n",
-		(sc11&0x02)?"enabled ":"disabled",
-		(sc11&0x08)?"enabled ":"disabled");
-	p += sprintf(p, "           Mode %s                      Mode %s\n",
-		(sc1a & 0x01) ? "MASTER" : "PCI   ",
-		(sc1b & 0x01) ? "MASTER" : "PCI   ");
-	p += sprintf(p, "                %s                     %s\n",
-		(sc1d & 0x08) ? "Error       " :
-		((sc1d & 0x05) == 0x05) ? "Not My INTR " :
-		(sc1d & 0x04) ? "Interrupting" :
-		(sc1d & 0x02) ? "FIFO Full   " :
-		(sc1d & 0x01) ? "FIFO Empty  " : "????????????",
-		(sc1d & 0x80) ? "Error       " :
-		((sc1d & 0x50) == 0x50) ? "Not My INTR " :
-		(sc1d & 0x40) ? "Interrupting" :
-		(sc1d & 0x20) ? "FIFO Full   " :
-		(sc1d & 0x10) ? "FIFO Empty  " : "????????????");
-	p += sprintf(p, "--------------- drive0 --------- drive1 "
-			"-------- drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:    %s              %s "
-			"            %s               %s\n",
-		(c0&0x20)?"yes":"no ", (c0&0x40)?"yes":"no ",
-		(c1&0x20)?"yes":"no ", (c1&0x40)?"yes":"no ");
-	p += sprintf(p, "DMA Mode:       %s           %s "
-			"         %s            %s\n",
-		pdc202xx_ultra_verbose(reg60h, (reg50h & pmask)),
-		pdc202xx_ultra_verbose(reg64h, (reg50h & pmask)),
-		pdc202xx_ultra_verbose(reg68h, (reg50h & smask)),
-		pdc202xx_ultra_verbose(reg6ch, (reg50h & smask)));
-	p += sprintf(p, "PIO Mode:       %s            %s "
-			"          %s            %s\n",
-		pdc202xx_pio_verbose(reg60h),
-		pdc202xx_pio_verbose(reg64h),
-		pdc202xx_pio_verbose(reg68h),
-		pdc202xx_pio_verbose(reg6ch));
-#if 0
-	p += sprintf(p, "--------------- Can ATAPI DMA ---------------\n");
 #endif
-	return (char *)p;
-}
-
-static int pdc202xx_get_info (char *buffer, char **addr, off_t
offset, int count)
-{
-	char *p = buffer;
-	int i, len;
-
-	for (i = 0; i < n_pdc202_devs; i++) {
-		struct pci_dev *dev	= pdc202_devs[i];
-		p = pdc202xx_info(buffer, dev);
-	}
-	/* p - buffer must be less than 4k! */
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-	
-	return len > count ? count : len;
-}
-#endif  /* defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 
 static u8 pdc202xx_ratemask (ide_drive_t *drive)
 {
@@ -546,11 +429,13 @@
 	u8 sc1d			= hwif->INB((high_16 + 0x001d));
 
 	if (hwif->channel) {
+		/* bit7: Error, bit6: Interrupting, bit5: FIFO Full, bit4: FIFO Empty */
 		if ((sc1d & 0x50) == 0x50)
 			goto somebody_else;
 		else if ((sc1d & 0x40) == 0x40)
 			return (dma_stat & 4) == 4;
 	} else {
+		/* bit3: Error, bit2: Interrupting, bit1: FIFO Full, bit0: FIFO Empty */
 		if ((sc1d & 0x05) == 0x05)
 			goto somebody_else;
 		else if ((sc1d & 0x04) == 0x04)
@@ -667,15 +552,6 @@
 		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
 			name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
-
-#if defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS)
-	pdc202_devs[n_pdc202_devs++] = dev;
-
-	if (!pdc202xx_proc) {
-		pdc202xx_proc = 1;
-		ide_pci_create_host_proc("pdc202xx", pdc202xx_get_info);
-	}
-#endif /* DISPLAY_PDC202XX_TIMINGS && CONFIG_PROC_FS */
 
 	/*
 	 * software reset -  this is required because the bios
diff -Nru a/drivers/ide/pci/pdc202xx_old.h b/drivers/ide/pci/pdc202xx_old.h
--- a/drivers/ide/pci/pdc202xx_old.h	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/pdc202xx_old.h	2004-10-23 23:29:01 +02:00
@@ -23,41 +23,6 @@
 	NULL
 };
 
-static inline u8 *pdc202xx_pio_verbose (u32 drive_pci)
-{
-	if ((drive_pci & 0x000ff000) == 0x000ff000) return("NOTSET");
-	if ((drive_pci & 0x00000401) == 0x00000401) return("PIO 4");
-	if ((drive_pci & 0x00000602) == 0x00000602) return("PIO 3");
-	if ((drive_pci & 0x00000803) == 0x00000803) return("PIO 2");
-	if ((drive_pci & 0x00000C05) == 0x00000C05) return("PIO 1");
-	if ((drive_pci & 0x00001309) == 0x00001309) return("PIO 0");
-	return("PIO ?");
-}
-
-static inline u8 *pdc202xx_dma_verbose (u32 drive_pci)
-{
-	if ((drive_pci & 0x00036000) == 0x00036000) return("MWDMA 2");
-	if ((drive_pci & 0x00046000) == 0x00046000) return("MWDMA 1");
-	if ((drive_pci & 0x00056000) == 0x00056000) return("MWDMA 0");
-	if ((drive_pci & 0x00056000) == 0x00056000) return("SWDMA 2");
-	if ((drive_pci & 0x00068000) == 0x00068000) return("SWDMA 1");
-	if ((drive_pci & 0x000BC000) == 0x000BC000) return("SWDMA 0");
-	return("PIO---");
-}
-
-static inline u8 *pdc202xx_ultra_verbose (u32 drive_pci, u16 slow_cable)
-{
-	if ((drive_pci & 0x000ff000) == 0x000ff000)
-		return("NOTSET");
-	if ((drive_pci & 0x00012000) == 0x00012000)
-		return((slow_cable) ? "UDMA 2" : "UDMA 4");
-	if ((drive_pci & 0x00024000) == 0x00024000)
-		return((slow_cable) ? "UDMA 1" : "UDMA 3");
-	if ((drive_pci & 0x00036000) == 0x00036000)
-		return("UDMA 0");
-	return(pdc202xx_dma_verbose(drive_pci));
-}
-
 /* A Register */
 #define	SYNC_ERRDY_EN	0xC0
 
@@ -97,8 +62,6 @@
 #define	MC2		0x04	/* DMA"C" timing */
 #define	MC1		0x02	/* DMA"C" timing */
 #define	MC0		0x01	/* DMA"C" timing */
-
-#define DISPLAY_PDC202XX_TIMINGS
 
 static void init_setup_pdc202ata4(struct pci_dev *dev, ide_pci_device_t *d);
 static void init_setup_pdc20265(struct pci_dev *, ide_pci_device_t *);
diff -Nru a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
--- a/drivers/ide/pci/piix.c	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/piix.c	2004-10-23 23:29:01 +02:00
@@ -106,165 +106,6 @@
 #include "piix.h"
 
 static int no_piix_dma;
-#if defined(DISPLAY_PIIX_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 piix_proc = 0;
-#define PIIX_MAX_DEVS		5
-static struct pci_dev *piix_devs[PIIX_MAX_DEVS];
-static int n_piix_devs;
-
-/**
- *	piix_get_info		-	fill in /proc for PIIX ide
- *	@buffer: buffer to fill
- *	@addr: address of user start in buffer
- *	@offset: offset into 'file'
- *	@count: buffer count
- *
- *	Walks the PIIX devices and outputs summary data on the tuning and
- *	anything else that will help with debugging
- */
- 
-static int piix_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	int i;
-
-	for (i = 0; i < n_piix_devs; i++) {
-		struct pci_dev *dev	= piix_devs[i];
-		unsigned long bibma = pci_resource_start(dev, 4);
-	        u16 reg40 = 0, psitre = 0, reg42 = 0, ssitre = 0;
-		u8  c0 = 0, c1 = 0, reg54 = 0, reg55 = 0;
-		u8  reg44 = 0, reg48 = 0, reg4a = 0, reg4b = 0;
-
-		p += sprintf(p, "\nController: %d\n", i);
-		p += sprintf(p, "\n                                Intel ");
-		switch(dev->device) {
-			case PCI_DEVICE_ID_INTEL_82801EB_1:
-				p += sprintf(p, "PIIX4 SATA 150 ");
-				break;
-			case PCI_DEVICE_ID_INTEL_82801BA_8:
-			case PCI_DEVICE_ID_INTEL_82801BA_9:
-			case PCI_DEVICE_ID_INTEL_82801CA_10:
-			case PCI_DEVICE_ID_INTEL_82801CA_11:
-			case PCI_DEVICE_ID_INTEL_82801DB_10:
-			case PCI_DEVICE_ID_INTEL_82801DB_11:
-			case PCI_DEVICE_ID_INTEL_82801EB_11:
-			case PCI_DEVICE_ID_INTEL_82801E_11:
-			case PCI_DEVICE_ID_INTEL_ESB_2:
-			case PCI_DEVICE_ID_INTEL_ICH6_19:
-				p += sprintf(p, "PIIX4 Ultra 100 ");
-				break;
-			case PCI_DEVICE_ID_INTEL_82372FB_1:
-			case PCI_DEVICE_ID_INTEL_82801AA_1:
-				p += sprintf(p, "PIIX4 Ultra 66 ");
-				break;
-			case PCI_DEVICE_ID_INTEL_82451NX:
-			case PCI_DEVICE_ID_INTEL_82801AB_1:
-			case PCI_DEVICE_ID_INTEL_82443MX_1:
-			case PCI_DEVICE_ID_INTEL_82371AB:
-				p += sprintf(p, "PIIX4 Ultra 33 ");
-				break;
-			case PCI_DEVICE_ID_INTEL_82371SB_1:
-				p += sprintf(p, "PIIX3 ");
-				break;
-			case PCI_DEVICE_ID_INTEL_82371MX:
-				p += sprintf(p, "MPIIX ");
-				break;
-			case PCI_DEVICE_ID_INTEL_82371FB_1:
-			case PCI_DEVICE_ID_INTEL_82371FB_0:
-			default:
-				p += sprintf(p, "PIIX ");
-				break;
-		}
-		p += sprintf(p, "Chipset.\n");
-
-		if (dev->device == PCI_DEVICE_ID_INTEL_82371MX)
-			continue;
-
-		pci_read_config_word(dev, 0x40, &reg40);
-		pci_read_config_word(dev, 0x42, &reg42);
-		pci_read_config_byte(dev, 0x44, &reg44);
-		pci_read_config_byte(dev, 0x48, &reg48);
-		pci_read_config_byte(dev, 0x4a, &reg4a);
-		pci_read_config_byte(dev, 0x4b, &reg4b);
-		pci_read_config_byte(dev, 0x54, &reg54);
-		pci_read_config_byte(dev, 0x55, &reg55);
-
-		psitre = (reg40 & 0x4000) ? 1 : 0;
-		ssitre = (reg42 & 0x4000) ? 1 : 0;
-
-		/*
-		 * at that point bibma+0x2 et bibma+0xa are byte registers
-		 * to investigate:
-		 */
-		c0 = inb(bibma + 0x02);
-		c1 = inb(bibma + 0x0a);
-
-		p += sprintf(p, "--------------- Primary Channel "
-				"---------------- Secondary Channel "
-				"-------------\n");
-		p += sprintf(p, "                %sabled "
-				"                        %sabled\n",
-				(c0&0x80) ? "dis" : " en",
-				(c1&0x80) ? "dis" : " en");
-		p += sprintf(p, "--------------- drive0 --------- drive1 "
-				"-------- drive0 ---------- drive1 ------\n");
-		p += sprintf(p, "DMA enabled:    %s              %s "
-				"            %s               %s\n",
-				(c0&0x20) ? "yes" : "no ",
-				(c0&0x40) ? "yes" : "no ",
-				(c1&0x20) ? "yes" : "no ",
-				(c1&0x40) ? "yes" : "no " );
-		p += sprintf(p, "UDMA enabled:   %s              %s "
-				"            %s               %s\n",
-				(reg48&0x01) ? "yes" : "no ",
-				(reg48&0x02) ? "yes" : "no ",
-				(reg48&0x04) ? "yes" : "no ",
-				(reg48&0x08) ? "yes" : "no " );
-		p += sprintf(p, "UDMA enabled:   %s                %s "
-				"              %s                 %s\n",
-				((reg54&0x11) &&
-				 (reg55&0x10) && (reg4a&0x01)) ? "5" :
-				((reg54&0x11) && (reg4a&0x02)) ? "4" :
-				((reg54&0x11) && (reg4a&0x01)) ? "3" :
-				(reg4a&0x02) ? "2" :
-				(reg4a&0x01) ? "1" :
-				(reg4a&0x00) ? "0" : "X",
-				((reg54&0x22) &&
-				 (reg55&0x20) && (reg4a&0x10)) ? "5" :
-				((reg54&0x22) && (reg4a&0x20)) ? "4" :
-				((reg54&0x22) && (reg4a&0x10)) ? "3" :
-				(reg4a&0x20) ? "2" :
-				(reg4a&0x10) ? "1" :
-				(reg4a&0x00) ? "0" : "X",
-				((reg54&0x44) &&
-				 (reg55&0x40) && (reg4b&0x03)) ? "5" :
-				((reg54&0x44) && (reg4b&0x02)) ? "4" :
-				((reg54&0x44) && (reg4b&0x01)) ? "3" :
-				(reg4b&0x02) ? "2" :
-				(reg4b&0x01) ? "1" :
-				(reg4b&0x00) ? "0" : "X",
-				((reg54&0x88) &&
-				 (reg55&0x80) && (reg4b&0x30)) ? "5" :
-				((reg54&0x88) && (reg4b&0x20)) ? "4" :
-				((reg54&0x88) && (reg4b&0x10)) ? "3" :
-				(reg4b&0x20) ? "2" :
-				(reg4b&0x10) ? "1" :
-				(reg4b&0x00) ? "0" : "X");
-
-		p += sprintf(p, "UDMA\n");
-		p += sprintf(p, "DMA\n");
-		p += sprintf(p, "PIO\n");
-
-		/*
-		 * FIXME.... Add configuration junk data....blah blah......
-		 */
-	}
-	return p-buffer;	 /* => must be less than 4k! */
-}
-#endif  /* defined(DISPLAY_PIIX_TIMINGS) && defined(CONFIG_PROC_FS) */
 
 /**
  *	piix_ratemask		-	compute rate mask for PIIX IDE
@@ -627,14 +468,6 @@
 			break;
 	}
 
-#if defined(DISPLAY_PIIX_TIMINGS) && defined(CONFIG_PROC_FS)
-	piix_devs[n_piix_devs++] = dev;
-
-	if (!piix_proc) {
-		piix_proc = 1;
-		ide_pci_create_host_proc("piix", piix_get_info);
-	}
-#endif /* DISPLAY_PIIX_TIMINGS && CONFIG_PROC_FS */
 	return 0;
 }
 
diff -Nru a/drivers/ide/pci/piix.h b/drivers/ide/pci/piix.h
--- a/drivers/ide/pci/piix.h	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/piix.h	2004-10-23 23:29:01 +02:00
@@ -5,10 +5,6 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-#define PIIX_DEBUG_DRIVE_INFO		0
-
-#define DISPLAY_PIIX_TIMINGS
-
 static void init_setup_piix(struct pci_dev *, ide_pci_device_t *);
 static unsigned int __devinit init_chipset_piix(struct pci_dev *,
const char *);
 static void init_hwif_piix(ide_hwif_t *);
diff -Nru a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
--- a/drivers/ide/pci/sc1200.c	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/sc1200.c	2004-10-23 23:29:01 +02:00
@@ -67,55 +67,6 @@
 	return pci_clock;
 }
 
-#define DISPLAY_SC1200_TIMINGS
-
-#if defined(DISPLAY_SC1200_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static int sc1200_get_info(char *, char **, off_t, int);
-extern int (*sc1200_display_info)(char *, char **, off_t, int); /*
ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
-static u8 sc1200_proc = 0;
-
-static struct pci_dev *bmide_dev;
-
-static int sc1200_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	unsigned long bibma = pci_resource_start(bmide_dev, 4);
-	int len;
-	u8  c0 = 0, c1 = 0;
-
-	/*
-	 * at that point bibma+0x2 et bibma+0xa are byte registers
-	 * to investigate:
-	 */
-
-	c0 = inb_p(bibma + 0x02);
-	c1 = inb_p(bibma + 0x0a);
-
-	p += sprintf(p, "\n                               National SCx200
Chipset.\n");
-	p += sprintf(p, "--------------- Primary Channel ----------------
Secondary Channel -------------\n");
-	p += sprintf(p, "                %sabled                         %sabled\n",
-			(c0&0x80) ? "dis" : " en",
-			(c1&0x80) ? "dis" : " en");
-	p += sprintf(p, "--------------- drive0 --------- drive1 --------
drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:    %s              %s             %s  
            %s\n",
-			(c0&0x20) ? "yes" : "no ", (c0&0x40) ? "yes" : "no ",
-			(c1&0x20) ? "yes" : "no ", (c1&0x40) ? "yes" : "no " );
-
-	p += sprintf(p, "UDMA\n");
-	p += sprintf(p, "DMA\n");
-	p += sprintf(p, "PIO\n");
-
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-	
-	return len > count ? count : len;
-}
-#endif /* DISPLAY_SC1200_TIMINGS && CONFIG_PROC_FS */
-
 extern char *ide_xfer_verbose (byte xfer_rate);
 
 /*
@@ -505,21 +456,6 @@
 }
 
 /*
- * Initialize the sc1200 bridge for reliable IDE DMA operation.
- */
-static unsigned int __init init_chipset_sc1200 (struct pci_dev *dev,
const char *name)
-{
-#if defined(DISPLAY_SC1200_TIMINGS) && defined(CONFIG_PROC_FS)
-	if (!bmide_dev) {
-		sc1200_proc = 1;
-		bmide_dev = dev;
-		ide_pci_create_host_proc("sc1200", sc1200_get_info);
-	}
-#endif /* DISPLAY_SC1200_TIMINGS && CONFIG_PROC_FS */
-	return 0;
-}
-
-/*
  * This gets invoked by the IDE driver once for each channel,
  * and performs channel-specific pre-initialization before drive probing.
  */
@@ -545,7 +481,6 @@
 
 static ide_pci_device_t sc1200_chipset __devinitdata = {
 	.name		= "SC1200",
-	.init_chipset	= init_chipset_sc1200,
 	.init_hwif	= init_hwif_sc1200,
 	.channels	= 2,
 	.autodma	= AUTODMA,
diff -Nru a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverworks.c
--- a/drivers/ide/pci/serverworks.c	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/serverworks.c	2004-10-23 23:29:01 +02:00
@@ -44,164 +44,6 @@
 static u8 svwks_revision = 0;
 static struct pci_dev *isa_dev;
 
-#if defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 svwks_proc = 0;
-#define SVWKS_MAX_DEVS		2
-static struct pci_dev *svwks_devs[SVWKS_MAX_DEVS];
-static int n_svwks_devs;
-
-static int svwks_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	int i, len;
-
-	p += sprintf(p, "\n                             "
-			"ServerWorks OSB4/CSB5/CSB6\n");
-
-	for (i = 0; i < n_svwks_devs; i++) {
-		struct pci_dev *dev = svwks_devs[i];
-		unsigned long bibma = pci_resource_start(dev, 4);
-		u32 reg40, reg44;
-		u16 reg48, reg56;
-		u8  reg54, c0=0, c1=0;
-
-		pci_read_config_dword(dev, 0x40, &reg40);
-		pci_read_config_dword(dev, 0x44, &reg44);
-		pci_read_config_word(dev, 0x48, &reg48);
-		pci_read_config_byte(dev, 0x54, &reg54);
-		pci_read_config_word(dev, 0x56, &reg56);
-
-		/*
-		 * at that point bibma+0x2 et bibma+0xa are byte registers
-		 * to investigate:
-		 */
-		c0 = inb_p(bibma + 0x02);
-		c1 = inb_p(bibma + 0x0a);
-
-		p += sprintf(p, "\n                            ServerWorks ");
-		switch(dev->device) {
-			case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2:
-			case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE:
-				p += sprintf(p, "CSB6 ");
-				break;
-			case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
-				p += sprintf(p, "CSB5 ");
-				break;
-			case PCI_DEVICE_ID_SERVERWORKS_OSB4IDE:
-				p += sprintf(p, "OSB4 ");
-				break;
-			default:
-				p += sprintf(p, "%04x ", dev->device);
-				break;
-		}
-		p += sprintf(p, "Chipset (rev %02x)\n", svwks_revision);
-
-		p += sprintf(p, "------------------------------- "
-				"General Status "
-				"---------------------------------\n");
-		p += sprintf(p, "--------------- Primary Channel "
-				"---------------- Secondary Channel "
-				"-------------\n");
-		p += sprintf(p, "                %sabled"
-				"                         %sabled\n",
-				(c0&0x80) ? "dis" : " en",
-				(c1&0x80) ? "dis" : " en");
-		p += sprintf(p, "--------------- drive0 --------- drive1 "
-				"-------- drive0 ---------- drive1 ------\n");
-		p += sprintf(p, "DMA enabled:    %s              %s"
-				"             %s               %s\n",
-			(c0&0x20) ? "yes" : "no ",
-			(c0&0x40) ? "yes" : "no ",
-			(c1&0x20) ? "yes" : "no ",
-			(c1&0x40) ? "yes" : "no " );
-		p += sprintf(p, "UDMA enabled:   %s              %s"
-				"             %s               %s\n",
-			(reg54 & 0x01) ? "yes" : "no ",
-			(reg54 & 0x02) ? "yes" : "no ",
-			(reg54 & 0x04) ? "yes" : "no ",
-			(reg54 & 0x08) ? "yes" : "no " );
-		p += sprintf(p, "UDMA enabled:   %s                %s"
-				"               %s                 %s\n",
-			((reg56&0x0005)==0x0005)?"5":
-				((reg56&0x0004)==0x0004)?"4":
-				((reg56&0x0003)==0x0003)?"3":
-				((reg56&0x0002)==0x0002)?"2":
-				((reg56&0x0001)==0x0001)?"1":
-				((reg56&0x000F))?"?":"0",
-			((reg56&0x0050)==0x0050)?"5":
-				((reg56&0x0040)==0x0040)?"4":
-				((reg56&0x0030)==0x0030)?"3":
-				((reg56&0x0020)==0x0020)?"2":
-				((reg56&0x0010)==0x0010)?"1":
-				((reg56&0x00F0))?"?":"0",
-			((reg56&0x0500)==0x0500)?"5":
-				((reg56&0x0400)==0x0400)?"4":
-				((reg56&0x0300)==0x0300)?"3":
-				((reg56&0x0200)==0x0200)?"2":
-				((reg56&0x0100)==0x0100)?"1":
-				((reg56&0x0F00))?"?":"0",
-			((reg56&0x5000)==0x5000)?"5":
-				((reg56&0x4000)==0x4000)?"4":
-				((reg56&0x3000)==0x3000)?"3":
-				((reg56&0x2000)==0x2000)?"2":
-				((reg56&0x1000)==0x1000)?"1":
-				((reg56&0xF000))?"?":"0");
-		p += sprintf(p, "DMA enabled:    %s                %s"
-				"               %s                 %s\n",
-			((reg44&0x00002000)==0x00002000)?"2":
-				((reg44&0x00002100)==0x00002100)?"1":
-				((reg44&0x00007700)==0x00007700)?"0":
-				((reg44&0x0000FF00)==0x0000FF00)?"X":"?",
-			((reg44&0x00000020)==0x00000020)?"2":
-				((reg44&0x00000021)==0x00000021)?"1":
-				((reg44&0x00000077)==0x00000077)?"0":
-				((reg44&0x000000FF)==0x000000FF)?"X":"?",
-			((reg44&0x20000000)==0x20000000)?"2":
-				((reg44&0x21000000)==0x21000000)?"1":
-				((reg44&0x77000000)==0x77000000)?"0":
-				((reg44&0xFF000000)==0xFF000000)?"X":"?",
-			((reg44&0x00200000)==0x00200000)?"2":
-				((reg44&0x00210000)==0x00210000)?"1":
-				((reg44&0x00770000)==0x00770000)?"0":
-				((reg44&0x00FF0000)==0x00FF0000)?"X":"?");
-
-		p += sprintf(p, "PIO  enabled:   %s                %s"
-				"               %s                 %s\n",
-			((reg40&0x00002000)==0x00002000)?"4":
-				((reg40&0x00002200)==0x00002200)?"3":
-				((reg40&0x00003400)==0x00003400)?"2":
-				((reg40&0x00004700)==0x00004700)?"1":
-				((reg40&0x00005D00)==0x00005D00)?"0":"?",
-			((reg40&0x00000020)==0x00000020)?"4":
-				((reg40&0x00000022)==0x00000022)?"3":
-				((reg40&0x00000034)==0x00000034)?"2":
-				((reg40&0x00000047)==0x00000047)?"1":
-				((reg40&0x0000005D)==0x0000005D)?"0":"?",
-			((reg40&0x20000000)==0x20000000)?"4":
-				((reg40&0x22000000)==0x22000000)?"3":
-				((reg40&0x34000000)==0x34000000)?"2":
-				((reg40&0x47000000)==0x47000000)?"1":
-				((reg40&0x5D000000)==0x5D000000)?"0":"?",
-			((reg40&0x00200000)==0x00200000)?"4":
-				((reg40&0x00220000)==0x00220000)?"3":
-				((reg40&0x00340000)==0x00340000)?"2":
-				((reg40&0x00470000)==0x00470000)?"1":
-				((reg40&0x005D0000)==0x005D0000)?"0":"?");
-
-	}
-	p += sprintf(p, "\n");
-
-	/* p - buffer must be less than 4k! */
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-	
-	return len > count ? count : len;
-}
-#endif  /* defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 static int check_in_drive_lists (ide_drive_t *drive, const char **list)
 {
 	while (*list)
@@ -616,16 +458,6 @@
 			btr |= (svwks_revision >= SVWKS_CSB5_REVISION_NEW) ? 0x3 : 0x2;
 		pci_write_config_byte(dev, 0x5A, btr);
 	}
-
-
-#if defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS)
-	svwks_devs[n_svwks_devs++] = dev;
-
-	if (!svwks_proc) {
-		svwks_proc = 1;
-		ide_pci_create_host_proc("svwks", svwks_get_info);
-	}
-#endif /* DISPLAY_SVWKS_TIMINGS && CONFIG_PROC_FS */
 
 	return (dev->irq) ? dev->irq : 0;
 }
diff -Nru a/drivers/ide/pci/serverworks.h b/drivers/ide/pci/serverworks.h
--- a/drivers/ide/pci/serverworks.h	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/serverworks.h	2004-10-23 23:29:01 +02:00
@@ -21,8 +21,6 @@
 	NULL
 };
 
-#define DISPLAY_SVWKS_TIMINGS	1
-
 static void init_setup_svwks(struct pci_dev *, ide_pci_device_t *);
 static void init_setup_csb6(struct pci_dev *, ide_pci_device_t *);
 static unsigned int init_chipset_svwks(struct pci_dev *, const char *);
diff -Nru a/drivers/ide/pci/slc90e66.c b/drivers/ide/pci/slc90e66.c
--- a/drivers/ide/pci/slc90e66.c	2004-10-23 23:29:01 +02:00
+++ b/drivers/ide/pci/slc90e66.c	2004-10-23 23:29:01 +02:00
@@ -21,103 +21,6 @@
 
 #include <asm/io.h>
 
-#define DISPLAY_SLC90E66_TIMINGS
-
-#if defined(DISPLAY_SLC90E66_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 slc90e66_proc = 0;
-static struct pci_dev *bmide_dev;
-
-static int slc90e66_get_info (char *buffer, char **addr, off_t
offset, int count)
-{
-	char *p = buffer;
-	int len;
-	unsigned long bibma = pci_resource_start(bmide_dev, 4);
-	u16 reg40 = 0, psitre = 0, reg42 = 0, ssitre = 0;
-	u8  c0 = 0, c1 = 0;
-	u8  reg44 = 0, reg47 = 0, reg48 = 0, reg4a = 0, reg4b = 0;
-
-	pci_read_config_word(bmide_dev, 0x40, &reg40);
-	pci_read_config_word(bmide_dev, 0x42, &reg42);
-	pci_read_config_byte(bmide_dev, 0x44, &reg44);
-	pci_read_config_byte(bmide_dev, 0x47, &reg47);
-	pci_read_config_byte(bmide_dev, 0x48, &reg48);
-	pci_read_config_byte(bmide_dev, 0x4a, &reg4a);
-	pci_read_config_byte(bmide_dev, 0x4b, &reg4b);
-
-	psitre = (reg40 & 0x4000) ? 1 : 0;
-	ssitre = (reg42 & 0x4000) ? 1 : 0;
-
-        /*
-         * at that point bibma+0x2 et bibma+0xa are byte registers
-         * to investigate:
-         */
-	c0 = inb_p(bibma + 0x02);
-	c1 = inb_p(bibma + 0x0a);
-
-	p += sprintf(p, "                                SLC90E66 Chipset.\n");
-	p += sprintf(p, "--------------- Primary Channel "
-			"---------------- Secondary Channel "
-			"-------------\n");
-	p += sprintf(p, "                %sabled "
-			"                        %sabled\n",
-			(c0&0x80) ? "dis" : " en",
-			(c1&0x80) ? "dis" : " en");
-	p += sprintf(p, "--------------- drive0 --------- drive1 "
-			"-------- drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:    %s              %s "
-			"            %s               %s\n",
-			(c0&0x20) ? "yes" : "no ",
-			(c0&0x40) ? "yes" : "no ",
-			(c1&0x20) ? "yes" : "no ",
-			(c1&0x40) ? "yes" : "no " );
-	p += sprintf(p, "UDMA enabled:   %s              %s "
-			"            %s               %s\n",
-			(reg48&0x01) ? "yes" : "no ",
-			(reg48&0x02) ? "yes" : "no ",
-			(reg48&0x04) ? "yes" : "no ",
-			(reg48&0x08) ? "yes" : "no " );
-	p += sprintf(p, "UDMA enabled:   %s                %s "
-			"              %s                 %s\n",
-			((reg4a&0x04)==0x04) ? "4" :
-			((reg4a&0x03)==0x03) ? "3" :
-			(reg4a&0x02) ? "2" :
-			(reg4a&0x01) ? "1" :
-			(reg4a&0x00) ? "0" : "X",
-			((reg4a&0x40)==0x40) ? "4" :
-			((reg4a&0x30)==0x30) ? "3" :
-			(reg4a&0x20) ? "2" :
-			(reg4a&0x10) ? "1" :
-			(reg4a&0x00) ? "0" : "X",
-			((reg4b&0x04)==0x04) ? "4" :
-			((reg4b&0x03)==0x03) ? "3" :
-			(reg4b&0x02) ? "2" :
-			(reg4b&0x01) ? "1" :
-			(reg4b&0x00) ? "0" : "X",
-			((reg4b&0x40)==0x40) ? "4" :
-			((reg4b&0x30)==0x30) ? "3" :
-			(reg4b&0x20) ? "2" :
-			(reg4b&0x10) ? "1" :
-			(reg4b&0x00) ? "0" : "X");
-
-	p += sprintf(p, "UDMA\n");
-	p += sprintf(p, "DMA\n");
-	p += sprintf(p, "PIO\n");
-
-/*
- *	FIXME.... Add configuration junk data....blah blah......
- */
-
-	/* p - buffer must be less than 4k! */
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-	
-	return len > count ? count : len;
-}
-#endif  /* defined(DISPLAY_SLC90E66_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 static u8 slc90e66_ratemask (ide_drive_t *drive)
 {
 	u8 mode	= 2;
@@ -236,6 +139,7 @@
 	if (speed >= XFER_UDMA_0) {
 		if (!(reg48 & u_flag))
 			pci_write_config_word(dev, 0x48, reg48|u_flag);
+		/* FIXME: (reg4a & a_speed) ? */
 		if ((reg4a & u_speed) != u_speed) {
 			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
 			pci_read_config_word(dev, 0x4a, &reg4a);
@@ -313,18 +217,6 @@
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
-static unsigned int __init init_chipset_slc90e66 (struct pci_dev
*dev, const char *name)
-{
-#if defined(DISPLAY_SLC90E66_TIMINGS) && defined(CONFIG_PROC_FS)
-	if (!slc90e66_proc) {
-		slc90e66_proc = 1;
-		bmide_dev = dev;
-		ide_pci_create_host_proc("slc90e66", slc90e66_get_info);
-	}
-#endif /* DISPLAY_SLC90E66_TIMINGS && CONFIG_PROC_FS */
-	return 0;
-}
-
 static void __init init_hwif_slc90e66 (ide_hwif_t *hwif)
 {
 	u8 reg47 = 0;
@@ -366,7 +258,6 @@
 
 static ide_pci_device_t slc90e66_chipset __devinitdata = {
 	.name		= "SLC90E66",
-	.init_chipset	= init_chipset_slc90e66,
 	.init_hwif	= init_hwif_slc90e66,
 	.channels	= 2,
 	.autodma	= AUTODMA,
