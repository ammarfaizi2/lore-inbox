Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbTIKXBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 19:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbTIKXBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 19:01:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:51858 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261590AbTIKW6u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:58:50 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10633211531194@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test5
In-Reply-To: <10633211532756@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 11 Sep 2003 15:59:13 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1287, 2003/09/11 15:46:20-07:00, greg@kroah.com

PCI: fix up some pci drivers that had marked their probe functions with __init

This also required some other functions and variables to be marked as 
__devinit


 drivers/atm/firestream.c        |   18 +++++++++---------
 drivers/block/cciss.c           |    4 ++--
 drivers/char/epca.c             |    2 +-
 drivers/char/watchdog/wdt_pci.c |    2 +-
 drivers/net/hamachi.c           |    6 +++---
 drivers/net/irda/via-ircc.c     |    6 +++---
 drivers/net/tc35815.c           |    4 ++--
 drivers/net/tokenring/abyss.c   |    4 ++--
 drivers/net/tokenring/tmspci.c  |    4 ++--
 drivers/net/tulip/de2104x.c     |    4 ++--
 drivers/net/tulip/de4x5.c       |    8 ++++----
 drivers/net/wan/dscc4.c         |    2 +-
 drivers/pcmcia/i82092.c         |    2 +-
 drivers/video/i810/i810_main.c  |   20 ++++++++++----------
 drivers/video/i810/i810_main.h  |    4 ++--
 drivers/video/riva/fbdev.c      |    4 ++--
 16 files changed, 47 insertions(+), 47 deletions(-)


diff -Nru a/drivers/atm/firestream.c b/drivers/atm/firestream.c
--- a/drivers/atm/firestream.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/atm/firestream.c	Thu Sep 11 15:54:39 2003
@@ -250,7 +250,7 @@
 };
 
 
-struct reginit_item PHY_NTC_INIT[] __initdata = {
+struct reginit_item PHY_NTC_INIT[] __devinitdata = {
 	{ PHY_CLEARALL, 0x40 }, 
 	{ 0x12,  0x0001 },
 	{ 0x13,  0x7605 },
@@ -1296,7 +1296,7 @@
 };
 
 
-static void __init undocumented_pci_fix (struct pci_dev *pdev)
+static void __devinit undocumented_pci_fix (struct pci_dev *pdev)
 {
 	int tint;
 
@@ -1320,13 +1320,13 @@
  *                              PHY routines                              *
  **************************************************************************/
 
-static void __init write_phy (struct fs_dev *dev, int regnum, int val)
+static void __devinit write_phy (struct fs_dev *dev, int regnum, int val)
 {
 	submit_command (dev,  &dev->hp_txq, QE_CMD_PRP_WR | QE_CMD_IMM_INQ,
 			regnum, val, 0);
 }
 
-static int __init init_phy (struct fs_dev *dev, struct reginit_item *reginit)
+static int __devinit init_phy (struct fs_dev *dev, struct reginit_item *reginit)
 {
 	int i;
 
@@ -1382,7 +1382,7 @@
 	}
 }
 
-static void __init *aligned_kmalloc (int size, int flags, int alignment)
+static void __devinit *aligned_kmalloc (int size, int flags, int alignment)
 {
 	void  *t;
 
@@ -1399,7 +1399,7 @@
 	return NULL;
 }
 
-static int __init init_q (struct fs_dev *dev, 
+static int __devinit init_q (struct fs_dev *dev, 
 			  struct queue *txq, int queue, int nentries, int is_rq)
 {
 	int sz = nentries * sizeof (struct FS_QENTRY);
@@ -1435,7 +1435,7 @@
 }
 
 
-static int __init init_fp (struct fs_dev *dev, 
+static int __devinit init_fp (struct fs_dev *dev, 
 			   struct freepool *fp, int queue, int bufsize, int nr_buffers)
 {
 	func_enter ();
@@ -1655,7 +1655,7 @@
 }
 #endif
 
-static int __init fs_init (struct fs_dev *dev)
+static int __devinit fs_init (struct fs_dev *dev)
 {
 	struct pci_dev  *pci_dev;
 	int isr, to;
@@ -1890,7 +1890,7 @@
 	return 0;
 }
 
-static int __init firestream_init_one (struct pci_dev *pci_dev,
+static int __devinit firestream_init_one (struct pci_dev *pci_dev,
 				       const struct pci_device_id *ent) 
 {
 	struct atm_dev *atm_dev;
diff -Nru a/drivers/block/cciss.c b/drivers/block/cciss.c
--- a/drivers/block/cciss.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/block/cciss.c	Thu Sep 11 15:54:39 2003
@@ -243,7 +243,7 @@
  * Get us a file in /proc/cciss that says something about each controller.
  * Create /proc/cciss if it doesn't exist yet.
  */
-static void __init cciss_procinit(int i)
+static void __devinit cciss_procinit(int i)
 {
 	struct proc_dir_entry *pde;
 
@@ -2427,7 +2427,7 @@
  *  stealing all these major device numbers.
  *  returns the number of block devices registered.
  */
-static int __init cciss_init_one(struct pci_dev *pdev,
+static int __devinit cciss_init_one(struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
 	request_queue_t *q;
diff -Nru a/drivers/char/epca.c b/drivers/char/epca.c
--- a/drivers/char/epca.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/char/epca.c	Thu Sep 11 15:54:39 2003
@@ -3868,7 +3868,7 @@
 };
 
 
-static int __init epca_init_one (struct pci_dev *pdev,
+static int __devinit epca_init_one (struct pci_dev *pdev,
 				 const struct pci_device_id *ent)
 {
 	static int board_num = -1;
diff -Nru a/drivers/char/watchdog/wdt_pci.c b/drivers/char/watchdog/wdt_pci.c
--- a/drivers/char/watchdog/wdt_pci.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/char/watchdog/wdt_pci.c	Thu Sep 11 15:54:39 2003
@@ -505,7 +505,7 @@
 };
 
 
-static int __init wdtpci_init_one (struct pci_dev *dev,
+static int __devinit wdtpci_init_one (struct pci_dev *dev,
 				   const struct pci_device_id *ent)
 {
 	static int dev_count = 0;
diff -Nru a/drivers/net/hamachi.c b/drivers/net/hamachi.c
--- a/drivers/net/hamachi.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/net/hamachi.c	Thu Sep 11 15:54:39 2003
@@ -178,7 +178,7 @@
 #include <asm/unaligned.h>
 #include <asm/cache.h>
 
-static char version[] __initdata =
+static char version[] __devinitdata =
 KERN_INFO DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE "  Written by Donald Becker\n"
 KERN_INFO "   Some modifications by Eric kasten <kasten@nscl.msu.edu>\n"
 KERN_INFO "   Further modifications by Keith Underwood <keithu@parl.clemson.edu>\n";
@@ -569,7 +569,7 @@
 static void set_rx_mode(struct net_device *dev);
 
 
-static int __init hamachi_init_one (struct pci_dev *pdev,
+static int __devinit hamachi_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent)
 {
 	struct hamachi_private *hmp;
@@ -794,7 +794,7 @@
 	return ret;
 }
 
-static int __init read_eeprom(long ioaddr, int location)
+static int __devinit read_eeprom(long ioaddr, int location)
 {
 	int bogus_cnt = 1000;
 
diff -Nru a/drivers/net/irda/via-ircc.c b/drivers/net/irda/via-ircc.c
--- a/drivers/net/irda/via-ircc.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/net/irda/via-ircc.c	Thu Sep 11 15:54:39 2003
@@ -107,7 +107,7 @@
 void hwreset(struct via_ircc_cb *self);
 static int via_ircc_dma_xmit(struct via_ircc_cb *self, u16 iobase);
 static int upload_rxdata(struct via_ircc_cb *self, int iobase);
-static int __init via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id);
+static int __devinit via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id);
 static void __exit via_remove_one (struct pci_dev *pdev);
 
 /* Should use udelay() instead, even if we are x86 only - Jean II */
@@ -168,7 +168,7 @@
 
 }
 
-static int __init via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id)
+static int __devinit via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id)
 {
 	int rc;
         u8 temp,oldPCI_40,oldPCI_44,bTmp,bTmp1;
@@ -326,7 +326,7 @@
  *    Open driver instance
  *
  */
-static __init int via_ircc_open(int i, chipio_t * info, unsigned int id)
+static __devinit int via_ircc_open(int i, chipio_t * info, unsigned int id)
 {
 	struct net_device *dev;
 	struct via_ircc_cb *self;
diff -Nru a/drivers/net/tc35815.c b/drivers/net/tc35815.c
--- a/drivers/net/tc35815.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/net/tc35815.c	Thu Sep 11 15:54:39 2003
@@ -448,7 +448,7 @@
 
 /* Index to functions, as function prototypes. */
 
-static int __init tc35815_probe1(struct pci_dev *pdev, unsigned int base_addr, unsigned int irq);
+static int __devinit tc35815_probe1(struct pci_dev *pdev, unsigned int base_addr, unsigned int irq);
 
 static int	tc35815_open(struct net_device *dev);
 static int	tc35815_send_packet(struct sk_buff *skb, struct net_device *dev);
@@ -526,7 +526,7 @@
 	return -ENODEV;
 }
 
-static int __init tc35815_probe1(struct pci_dev *pdev, unsigned int base_addr, unsigned int irq)
+static int __devinit tc35815_probe1(struct pci_dev *pdev, unsigned int base_addr, unsigned int irq)
 {
 	static unsigned version_printed = 0;
 	int i;
diff -Nru a/drivers/net/tokenring/abyss.c b/drivers/net/tokenring/abyss.c
--- a/drivers/net/tokenring/abyss.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/net/tokenring/abyss.c	Thu Sep 11 15:54:39 2003
@@ -40,7 +40,7 @@
 #include "tms380tr.h"
 #include "abyss.h"            /* Madge-specific constants */
 
-static char version[] __initdata =
+static char version[] __devinitdata =
 "abyss.c: v1.02 23/11/2000 by Adam Fritzler\n";
 
 #define ABYSS_IO_EXTENT 64
@@ -92,7 +92,7 @@
 	outw(val, dev->base_addr + reg);
 }
 
-static int __init abyss_attach(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit abyss_attach(struct pci_dev *pdev, const struct pci_device_id *ent)
 {	
 	static int versionprinted;
 	struct net_device *dev;
diff -Nru a/drivers/net/tokenring/tmspci.c b/drivers/net/tokenring/tmspci.c
--- a/drivers/net/tokenring/tmspci.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/net/tokenring/tmspci.c	Thu Sep 11 15:54:39 2003
@@ -40,7 +40,7 @@
 
 #include "tms380tr.h"
 
-static char version[] __initdata =
+static char version[] __devinitdata =
 "tmspci.c: v1.02 23/11/2000 by Adam Fritzler\n";
 
 #define TMS_PCI_IO_EXTENT 32
@@ -91,7 +91,7 @@
 	outw(val, dev->base_addr + reg);
 }
 
-static int __init tms_pci_attach(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit tms_pci_attach(struct pci_dev *pdev, const struct pci_device_id *ent)
 {	
 	static int versionprinted;
 	struct net_device *dev;
diff -Nru a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
--- a/drivers/net/tulip/de2104x.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/net/tulip/de2104x.c	Thu Sep 11 15:54:39 2003
@@ -50,7 +50,7 @@
 #include <asm/unaligned.h>
 
 /* These identify the driver base version and may not be removed. */
-static char version[] __initdata =
+static char version[] =
 KERN_INFO DRV_NAME " PCI Ethernet driver v" DRV_VERSION " (" DRV_RELDATE ")\n";
 
 MODULE_AUTHOR("Jeff Garzik <jgarzik@pobox.com>");
@@ -1932,7 +1932,7 @@
 	goto fill_defaults;
 }
 
-static int __init de_init_one (struct pci_dev *pdev,
+static int __devinit de_init_one (struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
 	struct net_device *dev;
diff -Nru a/drivers/net/tulip/de4x5.c b/drivers/net/tulip/de4x5.c
--- a/drivers/net/tulip/de4x5.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/net/tulip/de4x5.c	Thu Sep 11 15:54:39 2003
@@ -480,7 +480,7 @@
 
 #include "de4x5.h"
 
-static char version[] __initdata = "de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com\n";
+static char version[] __devinitdata = "de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com\n";
 
 #define c_char const char
 #define TWIDDLE(a) (u_short)le16_to_cpu(get_unaligned((u_short *)(a)))
@@ -1082,7 +1082,7 @@
 }
 
 
-static int __init 
+static int __devinit 
 de4x5_hw_init(struct net_device *dev, u_long iobase, struct device *gendev)
 {
     char name[DE4X5_NAME_LENGTH + 1];
@@ -2132,7 +2132,7 @@
 ** DECchips, we can find the base SROM irrespective of the BIOS scan direction.
 ** For single port cards this is a time waster...
 */
-static void __init 
+static void __devinit 
 srom_search(struct net_device *dev, struct pci_dev *pdev)
 {
     u_char pb;
@@ -2213,7 +2213,7 @@
 ** kernels use the V0.535[n] drivers.
 */
 
-static int __init de4x5_pci_probe (struct pci_dev *pdev,
+static int __devinit de4x5_pci_probe (struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
 	u_char pb, pbus = 0, dev_num, dnum = 0, timer;
diff -Nru a/drivers/net/wan/dscc4.c b/drivers/net/wan/dscc4.c
--- a/drivers/net/wan/dscc4.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/net/wan/dscc4.c	Thu Sep 11 15:54:39 2003
@@ -693,7 +693,7 @@
 	kfree(ppriv);
 }
 
-static int __init dscc4_init_one(struct pci_dev *pdev,
+static int __devinit dscc4_init_one(struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
 	struct dscc4_pci_priv *priv;
diff -Nru a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
--- a/drivers/pcmcia/i82092.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/pcmcia/i82092.c	Thu Sep 11 15:54:39 2003
@@ -92,7 +92,7 @@
 static int socket_count;  /* shortcut */                                  	                                	
 
 
-static int __init i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int __devinit i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned char configbyte;
 	int i, ret;
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/video/i810/i810_main.c	Thu Sep 11 15:54:39 2003
@@ -57,7 +57,7 @@
 #include "i810_main.h"
 
 /* PCI */
-static const char *i810_pci_list[] __initdata = {
+static const char *i810_pci_list[] __devinitdata = {
 	"Intel(R) 810 Framebuffer Device"                                 ,
 	"Intel(R) 810-DC100 Framebuffer Device"                           ,
 	"Intel(R) 810E Framebuffer Device"                                ,
@@ -1456,7 +1456,7 @@
 	return 0;
 }
 
-static struct fb_ops i810fb_ops __initdata = {
+static struct fb_ops i810fb_ops __devinitdata = {
 	.owner =             THIS_MODULE,
 	.fb_open =           i810fb_open,
 	.fb_release =        i810fb_release,
@@ -1538,7 +1538,7 @@
  *                  AGP resource allocation                            *
  ***********************************************************************/
   
-static void __init i810_fix_pointers(struct i810fb_par *par)
+static void __devinit i810_fix_pointers(struct i810fb_par *par)
 {
       	par->fb.physical = par->aperture.physical+(par->fb.offset << 12);
 	par->fb.virtual = par->aperture.virtual+(par->fb.offset << 12);
@@ -1550,7 +1550,7 @@
 		(par->cursor_heap.offset << 12);
 }
 
-static void __init i810_fix_offsets(struct i810fb_par *par)
+static void __devinit i810_fix_offsets(struct i810fb_par *par)
 {
 	if (vram + 1 > par->aperture.size >> 20)
 		vram = (par->aperture.size >> 20) - 1;
@@ -1570,7 +1570,7 @@
 	par->cursor_heap.size = 4096;
 }
 
-static int __init i810_alloc_agp_mem(struct fb_info *info)
+static int __devinit i810_alloc_agp_mem(struct fb_info *info)
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	int size;
@@ -1635,7 +1635,7 @@
  * Sets the the user monitor's horizontal and vertical
  * frequency limits
  */
-static void __init i810_init_monspecs(struct fb_info *info)
+static void __devinit i810_init_monspecs(struct fb_info *info)
 {
 	if (!hsync1)
 		hsync1 = HFMIN;
@@ -1663,7 +1663,7 @@
  * @par: pointer to i810fb_par structure
  * @info: pointer to current fb_info structure
  */
-static void __init i810_init_defaults(struct i810fb_par *par, 
+static void __devinit i810_init_defaults(struct i810fb_par *par, 
 				      struct fb_info *info)
 {
 	if (voffset) 
@@ -1707,7 +1707,7 @@
  * i810_init_device - initialize device
  * @par: pointer to i810fb_par structure
  */
-static void __init i810_init_device(struct i810fb_par *par)
+static void __devinit i810_init_device(struct i810fb_par *par)
 {
 	u8 reg, *mmio = par->mmio_start_virtual;
 
@@ -1726,7 +1726,7 @@
 	par->mem_freq = (reg) ? 133 : 100;
 }
 
-static int __init 
+static int __devinit 
 i810_allocate_pci_resource(struct i810fb_par *par, 
 			   const struct pci_device_id *entry)
 {
@@ -1831,7 +1831,7 @@
 	return 0;
 }
 
-static int __init i810fb_init_pci (struct pci_dev *dev, 
+static int __devinit i810fb_init_pci (struct pci_dev *dev, 
 				   const struct pci_device_id *entry)
 {
 	struct fb_info    *info;
diff -Nru a/drivers/video/i810/i810_main.h b/drivers/video/i810/i810_main.h
--- a/drivers/video/i810/i810_main.h	Thu Sep 11 15:54:39 2003
+++ b/drivers/video/i810/i810_main.h	Thu Sep 11 15:54:39 2003
@@ -14,7 +14,7 @@
 #ifndef __I810_MAIN_H__
 #define __I810_MAIN_H__
 
-static int  __init i810fb_init_pci (struct pci_dev *dev, 
+static int  __devinit i810fb_init_pci (struct pci_dev *dev, 
 				       const struct pci_device_id *entry);
 static void __exit i810fb_remove_pci(struct pci_dev *dev);
 static int i810fb_resume(struct pci_dev *dev);
@@ -95,7 +95,7 @@
 
 #ifdef CONFIG_MTRR
 #define KERNEL_HAS_MTRR 1
-static inline void __init set_mtrr(struct i810fb_par *par)
+static inline void __devinit set_mtrr(struct i810fb_par *par)
 {
 	par->mtrr_reg = mtrr_add((u32) par->aperture.physical, 
 		 par->aperture.size, MTRR_TYPE_WRCOMB, 1);
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	Thu Sep 11 15:54:39 2003
+++ b/drivers/video/riva/fbdev.c	Thu Sep 11 15:54:39 2003
@@ -1576,7 +1576,7 @@
 	.fb_sync 	= rivafb_sync,
 };
 
-static int __init riva_set_fbinfo(struct fb_info *info)
+static int __devinit riva_set_fbinfo(struct fb_info *info)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
 	unsigned int cmap_len;
@@ -1726,7 +1726,7 @@
  *
  * ------------------------------------------------------------------------- */
 
-static int __init rivafb_probe(struct pci_dev *pd,
+static int __devinit rivafb_probe(struct pci_dev *pd,
 			     	const struct pci_device_id *ent)
 {
 	struct riva_chip_info *rci = &riva_chip_info[ent->driver_data];

