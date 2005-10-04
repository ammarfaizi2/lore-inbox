Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVJDGR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVJDGR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 02:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVJDGR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 02:17:26 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:15509 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932368AbVJDGRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 02:17:25 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: [RFC PATCH] pci_ids: cleanup - remove redundant #defines from source
Date: Tue, 04 Oct 2005 16:17:04 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <ih74k1d24eie62eo3ikgcme8dahl302h7q@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Appended is start of next set for pci_ids cleanup.  This time, truly :o)

RFC as the pci_ids cleanup after this patch will involve transferring 
symbols from source to pci_ids.h.  The files in this patch are part of 
a 49 file target list that contain an #ifndef, #define sequence for 
PCI_VENDOR_ID_* and PCI_DEVICE_ID_* symbols.  Remaining targets require 
a transfer of symbols to pci_ids.h, thus will be presented separately 
by areas identified from linux/MAINTAINERS.

Further information (eg. hit list) is on:
  http://bugsplatter.mine.nu/kernel/pci_ids/

Cheers,
Grant.

From: Grant Coady <gcoady@gmail.com>

This patch removes redundant #defines for symbols already defined 
within pci_ids.h, compile tested with make allmodconfig.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 drivers/atm/nicstar.h               |   12 ------------
 drivers/char/applicom.c             |    6 ------
 drivers/char/istallion.c            |    6 ------
 drivers/char/moxa.c                 |   13 -------------
 drivers/char/rio/rio_linux.c        |    4 ----
 drivers/char/stallion.c             |   16 ----------------
 drivers/media/video/cx88/cx88-reg.h |    7 -------
 drivers/pcmcia/cirrus.h             |   10 ----------
 drivers/scsi/3w-9xxx.h              |    3 ---
 drivers/scsi/cpqfcTSinit.c          |    4 ----
 drivers/scsi/gdth.h                 |    7 -------
 drivers/scsi/megaraid.h             |   32 --------------------------------
 drivers/video/pvr2fb.c              |    4 ----
 include/video/pm3fb.h               |    5 -----
 sound/oss/cs461x.h                  |   13 -------------
 sound/oss/es1370.c                  |    8 --------
 sound/oss/es1371.c                  |   20 --------------------
 sound/oss/sonicvibes.c              |    7 -------
 18 files changed, 177 deletions(-)

diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/atm/nicstar.h linux-2.6.14-rc3c/drivers/atm/nicstar.h
--- linux-2.6.14-rc3/drivers/atm/nicstar.h	2005-10-01 17:07:29.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/atm/nicstar.h	2005-10-04 10:12:05.000000000 +1000
@@ -675,18 +675,6 @@ enum ns_regs
 #endif /* ENABLE_TSQFIE */
 
 
-/* PCI stuff ******************************************************************/
-
-#ifndef PCI_VENDOR_ID_IDT
-#define PCI_VENDOR_ID_IDT 0x111D
-#endif /* PCI_VENDOR_ID_IDT */
-
-#ifndef PCI_DEVICE_ID_IDT_IDT77201
-#define PCI_DEVICE_ID_IDT_IDT77201 0x0001
-#endif /* PCI_DEVICE_ID_IDT_IDT77201 */
-
-
-
 /* Device driver structures ***************************************************/
 
 
diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/char/applicom.c linux-2.6.14-rc3c/drivers/char/applicom.c
--- linux-2.6.14-rc3/drivers/char/applicom.c	2005-10-01 17:07:29.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/char/applicom.c	2005-10-04 10:12:51.000000000 +1000
@@ -51,12 +51,6 @@
 #define LEN_RAM_IO 0x800
 #define AC_MINOR 157
 
-#ifndef PCI_VENDOR_ID_APPLICOM
-#define PCI_VENDOR_ID_APPLICOM                0x1389
-#define PCI_DEVICE_ID_APPLICOM_PCIGENERIC     0x0001
-#define PCI_DEVICE_ID_APPLICOM_PCI2000IBS_CAN 0x0002
-#define PCI_DEVICE_ID_APPLICOM_PCI2000PFB     0x0003
-#endif
 #define MAX_PCI_DEVICE_NUM 3
 
 static char *applicom_pci_devnames[] = {
diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/char/istallion.c linux-2.6.14-rc3c/drivers/char/istallion.c
--- linux-2.6.14-rc3/drivers/char/istallion.c	2005-10-01 17:07:30.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/char/istallion.c	2005-10-04 11:03:18.000000000 +1000
@@ -412,12 +412,6 @@ static int	stli_eisamempsize = sizeof(st
  *	Define the Stallion PCI vendor and device IDs.
  */
 #ifdef CONFIG_PCI
-#ifndef	PCI_VENDOR_ID_STALLION
-#define	PCI_VENDOR_ID_STALLION		0x124d
-#endif
-#ifndef PCI_DEVICE_ID_ECRA
-#define	PCI_DEVICE_ID_ECRA		0x0004
-#endif
 
 static struct pci_device_id istallion_pci_tbl[] = {
 	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECRA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/char/moxa.c linux-2.6.14-rc3c/drivers/char/moxa.c
--- linux-2.6.14-rc3/drivers/char/moxa.c	2005-10-01 17:07:30.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/char/moxa.c	2005-10-04 11:01:43.000000000 +1000
@@ -74,19 +74,6 @@
 #define MOXA_BUS_TYPE_ISA		0
 #define MOXA_BUS_TYPE_PCI		1
 
-#ifndef	PCI_VENDOR_ID_MOXA
-#define	PCI_VENDOR_ID_MOXA	0x1393
-#endif
-#ifndef PCI_DEVICE_ID_CP204J
-#define PCI_DEVICE_ID_CP204J	0x2040
-#endif
-#ifndef PCI_DEVICE_ID_C218
-#define PCI_DEVICE_ID_C218	0x2180
-#endif
-#ifndef PCI_DEVICE_ID_C320
-#define PCI_DEVICE_ID_C320	0x3200
-#endif
-
 enum {
 	MOXA_BOARD_C218_PCI = 1,
 	MOXA_BOARD_C218_ISA,
diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/char/rio/rio_linux.c linux-2.6.14-rc3c/drivers/char/rio/rio_linux.c
--- linux-2.6.14-rc3/drivers/char/rio/rio_linux.c	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/char/rio/rio_linux.c	2005-10-04 11:06:16.000000000 +1000
@@ -112,10 +112,6 @@ more than 512 ports.... */
 #define RIO_NORMAL_MAJOR1  156
 #endif
 
-#ifndef PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8
-#define PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8 0x2000
-#endif
-
 #ifndef RIO_WINDOW_LEN 
 #define RIO_WINDOW_LEN 0x10000
 #endif
diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/char/stallion.c linux-2.6.14-rc3c/drivers/char/stallion.c
--- linux-2.6.14-rc3/drivers/char/stallion.c	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/char/stallion.c	2005-10-04 11:07:46.000000000 +1000
@@ -393,22 +393,6 @@ static unsigned char	stl_vecmap[] = {
 #ifdef CONFIG_PCI
 
 /*
- *	Define the Stallion PCI vendor and device IDs.
- */
-#ifndef	PCI_VENDOR_ID_STALLION
-#define	PCI_VENDOR_ID_STALLION		0x124d
-#endif
-#ifndef PCI_DEVICE_ID_ECHPCI832
-#define	PCI_DEVICE_ID_ECHPCI832		0x0000
-#endif
-#ifndef PCI_DEVICE_ID_ECHPCI864
-#define	PCI_DEVICE_ID_ECHPCI864		0x0002
-#endif
-#ifndef PCI_DEVICE_ID_EIOPCI
-#define	PCI_DEVICE_ID_EIOPCI		0x0003
-#endif
-
-/*
  *	Define structure to hold all Stallion PCI boards.
  */
 typedef struct stlpcibrd {
diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/media/video/cx88/cx88-reg.h linux-2.6.14-rc3c/drivers/media/video/cx88/cx88-reg.h
--- linux-2.6.14-rc3/drivers/media/video/cx88/cx88-reg.h	2005-10-01 17:07:31.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/media/video/cx88/cx88-reg.h	2005-10-04 11:19:42.000000000 +1000
@@ -28,13 +28,6 @@
 /* ---------------------------------------------------------------------- */
 /* PCI IDs and config space                                               */
 
-#ifndef PCI_VENDOR_ID_CONEXANT
-# define PCI_VENDOR_ID_CONEXANT		0x14F1
-#endif
-#ifndef PCI_DEVICE_ID_CX2300_VID
-# define PCI_DEVICE_ID_CX2300_VID	0x8800
-#endif
-
 #define CX88X_DEVCTRL 0x40
 #define CX88X_EN_TBFX 0x02
 #define CX88X_EN_VSFX 0x04
diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/pcmcia/cirrus.h linux-2.6.14-rc3c/drivers/pcmcia/cirrus.h
--- linux-2.6.14-rc3/drivers/pcmcia/cirrus.h	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/pcmcia/cirrus.h	2005-10-04 11:27:30.000000000 +1000
@@ -30,16 +30,6 @@
 #ifndef _LINUX_CIRRUS_H
 #define _LINUX_CIRRUS_H
 
-#ifndef PCI_VENDOR_ID_CIRRUS
-#define PCI_VENDOR_ID_CIRRUS		0x1013
-#endif
-#ifndef PCI_DEVICE_ID_CIRRUS_6729
-#define PCI_DEVICE_ID_CIRRUS_6729	0x1100
-#endif
-#ifndef PCI_DEVICE_ID_CIRRUS_6832
-#define PCI_DEVICE_ID_CIRRUS_6832	0x1110
-#endif
-
 #define PD67_MISC_CTL_1		0x16	/* Misc control 1 */
 #define PD67_FIFO_CTL		0x17	/* FIFO control */
 #define PD67_MISC_CTL_2		0x1E	/* Misc control 2 */
diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/scsi/3w-9xxx.h linux-2.6.14-rc3c/drivers/scsi/3w-9xxx.h
--- linux-2.6.14-rc3/drivers/scsi/3w-9xxx.h	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/scsi/3w-9xxx.h	2005-10-04 11:28:52.000000000 +1000
@@ -414,9 +414,6 @@ static twa_message_type twa_error_table[
 #define TW_DRIVER TW_MESSAGE_SOURCE_LINUX_DRIVER
 #define TW_MESSAGE_SOURCE_LINUX_OS            9
 #define TW_OS TW_MESSAGE_SOURCE_LINUX_OS
-#ifndef PCI_DEVICE_ID_3WARE_9000
-#define PCI_DEVICE_ID_3WARE_9000 0x1002
-#endif
 
 /* Bitmask macros to eliminate bitfields */
 
diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/scsi/cpqfcTSinit.c linux-2.6.14-rc3c/drivers/scsi/cpqfcTSinit.c
--- linux-2.6.14-rc3/drivers/scsi/cpqfcTSinit.c	2005-10-01 17:07:33.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/scsi/cpqfcTSinit.c	2005-10-04 11:29:30.000000000 +1000
@@ -266,10 +266,6 @@ static void launch_FCworker_thread(struc
  */
 #define HBA_TYPES 3
 
-#ifndef PCI_DEVICE_ID_COMPAQ_
-#define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc
-#endif
-
 static struct SupportedPCIcards cpqfc_boards[] __initdata = {
 	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TACHYON},
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_TACHLITE},
diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/scsi/gdth.h linux-2.6.14-rc3c/drivers/scsi/gdth.h
--- linux-2.6.14-rc3/drivers/scsi/gdth.h	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/scsi/gdth.h	2005-10-04 15:56:33.000000000 +1000
@@ -51,13 +51,6 @@
 #define GDT2_ID         0x0120941c              /* GDT2000/2020 */
 
 /* vendor ID, device IDs (PCI) */
-/* these defines should already exist in <linux/pci.h> */
-#ifndef PCI_VENDOR_ID_VORTEX
-#define PCI_VENDOR_ID_VORTEX            0x1119  /* PCI controller vendor ID */
-#endif
-#ifndef PCI_VENDOR_ID_INTEL
-#define PCI_VENDOR_ID_INTEL             0x8086  
-#endif
 
 #ifndef PCI_DEVICE_ID_VORTEX_GDT60x0
 /* GDT_PCI */
diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/scsi/megaraid.h linux-2.6.14-rc3c/drivers/scsi/megaraid.h
--- linux-2.6.14-rc3/drivers/scsi/megaraid.h	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/scsi/megaraid.h	2005-10-04 11:35:22.000000000 +1000
@@ -45,38 +45,6 @@
 
 #define MAX_DEV_TYPE	32
 
-#ifndef PCI_VENDOR_ID_LSI_LOGIC
-#define PCI_VENDOR_ID_LSI_LOGIC		0x1000
-#endif
-
-#ifndef PCI_VENDOR_ID_AMI
-#define PCI_VENDOR_ID_AMI		0x101E
-#endif
-
-#ifndef PCI_VENDOR_ID_DELL
-#define PCI_VENDOR_ID_DELL		0x1028
-#endif
-
-#ifndef PCI_VENDOR_ID_INTEL
-#define PCI_VENDOR_ID_INTEL		0x8086
-#endif
-
-#ifndef PCI_DEVICE_ID_AMI_MEGARAID
-#define PCI_DEVICE_ID_AMI_MEGARAID	0x9010
-#endif
-
-#ifndef PCI_DEVICE_ID_AMI_MEGARAID2
-#define PCI_DEVICE_ID_AMI_MEGARAID2	0x9060
-#endif
-
-#ifndef PCI_DEVICE_ID_AMI_MEGARAID3
-#define PCI_DEVICE_ID_AMI_MEGARAID3	0x1960
-#endif
-
-#define PCI_DEVICE_ID_DISCOVERY		0x000E
-#define PCI_DEVICE_ID_PERC4_DI		0x000F
-#define PCI_DEVICE_ID_PERC4_QC_VERDE	0x0407
-
 /* Sub-System Vendor IDs */
 #define	AMI_SUBSYS_VID			0x101E
 #define DELL_SUBSYS_VID			0x1028
diff -X dontdiff -Nrup linux-2.6.14-rc3/drivers/video/pvr2fb.c linux-2.6.14-rc3c/drivers/video/pvr2fb.c
--- linux-2.6.14-rc3/drivers/video/pvr2fb.c	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc3c/drivers/video/pvr2fb.c	2005-10-04 11:37:42.000000000 +1000
@@ -78,10 +78,6 @@
 #include <asm/cpu/sq.h>
 #endif
 
-#ifndef PCI_DEVICE_ID_NEC_NEON250
-#  define PCI_DEVICE_ID_NEC_NEON250	0x0067
-#endif
-
 /* 2D video registers */
 #define DISP_BASE	par->mmio_base
 #define DISP_BRDRCOLR (DISP_BASE + 0x40)
diff -X dontdiff -Nrup linux-2.6.14-rc3/include/video/pm3fb.h linux-2.6.14-rc3c/include/video/pm3fb.h
--- linux-2.6.14-rc3/include/video/pm3fb.h	2005-10-01 17:07:42.000000000 +1000
+++ linux-2.6.14-rc3c/include/video/pm3fb.h	2005-10-04 11:40:34.000000000 +1000
@@ -1122,11 +1122,6 @@
 /* permedia3 -specific definitions */
 #define PM3_SCALE_TO_CLOCK(pr, fe, po) ((2 * PM3_REF_CLOCK * fe) / (pr * (1 << (po))))
 
-/* in case it's not in linux/pci.h */
-#ifndef PCI_DEVICE_ID_3DLABS_PERMEDIA3
-#define PCI_DEVICE_ID_3DLABS_PERMEDIA3 0x000a
-#endif
-
 /* max number of simultaneous board */
 /* warning : make sure module array def's are coherent with PM3_MAX_BOARD */
 #define PM3_MAX_BOARD 4
diff -X dontdiff -Nrup linux-2.6.14-rc3/sound/oss/cs461x.h linux-2.6.14-rc3c/sound/oss/cs461x.h
--- linux-2.6.14-rc3/sound/oss/cs461x.h	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc3c/sound/oss/cs461x.h	2005-10-04 11:41:51.000000000 +1000
@@ -23,19 +23,6 @@
  *
  */
 
-#ifndef PCI_VENDOR_ID_CIRRUS
-#define PCI_VENDOR_ID_CIRRUS            0x1013
-#endif
-#ifndef PCI_DEVICE_ID_CIRRUS_4610
-#define PCI_DEVICE_ID_CIRRUS_4610       0x6001
-#endif
-#ifndef PCI_DEVICE_ID_CIRRUS_4612
-#define PCI_DEVICE_ID_CIRRUS_4612       0x6003
-#endif
-#ifndef PCI_DEVICE_ID_CIRRUS_4615
-#define PCI_DEVICE_ID_CIRRUS_4615       0x6004
-#endif
-
 /*
  *  Direct registers
  */
diff -X dontdiff -Nrup linux-2.6.14-rc3/sound/oss/es1370.c linux-2.6.14-rc3c/sound/oss/es1370.c
--- linux-2.6.14-rc3/sound/oss/es1370.c	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc3c/sound/oss/es1370.c	2005-10-04 11:42:49.000000000 +1000
@@ -174,14 +174,6 @@
 
 /* --------------------------------------------------------------------- */
 
-#ifndef PCI_VENDOR_ID_ENSONIQ
-#define PCI_VENDOR_ID_ENSONIQ        0x1274    
-#endif
-
-#ifndef PCI_DEVICE_ID_ENSONIQ_ES1370
-#define PCI_DEVICE_ID_ENSONIQ_ES1370 0x5000
-#endif
-
 #define ES1370_MAGIC  ((PCI_VENDOR_ID_ENSONIQ<<16)|PCI_DEVICE_ID_ENSONIQ_ES1370)
 
 #define ES1370_EXTENT             0x40
diff -X dontdiff -Nrup linux-2.6.14-rc3/sound/oss/es1371.c linux-2.6.14-rc3c/sound/oss/es1371.c
--- linux-2.6.14-rc3/sound/oss/es1371.c	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc3c/sound/oss/es1371.c	2005-10-04 11:43:41.000000000 +1000
@@ -147,26 +147,6 @@
 
 /* --------------------------------------------------------------------- */
 
-#ifndef PCI_VENDOR_ID_ENSONIQ
-#define PCI_VENDOR_ID_ENSONIQ        0x1274    
-#endif
-
-#ifndef PCI_VENDOR_ID_ECTIVA
-#define PCI_VENDOR_ID_ECTIVA         0x1102
-#endif
-
-#ifndef PCI_DEVICE_ID_ENSONIQ_ES1371
-#define PCI_DEVICE_ID_ENSONIQ_ES1371 0x1371
-#endif
-
-#ifndef PCI_DEVICE_ID_ENSONIQ_CT5880
-#define PCI_DEVICE_ID_ENSONIQ_CT5880 0x5880
-#endif
-
-#ifndef PCI_DEVICE_ID_ECTIVA_EV1938
-#define PCI_DEVICE_ID_ECTIVA_EV1938 0x8938
-#endif
-
 /* ES1371 chip ID */
 /* This is a little confusing because all ES1371 compatible chips have the
    same DEVICE_ID, the only thing differentiating them is the REV_ID field.
diff -X dontdiff -Nrup linux-2.6.14-rc3/sound/oss/sonicvibes.c linux-2.6.14-rc3c/sound/oss/sonicvibes.c
--- linux-2.6.14-rc3/sound/oss/sonicvibes.c	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc3c/sound/oss/sonicvibes.c	2005-10-04 11:47:00.000000000 +1000
@@ -132,13 +132,6 @@
 
 /* --------------------------------------------------------------------- */
 
-#ifndef PCI_VENDOR_ID_S3
-#define PCI_VENDOR_ID_S3             0x5333
-#endif
-#ifndef PCI_DEVICE_ID_S3_SONICVIBES
-#define PCI_DEVICE_ID_S3_SONICVIBES  0xca00
-#endif
-
 #define SV_MAGIC  ((PCI_VENDOR_ID_S3<<16)|PCI_DEVICE_ID_S3_SONICVIBES)
 
 #define SV_EXTENT_SB      0x10
