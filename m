Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbUKLNzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbUKLNzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 08:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbUKLNzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 08:55:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11026 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262531AbUKLNxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 08:53:55 -0500
Date: Fri, 12 Nov 2004 14:53:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dwmw2@redhat.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] MTD: some cleanups
Message-ID: <20041112135322.GB7707@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes the following cleanups for code under drivers/mtd/ :
- make some needlessly global code static
- remove the following unused code:
  - function ftl_freepart in drivers/mtd/ftl.c
  - functions nettel_eraseconfig and nettel_erasecallback,
    struct nettel_erase in drivers/mtd/maps/nettel.c
  - function physmap_set_partitions in drivers/mtd/maps/physmap.c

Please review whether this patch is correct, or whether it might 
conflict with MTD patches pending for kernel inclusion adding users for 
the code in question.


diffstat output:
 drivers/mtd/chips/cfi_cmdset_0001.c |    2 
 drivers/mtd/chips/cfi_cmdset_0002.c |    2 
 drivers/mtd/chips/cfi_cmdset_0020.c |    2 
 drivers/mtd/chips/chipreg.c         |    2 
 drivers/mtd/chips/jedec_probe.c     |    6 +-
 drivers/mtd/chips/map_absent.c      |    2 
 drivers/mtd/chips/map_ram.c         |    2 
 drivers/mtd/chips/map_rom.c         |    6 +-
 drivers/mtd/cmdlinepart.c           |    2 
 drivers/mtd/devices/blkmtd.c        |    8 +--
 drivers/mtd/devices/doc2000.c       |    2 
 drivers/mtd/devices/doc2001.c       |    2 
 drivers/mtd/devices/doc2001plus.c   |    2 
 drivers/mtd/devices/docprobe.c      |    2 
 drivers/mtd/devices/mtdram.c        |    6 +-
 drivers/mtd/devices/phram.c         |   12 ++---
 drivers/mtd/devices/pmc551.c        |    2 
 drivers/mtd/devices/slram.c         |   30 ++++++-------
 drivers/mtd/ftl.c                   |   31 --------------
 drivers/mtd/inftlcore.c             |    6 +-
 drivers/mtd/maps/amd76xrom.c        |    2 
 drivers/mtd/maps/elan-104nc.c       |    2 
 drivers/mtd/maps/ichxrom.c          |    2 
 drivers/mtd/maps/l440gx.c           |    4 -
 drivers/mtd/maps/nettel.c           |   61 ----------------------------
 drivers/mtd/maps/physmap.c          |    5 --
 drivers/mtd/maps/pnc2000.c          |    4 -
 drivers/mtd/maps/sbc_gxx.c          |    2 
 drivers/mtd/maps/scb2_flash.c       |    2 
 drivers/mtd/maps/scx200_docflash.c  |    2 
 drivers/mtd/mtd_blkdevs.c           |    8 +--
 drivers/mtd/mtdblock.c              |    4 -
 drivers/mtd/mtdblock.h              |    3 -
 drivers/mtd/mtdblock_ro.c           |    2 
 drivers/mtd/mtdcore.c               |    2 
 drivers/mtd/mtdpart.c               |    2 
 drivers/mtd/nand/diskonchip.c       |    4 -
 drivers/mtd/nftlcore.c              |    6 +-
 include/linux/mtd/partitions.h      |    1 
 include/linux/mtd/physmap.h         |   16 -------
 40 files changed, 78 insertions(+), 185 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/cfi_cmdset_0001.c.old	2004-11-11 23:14:48.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/cfi_cmdset_0001.c	2004-11-11 23:15:06.000000000 +0100
@@ -1774,7 +1774,7 @@
 static char im_name_1[]="cfi_cmdset_0001";
 static char im_name_3[]="cfi_cmdset_0003";
 
-int __init cfi_intelext_init(void)
+static int __init cfi_intelext_init(void)
 {
 	inter_module_register(im_name_1, THIS_MODULE, &cfi_cmdset_0001);
 	inter_module_register(im_name_3, THIS_MODULE, &cfi_cmdset_0001);
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/cfi_cmdset_0002.c.old	2004-11-11 23:15:27.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/cfi_cmdset_0002.c	2004-11-11 23:15:38.000000000 +0100
@@ -1506,7 +1506,7 @@
 static char im_name[]="cfi_cmdset_0002";
 
 
-int __init cfi_amdstd_init(void)
+static int __init cfi_amdstd_init(void)
 {
 	inter_module_register(im_name, THIS_MODULE, &cfi_cmdset_0002);
 	return 0;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/cfi_cmdset_0020.c.old	2004-11-11 23:16:00.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/cfi_cmdset_0020.c	2004-11-11 23:16:11.000000000 +0100
@@ -1401,7 +1401,7 @@
 
 static char im_name[]="cfi_cmdset_0020";
 
-int __init cfi_staa_init(void)
+static int __init cfi_staa_init(void)
 {
 	inter_module_register(im_name, THIS_MODULE, &cfi_cmdset_0020);
 	return 0;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/chipreg.c.old	2004-11-11 23:16:46.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/chipreg.c	2004-11-11 23:16:57.000000000 +0100
@@ -15,7 +15,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/compatmac.h>
 
-spinlock_t chip_drvs_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t chip_drvs_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(chip_drvs_list);
 
 void register_mtd_chip_driver(struct mtd_chip_driver *drv)
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/jedec_probe.c.old	2004-11-11 23:17:40.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/jedec_probe.c	2004-11-11 23:18:25.000000000 +0100
@@ -1661,7 +1661,7 @@
 static int jedec_probe_chip(struct map_info *map, __u32 base,
 			    unsigned long *chip_map, struct cfi_private *cfi);
 
-struct mtd_info *jedec_probe(struct map_info *map);
+static struct mtd_info *jedec_probe(struct map_info *map);
 
 static inline u32 jedec_read_mfr(struct map_info *map, __u32 base, 
 	struct cfi_private *cfi)
@@ -2055,7 +2055,7 @@
 	.probe_chip = jedec_probe_chip
 };
 
-struct mtd_info *jedec_probe(struct map_info *map)
+static struct mtd_info *jedec_probe(struct map_info *map)
 {
 	/*
 	 * Just use the generic probe stuff to call our CFI-specific
@@ -2070,7 +2070,7 @@
 	.module	= THIS_MODULE
 };
 
-int __init jedec_probe_init(void)
+static int __init jedec_probe_init(void)
 {
 	register_mtd_chip_driver(&jedec_chipdrv);
 	return 0;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/map_absent.c.old	2004-11-11 23:18:41.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/map_absent.c	2004-11-11 23:18:53.000000000 +0100
@@ -98,7 +98,7 @@
 	/* nop */
 }
 
-int __init map_absent_init(void)
+static int __init map_absent_init(void)
 {
 	register_mtd_chip_driver(&map_absent_chipdrv);
 	return 0;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/map_ram.c.old	2004-11-11 23:19:11.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/map_ram.c	2004-11-11 23:19:23.000000000 +0100
@@ -124,7 +124,7 @@
 	/* Nothing to see here */
 }
 
-int __init map_ram_init(void)
+static int __init map_ram_init(void)
 {
 	register_mtd_chip_driver(&mapram_chipdrv);
 	return 0;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/map_rom.c.old	2004-11-11 23:19:45.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/chips/map_rom.c	2004-11-11 23:20:12.000000000 +0100
@@ -19,7 +19,7 @@
 static int maprom_read (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
 static int maprom_write (struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
 static void maprom_nop (struct mtd_info *);
-struct mtd_info *map_rom_probe(struct map_info *map);
+static struct mtd_info *map_rom_probe(struct map_info *map);
 
 static struct mtd_chip_driver maprom_chipdrv = {
 	.probe	= map_rom_probe,
@@ -27,7 +27,7 @@
 	.module	= THIS_MODULE
 };
 
-struct mtd_info *map_rom_probe(struct map_info *map)
+static struct mtd_info *map_rom_probe(struct map_info *map)
 {
 	struct mtd_info *mtd;
 
@@ -75,7 +75,7 @@
 	return -EIO;
 }
 
-int __init map_rom_init(void)
+static int __init map_rom_init(void)
 {
 	register_mtd_chip_driver(&maprom_chipdrv);
 	return 0;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/cmdlinepart.c.old	2004-11-11 23:20:26.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/cmdlinepart.c	2004-11-11 23:21:00.000000000 +0100
@@ -339,7 +339,7 @@
  * main.c::checksetup(). Note that we can not yet kmalloc() anything,
  * so we only save the commandline for later processing.
  */
-int mtdpart_setup(char *s)
+static int mtdpart_setup(char *s)
 {
 	cmdline = s;
 	return 1;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/blkmtd.c.old	2004-11-11 23:21:09.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/blkmtd.c	2004-11-11 23:21:39.000000000 +0100
@@ -59,10 +59,10 @@
 #define MAX_DEVICES 4
 
 /* Module parameters passed by insmod/modprobe */
-char *device[MAX_DEVICES];    /* the block device to use */
-int erasesz[MAX_DEVICES];     /* optional default erase size */
-int ro[MAX_DEVICES];          /* optional read only flag */
-int sync;
+static char *device[MAX_DEVICES];    /* the block device to use */
+static int erasesz[MAX_DEVICES];     /* optional default erase size */
+static int ro[MAX_DEVICES];          /* optional read only flag */
+static int sync;
 
 
 MODULE_LICENSE("GPL");
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/doc2000.c.old	2004-11-11 23:21:53.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/doc2000.c	2004-11-11 23:22:02.000000000 +0100
@@ -1290,7 +1290,7 @@
  *
  ****************************************************************************/
 
-int __init init_doc2000(void)
+static int __init init_doc2000(void)
 {
        inter_module_register(im_name, THIS_MODULE, &DoC2k_init);
        return 0;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/doc2001.c.old	2004-11-11 23:22:18.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/doc2001.c	2004-11-11 23:22:28.000000000 +0100
@@ -856,7 +856,7 @@
  *
  ****************************************************************************/
 
-int __init init_doc2001(void)
+static int __init init_doc2001(void)
 {
 	inter_module_register(im_name, THIS_MODULE, &DoCMil_init);
 	return 0;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/doc2001plus.c.old	2004-11-11 23:22:38.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/doc2001plus.c	2004-11-11 23:22:48.000000000 +0100
@@ -1122,7 +1122,7 @@
  *
  ****************************************************************************/
 
-int __init init_doc2001plus(void)
+static int __init init_doc2001plus(void)
 {
 	inter_module_register(im_name, THIS_MODULE, &DoCMilPlus_init);
 	return 0;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/docprobe.c.old	2004-11-11 23:23:04.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/docprobe.c	2004-11-11 23:23:12.000000000 +0100
@@ -328,7 +328,7 @@
  *
  ****************************************************************************/
 
-int __init init_doc(void)
+static int __init init_doc(void)
 {
 	int i;
 	
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/mtdram.c.old	2004-11-11 23:23:45.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/mtdram.c	2004-11-11 23:24:13.000000000 +0100
@@ -153,7 +153,7 @@
 
 #if CONFIG_MTDRAM_TOTAL_SIZE > 0
 #if CONFIG_MTDRAM_ABS_POS > 0
-int __init init_mtdram(void)
+static int __init init_mtdram(void)
 {
   void *addr;
   int err;
@@ -186,7 +186,7 @@
 
 #else /* CONFIG_MTDRAM_ABS_POS > 0 */
 
-int __init init_mtdram(void)
+static int __init init_mtdram(void)
 {
   void *addr;
   int err;
@@ -220,7 +220,7 @@
 
 #else /* CONFIG_MTDRAM_TOTAL_SIZE > 0 */
 
-int __init init_mtdram(void)
+static int __init init_mtdram(void)
 {
   return 0;
 }
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/phram.c.old	2004-11-11 23:24:52.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/phram.c	2004-11-11 23:25:31.000000000 +0100
@@ -39,7 +39,7 @@
 
 
 
-int phram_erase(struct mtd_info *mtd, struct erase_info *instr)
+static int phram_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
 	u_char *start = (u_char *)mtd->priv;
 
@@ -60,7 +60,7 @@
 	return 0;
 }
 
-int phram_point(struct mtd_info *mtd, loff_t from, size_t len,
+static int phram_point(struct mtd_info *mtd, loff_t from, size_t len,
 		size_t *retlen, u_char **mtdbuf)
 {
 	u_char *start = (u_char *)mtd->priv;
@@ -73,11 +73,11 @@
 	return 0;
 }
 
-void phram_unpoint(struct mtd_info *mtd, u_char *addr, loff_t from, size_t len)
+static void phram_unpoint(struct mtd_info *mtd, u_char *addr, loff_t from, size_t len)
 {
 }
 
-int phram_read(struct mtd_info *mtd, loff_t from, size_t len,
+static int phram_read(struct mtd_info *mtd, loff_t from, size_t len,
 		size_t *retlen, u_char *buf)
 {
 	u_char *start = (u_char *)mtd->priv;
@@ -91,7 +91,7 @@
 	return 0;
 }
 
-int phram_write(struct mtd_info *mtd, loff_t to, size_t len,
+static int phram_write(struct mtd_info *mtd, loff_t to, size_t len,
 		size_t *retlen, const u_char *buf)
 {
 	u_char *start = (u_char *)mtd->priv;
@@ -340,7 +340,7 @@
 MODULE_PARM_DESC(slram, "List of memory regions to map. \"map=<name>,<start><length/end>\"");
 
 
-int __init init_phram(void)
+static int __init init_phram(void)
 {
 	printk(KERN_ERR "phram loaded\n");
 	return 0;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/pmc551.c.old	2004-11-11 23:26:09.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/pmc551.c	2004-11-11 23:26:21.000000000 +0100
@@ -648,7 +648,7 @@
 /*
  * PMC551 Card Initialization
  */
-int __init init_pmc551(void)
+static int __init init_pmc551(void)
 {
         struct pci_dev *PCI_Device = NULL;
         struct mypriv *priv;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/slram.c.old	2004-11-11 23:27:12.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/devices/slram.c	2004-11-11 23:29:44.000000000 +0100
@@ -75,13 +75,13 @@
 
 static slram_mtd_list_t *slram_mtdlist = NULL;
 
-int slram_erase(struct mtd_info *, struct erase_info *);
-int slram_point(struct mtd_info *, loff_t, size_t, size_t *, u_char **);
-void slram_unpoint(struct mtd_info *, u_char *, loff_t,	size_t);
-int slram_read(struct mtd_info *, loff_t, size_t, size_t *, u_char *);
-int slram_write(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
+static int slram_erase(struct mtd_info *, struct erase_info *);
+static int slram_point(struct mtd_info *, loff_t, size_t, size_t *, u_char **);
+static void slram_unpoint(struct mtd_info *, u_char *, loff_t,	size_t);
+static int slram_read(struct mtd_info *, loff_t, size_t, size_t *, u_char *);
+static int slram_write(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
 
-int slram_erase(struct mtd_info *mtd, struct erase_info *instr)
+static int slram_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
 	slram_priv_t *priv = mtd->priv;
 
@@ -103,7 +103,7 @@
 	return(0);
 }
 
-int slram_point(struct mtd_info *mtd, loff_t from, size_t len,
+static int slram_point(struct mtd_info *mtd, loff_t from, size_t len,
 		size_t *retlen, u_char **mtdbuf)
 {
 	slram_priv_t *priv = (slram_priv_t *)mtd->priv;
@@ -113,11 +113,11 @@
 	return(0);
 }
 
-void slram_unpoint(struct mtd_info *mtd, u_char *addr, loff_t from, size_t len)
+static void slram_unpoint(struct mtd_info *mtd, u_char *addr, loff_t from, size_t len)
 {
 }
 
-int slram_read(struct mtd_info *mtd, loff_t from, size_t len,
+static int slram_read(struct mtd_info *mtd, loff_t from, size_t len,
 		size_t *retlen, u_char *buf)
 {
 	slram_priv_t *priv = (slram_priv_t *)mtd->priv;
@@ -128,7 +128,7 @@
 	return(0);
 }
 
-int slram_write(struct mtd_info *mtd, loff_t to, size_t len,
+static int slram_write(struct mtd_info *mtd, loff_t to, size_t len,
 		size_t *retlen, const u_char *buf)
 {
 	slram_priv_t *priv = (slram_priv_t *)mtd->priv;
@@ -141,7 +141,7 @@
 
 /*====================================================================*/
 
-int register_device(char *name, unsigned long start, unsigned long length)
+static int register_device(char *name, unsigned long start, unsigned long length)
 {
 	slram_mtd_list_t **curmtd;
 
@@ -213,7 +213,7 @@
 	return(0);	
 }
 
-void unregister_devices(void)
+static void unregister_devices(void)
 {
 	slram_mtd_list_t *nextitem;
 
@@ -228,7 +228,7 @@
 	}
 }
 
-unsigned long handle_unit(unsigned long value, char *unit)
+static unsigned long handle_unit(unsigned long value, char *unit)
 {
 	if ((*unit == 'M') || (*unit == 'm')) {
 		return(value * 1024 * 1024);
@@ -238,7 +238,7 @@
 	return(value);
 }
 
-int parse_cmdline(char *devname, char *szstart, char *szlength)
+static int parse_cmdline(char *devname, char *szstart, char *szlength)
 {
 	char *buffer;
 	unsigned long devstart;
@@ -285,7 +285,7 @@
 
 #endif
 
-int init_slram(void)
+static int init_slram(void)
 {
 	char *devname;
 	int i;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/ftl.c.old	2004-11-11 23:30:18.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/ftl.c	2004-11-11 23:30:55.000000000 +0100
@@ -137,8 +137,6 @@
 #endif
 } partition_t;
 
-void ftl_freepart(partition_t *part);
-
 /* Partition state flags */
 #define FTL_FORMATTED	0x01
 
@@ -1014,31 +1012,6 @@
 
 /*====================================================================*/
 
-void ftl_freepart(partition_t *part)
-{
-    if (part->VirtualBlockMap) {
-	vfree(part->VirtualBlockMap);
-	part->VirtualBlockMap = NULL;
-    }
-    if (part->VirtualPageMap) {
-	kfree(part->VirtualPageMap);
-	part->VirtualPageMap = NULL;
-    }
-    if (part->EUNInfo) {
-	kfree(part->EUNInfo);
-	part->EUNInfo = NULL;
-    }
-    if (part->XferInfo) {
-	kfree(part->XferInfo);
-	part->XferInfo = NULL;
-    }
-    if (part->bam_cache) {
-	kfree(part->bam_cache);
-	part->bam_cache = NULL;
-    }
-    
-} /* ftl_freepart */
-
 static void ftl_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 {
 	partition_t *partition;
@@ -1080,7 +1053,7 @@
 	kfree(dev);
 }
 
-struct mtd_blktrans_ops ftl_tr = {
+static struct mtd_blktrans_ops ftl_tr = {
 	.name		= "ftl",
 	.major		= FTL_MAJOR,
 	.part_bits	= PART_BITS,
@@ -1092,7 +1065,7 @@
 	.owner		= THIS_MODULE,
 };
 
-int init_ftl(void)
+static int init_ftl(void)
 {
 	DEBUG(0, "$Id: ftl.c,v 1.53 2004/08/09 13:55:43 dwmw2 Exp $\n");
 
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/inftlcore.c.old	2004-11-11 23:31:32.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/inftlcore.c	2004-11-11 23:31:59.000000000 +0100
@@ -352,7 +352,7 @@
 	return targetEUN;
 }
 
-u16 INFTL_makefreeblock(struct INFTLrecord *inftl, unsigned pendingblock)
+static u16 INFTL_makefreeblock(struct INFTLrecord *inftl, unsigned pendingblock)
 {
 	/*
 	 * This is the part that needs some cleverness applied. 
@@ -877,7 +877,7 @@
 	return 0;
 }
 
-struct mtd_blktrans_ops inftl_tr = {
+static struct mtd_blktrans_ops inftl_tr = {
 	.name		= "inftl",
 	.major		= INFTL_MAJOR,
 	.part_bits	= INFTL_PARTN_BITS,
@@ -891,7 +891,7 @@
 
 extern char inftlmountrev[];
 
-int __init init_inftl(void)
+static int __init init_inftl(void)
 {
 	printk(KERN_INFO "INFTL: inftlcore.c $Revision: 1.17 $, "
 		"inftlmount.c %s\n", inftlmountrev);
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/amd76xrom.c.old	2004-11-11 23:32:12.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/amd76xrom.c	2004-11-11 23:32:20.000000000 +0100
@@ -298,7 +298,7 @@
 };
 #endif
 
-int __init init_amd76xrom(void)
+static int __init init_amd76xrom(void)
 {
 	struct pci_dev *pdev;
 	struct pci_device_id *id;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/elan-104nc.c.old	2004-11-11 23:32:35.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/elan-104nc.c	2004-11-11 23:32:52.000000000 +0100
@@ -185,7 +185,7 @@
 	iounmap((void *)iomapadr);
 }
 
-int __init init_elan_104nc(void)
+static int __init init_elan_104nc(void)
 {
 	/* Urg! We use I/O port 0x22 without request_region()ing it,
 	   because it's already allocated to the PIC. */
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/ichxrom.c.old	2004-11-11 23:33:13.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/ichxrom.c	2004-11-11 23:33:22.000000000 +0100
@@ -349,7 +349,7 @@
 };
 #endif
 
-int __init init_ichxrom(void)
+static int __init init_ichxrom(void)
 {
 	struct pci_dev *pdev;
 	struct pci_device_id *id;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/l440gx.c.old	2004-11-11 23:33:49.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/l440gx.c	2004-11-11 23:34:07.000000000 +0100
@@ -30,7 +30,7 @@
 
 
 /* Is this really the vpp port? */
-void l440gx_set_vpp(struct map_info *map, int vpp)
+static void l440gx_set_vpp(struct map_info *map, int vpp)
 {
 	unsigned long l;
 
@@ -43,7 +43,7 @@
 	outl(l, VPP_PORT);
 }
 
-struct map_info l440gx_map = {
+static struct map_info l440gx_map = {
 	.name = "L440GX BIOS",
 	.size = WINDOW_SIZE,
 	.bankwidth = BUSWIDTH,
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/nettel.c.old	2004-11-11 23:34:39.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/nettel.c	2004-11-11 23:36:24.000000000 +0100
@@ -156,68 +156,11 @@
 	nettel_reboot_notifier, NULL, 0
 };
 
-/*
- *	Erase the configuration file system.
- *	Used to support the software reset button.
- */
-static void nettel_erasecallback(struct erase_info *done)
-{
-	wait_queue_head_t *wait_q = (wait_queue_head_t *)done->priv;
-	wake_up(wait_q);
-}
-
-static struct erase_info nettel_erase;
-
-int nettel_eraseconfig(void)
-{
-	struct mtd_info *mtd;
-	DECLARE_WAITQUEUE(wait, current);
-	wait_queue_head_t wait_q;
-	int ret;
-
-	init_waitqueue_head(&wait_q);
-	mtd = get_mtd_device(NULL, 2);
-	if (mtd) {
-		nettel_erase.mtd = mtd;
-		nettel_erase.callback = nettel_erasecallback;
-		nettel_erase.callback = NULL;
-		nettel_erase.addr = 0;
-		nettel_erase.len = mtd->size;
-		nettel_erase.priv = (u_long) &wait_q;
-		nettel_erase.priv = 0;
-
-		set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&wait_q, &wait);
-
-		ret = MTD_ERASE(mtd, &nettel_erase);
-		if (ret) {
-			set_current_state(TASK_RUNNING);
-			remove_wait_queue(&wait_q, &wait);
-			put_mtd_device(mtd);
-			return(ret);
-		}
-
-		schedule();  /* Wait for erase to finish. */
-		remove_wait_queue(&wait_q, &wait);
-		
-		put_mtd_device(mtd);
-	}
-
-	return(0);
-}
-
-#else
-
-int nettel_eraseconfig(void)
-{
-	return(0);
-}
-
 #endif
 
 /****************************************************************************/
 
-int __init nettel_init(void)
+static int __init nettel_init(void)
 {
 	volatile unsigned long *amdpar;
 	unsigned long amdaddr, maxsize;
@@ -461,7 +404,7 @@
 
 /****************************************************************************/
 
-void __exit nettel_cleanup(void)
+static void __exit nettel_cleanup(void)
 {
 #ifdef CONFIG_MTD_CFI_INTELEXT
 	unregister_reboot_notifier(&nettel_notifier_block);
--- linux-2.6.10-rc1-mm5-full/include/linux/mtd/physmap.h.old	2004-11-11 23:38:16.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/include/linux/mtd/physmap.h	2004-11-11 23:39:00.000000000 +0100
@@ -41,21 +41,7 @@
 	physmap_map.set_vpp = set_vpp;
 }
 
-#if defined(CONFIG_MTD_PARTITIONS)
-
-/*
- * Machines that wish to do flash partition may want to call this function in 
- * their setup routine.  
- *
- *	physmap_set_partitions(mypartitions, num_parts);
- *
- * Note that one can always override this hard-coded partition with 
- * command line partition (you need to enable CONFIG_MTD_CMDLINE_PARTS).
- */
-void physmap_set_partitions(struct mtd_partition *parts, int num_parts);
-
-#endif /* defined(CONFIG_MTD_PARTITIONS) */
-#endif /* defined(CONFIG_MTD) */
+#endif /* defined(CONFIG_MTD_PHYSMAP) */
 
 #endif /* __LINUX_MTD_PHYSMAP__ */
 
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/physmap.c.old	2004-11-11 23:39:08.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/physmap.c	2004-11-11 23:39:43.000000000 +0100
@@ -38,11 +38,6 @@
 
 static const char *part_probes[] __initdata = {"cmdlinepart", "RedBoot", NULL};
 
-void physmap_set_partitions(struct mtd_partition *parts, int num_parts)
-{
-	physmap_partitions=parts;
-	num_physmap_partitions=num_parts;
-}
 #endif /* CONFIG_MTD_PARTITIONS */
 
 static int __init init_physmap(void)
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/pnc2000.c.old	2004-11-11 23:40:09.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/pnc2000.c	2004-11-11 23:40:37.000000000 +0100
@@ -26,7 +26,7 @@
  */
 
 
-struct map_info pnc_map = {
+static struct map_info pnc_map = {
 	.name = "PNC-2000",
 	.size = WINDOW_SIZE,
 	.bankwidth = 4,
@@ -62,7 +62,7 @@
  */
 static struct mtd_info *mymtd;
 
-int __init init_pnc2000(void)
+static int __init init_pnc2000(void)
 {
 	printk(KERN_NOTICE "Photron PNC-2000 flash mapping: %x at %x\n", WINDOW_SIZE, WINDOW_ADDR);
 
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/sbc_gxx.c.old	2004-11-11 23:40:51.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/sbc_gxx.c	2004-11-11 23:40:58.000000000 +0100
@@ -193,7 +193,7 @@
 	release_region(PAGE_IO,PAGE_IO_SIZE);
 }
 
-int __init init_sbc_gxx(void)
+static int __init init_sbc_gxx(void)
 {
   	iomapadr = (void __iomem *)ioremap(WINDOW_START, WINDOW_LENGTH);
 	if (!iomapadr) {
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/scb2_flash.c.old	2004-11-11 23:41:21.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/scb2_flash.c	2004-11-11 23:41:35.000000000 +0100
@@ -64,7 +64,7 @@
 
 static void *scb2_ioaddr;
 static struct mtd_info *scb2_mtd;
-struct map_info scb2_map = {
+static struct map_info scb2_map = {
 	.name =      "SCB2 BIOS Flash",
 	.size =      0,
 	.bankwidth =  1,
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/scx200_docflash.c.old	2004-11-11 23:41:53.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/maps/scx200_docflash.c	2004-11-11 23:42:06.000000000 +0100
@@ -81,7 +81,7 @@
 	.name      = "NatSemi SCx200 DOCCS Flash",
 };
 
-int __init init_scx200_docflash(void)
+static int __init init_scx200_docflash(void)
 {
 	unsigned u;
 	unsigned base;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/mtd_blkdevs.c.old	2004-11-11 23:43:15.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/mtd_blkdevs.c	2004-11-11 23:52:26.000000000 +0100
@@ -143,7 +143,7 @@
 }
 
 
-int blktrans_open(struct inode *i, struct file *f)
+static int blktrans_open(struct inode *i, struct file *f)
 {
 	struct mtd_blktrans_dev *dev;
 	struct mtd_blktrans_ops *tr;
@@ -174,7 +174,7 @@
 	return ret;
 }
 
-int blktrans_release(struct inode *i, struct file *f)
+static int blktrans_release(struct inode *i, struct file *f)
 {
 	struct mtd_blktrans_dev *dev;
 	struct mtd_blktrans_ops *tr;
@@ -326,7 +326,7 @@
 	return 0;
 }
 
-void blktrans_notify_remove(struct mtd_info *mtd)
+static void blktrans_notify_remove(struct mtd_info *mtd)
 {
 	struct list_head *this, *this2, *next;
 
@@ -342,7 +342,7 @@
 	}
 }
 
-void blktrans_notify_add(struct mtd_info *mtd)
+static void blktrans_notify_add(struct mtd_info *mtd)
 {
 	struct list_head *this;
 
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/mtdblock.h.old	2004-11-11 23:46:06.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/mtdblock.h	2004-11-11 23:46:15.000000000 +0100
@@ -29,7 +29,4 @@
 extern int do_cached_read (struct mtdblk_dev *mtdblk, unsigned long pos, 
 			   int len, char *buf);
 
-extern void __exit cleanup_mtdblock(void);
-extern int __init init_mtdblock(void);
-
 #endif
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/mtdblock.c.old	2004-11-11 23:46:24.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/mtdblock.c	2004-11-11 23:46:42.000000000 +0100
@@ -361,7 +361,7 @@
 	kfree(dev);
 }
 
-struct mtd_blktrans_ops mtdblock_tr = {
+static struct mtd_blktrans_ops mtdblock_tr = {
 	.name		= "mtdblock",
 	.major		= 31,
 	.part_bits	= 0,
@@ -375,7 +375,7 @@
 	.owner		= THIS_MODULE,
 };
 
-int __init init_mtdblock(void)
+static int __init init_mtdblock(void)
 {
 	return register_mtd_blktrans(&mtdblock_tr);
 }
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/mtdblock_ro.c.old	2004-11-11 23:46:50.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/mtdblock_ro.c	2004-11-11 23:46:58.000000000 +0100
@@ -58,7 +58,7 @@
 	kfree(dev);
 }
 
-struct mtd_blktrans_ops mtdblock_tr = {
+static struct mtd_blktrans_ops mtdblock_tr = {
 	.name		= "mtdblock",
 	.major		= 31,
 	.part_bits	= 0,
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/mtdcore.c.old	2004-11-11 23:47:30.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/mtdcore.c	2004-11-11 23:47:39.000000000 +0100
@@ -382,7 +382,7 @@
 /*====================================================================*/
 /* Init code */
 
-int __init init_mtd(void)
+static int __init init_mtd(void)
 {
 #ifdef CONFIG_PROC_FS
 	if ((proc_mtd = create_proc_entry( "mtd", 0, NULL )))
--- linux-2.6.10-rc1-mm5-full/include/linux/mtd/partitions.h.old	2004-11-11 23:48:02.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/include/linux/mtd/partitions.h	2004-11-11 23:48:10.000000000 +0100
@@ -64,7 +64,6 @@
 	int (*parse_fn)(struct mtd_info *, struct mtd_partition **, unsigned long);
 };
 
-extern struct mtd_part_parser *get_partition_parser(const char *name);
 extern int register_mtd_parser(struct mtd_part_parser *parser);
 extern int deregister_mtd_parser(struct mtd_part_parser *parser);
 extern int parse_mtd_partitions(struct mtd_info *master, const char **types, 
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/mtdpart.c.old	2004-11-11 23:48:17.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/mtdpart.c	2004-11-11 23:48:27.000000000 +0100
@@ -526,7 +526,7 @@
 static spinlock_t part_parser_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(part_parsers);
 
-struct mtd_part_parser *get_partition_parser(const char *name)
+static struct mtd_part_parser *get_partition_parser(const char *name)
 {
 	struct list_head *this;
 	void *ret = NULL;
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/nand/diskonchip.c.old	2004-11-11 23:48:51.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/nand/diskonchip.c	2004-11-11 23:49:06.000000000 +0100
@@ -1720,7 +1720,7 @@
 	}
 }
 
-int __init init_nanddoc(void)
+static int __init init_nanddoc(void)
 {
 	int i;
 
@@ -1758,7 +1758,7 @@
 	return 0;
 }
 
-void __exit cleanup_nanddoc(void)
+static void __exit cleanup_nanddoc(void)
 {
 	/* Cleanup the nand/DoC resources */
 	release_nanddoc();
--- linux-2.6.10-rc1-mm5-full/drivers/mtd/nftlcore.c.old	2004-11-11 23:49:41.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/mtd/nftlcore.c	2004-11-11 23:50:08.000000000 +0100
@@ -421,7 +421,7 @@
 	return targetEUN;
 }
 
-u16 NFTL_makefreeblock( struct NFTLrecord *nftl , unsigned pendingblock)
+static u16 NFTL_makefreeblock( struct NFTLrecord *nftl , unsigned pendingblock)
 {
 	/* This is the part that needs some cleverness applied. 
 	   For now, I'm doing the minimum applicable to actually
@@ -731,7 +731,7 @@
  ****************************************************************************/
 
 
-struct mtd_blktrans_ops nftl_tr = {
+static struct mtd_blktrans_ops nftl_tr = {
 	.name		= "nftl",
 	.major		= NFTL_MAJOR,
 	.part_bits	= NFTL_PARTN_BITS,
@@ -747,7 +747,7 @@
 
 extern char nftlmountrev[];
 
-int __init init_nftl(void)
+static int __init init_nftl(void)
 {
 	printk(KERN_INFO "NFTL driver: nftlcore.c $Revision: 1.96 $, nftlmount.c %s\n", nftlmountrev);
 

