Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUEFODi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUEFODi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 10:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUEFODh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 10:03:37 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:48777 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S261851AbUEFNzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:55:08 -0400
Message-ID: <409A43A5.5040109@superonline.com>
Date: Thu, 06 May 2004 16:54:45 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27-pre2-pac1
Content-Type: multipart/mixed;
 boundary="------------070800060607030707000509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070800060607030707000509
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit

Hello:

You may want to apply the attached patch which
removes double/obsolete entries, makes some minor
name clarifications.

Regards;
Özkan Sezer

--------------070800060607030707000509
Content-Type: text/plain;
 name="27p2pac1-cleanup1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="27p2pac1-cleanup1.patch"

diff -urN 27p2.pac/Documentation/Configure.help 27p2.acx/Documentation/Configure.help
--- 27p2.pac/Documentation/Configure.help
+++ 27p2.acx/Documentation/Configure.help
@@ -12532,18 +12532,6 @@
   <file:Documentation/networking/net-modules.txt>.  The module will be
   called forcedeth.o.
 
-Reverse Engineered nForce Ethernet support (EXPERIMENTAL)
-CONFIG_FORCEDETH
-  If you have a network (Ethernet) controller of this type, say Y and
-  read the Ethernet-HOWTO, available from
-  <http://www.tldp.org/docs.html#howto>.
-
-  If you want to compile this as a module ( = code which can be
-  inserted in and removed from the running kernel whenever you want),
-  say M here and read <file:Documentation/modules.txt> as well as
-  <file:Documentation/networking/net-modules.txt>.  The module will be
-  called forcedeth.
-
 CS89x0 support (Daynaport CS and LC cards)
 CONFIG_CS89x0
   Support for CS89x0 chipset based Ethernet cards. If you have a

diff -urN 27p2.pac/drivers/ide/pci/atiixp.c 27p2.acx/drivers/ide/pci/atiixp.c
--- 27p2.pac/drivers/ide/pci/atiixp.c
+++ 27p2.acx/drivers/ide/pci/atiixp.c
@@ -519,4 +519,6 @@
 MODULE_DESCRIPTION("PCI driver module for ATI IXP IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
+
 EXPORT_NO_SYMBOLS;

diff -urN 27p2.pac/drivers/ide/pci/piix.h 27p2.acx/drivers/ide/pci/piix.h
--- 27p2.pac/drivers/ide/pci/piix.h
+++ 27p2.acx/drivers/ide/pci/piix.h
@@ -333,20 +333,6 @@
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
-	},{	/* 19 */
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_ESB_2,
-		.name		= "ESB",
-		.init_setup	= init_setup_piix,
-		.init_chipset	= init_chipset_piix,
-		.init_iops	= NULL,
-		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
-		.bootable	= ON_BOARD,
-		.extra		= 0,
 	},{
 		.vendor		= 0,
 		.device		= 0,

diff -urN 27p2.pac/drivers/scsi/Config.in 27p2.acx/drivers/scsi/Config.in
--- 27p2.pac/drivers/scsi/Config.in
+++ 27p2.acx/drivers/scsi/Config.in
@@ -40,11 +40,6 @@
    dep_tristate 'DEC SII Scsi Driver' CONFIG_SCSI_DECSII $CONFIG_SCSI $CONFIG_MIPS32
 fi
 
-dep_mbool 'SATA support' CONFIG_SCSI_ATA $CONFIG_SCSI
-#dep_bool '  Parallel ATA support' CONFIG_SCSI_ATA_PATA $CONFIG_SCSI_ATA
-dep_tristate '  Intel PIIX/ICH support' CONFIG_SCSI_ATA_PIIX $CONFIG_SCSI_ATA $CONFIG_PCI
-dep_tristate '  VIA SATA support' CONFIG_SCSI_SATA_VIA $CONFIG_SCSI_ATA $CONFIG_PCI
-
 if [ "$CONFIG_PCI" = "y" ]; then
    dep_tristate '3ware Hardware ATA-RAID support' CONFIG_BLK_DEV_3W_XXXX_RAID $CONFIG_SCSI
 fi

diff -urN 27p2.pac/fs/ext2/inode.c 27p2.acx/fs/ext2/inode.c
--- 27p2.pac/fs/ext2/inode.c
+++ 27p2.acx/fs/ext2/inode.c
@@ -813,8 +813,6 @@
 		return;
 	if (ext2_inode_is_fast_symlink(inode))
 		return;
-	if (ext2_inode_is_fast_symlink(inode))
-		return;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
 

diff -urN 27p2.pac/fs/ext3/inode.c 27p2.acx/fs/ext3/inode.c
--- 27p2.pac/fs/ext3/inode.c
+++ 27p2.acx/fs/ext3/inode.c
@@ -1884,8 +1884,6 @@
 		return;
 	if (ext3_inode_is_fast_symlink(inode))
 		return;
-	if (ext3_inode_is_fast_symlink(inode))
-		return;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
 

diff -urN 27p2.pac/drivers/scsi/pcmcia/Makefile 27p2.acx/drivers/scsi/pcmcia/Makefile
--- 27p2.pac/drivers/scsi/pcmcia/Makefile
+++ 27p2.acx/drivers/scsi/pcmcia/Makefile
@@ -22,9 +22,9 @@
 obj-$(CONFIG_PCMCIA_NINJA_SCSI)	+= nsp_cs.o
 
 list-multi	:= qlogic_cs.o fdomain_cs.o aha152x_cs.o
-aha152x_cs-objs	:= aha152x.o
-fdomain_cs-objs	:= fdomain.o
-qlogic_cs-objs	:= qlogicfas.o
+aha152x_cs-objs	:= aha152x_stub.o aha152x.o
+fdomain_cs-objs	:= fdomain_stub.o fdomain.o
+qlogic_cs-objs	:= qlogic_stub.o qlogicfas.o
 
 include $(TOPDIR)/Rules.make
 

diff -urN 27p2.pac/drivers/char/drm/r128_state.c 27p2.acx/drivers/char/drm/r128_state.c
--- 27p2.pac/drivers/char/drm/r128_state.c
+++ 27p2.acx/drivers/char/drm/r128_state.c
@@ -1025,7 +1025,7 @@
 
 	count = depth->n;
 
-	if ( count > 4096 || count <= 0 )
+	if ( count > 4096 || count <= 0)
 		return DRM_ERR(EMSGSIZE);
 
 	xbuf_size = count * sizeof(*x);
@@ -1191,7 +1191,7 @@
 
 	count = depth->n;
 	if ( count > 4096 || count <= 0)
-		return -EMSGSIZE;
+		return DRM_ERR(EMSGSIZE);
 
 	if ( count > dev_priv->depth_pitch ) {
 		count = dev_priv->depth_pitch;

diff -urN 27p2.pac/drivers/char/drm/drmP.h 27p2.acx/drivers/char/drm/drmP.h
--- 27p2.pac/drivers/char/drm/drmP.h
+++ 27p2.acx/drivers/char/drm/drmP.h
@@ -54,7 +54,6 @@
 #include <linux/version.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>	/* For (un)lock_kernel */
-#include <asm/system.h>	/* for cmpxchg() */
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #if defined(__alpha__) || defined(__powerpc__)
@@ -120,79 +119,9 @@
 #define __REALLY_HAVE_AGP	(__HAVE_AGP && (defined(CONFIG_AGP) || \
 						defined(CONFIG_AGP_MODULE)))
 #define __REALLY_HAVE_MTRR	(__HAVE_MTRR && defined(CONFIG_MTRR))
+#define __REALLY_HAVE_SG	(__HAVE_SG)
 
 
-				/* Generic cmpxchg added in 2.3.x */
-#ifndef __HAVE_ARCH_CMPXCHG
-				/* Include this here so that driver can be
-                                   used with older kernels. */
-#if defined(__alpha__)
-static __inline__ unsigned long
-__cmpxchg_u32(volatile int *m, int old, int new)
-{
-	unsigned long prev, cmp;
-
-	__asm__ __volatile__(
-	"1:	ldl_l %0,%2\n"
-	"	cmpeq %0,%3,%1\n"
-	"	beq %1,2f\n"
-	"	mov %4,%1\n"
-	"	stl_c %1,%2\n"
-	"	beq %1,3f\n"
-	"2:	mb\n"
-	".subsection 2\n"
-	"3:	br 1b\n"
-	".previous"
-	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
-	: "r"((long) old), "r"(new), "m"(*m));
-
-	return prev;
-}
-
-static __inline__ unsigned long
-__cmpxchg_u64(volatile long *m, unsigned long old, unsigned long new)
-{
-	unsigned long prev, cmp;
-
-	__asm__ __volatile__(
-	"1:	ldq_l %0,%2\n"
-	"	cmpeq %0,%3,%1\n"
-	"	beq %1,2f\n"
-	"	mov %4,%1\n"
-	"	stq_c %1,%2\n"
-	"	beq %1,3f\n"
-	"2:	mb\n"
-	".subsection 2\n"
-	"3:	br 1b\n"
-	".previous"
-	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
-	: "r"((long) old), "r"(new), "m"(*m));
-
-	return prev;
-}
-
-static __inline__ unsigned long
-__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
-{
-	switch (size) {
-		case 4:
-			return __cmpxchg_u32(ptr, old, new);
-		case 8:
-			return __cmpxchg_u64(ptr, old, new);
-	}
-	return old;
-}
-#define cmpxchg(ptr,o,n)						 \
-  ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
-     __typeof__(*(ptr)) _n_ = (n);					 \
-     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
-				    (unsigned long)_n_, sizeof(*(ptr))); \
-  })
-
-#endif /* alpha */
-#endif
-#define __REALLY_HAVE_SG	(__HAVE_SG)
 
 /* Begin the DRM...
  */

diff -urN 27p2.pac/drivers/usb/storage/unusual_devs.h 27p2.acx/drivers/usb/storage/unusual_devs.h
--- 27p2.pac/drivers/usb/storage/unusual_devs.h
+++ 27p2.acx/drivers/usb/storage/unusual_devs.h
@@ -491,10 +491,10 @@
 		US_FL_IGNORE_SER ),
 
 UNUSUAL_DEV(  0x0781, 0x0100, 0x0100, 0x0100,
-                "Sandisk",
-                "ImageMate SDDR-12",
-                US_SC_SCSI, US_PR_CB, NULL,
-                US_FL_SINGLE_LUN ),
+		"Sandisk",
+		"ImageMate SDDR-12",
+		US_SC_SCSI, US_PR_CB, NULL,
+		US_FL_SINGLE_LUN ),
 
 #ifdef CONFIG_USB_STORAGE_SDDR09
 UNUSUAL_DEV(  0x0781, 0x0200, 0x0000, 0x9999, 

diff -urN 27p2.pac/drivers/usb/Config.in 27p2.acx/drivers/usb/Config.in
--- 27p2.pac/drivers/usb/Config.in
+++ 27p2.acx/drivers/usb/Config.in
@@ -28,7 +28,7 @@
          comment '  USB Bluetooth can only be used with disabled Bluetooth subsystem'
       fi
    fi
-   dep_tristate '  USB DFU support' CONFIG_USB_DFU $CONFIG_USB
+   dep_tristate '  USB Device Firmware Upgrade (DFU) support' CONFIG_USB_DFU $CONFIG_USB
    dep_tristate '  USB MIDI support' CONFIG_USB_MIDI $CONFIG_USB $CONFIG_SOUND
    if [ "$CONFIG_SCSI" = "n" ]; then
       comment '  SCSI support is needed for USB Storage'

diff -urN 27p2.pac/drivers/usb/atmel/README 27p2.acx/drivers/usb/atmel/README
--- 27p2.pac/drivers/usb/atmel/README
+++ 27p2.acx/drivers/usb/atmel/README
@@ -181,12 +181,3 @@
 Oliver Kurth <oku@masqmail.cx>, Mon,  6 Jan 2003 22:39:47 +0100
 updated by Joerg Albert, Thu, 1 May 2003 and later
 
-
-
-
-
-
-
-
-
-

diff -urN 27p2.pac/arch/i386/kernel/i386_ksyms.c 27p2.acx/arch/i386/kernel/i386_ksyms.c
--- 27p2.pac/arch/i386/kernel/i386_ksyms.c
+++ 27p2.acx/arch/i386/kernel/i386_ksyms.c
@@ -133,7 +133,9 @@
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(kernel_flag_cacheline);
 EXPORT_SYMBOL(smp_num_cpus);
+EXPORT_SYMBOL(smp_num_siblings);
 EXPORT_SYMBOL(cpu_online_map);
+EXPORT_SYMBOL_GPL(cpu_sibling_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
 EXPORT_SYMBOL_NOVERS(__read_lock_failed);
 

diff -urN 27p2.pac/Documentation/Configure.help 27p2.acx/Documentation/Configure.help
--- 27p2.pac/Documentation/Configure.help
+++ 27p2.acx/Documentation/Configure.help
@@ -1336,8 +1336,8 @@
   not match, the driver attempts to do dynamic tuning of the chipset
   at boot-time for max speed.  Ultra33 BIOS 1.25 or newer is required
   for more than one card. This card may require that you say Y to
-  "Special UDMA Feature" to force UDMA mode for connected UDMA capable
-  disk drives.
+  "Special UDMA Feature" (or "Override-Enable UDMA for Promise Contr.")
+  to force UDMA mode for connected UDMA capable disk drives.
 
   If you say Y here, you need to say Y to "Use DMA by default when
   available" as well.

--------------070800060607030707000509--

