Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752309AbWCPKEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbWCPKEP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbWCPKEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:04:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13021 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752018AbWCPKEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:04:14 -0500
Message-Id: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
Subject: [patch 1/1] consolidate TRUE and FALSE
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, aia21@cantab.net, len.brown@intel.com
From: akpm@osdl.org
Date: Thu, 16 Mar 2006 02:01:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andrew Morton <akpm@osdl.org>

We have no less than 65 implementations of TRUE and FALSE in the tree, so the
inevitable happened:

In file included from drivers/pci/hotplug/ibmphp_core.c:40:
drivers/pci/hotplug/ibmphp.h:409:1: warning: "FALSE" redefined
In file included from include/acpi/acpi.h:55,
                 from drivers/pci/hotplug/pci_hotplug.h:187,
                 from drivers/pci/hotplug/ibmphp.h:33,
                 from drivers/pci/hotplug/ibmphp_core.c:40:
include/acpi/actypes.h:336:1: warning: this is the location of the previous definition

The patch implements TRUE and FALSE in include/linux/kernel.h and removes all
the private versions.

The patch also kills off a few private implementations of NULL.


Note that the patch also removes TRUE, FALSE and NULL from
include/acpi/actypes.h.  If this breaks ACPi on non-linux builds I'd suggest
that these things should be implemented in an OS-specific ACPI header, not in
a generic one.  Because this OS now provides TRUE and FALSE and NULL.


Various places are doing things like

typedef {
	FALSE,
	TRUE
} my_fave_name_for_a_bool;

These are converted to

typedef int my_fave_name_for_a_bool;


Cc: "Brown, Len" <len.brown@intel.com>
Cc: Anton Altaparmakov <aia21@cantab.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/mtrr.txt                 |    5 -----
 arch/alpha/kernel/smc37c669.c          |    7 -------
 arch/arm/nwfpe/milieu.h                |    9 ---------
 arch/arm26/nwfpe/milieu.h              |    9 ---------
 arch/i386/kernel/cpu/mtrr/mtrr.h       |    5 -----
 arch/mips/ite-boards/generic/lpc.c     |    8 --------
 arch/parisc/math-emu/float.h           |    2 --
 arch/ppc/4xx_io/serial_sicc.c          |    7 -------
 arch/ppc/boot/common/misc-common.c     |    7 ++-----
 arch/ppc/boot/simple/rw4/stb.h         |   11 -----------
 drivers/block/z2ram.c                  |    3 ---
 drivers/char/ftape/compressor/lzrw3.h  |    3 ---
 drivers/char/mwave/smapi.h             |    2 --
 drivers/char/rio/rio.h                 |    7 -------
 drivers/char/rio/sam.h                 |    7 -------
 drivers/input/joystick/iforce/iforce.h |    3 ---
 drivers/isdn/hardware/eicon/platform.h |   12 ------------
 drivers/isdn/hisax/hfc_usb.h           |    4 ----
 drivers/media/radio/radio-gemtek-pci.c |    8 --------
 drivers/media/video/cx88/cx88.h        |    6 ------
 drivers/media/video/saa5246a.h         |    5 -----
 drivers/media/video/saa5249.c          |    5 -----
 drivers/media/video/saa7134/saa7134.h  |    6 ------
 drivers/net/3c505.c                    |   15 ---------------
 drivers/net/8139cp.c                   |    5 -----
 drivers/net/dm9000.c                   |    3 ---
 drivers/net/e1000/e1000_osdep.h        |    7 +------
 drivers/net/ixgb/ixgb_osdep.h          |    7 +------
 drivers/net/oaknet.c                   |    8 --------
 drivers/net/s2io.h                     |    5 -----
 drivers/net/skfp/h/targetos.h          |    3 ---
 drivers/net/tlan.h                     |    3 ---
 drivers/net/tokenring/ibmtr.c          |    3 ---
 drivers/net/tulip/de4x5.h              |    3 ---
 drivers/net/wireless/strip.c           |    2 --
 drivers/net/wireless/wavelan_cs.h      |    3 ---
 drivers/pci/hotplug/ibmphp.h           |    2 --
 drivers/scsi/advansys.c                |    7 -------
 drivers/scsi/aic7xxx/aic79xx.h         |    7 -------
 drivers/scsi/aic7xxx/aic7xxx.h         |    7 -------
 drivers/scsi/aic7xxx/aicasm/aicasm.h   |    8 --------
 drivers/scsi/aic7xxx_old.c             |    6 ------
 drivers/scsi/dpti.h                    |    6 ------
 drivers/scsi/eata_generic.h            |    7 -------
 drivers/scsi/gdth.h                    |    7 -------
 drivers/scsi/nsp32.h                   |    6 ------
 drivers/scsi/scsi.h                    |   10 ----------
 drivers/scsi/u14-34f.c                 |    2 --
 drivers/scsi/ultrastor.c               |    3 ---
 drivers/telephony/ixj.h                |    3 ---
 drivers/usb/serial/io_edgeport.h       |    6 ------
 drivers/usb/serial/whiteheat.h         |    5 -----
 drivers/video/cirrusfb.c               |    9 ---------
 drivers/video/riva/riva_hw.h           |   10 ----------
 drivers/video/sis/vgatypes.h           |    8 --------
 fs/cifs/cifsfs.h                       |    8 --------
 fs/cifs/cifsglob.h                     |    8 --------
 fs/cifs/smbencrypt.c                   |    7 -------
 fs/devfs/base.c                        |    5 -----
 fs/jfs/jfs_types.h                     |    2 --
 fs/ntfs/types.h                        |    5 +----
 fs/partitions/ldm.c                    |    5 +----
 include/asm-ppc/gt64260.h              |    8 --------
 include/linux/agp_backend.h            |    8 --------
 include/linux/agpgart.h                |    8 --------
 include/linux/kernel.h                 |    7 +++++++
 include/linux/ps2esdi.h                |    3 ---
 include/linux/synclink.h               |    2 --
 include/net/irda/irda.h                |    8 --------
 sound/oss/aedsp16.c                    |    6 ------
 sound/oss/os.h                         |    3 ---
 71 files changed, 13 insertions(+), 407 deletions(-)

diff -puN arch/alpha/kernel/smc37c669.c~consolidate-true-and-false arch/alpha/kernel/smc37c669.c
--- devel/arch/alpha/kernel/smc37c669.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/arch/alpha/kernel/smc37c669.c	2006-03-16 02:01:02.000000000 -0800
@@ -947,13 +947,6 @@ void SMC37c669_display_device_info( 
 #include    "cp$src:platform.h"
 #endif
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 #define wb( _x_, _y_ )	outb( _y_, (unsigned int)((unsigned long)_x_) )
 #define rb( _x_ )	inb( (unsigned int)((unsigned long)_x_) )
 
diff -puN arch/arm26/nwfpe/milieu.h~consolidate-true-and-false arch/arm26/nwfpe/milieu.h
--- devel/arch/arm26/nwfpe/milieu.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/arch/arm26/nwfpe/milieu.h	2006-03-16 02:01:02.000000000 -0800
@@ -35,14 +35,3 @@ Include common integer types and flags.
 -------------------------------------------------------------------------------
 */
 #include "ARM-gcc.h"
-
-/*
--------------------------------------------------------------------------------
-Symbolic Boolean literals.
--------------------------------------------------------------------------------
-*/
-enum {
-    FALSE = 0,
-    TRUE  = 1
-};
-
diff -puN arch/arm/nwfpe/milieu.h~consolidate-true-and-false arch/arm/nwfpe/milieu.h
--- devel/arch/arm/nwfpe/milieu.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/arch/arm/nwfpe/milieu.h	2006-03-16 02:01:02.000000000 -0800
@@ -35,14 +35,3 @@ Include common integer types and flags.
 -------------------------------------------------------------------------------
 */
 #include "ARM-gcc.h"
-
-/*
--------------------------------------------------------------------------------
-Symbolic Boolean literals.
--------------------------------------------------------------------------------
-*/
-enum {
-    FALSE = 0,
-    TRUE  = 1
-};
-
diff -puN arch/i386/kernel/cpu/mtrr/mtrr.h~consolidate-true-and-false arch/i386/kernel/cpu/mtrr/mtrr.h
--- devel/arch/i386/kernel/cpu/mtrr/mtrr.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/arch/i386/kernel/cpu/mtrr/mtrr.h	2006-03-16 02:01:02.000000000 -0800
@@ -2,11 +2,6 @@
  * local mtrr defines.
  */
 
-#ifndef TRUE
-#define TRUE  1
-#define FALSE 0
-#endif
-
 #define MTRRcap_MSR     0x0fe
 #define MTRRdefType_MSR 0x2ff
 
diff -puN arch/mips/ite-boards/generic/lpc.c~consolidate-true-and-false arch/mips/ite-boards/generic/lpc.c
--- devel/arch/mips/ite-boards/generic/lpc.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/arch/mips/ite-boards/generic/lpc.c	2006-03-16 02:01:02.000000000 -0800
@@ -33,14 +33,6 @@
 #include <asm/it8712.h>
 #include <asm/it8172/it8172.h>
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 void LPCEnterMBPnP(void)
 {
 	int i;
diff -puN arch/parisc/math-emu/float.h~consolidate-true-and-false arch/parisc/math-emu/float.h
--- devel/arch/parisc/math-emu/float.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/arch/parisc/math-emu/float.h	2006-03-16 02:01:02.000000000 -0800
@@ -392,8 +392,6 @@ typedef struct dblwd dbl_unsigned;
 #define QUAD_P 113
 
 /* Boolean Values etc. */
-#define FALSE 0
-#define TRUE (!FALSE)
 #define NOT !
 #define XOR ^
 
diff -puN arch/ppc/4xx_io/serial_sicc.c~consolidate-true-and-false arch/ppc/4xx_io/serial_sicc.c
--- devel/arch/ppc/4xx_io/serial_sicc.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/arch/ppc/4xx_io/serial_sicc.c	2006-03-16 02:01:02.000000000 -0800
@@ -185,13 +185,6 @@
 #define SERIAL_SICC_MINOR   1
 #define SERIAL_SICC_NR      1
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 /*
  * Things needed by tty driver
  */
diff -puN arch/ppc/boot/common/misc-common.c~consolidate-true-and-false arch/ppc/boot/common/misc-common.c
--- devel/arch/ppc/boot/common/misc-common.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/arch/ppc/boot/common/misc-common.c	2006-03-16 02:01:02.000000000 -0800
@@ -287,9 +287,6 @@ puthex(unsigned long val)
 	puts(buf);
 }
 
-#define FALSE 0
-#define TRUE  1
-
 void
 _printk(char const *fmt, ...)
 {
@@ -323,11 +320,11 @@ _vprintk(void(*putc)(const char), const 
 			}
 			if (c == '0')
 			{
-				zero_fill = TRUE;
+				zero_fill = 1;
 				c = *fmt0++;
 			} else
 			{
-				zero_fill = FALSE;
+				zero_fill = 0;
 			}
 			while (is_digit(c))
 			{
diff -puN arch/ppc/boot/simple/rw4/stb.h~consolidate-true-and-false arch/ppc/boot/simple/rw4/stb.h
--- devel/arch/ppc/boot/simple/rw4/stb.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/arch/ppc/boot/simple/rw4/stb.h	2006-03-16 02:01:02.000000000 -0800
@@ -225,15 +225,4 @@
 #define STB_SDRAM_BASE_ADDRESS  0xA0000000
 #endif
 
-/*----------------------------------------------------------------------------+
-| Other common defines.
-+----------------------------------------------------------------------------*/
-#ifndef TRUE
-#define TRUE    1
-#endif
-
-#ifndef FALSE
-#define FALSE   0
-#endif
-
 #endif /* _stb_h_ */
diff -puN Documentation/mtrr.txt~consolidate-true-and-false Documentation/mtrr.txt
--- devel/Documentation/mtrr.txt~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/Documentation/mtrr.txt	2006-03-16 02:01:02.000000000 -0800
@@ -147,11 +147,8 @@ Reading MTRRs from a C program using ioc
 #define MTRR_NEED_STRINGS
 #include <asm/mtrr.h>
 
-#define TRUE 1
-#define FALSE 0
 #define ERRSTRING strerror (errno)
 
-
 int main ()
 {
     int fd;
@@ -235,8 +232,6 @@ Creating MTRRs from a C programme using 
 #define MTRR_NEED_STRINGS
 #include <asm/mtrr.h>
 
-#define TRUE 1
-#define FALSE 0
 #define ERRSTRING strerror (errno)
 
 
diff -puN drivers/block/z2ram.c~consolidate-true-and-false drivers/block/z2ram.c
--- devel/drivers/block/z2ram.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/block/z2ram.c	2006-03-16 02:01:02.000000000 -0800
@@ -44,9 +44,6 @@
 extern int m68k_realnum_memory;
 extern struct mem_info m68k_memory[NUM_MEMINFO];
 
-#define TRUE                  (1)
-#define FALSE                 (0)
-
 #define Z2MINOR_COMBINED      (0)
 #define Z2MINOR_Z2ONLY        (1)
 #define Z2MINOR_CHIPONLY      (2)
diff -puN drivers/char/ftape/compressor/lzrw3.h~consolidate-true-and-false drivers/char/ftape/compressor/lzrw3.h
--- devel/drivers/char/ftape/compressor/lzrw3.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/char/ftape/compressor/lzrw3.h	2006-03-16 02:01:02.000000000 -0800
@@ -168,9 +168,6 @@
       #define FOPEN_BINARY_WRITE not used  /* Mode string for binary writing. */
       #define FOPEN_TEXT_APPEND  not used  /* Mode string for text appending. */
       #define REAL not used                /* USed for floating point stuff.  */
-      #ifndef TRUE
-      #define TRUE 1
-      #endif
    #endif
 
    #define DONE_PORT                   /* Don't do all this again.            */
diff -puN drivers/char/mwave/smapi.h~consolidate-true-and-false drivers/char/mwave/smapi.h
--- devel/drivers/char/mwave/smapi.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/char/mwave/smapi.h	2006-03-16 02:01:02.000000000 -0800
@@ -49,8 +49,6 @@
 #ifndef _LINUX_SMAPI_H
 #define _LINUX_SMAPI_H
 
-#define TRUE 1
-#define FALSE 0
 #define BOOLEAN int
 
 typedef struct {
diff -puN drivers/char/rio/rio.h~consolidate-true-and-false drivers/char/rio/rio.h
--- devel/drivers/char/rio/rio.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/char/rio/rio.h	2006-03-16 02:01:02.000000000 -0800
@@ -221,13 +221,6 @@ typedef struct DbInf {
 	char Name[8];
 } DbInf;
 
-#ifndef TRUE
-#define	TRUE (1==1)
-#endif
-#ifndef FALSE
-#define	FALSE	(!TRUE)
-#endif
-
 #define CSUM(pkt_ptr)  (((ushort *)(pkt_ptr))[0] + ((ushort *)(pkt_ptr))[1] + \
 			((ushort *)(pkt_ptr))[2] + ((ushort *)(pkt_ptr))[3] + \
 			((ushort *)(pkt_ptr))[4] + ((ushort *)(pkt_ptr))[5] + \
diff -puN drivers/char/rio/sam.h~consolidate-true-and-false drivers/char/rio/sam.h
--- devel/drivers/char/rio/sam.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/char/rio/sam.h	2006-03-16 02:01:02.000000000 -0800
@@ -45,13 +45,6 @@
 
 #define NUM_FREE_LIST_UNITS     500
 
-#ifndef FALSE
-#define FALSE (short)  0x00
-#endif
-#ifndef TRUE
-#define TRUE  (short)  !FALSE
-#endif
-
 #define TX    TRUE
 #define RX    FALSE
 
diff -puN drivers/input/joystick/iforce/iforce.h~consolidate-true-and-false drivers/input/joystick/iforce/iforce.h
--- devel/drivers/input/joystick/iforce/iforce.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/input/joystick/iforce/iforce.h	2006-03-16 02:01:02.000000000 -0800
@@ -51,9 +51,6 @@
 #define IFORCE_232	1
 #define IFORCE_USB	2
 
-#define FALSE 0
-#define TRUE 1
-
 #define FF_EFFECTS_MAX	32
 
 /* Each force feedback effect is made of one core effect, which can be
diff -puN drivers/isdn/hardware/eicon/platform.h~consolidate-true-and-false drivers/isdn/hardware/eicon/platform.h
--- devel/drivers/isdn/hardware/eicon/platform.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/isdn/hardware/eicon/platform.h	2006-03-16 02:01:02.000000000 -0800
@@ -72,18 +72,6 @@
 #define	qword  u64
 #endif
 
-#ifndef	TRUE
-#define	TRUE	1
-#endif
-
-#ifndef	FALSE
-#define	FALSE	0
-#endif
-
-#ifndef	NULL
-#define	NULL	((void *) 0)
-#endif
-
 #ifndef	MIN
 #define MIN(a,b)	((a)>(b) ? (b) : (a))
 #endif
diff -puN drivers/isdn/hisax/hfc_usb.h~consolidate-true-and-false drivers/isdn/hisax/hfc_usb.h
--- devel/drivers/isdn/hisax/hfc_usb.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/isdn/hisax/hfc_usb.h	2006-03-16 02:01:02.000000000 -0800
@@ -12,10 +12,6 @@
 
 #define VERBOSE_USB_DEBUG
 
-#define TRUE  1
-#define FALSE 0
-
-
 /***********/
 /* defines */
 /***********/
diff -puN drivers/media/radio/radio-gemtek-pci.c~consolidate-true-and-false drivers/media/radio/radio-gemtek-pci.c
--- devel/drivers/media/radio/radio-gemtek-pci.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/media/radio/radio-gemtek-pci.c	2006-03-16 02:01:02.000000000 -0800
@@ -65,14 +65,6 @@
 #define GEMTEK_PCI_RANGE_HIGH (108*16000)
 #endif
 
-#ifndef TRUE
-#define TRUE (1)
-#endif
-
-#ifndef FALSE 
-#define FALSE (0)
-#endif
-
 struct gemtek_pci_card {
 	struct video_device *videodev;
 	
diff -puN drivers/media/video/cx88/cx88.h~consolidate-true-and-false drivers/media/video/cx88/cx88.h
--- devel/drivers/media/video/cx88/cx88.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/media/video/cx88/cx88.h	2006-03-16 02:01:02.000000000 -0800
@@ -37,12 +37,6 @@
 #include <linux/version.h>
 #define CX88_VERSION_CODE KERNEL_VERSION(0,0,5)
 
-#ifndef TRUE
-# define TRUE (1==1)
-#endif
-#ifndef FALSE
-# define FALSE (1==0)
-#endif
 #define UNSET (-1U)
 
 #define CX88_MAXBOARDS 8
diff -puN drivers/media/video/saa5246a.h~consolidate-true-and-false drivers/media/video/saa5246a.h
--- devel/drivers/media/video/saa5246a.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/media/video/saa5246a.h	2006-03-16 02:01:02.000000000 -0800
@@ -53,11 +53,6 @@
 	((p_req)->start <= POS_HEADER_END && \
 	 (p_req)->end   >= POS_HEADER_START)
 
-#ifndef FALSE
-#define FALSE 0
-#define TRUE 1
-#endif
-
 /*****************************************************************************/
 /* Mode register numbers of the SAA5246A				     */
 /*****************************************************************************/
diff -puN drivers/media/video/saa5249.c~consolidate-true-and-false drivers/media/video/saa5249.c
--- devel/drivers/media/video/saa5249.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/media/video/saa5249.c	2006-03-16 02:01:02.000000000 -0800
@@ -121,11 +121,6 @@ struct saa5249_device
 
 /* General defines and debugging support */
 
-#ifndef FALSE
-#define FALSE 0
-#define TRUE 1
-#endif
-
 #define RESCHED do { cond_resched(); } while(0)
 
 static struct video_device saa_template;	/* Declared near bottom */
diff -puN drivers/media/video/saa7134/saa7134.h~consolidate-true-and-false drivers/media/video/saa7134/saa7134.h
--- devel/drivers/media/video/saa7134/saa7134.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/media/video/saa7134/saa7134.h	2006-03-16 02:01:02.000000000 -0800
@@ -42,12 +42,6 @@
 #include <sound/pcm.h>
 #include <media/video-buf-dvb.h>
 
-#ifndef TRUE
-# define TRUE (1==1)
-#endif
-#ifndef FALSE
-# define FALSE (1==0)
-#endif
 #define UNSET (-1U)
 
 /* ----------------------------------------------------------- */
diff -puN drivers/net/3c505.c~consolidate-true-and-false drivers/net/3c505.c
--- devel/drivers/net/3c505.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/3c505.c	2006-03-16 02:01:02.000000000 -0800
@@ -169,21 +169,6 @@ static int elp_debug;
 
 /*****************************************************************
  *
- * useful macros
- *
- *****************************************************************/
-
-#ifndef	TRUE
-#define	TRUE	1
-#endif
-
-#ifndef	FALSE
-#define	FALSE	0
-#endif
-
-
-/*****************************************************************
- *
  * List of I/O-addresses we try to auto-sense
  * Last element MUST BE 0!
  *****************************************************************/
diff -puN drivers/net/8139cp.c~consolidate-true-and-false drivers/net/8139cp.c
--- devel/drivers/net/8139cp.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/8139cp.c	2006-03-16 02:01:02.000000000 -0800
@@ -108,11 +108,6 @@ MODULE_PARM_DESC (multicast_filter_limit
 
 #define PFX			DRV_NAME ": "
 
-#ifndef TRUE
-#define FALSE 0
-#define TRUE (!FALSE)
-#endif
-
 #define CP_DEF_MSG_ENABLE	(NETIF_MSG_DRV		| \
 				 NETIF_MSG_PROBE 	| \
 				 NETIF_MSG_LINK)
diff -puN drivers/net/dm9000.c~consolidate-true-and-false drivers/net/dm9000.c
--- devel/drivers/net/dm9000.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/dm9000.c	2006-03-16 02:01:02.000000000 -0800
@@ -77,9 +77,6 @@
 
 #define DM9000_PHY		0x40	/* PHY address 0x01 */
 
-#define TRUE			1
-#define FALSE			0
-
 #define CARDNAME "dm9000"
 #define PFX CARDNAME ": "
 
diff -puN drivers/net/e1000/e1000_osdep.h~consolidate-true-and-false drivers/net/e1000/e1000_osdep.h
--- devel/drivers/net/e1000/e1000_osdep.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/e1000/e1000_osdep.h	2006-03-16 02:01:02.000000000 -0800
@@ -60,12 +60,7 @@
 #define PCI_COMMAND_REGISTER   PCI_COMMAND
 #define CMD_MEM_WRT_INVALIDATE PCI_COMMAND_INVALIDATE
 
-typedef enum {
-#undef FALSE
-    FALSE = 0,
-#undef TRUE
-    TRUE = 1
-} boolean_t;
+typedef int boolean_t;
 
 #define MSGOUT(S, A, B)	printk(KERN_DEBUG S "\n", A, B)
 
diff -puN drivers/net/ixgb/ixgb_osdep.h~consolidate-true-and-false drivers/net/ixgb/ixgb_osdep.h
--- devel/drivers/net/ixgb/ixgb_osdep.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/ixgb/ixgb_osdep.h	2006-03-16 02:01:02.000000000 -0800
@@ -52,12 +52,7 @@
 #define PCI_COMMAND_REGISTER   PCI_COMMAND
 #define CMD_MEM_WRT_INVALIDATE PCI_COMMAND_INVALIDATE
 
-typedef enum {
-#undef FALSE
-	FALSE = 0,
-#undef TRUE
-	TRUE = 1
-} boolean_t;
+typedef int boolean_t;
 
 #undef ASSERT
 #define ASSERT(x)	if(!(x)) BUG()
diff -puN drivers/net/oaknet.c~consolidate-true-and-false drivers/net/oaknet.c
--- devel/drivers/net/oaknet.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/oaknet.c	2006-03-16 02:01:02.000000000 -0800
@@ -29,14 +29,6 @@
 
 /* Preprocessor Defines */
 
-#if !defined(TRUE) || TRUE != 1
-#define	TRUE	1
-#endif
-
-#if !defined(FALSE) || FALSE != 0
-#define	FALSE	0
-#endif
-
 #define	OAKNET_START_PG		0x20	/* First page of TX buffer */
 #define	OAKNET_STOP_PG		0x40	/* Last pagge +1 of RX ring */
 
diff -puN drivers/net/s2io.h~consolidate-true-and-false drivers/net/s2io.h
--- devel/drivers/net/s2io.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/s2io.h	2006-03-16 02:01:02.000000000 -0800
@@ -22,11 +22,6 @@
 #define BOOL    int
 #endif
 
-#ifndef TRUE
-#define TRUE    1
-#define FALSE   0
-#endif
-
 #undef SUCCESS
 #define SUCCESS 0
 #define FAILURE -1
diff -puN drivers/net/skfp/h/targetos.h~consolidate-true-and-false drivers/net/skfp/h/targetos.h
--- devel/drivers/net/skfp/h/targetos.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/skfp/h/targetos.h	2006-03-16 02:01:02.000000000 -0800
@@ -60,9 +60,6 @@
 
 #include "h/hwmtm.h"
 
-#define TRUE  1
-#define FALSE 0
-
 // HWM Definitions
 // -----------------------
 #define FDDI_TRACE(string, arg1, arg2, arg3)	// Performance analysis.
diff -puN drivers/net/tlan.h~consolidate-true-and-false drivers/net/tlan.h
--- devel/drivers/net/tlan.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/tlan.h	2006-03-16 02:01:02.000000000 -0800
@@ -33,9 +33,6 @@
 	 *
 	 ****************************************************************/
 
-#define FALSE			0
-#define TRUE			1
-
 #define TLAN_MIN_FRAME_SIZE	64
 #define TLAN_MAX_FRAME_SIZE	1600
 
diff -puN drivers/net/tokenring/ibmtr.c~consolidate-true-and-false drivers/net/tokenring/ibmtr.c
--- devel/drivers/net/tokenring/ibmtr.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/tokenring/ibmtr.c	2006-03-16 02:01:02.000000000 -0800
@@ -116,9 +116,6 @@ in the event that chatty debug messages 
 #define ENABLE_PAGING 1		
 #endif
 
-#define FALSE 0
-#define TRUE (!FALSE)
-
 /* changes the output format of driver initialization */
 #define TR_VERBOSE	0
 
diff -puN drivers/net/tulip/de4x5.h~consolidate-true-and-false drivers/net/tulip/de4x5.h
--- devel/drivers/net/tulip/de4x5.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/tulip/de4x5.h	2006-03-16 02:01:02.000000000 -0800
@@ -896,10 +896,7 @@
 ** Booleans
 */
 #define NO                   0
-#define FALSE                0
-
 #define YES                  ~0
-#define TRUE                 ~0
 
 /*
 ** Adapter state
diff -puN drivers/net/wireless/strip.c~consolidate-true-and-false drivers/net/wireless/strip.c
--- devel/drivers/net/wireless/strip.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/wireless/strip.c	2006-03-16 02:01:02.000000000 -0800
@@ -178,8 +178,6 @@ typedef struct {
 	MetricomNode node[NODE_TABLE_SIZE];
 } MetricomNodeTable;
 
-enum { FALSE = 0, TRUE = 1 };
-
 /*
  * Holds the radio's firmware version.
  */
diff -puN drivers/net/wireless/wavelan_cs.h~consolidate-true-and-false drivers/net/wireless/wavelan_cs.h
--- devel/drivers/net/wireless/wavelan_cs.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/net/wireless/wavelan_cs.h	2006-03-16 02:01:02.000000000 -0800
@@ -151,9 +151,6 @@ static const int	fixed_bands[] = { 915e6
 #define RX_SIZE		(TX_BASE-RX_BASE)	/* Size of receive area */
 #define RX_SIZE_SHIFT	6		/* Bits to shift in stop register */
 
-#define TRUE  1
-#define FALSE 0
-
 #define MOD_ENAL 1
 #define MOD_PROM 2
 
diff -puN drivers/pci/hotplug/ibmphp.h~consolidate-true-and-false drivers/pci/hotplug/ibmphp.h
--- devel/drivers/pci/hotplug/ibmphp.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/pci/hotplug/ibmphp.h	2006-03-16 02:01:02.000000000 -0800
@@ -406,8 +406,6 @@ extern void ibmphp_hpc_stop_poll_thread 
 //----------------------------------------------------------------------------
 // HPC return codes
 //----------------------------------------------------------------------------
-#define FALSE				0x00
-#define TRUE				0x01
 #define HPC_ERROR			0xFF
 
 //-----------------------------------------------------------------------------
diff -puN drivers/scsi/advansys.c~consolidate-true-and-false drivers/scsi/advansys.c
--- devel/drivers/scsi/advansys.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/scsi/advansys.c	2006-03-16 02:01:02.000000000 -0800
@@ -865,13 +865,6 @@
 
 typedef unsigned char uchar;
 
-#ifndef TRUE
-#define TRUE     (1)
-#endif
-#ifndef FALSE
-#define FALSE    (0)
-#endif
-
 #define EOF      (-1)
 #define ERR      (-1)
 #define UW_ERR   (uint)(0xFFFF)
diff -puN drivers/scsi/aic7xxx/aic79xx.h~consolidate-true-and-false drivers/scsi/aic7xxx/aic79xx.h
--- devel/drivers/scsi/aic7xxx/aic79xx.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/scsi/aic7xxx/aic79xx.h	2006-03-16 02:01:02.000000000 -0800
@@ -61,13 +61,6 @@ struct scb_platform_data;
 #define MIN(a,b) (((a) < (b)) ? (a) : (b))
 #endif
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 #define NUM_ELEMENTS(array) (sizeof(array) / sizeof(*array))
 
 #define ALL_CHANNELS '\0'
diff -puN drivers/scsi/aic7xxx/aic7xxx.h~consolidate-true-and-false drivers/scsi/aic7xxx/aic7xxx.h
--- devel/drivers/scsi/aic7xxx/aic7xxx.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/scsi/aic7xxx/aic7xxx.h	2006-03-16 02:01:02.000000000 -0800
@@ -62,13 +62,6 @@ struct seeprom_descriptor;
 #define MIN(a,b) (((a) < (b)) ? (a) : (b))
 #endif
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 #define NUM_ELEMENTS(array) (sizeof(array) / sizeof(*array))
 
 #define ALL_CHANNELS '\0'
diff -puN drivers/scsi/aic7xxx/aicasm/aicasm.h~consolidate-true-and-false drivers/scsi/aic7xxx/aicasm/aicasm.h
--- devel/drivers/scsi/aic7xxx/aicasm/aicasm.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/scsi/aic7xxx/aicasm/aicasm.h	2006-03-16 02:01:02.000000000 -0800
@@ -48,14 +48,6 @@
 #include <sys/queue.h>
 #endif
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 typedef struct path_entry {
 	char	*directory;
 	int	quoted_includes_only;
diff -puN drivers/scsi/aic7xxx_old.c~consolidate-true-and-false drivers/scsi/aic7xxx_old.c
--- devel/drivers/scsi/aic7xxx_old.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/scsi/aic7xxx_old.c	2006-03-16 02:01:02.000000000 -0800
@@ -258,12 +258,6 @@
 #define ALL_LUNS -1
 #define MAX_TARGETS  16
 #define MAX_LUNS     8
-#ifndef TRUE
-#  define TRUE 1
-#endif
-#ifndef FALSE
-#  define FALSE 0
-#endif
 
 #if defined(__powerpc__) || defined(__i386__) || defined(__x86_64__)
 #  define MMAPIO
diff -puN drivers/scsi/dpti.h~consolidate-true-and-false drivers/scsi/dpti.h
--- devel/drivers/scsi/dpti.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/scsi/dpti.h	2006-03-16 02:01:02.000000000 -0800
@@ -158,12 +158,6 @@ static int adpt_device_reset(struct scsi
 #define I2O_SCSI_DSC_BUS_BUSY               0x3F00
 #define I2O_SCSI_DSC_QUEUE_FROZEN           0x4000
 
-
-#ifndef TRUE
-#define TRUE                  1
-#define FALSE                 0
-#endif
-
 #define HBA_FLAGS_INSTALLED_B       0x00000001	// Adapter Was Installed
 #define HBA_FLAGS_BLINKLED_B        0x00000002	// Adapter In Blink LED State
 #define HBA_FLAGS_IN_RESET	0x00000040	/* in reset */
diff -puN drivers/scsi/eata_generic.h~consolidate-true-and-false drivers/scsi/eata_generic.h
--- devel/drivers/scsi/eata_generic.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/scsi/eata_generic.h	2006-03-16 02:01:02.000000000 -0800
@@ -18,13 +18,6 @@
  * Misc. definitions			     *
  *********************************************/
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 #define R_LIMIT 0x20000
 
 #define MAXISA	   4
diff -puN drivers/scsi/gdth.h~consolidate-true-and-false drivers/scsi/gdth.h
--- devel/drivers/scsi/gdth.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/scsi/gdth.h	2006-03-16 02:01:02.000000000 -0800
@@ -16,13 +16,6 @@
 #include <linux/version.h>
 #include <linux/types.h>
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 /* defines, macros */
 
 /* driver version */
diff -puN drivers/scsi/nsp32.h~consolidate-true-and-false drivers/scsi/nsp32.h
--- devel/drivers/scsi/nsp32.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/scsi/nsp32.h	2006-03-16 02:01:02.000000000 -0800
@@ -76,12 +76,6 @@ typedef u16 u16_le;
 /*
  * BASIC Definitions
  */
-#ifndef TRUE
-# define TRUE  1
-#endif
-#ifndef FALSE
-# define FALSE 0
-#endif
 #define ASSERT 1
 #define NEGATE 0
 
diff -puN drivers/scsi/scsi.h~consolidate-true-and-false drivers/scsi/scsi.h
--- devel/drivers/scsi/scsi.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/scsi/scsi.h	2006-03-16 02:01:02.000000000 -0800
@@ -29,16 +29,6 @@
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi.h>
 
-/*
- * Some defs, in case these are not defined elsewhere.
- */
-#ifndef TRUE
-#define TRUE 1
-#endif
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 struct Scsi_Host;
 struct scsi_cmnd;
 struct scsi_device;
diff -puN drivers/scsi/u14-34f.c~consolidate-true-and-false drivers/scsi/u14-34f.c
--- devel/drivers/scsi/u14-34f.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/scsi/u14-34f.c	2006-03-16 02:01:02.000000000 -0800
@@ -502,8 +502,6 @@ static struct scsi_host_template driver_
 #define MAX_TAGGED_CMD_PER_LUN (MAX_MAILBOXES - MAX_CMD_PER_LUN)
 
 #define SKIP ULONG_MAX
-#define FALSE 0
-#define TRUE 1
 #define FREE 0
 #define IN_USE   1
 #define LOCKED   2
diff -puN drivers/scsi/ultrastor.c~consolidate-true-and-false drivers/scsi/ultrastor.c
--- devel/drivers/scsi/ultrastor.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/scsi/ultrastor.c	2006-03-16 02:01:02.000000000 -0800
@@ -148,9 +148,6 @@
 #include <scsi/scsi_host.h>
 #include "ultrastor.h"
 
-#define FALSE 0
-#define TRUE 1
-
 #ifndef ULTRASTOR_DEBUG
 #define ULTRASTOR_DEBUG (UD_ABORT|UD_CSIR|UD_RESET)
 #endif
diff -puN drivers/telephony/ixj.h~consolidate-true-and-false drivers/telephony/ixj.h
--- devel/drivers/telephony/ixj.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/telephony/ixj.h	2006-03-16 02:01:02.000000000 -0800
@@ -54,9 +54,6 @@ typedef __u8 BOOL;
 #define IXJMAX 16
 #endif
 
-#define TRUE 1
-#define FALSE 0
-
 /******************************************************************************
 *
 *  This structure when unioned with the structures below makes simple byte
diff -puN drivers/usb/serial/io_edgeport.h~consolidate-true-and-false drivers/usb/serial/io_edgeport.h
--- devel/drivers/usb/serial/io_edgeport.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/usb/serial/io_edgeport.h	2006-03-16 02:01:02.000000000 -0800
@@ -19,12 +19,6 @@
 #define MAX_RS232_PORTS		8	/* Max # of RS-232 ports per device */
 
 /* typedefs that the insideout headers need */
-#ifndef TRUE
-	#define TRUE		(1)
-#endif
-#ifndef FALSE
-	#define FALSE		(0)
-#endif
 #ifndef LOW8
 	#define LOW8(a)		((unsigned char)(a & 0xff))
 #endif
diff -puN drivers/usb/serial/whiteheat.h~consolidate-true-and-false drivers/usb/serial/whiteheat.h
--- devel/drivers/usb/serial/whiteheat.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/usb/serial/whiteheat.h	2006-03-16 02:01:02.000000000 -0800
@@ -19,11 +19,6 @@
 #ifndef __LINUX_USB_SERIAL_WHITEHEAT_H
 #define __LINUX_USB_SERIAL_WHITEHEAT_H
 
-
-#define FALSE	0
-#define TRUE	1
-
-
 /* WhiteHEAT commands */
 #define WHITEHEAT_OPEN			1	/* open the port */
 #define WHITEHEAT_CLOSE			2	/* close the port */
diff -puN drivers/video/cirrusfb.c~consolidate-true-and-false drivers/video/cirrusfb.c
--- devel/drivers/video/cirrusfb.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/video/cirrusfb.c	2006-03-16 02:01:02.000000000 -0800
@@ -100,15 +100,6 @@
 #define assert(expr)
 #endif
 
-#ifdef TRUE
-#undef TRUE
-#endif
-#ifdef FALSE
-#undef FALSE
-#endif
-#define TRUE  1
-#define FALSE 0
-
 #define MB_ (1024*1024)
 #define KB_ (1024)
 
diff -puN drivers/video/riva/riva_hw.h~consolidate-true-and-false drivers/video/riva/riva_hw.h
--- devel/drivers/video/riva/riva_hw.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/video/riva/riva_hw.h	2006-03-16 02:01:02.000000000 -0800
@@ -53,16 +53,6 @@
 typedef int Bool;
 #endif
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-#ifndef FALSE
-#define FALSE 0
-#endif
-#ifndef NULL
-#define NULL 0
-#endif
-
 /*
  * Typedefs to force certain sized values.
  */
diff -puN drivers/video/sis/vgatypes.h~consolidate-true-and-false drivers/video/sis/vgatypes.h
--- devel/drivers/video/sis/vgatypes.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/drivers/video/sis/vgatypes.h	2006-03-16 02:01:02.000000000 -0800
@@ -57,14 +57,6 @@
 #include <linux/version.h>
 #endif
 
-#ifndef FALSE
-#define FALSE   0
-#endif
-
-#ifndef TRUE
-#define TRUE    1
-#endif
-
 #ifndef BOOLEAN
 typedef unsigned int BOOLEAN;
 #endif
diff -puN fs/cifs/cifsfs.h~consolidate-true-and-false fs/cifs/cifsfs.h
--- devel/fs/cifs/cifsfs.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/fs/cifs/cifsfs.h	2006-03-16 02:01:02.000000000 -0800
@@ -24,14 +24,6 @@
 
 #define ROOT_I 2
 
-#ifndef FALSE
-#define FALSE 0
-#endif
-
-#ifndef TRUE
-#define TRUE 1
-#endif
-
 extern struct address_space_operations cifs_addr_ops;
 
 /* Functions related to super block operations */
diff -puN fs/cifs/cifsglob.h~consolidate-true-and-false fs/cifs/cifsglob.h
--- devel/fs/cifs/cifsglob.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/fs/cifs/cifsglob.h	2006-03-16 02:01:02.000000000 -0800
@@ -55,14 +55,6 @@
 
 #include "cifspdu.h"
 
-#ifndef FALSE
-#define FALSE 0
-#endif
-
-#ifndef TRUE
-#define TRUE 1
-#endif
-
 #ifndef XATTR_DOS_ATTRIB
 #define XATTR_DOS_ATTRIB "user.DOSATTRIB"
 #endif
diff -puN fs/cifs/smbencrypt.c~consolidate-true-and-false fs/cifs/smbencrypt.c
--- devel/fs/cifs/smbencrypt.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/fs/cifs/smbencrypt.c	2006-03-16 02:01:02.000000000 -0800
@@ -34,13 +34,6 @@
 #include "cifs_debug.h"
 #include "cifsencrypt.h"
 
-#ifndef FALSE
-#define FALSE 0
-#endif
-#ifndef TRUE
-#define TRUE 1
-#endif
-
 /* following came from the other byteorder.h to avoid include conflicts */
 #define CVAL(buf,pos) (((unsigned char *)(buf))[pos])
 #define SSVALX(buf,pos,val) (CVAL(buf,pos)=(val)&0xFF,CVAL(buf,pos+1)=(val)>>8)
diff -puN fs/devfs/base.c~consolidate-true-and-false fs/devfs/base.c
--- devel/fs/devfs/base.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/fs/devfs/base.c	2006-03-16 02:01:02.000000000 -0800
@@ -697,11 +697,6 @@
 #define POISON_PTR ( *(void **) poison_array )
 #define MAGIC_VALUE 0x327db823
 
-#ifndef TRUE
-#  define TRUE 1
-#  define FALSE 0
-#endif
-
 #define MODE_DIR (S_IFDIR | S_IWUSR | S_IRUGO | S_IXUGO)
 
 #define DEBUG_NONE         0x0000000
diff -puN fs/jfs/jfs_types.h~consolidate-true-and-false fs/jfs/jfs_types.h
--- devel/fs/jfs/jfs_types.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/fs/jfs/jfs_types.h	2006-03-16 02:01:02.000000000 -0800
@@ -58,8 +58,6 @@ struct timestruc_t {
 #define	ONES		0xffffffffu	/* all bit on                   */
 
 typedef int boolean_t;
-#define TRUE 1
-#define FALSE 0
 
 /*
  *	logical xd (lxd)
diff -puN fs/ntfs/types.h~consolidate-true-and-false fs/ntfs/types.h
--- devel/fs/ntfs/types.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/fs/ntfs/types.h	2006-03-16 02:01:02.000000000 -0800
@@ -61,10 +61,7 @@ typedef sle64 leLSN;
 typedef s64 USN;
 typedef sle64 leUSN;
 
-typedef enum {
-	FALSE = 0,
-	TRUE = 1
-} BOOL;
+typedef int BOOL;
 
 typedef enum {
 	CASE_SENSITIVE = 0,
diff -puN fs/partitions/ldm.c~consolidate-true-and-false fs/partitions/ldm.c
--- devel/fs/partitions/ldm.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/fs/partitions/ldm.c	2006-03-16 02:01:02.000000000 -0800
@@ -30,10 +30,7 @@
 #include "check.h"
 #include "msdos.h"
 
-typedef enum {
-	FALSE = 0,
-	TRUE  = 1
-} BOOL;
+typedef int BOOL;
 
 /**
  * ldm_debug/info/error/crit - Output an error message
diff -puN include/asm-ppc/gt64260.h~consolidate-true-and-false include/asm-ppc/gt64260.h
--- devel/include/asm-ppc/gt64260.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/include/asm-ppc/gt64260.h	2006-03-16 02:01:02.000000000 -0800
@@ -32,14 +32,6 @@ extern u32     gt64260_irq_base;     /* 
 extern u32     gt64260_revision;
 extern u8      gt64260_pci_exclude_bridge;
 
-#ifndef	TRUE
-#define	TRUE	1
-#endif
-
-#ifndef	FALSE
-#define	FALSE	0
-#endif
-
 /* IRQs defined by the 64260 */
 #define	GT64260_IRQ_MPSC0		40
 #define	GT64260_IRQ_MPSC1		42
diff -puN include/linux/agp_backend.h~consolidate-true-and-false include/linux/agp_backend.h
--- devel/include/linux/agp_backend.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/include/linux/agp_backend.h	2006-03-16 02:01:02.000000000 -0800
@@ -32,14 +32,6 @@
 
 #ifdef __KERNEL__
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 enum chipset_type {
 	NOT_SUPPORTED,
 	SUPPORTED,
diff -puN include/linux/agpgart.h~consolidate-true-and-false include/linux/agpgart.h
--- devel/include/linux/agpgart.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/include/linux/agpgart.h	2006-03-16 02:01:02.000000000 -0800
@@ -43,14 +43,6 @@
 
 #define AGP_DEVICE      "/dev/agpgart"
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 #ifndef __KERNEL__
 #include <linux/types.h>
 #include <asm/types.h>
diff -puN include/linux/kernel.h~consolidate-true-and-false include/linux/kernel.h
--- devel/include/linux/kernel.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/include/linux/kernel.h	2006-03-16 02:01:02.000000000 -0800
@@ -18,6 +18,13 @@
 
 extern const char linux_banner[];
 
+/*
+ * Give these a funny-looking definition to improve the chances of them
+ * clashing with other definitions of TRUE and FALSE, causing a cpp error
+ */
+#define TRUE		((1))
+#define FALSE		((0))
+
 #define INT_MAX		((int)(~0U>>1))
 #define INT_MIN		(-INT_MAX - 1)
 #define UINT_MAX	(~0U)
diff -puN include/linux/ps2esdi.h~consolidate-true-and-false include/linux/ps2esdi.h
--- devel/include/linux/ps2esdi.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/include/linux/ps2esdi.h	2006-03-16 02:01:02.000000000 -0800
@@ -85,9 +85,6 @@
 
 #define HDIO_GETGEO 0x0301
 
-#define FALSE 0
-#define TRUE !FALSE
-
 struct ps2esdi_geometry {
 	unsigned char heads;
 	unsigned char sectors;
diff -puN include/linux/synclink.h~consolidate-true-and-false include/linux/synclink.h
--- devel/include/linux/synclink.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/include/linux/synclink.h	2006-03-16 02:01:02.000000000 -0800
@@ -14,8 +14,6 @@
 #define SYNCLINK_H_VERSION 3.6
 
 #define BOOLEAN int
-#define TRUE 1
-#define FALSE 0
 
 #define BIT0	0x0001
 #define BIT1	0x0002
diff -puN include/net/irda/irda.h~consolidate-true-and-false include/net/irda/irda.h
--- devel/include/net/irda/irda.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/include/net/irda/irda.h	2006-03-16 02:01:02.000000000 -0800
@@ -34,14 +34,6 @@
 
 typedef __u32 magic_t;
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-
-#ifndef FALSE 
-#define FALSE 0
-#endif
-
 /* Hack to do small backoff when setting media busy in IrLAP */
 #ifndef SMALL
 #define SMALL 5
diff -puN sound/oss/aedsp16.c~consolidate-true-and-false sound/oss/aedsp16.c
--- devel/sound/oss/aedsp16.c~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/sound/oss/aedsp16.c	2006-03-16 02:01:02.000000000 -0800
@@ -274,12 +274,6 @@
 #endif
 
 /*
- * Misc definitions
- */
-#define TRUE	1
-#define FALSE	0
-
-/*
  * Region Size for request/check/release region.
  */
 #define IOBASE_REGION_SIZE	0x10
diff -puN sound/oss/os.h~consolidate-true-and-false sound/oss/os.h
--- devel/sound/oss/os.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
+++ devel-akpm/sound/oss/os.h	2006-03-16 02:01:02.000000000 -0800
@@ -25,9 +25,6 @@
 
 #include <linux/soundcard.h>
 
-#define FALSE	0
-#define TRUE	1
-
 extern int sound_alloc_dma(int chn, char *deviceID);
 extern int sound_open_dma(int chn, char *deviceID);
 extern void sound_free_dma(int chn);
_
