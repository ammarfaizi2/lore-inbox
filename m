Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTDYPBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 11:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbTDYPBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 11:01:19 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12161 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263279AbTDYPBM (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 11:01:12 -0400
Message-Id: <200304251513.h3PFDNQd005345@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk3 #if cleanups part 2 (2/2)
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 Apr 2003 11:13:23 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.. This one's actually cleaning up uses of LINUX_VERSION_CODE. I'm
surprised this actually worked - as written, these two wouldn't have been
including either version of spinlock.h.   The patches are large mostly
because I replaced the local LinuxVersionCode macro with the version.h
macro - the important part is the move of the include of version.h to
before the first use of LINUX_VERSION_CODE...

If I'm fixing dead code, please tell me so we can expunge it instead.. ;)

--- linux-2.5.68-bk3/drivers/scsi/sym53c8xx.c.dist	2003-04-22 13:57:07.000000000 -0400
+++ linux-2.5.68-bk3/drivers/scsi/sym53c8xx.c	2003-04-23 03:17:14.324402801 -0400
@@ -99,16 +99,16 @@
 **==========================================================
 */
 
-#define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
+#include <linux/version.h>
 
 #include <linux/module.h>
 
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,17)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,17)
 #include <linux/spinlock.h>
-#elif LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,93)
 #include <asm/spinlock.h>
 #endif
 #include <linux/delay.h>
@@ -123,10 +123,9 @@
 #include <linux/timer.h>
 #include <linux/stat.h>
 
-#include <linux/version.h>
 #include <linux/blk.h>
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,35)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,35)
 #include <linux/init.h>
 #endif
 
@@ -137,7 +136,7 @@
 #define	__initdata
 #endif
 
-#if LINUX_VERSION_CODE <= LinuxVersionCode(2,1,92)
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,1,92)
 #include <linux/bios32.h>
 #endif
 
@@ -170,7 +169,7 @@
 **	Donnot compile integrity checking code for Linux-2.3.0 
 **	and above since SCSI data structures are not ready yet.
 */
-/* #if LINUX_VERSION_CODE < LinuxVersionCode(2,3,0) */
+/* #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0) */
 #if 0
 #define	SCSI_NCR_INTEGRITY_CHECKING
 #endif
@@ -183,7 +182,7 @@
 **	despite the fact that the PCI specifications are looking 
 **	so smart and simple! ;-)
 */
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,47)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,47)
 #define SCSI_NCR_DYNAMIC_DMA_MAPPING
 #endif
 
@@ -439,7 +438,7 @@
 **	code.
 */
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,2,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
 
 typedef struct pci_dev *pcidev_t;
 #define PCIDEV_NULL		(0)
@@ -454,7 +453,7 @@
 {
 	u_long base;
 
-#if LINUX_VERSION_CODE > LinuxVersionCode(2,3,12)
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,12)
 	base = pdev->resource[index].start;
 #else
 	base = pdev->base_address[index];
@@ -574,13 +573,13 @@
 	return base;
 }
 
-#endif	/* LINUX_VERSION_CODE >= LinuxVersionCode(2,2,0) */
+#endif	/* LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0) */
 
 /* Does not make sense in earlier kernels */
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,4,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
 #define pci_enable_device(pdev)		(0)
 #endif
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,4,4)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
 #define	scsi_set_pci_device(inst, pdev)	(0)
 #endif
 
@@ -630,7 +629,7 @@
 **	  wished (e.g.: threaded by controller).
 */
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,93)
 
 spinlock_t sym53c8xx_lock = SPIN_LOCK_UNLOCKED;
 #define	NCR_LOCK_DRIVER(flags)     spin_lock_irqsave(&sym53c8xx_lock, flags)
@@ -670,7 +669,7 @@
 **	architecture.
 */
 
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,1,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0)
 #define ioremap vremap
 #define iounmap vfree
 #endif
@@ -713,7 +712,7 @@
 **	inaccurate on Pentium processors.
 */
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,105)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,105)
 #define UDELAY udelay
 #define MDELAY mdelay
 #else
@@ -735,7 +734,7 @@
 **	real bus astraction, btw).
 */
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,0)
 #define __GetFreePages(flags, order) __get_free_pages(flags, order)
 #else
 #define __GetFreePages(flags, order) __get_free_pages(flags, order, 0)
@@ -1282,7 +1281,7 @@
 /*
 **	/proc directory entry and proc_info function
 */
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,3,27)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,27)
 static struct proc_dir_entry proc_scsi_sym53c8xx = {
     PROC_SCSI_SYM53C8XX, 9, NAME53C8XX,
     S_IFDIR | S_IRUGO | S_IXUGO, 2
@@ -1307,7 +1306,7 @@
 	driver_safe_setup __initdata	= SCSI_NCR_DRIVER_SAFE_SETUP;
 # ifdef	MODULE
 char *sym53c8xx = 0;	/* command line passed by insmod */
-#  if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,30)
+#  if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,30)
 MODULE_PARM(sym53c8xx, "s");
 #  endif
 # endif
@@ -2026,7 +2025,7 @@
 					/*  when lcb is not allocated.	*/
 	Scsi_Cmnd	*done_list;	/* Commands waiting for done()  */
 					/* callback to be invoked.      */ 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,93)
 	spinlock_t	smp_lock;	/* Lock for SMP threading       */
 #endif
 
@@ -5843,7 +5842,7 @@
 			((driver_setup.irqm & 0x20) ? 0 : SA_INTERRUPT),
 #else
 			((driver_setup.irqm & 0x10) ? 0 : SA_SHIRQ) |
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,2,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,0)
 			((driver_setup.irqm & 0x20) ? 0 : SA_INTERRUPT),
 #else
 			0,
@@ -5907,7 +5906,7 @@
 	instance->max_id	= np->maxwide ? 16 : 8;
 	instance->max_lun	= MAX_LUN;
 #ifndef SCSI_NCR_IOMAPPED
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,29)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,29)
 	instance->base		= (unsigned long) np->reg;
 #else
 	instance->base		= (char *) np->reg;
@@ -7406,7 +7405,7 @@
 		}
 	}
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,99)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,99)
 	/*
 	**	Move residual byte count to user structure.
 	*/
@@ -12774,7 +12773,7 @@
 	return 1;
 }
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,13)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,13)
 #ifndef MODULE
 __setup("sym53c8xx=", sym53c8xx_setup);
 #endif
@@ -12915,7 +12914,7 @@
 	**    Initialize driver general stuff.
 	*/
 #ifdef SCSI_NCR_PROC_INFO_SUPPORT
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,3,27)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,27)
      tpnt->proc_dir  = &proc_scsi_sym53c8xx;
 #else
      tpnt->proc_name = NAME53C8XX;
@@ -13244,7 +13243,7 @@
 		pci_write_config_word(pdev, PCI_COMMAND, command);
 	}
 
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,2,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,0)
 	if ( is_prep ) {
 		if (io_port >= 0x10000000) {
 			printk(NAME53C8XX ": reallocating io_port (Wacky IBM)");
@@ -13270,7 +13269,7 @@
 
 #if defined(__i386__) && !defined(MODULE)
 	if (!cache_line_size) {
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,1,75)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,75)
 		extern char x86;
 		switch(x86) {
 #else
@@ -14719,10 +14718,10 @@
 
 MODULE_LICENSE("GPL");
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static
 #endif
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0) || defined(MODULE)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0) || defined(MODULE)
 Scsi_Host_Template driver_template = SYM53C8XX;
 #include "scsi_module.c"
 #endif
--- linux-2.5.68-bk3/drivers/scsi/ncr53c8xx.c.dist	2003-04-07 13:30:59.000000000 -0400
+++ linux-2.5.68-bk3/drivers/scsi/ncr53c8xx.c	2003-04-23 03:18:40.331499478 -0400
@@ -115,15 +115,15 @@
 **==========================================================
 */
 
-#define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
+#include <linux/version.h>
 
 #include <linux/module.h>
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,17)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,17)
 #include <linux/spinlock.h>
-#elif LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,93)
 #include <asm/spinlock.h>
 #endif
 #include <linux/delay.h>
@@ -140,10 +140,9 @@
 #include <linux/timer.h>
 #include <linux/stat.h>
 
-#include <linux/version.h>
 #include <linux/blk.h>
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,35)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,35)
 #include <linux/init.h>
 #endif
 
@@ -154,7 +153,7 @@
 #define	__initdata
 #endif
 
-#if LINUX_VERSION_CODE <= LinuxVersionCode(2,1,92)
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,1,92)
 #include <linux/bios32.h>
 #endif
 
@@ -205,7 +204,7 @@
 **	Donnot compile integrity checking code for Linux-2.3.0 
 **	and above since SCSI data structures are not ready yet.
 */
-/* #if LINUX_VERSION_CODE < LinuxVersionCode(2,3,0) */
+/* #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0) */
 #if 0
 #define	SCSI_NCR_INTEGRITY_CHECKING
 #endif
@@ -1049,7 +1048,7 @@
 					/*  when lcb is not allocated.	*/
 	Scsi_Cmnd	*done_list;	/* Commands waiting for done()  */
 					/* callback to be invoked.      */ 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,93)
 	spinlock_t	smp_lock;	/* Lock for SMP threading       */
 #endif
 
@@ -3816,7 +3815,7 @@
 	instance->max_id	= np->maxwide ? 16 : 8;
 	instance->max_lun	= SCSI_NCR_MAX_LUN;
 #ifndef SCSI_NCR_IOMAPPED
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,29)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,29)
 	instance->base		= (unsigned long) np->reg;
 #else
 	instance->base		= (char *) np->reg;
@@ -3901,7 +3900,7 @@
 
 	if (request_irq(device->slot.irq, ncr53c8xx_intr,
 			((driver_setup.irqm & 0x10) ? 0 : SA_SHIRQ) |
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,2,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,0)
 			((driver_setup.irqm & 0x20) ? 0 : SA_INTERRUPT),
 #else
 			0,
@@ -9335,7 +9334,7 @@
 **
 **==========================================================
 */
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,3,27)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,27)
 static struct proc_dir_entry proc_scsi_ncr53c8xx = {
     PROC_SCSI_NCR53C8XX, 9, NAME53C8XX,
     S_IFDIR | S_IRUGO | S_IXUGO, 2
@@ -9350,7 +9349,7 @@
 */
 #ifdef	MODULE
 char *ncr53c8xx = 0;	/* command line passed by insmod */
-# if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,30)
+# if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,30)
 MODULE_PARM(ncr53c8xx, "s");
 # endif
 #endif
@@ -9360,7 +9359,7 @@
 	return sym53c8xx__setup(str);
 }
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,13)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,13)
 #ifndef MODULE
 __setup("ncr53c8xx=", ncr53c8xx_setup);
 #endif
@@ -9469,7 +9468,7 @@
 	**    Initialize driver general stuff.
 	*/
 #ifdef SCSI_NCR_PROC_INFO_SUPPORT
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,3,27)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,27)
      tpnt->proc_dir  = &proc_scsi_ncr53c8xx;
 #else
      tpnt->proc_name = NAME53C8XX;
@@ -9502,10 +9501,10 @@
 */
 MODULE_LICENSE("GPL");
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static
 #endif
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0) || defined(MODULE)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0) || defined(MODULE)
 #ifdef ENABLE_SCSI_ZALON
 Scsi_Host_Template driver_template =  {
 	.proc_name =		"zalon720",


