Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284436AbRLEO56>; Wed, 5 Dec 2001 09:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284446AbRLEO5s>; Wed, 5 Dec 2001 09:57:48 -0500
Received: from t2.redhat.com ([199.183.24.243]:12787 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S284436AbRLEO5U>; Wed, 5 Dec 2001 09:57:20 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove bogus #include <asm/segment.h>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Dec 2001 14:56:48 +0000
Message-ID: <8642.1007564208@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generic code has no business including this header, and no reason to do so. 
And it breaks the SH build. I could work around it by just

echo "#warning bogus include" >  include/asm-sh/segment.h 

but I think that's the wrong approach. 

The following patch, made against 2.5.1-pre5 but tested in 2.4.16, removes 
the bogus includes from all generic code which doesn't need it (i.e. all 
generic code).

Please apply to both trees.

Index: ./drivers/block/nbd.c
===================================================================
RCS file: /inst/cvs/linux/drivers/block/nbd.c,v
retrieving revision 1.3.2.25.2.3
diff -u -r1.3.2.25.2.3 nbd.c
--- ./drivers/block/nbd.c	30 Nov 2001 10:42:32 -0000	1.3.2.25.2.3
+++ ./drivers/block/nbd.c	5 Dec 2001 14:03:30 -0000
@@ -45,7 +45,6 @@
 
 #include <linux/devfs_fs_kernel.h>
 
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <asm/types.h>
 
Index: ./drivers/block/DAC960.c
===================================================================
RCS file: /inst/cvs/linux/drivers/block/DAC960.c,v
retrieving revision 1.5.2.36.2.2
diff -u -r1.5.2.36.2.2 DAC960.c
--- ./drivers/block/DAC960.c	29 Nov 2001 10:42:42 -0000	1.5.2.36.2.2
+++ ./drivers/block/DAC960.c	5 Dec 2001 14:03:30 -0000
@@ -45,7 +45,6 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include "DAC960.h"
 
Index: ./drivers/block/ps2esdi.c
===================================================================
RCS file: /inst/cvs/linux/drivers/block/ps2esdi.c,v
retrieving revision 1.1.1.1.2.28.2.1
diff -u -r1.1.1.1.2.28.2.1 ps2esdi.c
--- ./drivers/block/ps2esdi.c	28 Nov 2001 13:55:46 -0000	1.1.1.1.2.28.2.1
+++ ./drivers/block/ps2esdi.c	5 Dec 2001 14:03:30 -0000
@@ -51,7 +51,6 @@
 
 #include <asm/system.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 #include <asm/dma.h>
 #include <asm/mca_dma.h>
 #include <asm/uaccess.h>
Index: ./drivers/cdrom/cdrom.c
===================================================================
RCS file: /inst/cvs/linux/drivers/cdrom/cdrom.c,v
retrieving revision 1.3.2.36.2.1
diff -u -r1.3.2.36.2.1 cdrom.c
--- ./drivers/cdrom/cdrom.c	28 Nov 2001 13:55:46 -0000	1.3.2.36.2.1
+++ ./drivers/cdrom/cdrom.c	5 Dec 2001 14:03:30 -0000
@@ -266,7 +266,6 @@
 #include <linux/init.h>
 
 #include <asm/fcntl.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 
 /* used to tell the module to turn on full debugging messages */
Index: ./drivers/char/ftape/compressor/zftape-compress.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/compressor/zftape-compress.c,v
retrieving revision 1.1.1.1.2.2
diff -u -r1.1.1.1.2.2 zftape-compress.c
--- ./drivers/char/ftape/compressor/zftape-compress.c	17 Sep 2001 13:10:03 -0000	1.1.1.1.2.2
+++ ./drivers/char/ftape/compressor/zftape-compress.c	5 Dec 2001 14:03:30 -0000
@@ -40,7 +40,6 @@
 #if LINUX_VERSION_CODE >= KERNEL_VER(2,1,6)
 #include <asm/uaccess.h>
 #else
-#include <asm/segment.h>
 #endif
 
 #include "../zftape/zftape-init.h"
Index: ./drivers/char/ftape/lowlevel/ftape-buffer.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/lowlevel/ftape-buffer.c,v
retrieving revision 1.1.1.1.2.3
diff -u -r1.1.1.1.2.3 ftape-buffer.c
--- ./drivers/char/ftape/lowlevel/ftape-buffer.c	24 Feb 2001 19:01:21 -0000	1.1.1.1.2.3
+++ ./drivers/char/ftape/lowlevel/ftape-buffer.c	5 Dec 2001 14:03:30 -0000
@@ -24,7 +24,6 @@
  *  buffer.
  */
 
-#include <asm/segment.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
Index: ./drivers/char/ftape/lowlevel/ftape-ctl.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/lowlevel/ftape-ctl.c,v
retrieving revision 1.1.1.1.2.3
diff -u -r1.1.1.1.2.3 ftape-ctl.c
--- ./drivers/char/ftape/lowlevel/ftape-ctl.c	5 Dec 2000 13:30:40 -0000	1.1.1.1.2.3
+++ ./drivers/char/ftape/lowlevel/ftape-ctl.c	5 Dec 2001 14:03:30 -0000
@@ -36,7 +36,6 @@
 #if LINUX_VERSION_CODE >= KERNEL_VER(2,1,6)
 #include <asm/uaccess.h>
 #else
-#include <asm/segment.h>
 #endif
 #include <asm/io.h>
 
Index: ./drivers/char/ftape/lowlevel/ftape-io.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/lowlevel/ftape-io.c,v
retrieving revision 1.1.1.1.2.2
diff -u -r1.1.1.1.2.2 ftape-io.c
--- ./drivers/char/ftape/lowlevel/ftape-io.c	5 Dec 2000 11:44:58 -0000	1.1.1.1.2.2
+++ ./drivers/char/ftape/lowlevel/ftape-io.c	5 Dec 2001 14:03:30 -0000
@@ -29,7 +29,6 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/ioctl.h>
 #include <linux/mtio.h>
Index: ./drivers/char/ftape/lowlevel/ftape-read.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/lowlevel/ftape-read.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ftape-read.c
--- ./drivers/char/ftape/lowlevel/ftape-read.c	4 Dec 2000 14:23:07 -0000	1.1.1.1
+++ ./drivers/char/ftape/lowlevel/ftape-read.c	5 Dec 2001 14:03:30 -0000
@@ -29,7 +29,6 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
-#include <asm/segment.h>
 
 #include <linux/ftape.h>
 #include <linux/qic117.h>
Index: ./drivers/char/ftape/lowlevel/ftape-setup.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/lowlevel/ftape-setup.c,v
retrieving revision 1.1.1.1.2.2
diff -u -r1.1.1.1.2.2 ftape-setup.c
--- ./drivers/char/ftape/lowlevel/ftape-setup.c	4 Dec 2000 15:42:32 -0000	1.1.1.1.2.2
+++ ./drivers/char/ftape/lowlevel/ftape-setup.c	5 Dec 2001 14:03:30 -0000
@@ -29,7 +29,6 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
-#include <asm/segment.h>
 
 #include <linux/ftape.h>
 #if LINUX_VERSION_CODE >= KERNEL_VER(2,1,16)
Index: ./drivers/char/ftape/lowlevel/ftape-write.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/lowlevel/ftape-write.c,v
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1.2.1 ftape-write.c
--- ./drivers/char/ftape/lowlevel/ftape-write.c	5 Dec 2000 11:44:58 -0000	1.1.1.1.2.1
+++ ./drivers/char/ftape/lowlevel/ftape-write.c	5 Dec 2001 14:03:30 -0000
@@ -28,7 +28,6 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
-#include <asm/segment.h>
 
 #include <linux/ftape.h>
 #include <linux/qic117.h>
Index: ./drivers/char/ftape/zftape/zftape-init.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/zftape/zftape-init.c,v
retrieving revision 1.2.2.10.2.2
diff -u -r1.2.2.10.2.2 zftape-init.c
--- ./drivers/char/ftape/zftape/zftape-init.c	1 Dec 2001 16:14:21 -0000	1.2.2.10.2.2
+++ ./drivers/char/ftape/zftape/zftape-init.c	5 Dec 2001 14:03:30 -0000
@@ -25,7 +25,6 @@
 #include <linux/errno.h>
 #include <linux/version.h>
 #include <linux/fs.h>
-#include <asm/segment.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/major.h>
Index: ./drivers/char/ftape/zftape/zftape-buffers.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/zftape/zftape-buffers.c,v
retrieving revision 1.1.1.1.2.2
diff -u -r1.1.1.1.2.2 zftape-buffers.c
--- ./drivers/char/ftape/zftape/zftape-buffers.c	24 Feb 2001 19:01:21 -0000	1.1.1.1.2.2
+++ ./drivers/char/ftape/zftape/zftape-buffers.c	5 Dec 2001 14:03:30 -0000
@@ -27,7 +27,6 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <asm/segment.h>
 
 #include <linux/zftape.h>
 
Index: ./drivers/char/ftape/zftape/zftape-ctl.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/zftape/zftape-ctl.c,v
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1.2.1 zftape-ctl.c
--- ./drivers/char/ftape/zftape/zftape-ctl.c	5 Dec 2000 11:44:58 -0000	1.1.1.1.2.1
+++ ./drivers/char/ftape/zftape/zftape-ctl.c	5 Dec 2001 14:03:30 -0000
@@ -36,7 +36,6 @@
 #if LINUX_VERSION_CODE >= KERNEL_VER(2,1,6)
 #include <asm/uaccess.h>
 #else
-#include <asm/segment.h>
 #endif
 
 #include "../zftape/zftape-init.h"
Index: ./drivers/char/ftape/zftape/zftape-read.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/zftape/zftape-read.c,v
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1.2.1 zftape-read.c
--- ./drivers/char/ftape/zftape/zftape-read.c	5 Dec 2000 11:44:58 -0000	1.1.1.1.2.1
+++ ./drivers/char/ftape/zftape/zftape-read.c	5 Dec 2001 14:03:30 -0000
@@ -32,7 +32,6 @@
 #if LINUX_VERSION_CODE >= KERNEL_VER(2,1,6)
 #include <asm/uaccess.h>
 #else
-#include <asm/segment.h>
 #endif
 
 #include "../zftape/zftape-init.h"
Index: ./drivers/char/ftape/zftape/zftape-rw.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/zftape/zftape-rw.c,v
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1.2.1 zftape-rw.c
--- ./drivers/char/ftape/zftape/zftape-rw.c	5 Dec 2000 11:44:58 -0000	1.1.1.1.2.1
+++ ./drivers/char/ftape/zftape/zftape-rw.c	5 Dec 2001 14:03:30 -0000
@@ -27,7 +27,6 @@
 #include <linux/config.h> /* for CONFIG_ZFT_DFLT_BLK_SZ */
 #include <linux/errno.h>
 #include <linux/mm.h>
-#include <asm/segment.h>
 
 #include <linux/zftape.h>
 #include "../zftape/zftape-init.h"
Index: ./drivers/char/ftape/zftape/zftape-vtbl.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/zftape/zftape-vtbl.c,v
retrieving revision 1.1.1.1.2.3
diff -u -r1.1.1.1.2.3 zftape-vtbl.c
--- ./drivers/char/ftape/zftape/zftape-vtbl.c	9 Apr 2001 13:38:28 -0000	1.1.1.1.2.3
+++ ./drivers/char/ftape/zftape/zftape-vtbl.c	5 Dec 2001 14:03:30 -0000
@@ -31,7 +31,6 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <asm/segment.h>
 
 #include <linux/zftape.h>
 #include "../zftape/zftape-init.h"
Index: ./drivers/char/ftape/zftape/zftape-write.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ftape/zftape/zftape-write.c,v
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1.2.1 zftape-write.c
--- ./drivers/char/ftape/zftape/zftape-write.c	5 Dec 2000 11:44:58 -0000	1.1.1.1.2.1
+++ ./drivers/char/ftape/zftape/zftape-write.c	5 Dec 2001 14:03:30 -0000
@@ -32,7 +32,6 @@
 #if LINUX_VERSION_CODE >= KERNEL_VER(2,1,6)
 #include <asm/uaccess.h>
 #else
-#include <asm/segment.h>
 #endif
 
 #include "../zftape/zftape-init.h"
Index: ./drivers/char/dsp56k.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/dsp56k.c,v
retrieving revision 1.1.1.1.2.16
diff -u -r1.1.1.1.2.16 dsp56k.c
--- ./drivers/char/dsp56k.c	12 Sep 2001 09:56:47 -0000	1.1.1.1.2.16
+++ ./drivers/char/dsp56k.c	5 Dec 2001 14:03:30 -0000
@@ -37,7 +37,6 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 
-#include <asm/segment.h>
 #include <asm/atarihw.h>
 #include <asm/traps.h>
 #include <asm/uaccess.h>	/* For put_user and get_user */
Index: ./drivers/char/dtlk.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/dtlk.c,v
retrieving revision 1.2.2.14.2.1
diff -u -r1.2.2.14.2.1 dtlk.c
--- ./drivers/char/dtlk.c	29 Nov 2001 10:42:43 -0000	1.2.2.14.2.1
+++ ./drivers/char/dtlk.c	5 Dec 2001 14:03:30 -0000
@@ -57,7 +57,6 @@
 #include <linux/errno.h>	/* for -EBUSY */
 #include <linux/ioport.h>	/* for check_region, request_region */
 #include <linux/delay.h>	/* for loops_per_jiffy */
-#include <asm/segment.h>	/* for put_user_byte */
 #include <asm/io.h>		/* for inb_p, outb_p, inb, outb, etc. */
 #include <asm/uaccess.h>	/* for get_user, etc. */
 #include <linux/wait.h>		/* for wait_queue */
Index: ./drivers/char/epca.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/epca.c,v
retrieving revision 1.2.2.19
diff -u -r1.2.2.19 epca.c
--- ./drivers/char/epca.c	13 Oct 2001 11:07:58 -0000	1.2.2.19
+++ ./drivers/char/epca.c	5 Dec 2001 14:03:30 -0000
@@ -897,7 +897,6 @@
 					inline void copy_from_user(void * to, const void * from,
 					                          unsigned long count);
 
-					You must include <asm/segment.h>
 					I also think (Check hackers guide) that optimization must
 					be turned ON.  (Which sounds strange to me...)
 	
Index: ./drivers/char/esp.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/esp.c,v
retrieving revision 1.1.1.1.2.12
diff -u -r1.1.1.1.2.12 esp.c
--- ./drivers/char/esp.c	9 Nov 2001 23:40:28 -0000	1.1.1.1.2.12
+++ ./drivers/char/esp.c	5 Dec 2001 14:03:30 -0000
@@ -60,7 +60,6 @@
 
 #include <asm/system.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 
 #include <asm/dma.h>
Index: ./drivers/char/h8.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/h8.c,v
retrieving revision 1.1.1.1.2.10
diff -u -r1.1.1.1.2.10 h8.c
--- ./drivers/char/h8.c	17 Sep 2001 13:10:02 -0000	1.1.1.1.2.10
+++ ./drivers/char/h8.c	5 Dec 2001 14:03:30 -0000
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 
 #include <linux/types.h>
Index: ./drivers/char/isicom.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/isicom.c,v
retrieving revision 1.3.2.14
diff -u -r1.3.2.14 isicom.c
--- ./drivers/char/isicom.c	9 Nov 2001 23:40:28 -0000	1.3.2.14
+++ ./drivers/char/isicom.c	5 Dec 2001 14:03:30 -0000
@@ -51,7 +51,6 @@
 #include <linux/timer.h>
 #include <linux/ioport.h>
 
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
Index: ./drivers/char/n_hdlc.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/n_hdlc.c,v
retrieving revision 1.1.2.12
diff -u -r1.1.2.12 n_hdlc.c
--- ./drivers/char/n_hdlc.c	17 Sep 2001 13:10:02 -0000	1.1.2.12
+++ ./drivers/char/n_hdlc.c	5 Dec 2001 14:03:30 -0000
@@ -112,7 +112,6 @@
 #include <linux/kerneld.h>
 #endif
 
-#include <asm/segment.h>
 #define GET_USER(error,value,addr) error = get_user(value,addr)
 #define COPY_FROM_USER(error,dest,src,size) error = copy_from_user(dest,src,size) ? -EFAULT : 0
 #define PUT_USER(error,value,addr) error = put_user(value,addr)
Index: ./drivers/char/moxa.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/moxa.c,v
retrieving revision 1.2.2.11
diff -u -r1.2.2.11 moxa.c
--- ./drivers/char/moxa.c	26 Oct 2001 15:28:47 -0000	1.2.2.11
+++ ./drivers/char/moxa.c	5 Dec 2001 14:03:30 -0000
@@ -53,7 +53,6 @@
 
 #include <asm/system.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
Index: ./drivers/char/serial167.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/serial167.c,v
retrieving revision 1.1.1.1.2.9
diff -u -r1.1.1.1.2.9 serial167.c
--- ./drivers/char/serial167.c	17 Sep 2001 14:24:33 -0000	1.1.1.1.2.9
+++ ./drivers/char/serial167.c	5 Dec 2001 14:03:30 -0000
@@ -65,7 +65,6 @@
 
 #include <asm/system.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 #include <asm/mvme16xhw.h>
 #include <asm/bootinfo.h>
Index: ./drivers/char/ip2main.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/ip2main.c,v
retrieving revision 1.4.2.17
diff -u -r1.4.2.17 ip2main.c
--- ./drivers/char/ip2main.c	4 Nov 2001 10:23:29 -0000	1.4.2.17
+++ ./drivers/char/ip2main.c	5 Dec 2001 14:03:30 -0000
@@ -142,7 +142,6 @@
 // so blame them.
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,4)
-#	include <asm/segment.h>
 #	define GET_USER(error,value,addr) error = get_user(value,addr)
 #	define COPY_FROM_USER(error,dest,src,size) error = copy_from_user(dest,src,size) ? -EFAULT : 0
 #	define PUT_USER(error,value,addr) error = put_user(value,addr)
Index: ./drivers/char/mxser.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/mxser.c,v
retrieving revision 1.2.2.12
diff -u -r1.2.2.12 mxser.c
--- ./drivers/char/mxser.c	26 Oct 2001 15:28:47 -0000	1.2.2.12
+++ ./drivers/char/mxser.c	5 Dec 2001 14:03:30 -0000
@@ -58,7 +58,6 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
Index: ./drivers/char/synclink.c
===================================================================
RCS file: /inst/cvs/linux/drivers/char/synclink.c,v
retrieving revision 1.1.2.20
diff -u -r1.1.2.20 synclink.c
--- ./drivers/char/synclink.c	17 Sep 2001 14:24:33 -0000	1.1.2.20
+++ ./drivers/char/synclink.c	5 Dec 2001 14:03:30 -0000
@@ -114,7 +114,6 @@
 #endif
 #endif
 
-#include <asm/segment.h>
 #define GET_USER(error,value,addr) error = get_user(value,addr)
 #define COPY_FROM_USER(error,dest,src,size) error = copy_from_user(dest,src,size) ? -EFAULT : 0
 #define PUT_USER(error,value,addr) error = put_user(value,addr)
Index: ./drivers/isdn/act2000/act2000.h
===================================================================
RCS file: /inst/cvs/linux/drivers/isdn/act2000/act2000.h,v
retrieving revision 1.2.2.5
diff -u -r1.2.2.5 act2000.h
--- ./drivers/isdn/act2000/act2000.h	1 Oct 2001 21:50:35 -0000	1.2.2.5
+++ ./drivers/isdn/act2000/act2000.h	5 Dec 2001 14:03:30 -0000
@@ -68,7 +68,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
Index: ./drivers/isdn/avmb1/kcapi.c
===================================================================
RCS file: /inst/cvs/linux/drivers/isdn/avmb1/kcapi.c,v
retrieving revision 1.6.2.19
diff -u -r1.6.2.19 kcapi.c
--- ./drivers/isdn/avmb1/kcapi.c	1 Oct 2001 21:50:36 -0000	1.6.2.19
+++ ./drivers/isdn/avmb1/kcapi.c	5 Dec 2001 14:03:30 -0000
@@ -17,7 +17,6 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <asm/segment.h>
 #include <linux/proc_fs.h>
 #include <linux/skbuff.h>
 #include <linux/tqueue.h>
Index: ./drivers/isdn/avmb1/capidrv.c
===================================================================
RCS file: /inst/cvs/linux/drivers/isdn/avmb1/capidrv.c,v
retrieving revision 1.1.1.1.2.19
diff -u -r1.1.1.1.2.19 capidrv.c
--- ./drivers/isdn/avmb1/capidrv.c	1 Oct 2001 21:50:35 -0000	1.1.1.1.2.19
+++ ./drivers/isdn/avmb1/capidrv.c	5 Dec 2001 14:03:30 -0000
@@ -29,7 +29,6 @@
 #include <linux/kernelcapi.h>
 #include <linux/ctype.h>
 #include <linux/init.h>
-#include <asm/segment.h>
 
 #include "capiutil.h"
 #include "capicmd.h"
Index: ./drivers/isdn/avmb1/capiutil.c
===================================================================
RCS file: /inst/cvs/linux/drivers/isdn/avmb1/capiutil.c,v
retrieving revision 1.1.1.1.2.8
diff -u -r1.1.1.1.2.8 capiutil.c
--- ./drivers/isdn/avmb1/capiutil.c	1 Oct 2001 21:50:36 -0000	1.1.1.1.2.8
+++ ./drivers/isdn/avmb1/capiutil.c	5 Dec 2001 14:03:30 -0000
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/init.h>
-#include <asm/segment.h>
 #include <linux/config.h>
 #include "capiutil.h"
 
Index: ./drivers/isdn/hisax/hisax.h
===================================================================
RCS file: /inst/cvs/linux/drivers/isdn/hisax/hisax.h,v
retrieving revision 1.2.2.23
diff -u -r1.2.2.23 hisax.h
--- ./drivers/isdn/hisax/hisax.h	1 Oct 2001 21:50:36 -0000	1.2.2.23
+++ ./drivers/isdn/hisax/hisax.h	5 Dec 2001 14:03:30 -0000
@@ -10,7 +10,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
Index: ./drivers/isdn/icn/icn.h
===================================================================
RCS file: /inst/cvs/linux/drivers/isdn/icn/icn.h,v
retrieving revision 1.1.1.1.2.8
diff -u -r1.1.1.1.2.8 icn.h
--- ./drivers/isdn/icn/icn.h	1 Oct 2001 21:50:40 -0000	1.1.1.1.2.8
+++ ./drivers/isdn/icn/icn.h	5 Dec 2001 14:03:30 -0000
@@ -39,7 +39,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
Index: ./drivers/isdn/isdnloop/isdnloop.h
===================================================================
RCS file: /inst/cvs/linux/drivers/isdn/isdnloop/isdnloop.h,v
retrieving revision 1.1.1.1.2.7
diff -u -r1.1.1.1.2.7 isdnloop.h
--- ./drivers/isdn/isdnloop/isdnloop.h	1 Oct 2001 21:50:40 -0000	1.1.1.1.2.7
+++ ./drivers/isdn/isdnloop/isdnloop.h	5 Dec 2001 14:03:30 -0000
@@ -37,7 +37,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
Index: ./drivers/isdn/sc/includes.h
===================================================================
RCS file: /inst/cvs/linux/drivers/isdn/sc/includes.h,v
retrieving revision 1.1.1.1.2.2
diff -u -r1.1.1.1.2.2 includes.h
--- ./drivers/isdn/sc/includes.h	1 Oct 2001 21:50:40 -0000	1.1.1.1.2.2
+++ ./drivers/isdn/sc/includes.h	5 Dec 2001 14:03:30 -0000
@@ -6,7 +6,6 @@
 
 #include <linux/version.h>
 #include <linux/errno.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
Index: ./drivers/isdn/eicon/eicon.h
===================================================================
RCS file: /inst/cvs/linux/drivers/isdn/eicon/eicon.h,v
retrieving revision 1.5.2.12
diff -u -r1.5.2.12 eicon.h
--- ./drivers/isdn/eicon/eicon.h	1 Oct 2001 21:50:36 -0000	1.5.2.12
+++ ./drivers/isdn/eicon/eicon.h	5 Dec 2001 14:03:30 -0000
@@ -123,7 +123,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
Index: ./drivers/isdn/eicon/lincfg.c
===================================================================
RCS file: /inst/cvs/linux/drivers/isdn/eicon/lincfg.c,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 lincfg.c
--- ./drivers/isdn/eicon/lincfg.c	1 Oct 2001 21:50:36 -0000	1.1.2.4
+++ ./drivers/isdn/eicon/lincfg.c	5 Dec 2001 14:03:30 -0000
@@ -11,7 +11,6 @@
 #include <linux/fs.h>
 #undef N_DATA   /* Because we have our own definition */
 
-#include <asm/segment.h>
 #include <asm/io.h>
 
 #include "sys.h"
Index: ./drivers/isdn/isdn_bsdcomp.c
===================================================================
RCS file: /inst/cvs/linux/drivers/isdn/isdn_bsdcomp.c,v
retrieving revision 1.2.2.6
diff -u -r1.2.2.6 isdn_bsdcomp.c
--- ./drivers/isdn/isdn_bsdcomp.c	1 Oct 2001 21:50:35 -0000	1.2.2.6
+++ ./drivers/isdn/isdn_bsdcomp.c	5 Dec 2001 14:03:31 -0000
@@ -71,7 +71,6 @@
 
 #include <asm/system.h>
 #include <asm/bitops.h>
-#include <asm/segment.h>
 #include <asm/byteorder.h>
 #include <asm/types.h>
 
Index: ./drivers/macintosh/macserial.c
===================================================================
RCS file: /inst/cvs/linux/drivers/macintosh/macserial.c,v
retrieving revision 1.3.2.19
diff -u -r1.3.2.19 macserial.c
--- ./drivers/macintosh/macserial.c	19 Oct 2001 14:02:13 -0000	1.3.2.19
+++ ./drivers/macintosh/macserial.c	5 Dec 2001 14:03:31 -0000
@@ -38,7 +38,6 @@
 #include <asm/irq.h>
 #include <asm/prom.h>
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 #include <asm/feature.h>
 #include <linux/adb.h>
Index: ./drivers/mtd/devices/doc1000.c
===================================================================
RCS file: /inst/cvs/linux/drivers/mtd/devices/Attic/doc1000.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 doc1000.c
--- ./drivers/mtd/devices/doc1000.c	5 Oct 2001 06:50:46 -0000	1.1.2.3
+++ ./drivers/mtd/devices/doc1000.c	5 Dec 2001 14:03:31 -0000
@@ -20,7 +20,6 @@
 #include <linux/ioctl.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <stdarg.h>
 #include <linux/delay.h>
 #include <linux/init.h>
Index: ./drivers/mtd/devices/pmc551.c
===================================================================
RCS file: /inst/cvs/linux/drivers/mtd/devices/Attic/pmc551.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 pmc551.c
--- ./drivers/mtd/devices/pmc551.c	5 Oct 2001 06:50:46 -0000	1.1.2.3
+++ ./drivers/mtd/devices/pmc551.c	5 Dec 2001 14:03:31 -0000
@@ -98,7 +98,6 @@
 #include <linux/ioctl.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <stdarg.h>
 #include <linux/pci.h>
 
Index: ./drivers/mtd/devices/slram.c
===================================================================
RCS file: /inst/cvs/linux/drivers/mtd/devices/Attic/slram.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 slram.c
--- ./drivers/mtd/devices/slram.c	5 Oct 2001 06:50:46 -0000	1.1.2.3
+++ ./drivers/mtd/devices/slram.c	5 Dec 2001 14:03:31 -0000
@@ -20,7 +20,6 @@
 #include <linux/init.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <stdarg.h>
 
 #include <linux/mtd/mtd.h>
Index: ./drivers/net/hamradio/soundmodem/sm_sbc.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/hamradio/soundmodem/sm_sbc.c,v
retrieving revision 1.1.1.1.2.3
diff -u -r1.1.1.1.2.3 sm_sbc.c
--- ./drivers/net/hamradio/soundmodem/sm_sbc.c	5 Dec 2000 10:39:26 -0000	1.1.1.1.2.3
+++ ./drivers/net/hamradio/soundmodem/sm_sbc.c	5 Dec 2001 14:03:31 -0000
@@ -50,7 +50,6 @@
 #if LINUX_VERSION_CODE >= 0x20100
 #include <asm/uaccess.h>
 #else
-#include <asm/segment.h>
 #include <linux/mm.h>
 
 #undef put_user
Index: ./drivers/net/hamradio/soundmodem/sm_wss.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/hamradio/soundmodem/sm_wss.c,v
retrieving revision 1.1.1.1.2.4
diff -u -r1.1.1.1.2.4 sm_wss.c
--- ./drivers/net/hamradio/soundmodem/sm_wss.c	28 Jun 2001 11:16:53 -0000	1.1.1.1.2.4
+++ ./drivers/net/hamradio/soundmodem/sm_wss.c	5 Dec 2001 14:03:31 -0000
@@ -49,7 +49,6 @@
 #if LINUX_VERSION_CODE >= 0x20100
 #include <asm/uaccess.h>
 #else
-#include <asm/segment.h>
 #include <linux/mm.h>
 
 #undef put_user
Index: ./drivers/net/hamradio/mkiss.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/hamradio/mkiss.c,v
retrieving revision 1.1.1.1.2.10
diff -u -r1.1.1.1.2.10 mkiss.c
--- ./drivers/net/hamradio/mkiss.c	17 Sep 2001 13:10:03 -0000	1.1.1.1.2.10
+++ ./drivers/net/hamradio/mkiss.c	5 Dec 2001 14:03:31 -0000
@@ -27,7 +27,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
Index: ./drivers/net/hamradio/bpqether.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/hamradio/bpqether.c,v
retrieving revision 1.1.1.1.2.16
diff -u -r1.1.1.1.2.16 bpqether.c
--- ./drivers/net/hamradio/bpqether.c	17 Sep 2001 13:10:03 -0000	1.1.1.1.2.16
+++ ./drivers/net/hamradio/bpqether.c	5 Dec 2001 14:03:31 -0000
@@ -69,7 +69,6 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <linux/mm.h>
Index: ./drivers/net/hamradio/dmascc.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/hamradio/dmascc.c,v
retrieving revision 1.1.1.1.2.8
diff -u -r1.1.1.1.2.8 dmascc.c
--- ./drivers/net/hamradio/dmascc.c	14 May 2001 09:24:40 -0000	1.1.1.1.2.8
+++ ./drivers/net/hamradio/dmascc.c	5 Dec 2001 14:03:31 -0000
@@ -43,7 +43,6 @@
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <net/ax25.h>
 #include "z8530.h"
Index: ./drivers/net/wan/lapbether.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/wan/Attic/lapbether.c,v
retrieving revision 1.1.2.9
diff -u -r1.1.2.9 lapbether.c
--- ./drivers/net/wan/lapbether.c	17 Sep 2001 13:10:04 -0000	1.1.2.9
+++ ./drivers/net/wan/lapbether.c	5 Dec 2001 14:03:31 -0000
@@ -32,7 +32,6 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <linux/mm.h>
Index: ./drivers/net/wan/sdla_fr.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/wan/Attic/sdla_fr.c,v
retrieving revision 1.1.2.18
diff -u -r1.1.2.18 sdla_fr.c
--- ./drivers/net/wan/sdla_fr.c	17 Sep 2001 13:10:04 -0000	1.1.2.18
+++ ./drivers/net/wan/sdla_fr.c	5 Dec 2001 14:03:31 -0000
@@ -169,7 +169,6 @@
  #include <linux/netdevice.h>
 
 #else
- #include <asm/segment.h>
 #endif
 
 #include <net/route.h>          	/* Dynamic Route Creation */
Index: ./drivers/net/wan/sdla_ppp.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/wan/Attic/sdla_ppp.c,v
retrieving revision 1.1.2.17
diff -u -r1.1.2.17 sdla_ppp.c
--- ./drivers/net/wan/sdla_ppp.c	17 Sep 2001 13:10:04 -0000	1.1.2.17
+++ ./drivers/net/wan/sdla_ppp.c	5 Dec 2001 14:03:31 -0000
@@ -111,7 +111,6 @@
  #include <linux/inetdevice.h>
  #include <linux/netdevice.h>
 #else
- #include <asm/segment.h>
  #include <net/route.h>          /* Adding new route entries : 2.0.X kernels */
 #endif
 
Index: ./drivers/net/wan/sdla_x25.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/wan/Attic/sdla_x25.c,v
retrieving revision 1.1.2.14
diff -u -r1.1.2.14 sdla_x25.c
--- ./drivers/net/wan/sdla_x25.c	17 Sep 2001 13:10:04 -0000	1.1.2.14
+++ ./drivers/net/wan/sdla_x25.c	5 Dec 2001 14:03:31 -0000
@@ -98,7 +98,6 @@
 #if defined(LINUX_2_1) || defined(LINUX_2_4)
  #include <asm/uaccess.h>
 #else
- #include <asm/segment.h>
  #include <net/route.h>
 #endif
 
Index: ./drivers/net/wan/sdlamain.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/wan/Attic/sdlamain.c,v
retrieving revision 1.1.2.12
diff -u -r1.1.2.12 sdlamain.c
--- ./drivers/net/wan/sdlamain.c	17 Sep 2001 13:10:04 -0000	1.1.2.12
+++ ./drivers/net/wan/sdlamain.c	5 Dec 2001 14:03:31 -0000
@@ -78,7 +78,6 @@
 
 #else
 
- #include <asm/segment.h>
  #define devinet_ioctl(x,y) dev_ioctl(x,y)
  #define netdevice_t struct device 
  #define test_and_set_bit set_bit
Index: ./drivers/net/wan/sdla_chdlc.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/wan/Attic/sdla_chdlc.c,v
retrieving revision 1.1.2.16
diff -u -r1.1.2.16 sdla_chdlc.c
--- ./drivers/net/wan/sdla_chdlc.c	17 Sep 2001 13:10:04 -0000	1.1.2.16
+++ ./drivers/net/wan/sdla_chdlc.c	5 Dec 2001 14:03:31 -0000
@@ -65,7 +65,6 @@
  #include <linux/inetdevice.h>
  #include <linux/netdevice.h>
 #else 				
- #include <asm/segment.h>
  #include <net/route.h>          /* Adding new route entries : 2.0.X kernels */
 #endif
 
Index: ./drivers/net/wan/lmc/lmc_main.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/wan/lmc/Attic/lmc_main.c,v
retrieving revision 1.1.2.11
diff -u -r1.1.2.11 lmc_main.c
--- ./drivers/net/wan/lmc/lmc_main.c	17 Sep 2001 13:10:17 -0000	1.1.2.11
+++ ./drivers/net/wan/lmc/lmc_main.c	5 Dec 2001 14:03:31 -0000
@@ -50,7 +50,6 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
-#include <asm/segment.h>
 #include <linux/init.h>
 
 #if LINUX_VERSION_CODE < 0x20155
Index: ./drivers/net/wan/lmc/lmc_media.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/wan/lmc/Attic/lmc_media.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 lmc_media.c
--- ./drivers/net/wan/lmc/lmc_media.c	13 Mar 2001 10:06:31 -0000	1.1.2.3
+++ ./drivers/net/wan/lmc/lmc_media.c	5 Dec 2001 14:03:31 -0000
@@ -12,7 +12,6 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
-#include <asm/segment.h>
 //#include <asm/smp.h>
 
 #if LINUX_VERSION_CODE < 0x20155
Index: ./drivers/net/wan/lmc/lmc_proto.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/wan/lmc/Attic/lmc_proto.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 lmc_proto.c
--- ./drivers/net/wan/lmc/lmc_proto.c	13 Mar 2001 10:06:31 -0000	1.1.2.3
+++ ./drivers/net/wan/lmc/lmc_proto.c	5 Dec 2001 14:03:31 -0000
@@ -30,7 +30,6 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
-#include <asm/segment.h>
 #include <asm/smp.h>
 
 #include <linux/in.h>
Index: ./drivers/net/strip.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/strip.c,v
retrieving revision 1.1.1.1.2.16
diff -u -r1.1.1.1.2.16 strip.c
--- ./drivers/net/strip.c	9 Nov 2001 23:40:30 -0000	1.1.1.1.2.16
+++ ./drivers/net/strip.c	5 Dec 2001 14:03:31 -0000
@@ -87,7 +87,6 @@
 #include <linux/init.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 
 /*
Index: ./drivers/net/sgiseeq.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/sgiseeq.c,v
retrieving revision 1.1.1.1.2.10
diff -u -r1.1.1.1.2.10 sgiseeq.c
--- ./drivers/net/sgiseeq.c	17 Apr 2001 08:51:49 -0000	1.1.1.1.2.10
+++ ./drivers/net/sgiseeq.c	5 Dec 2001 14:03:31 -0000
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 
 #include <asm/io.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/page.h>
Index: ./drivers/net/jazzsonic.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/jazzsonic.c,v
retrieving revision 1.1.2.8
diff -u -r1.1.2.8 jazzsonic.c
--- ./drivers/net/jazzsonic.c	10 Sep 2001 11:57:48 -0000	1.1.2.8
+++ ./drivers/net/jazzsonic.c	5 Dec 2001 14:03:31 -0000
@@ -29,7 +29,6 @@
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/pgtable.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/jazz.h>
Index: ./drivers/net/macsonic.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/macsonic.c,v
retrieving revision 1.1.2.11
diff -u -r1.1.2.11 macsonic.c
--- ./drivers/net/macsonic.c	19 Oct 2001 14:08:21 -0000	1.1.2.11
+++ ./drivers/net/macsonic.c	5 Dec 2001 14:03:31 -0000
@@ -40,7 +40,6 @@
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/pgtable.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/hwtest.h>
 #include <asm/dma.h>
Index: ./drivers/net/irda/irtty.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/irda/irtty.c,v
retrieving revision 1.4.2.22
diff -u -r1.4.2.22 irtty.c
--- ./drivers/net/irda/irtty.c	1 Oct 2001 21:50:43 -0000	1.4.2.22
+++ ./drivers/net/irda/irtty.c	5 Dec 2001 14:03:31 -0000
@@ -32,7 +32,6 @@
 #include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
 
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 
 #include <net/irda/irda.h>
Index: ./drivers/net/wireless/airo.c
===================================================================
RCS file: /inst/cvs/linux/drivers/net/wireless/Attic/airo.c,v
retrieving revision 1.1.2.10
diff -u -r1.1.2.10 airo.c
--- ./drivers/net/wireless/airo.c	9 Nov 2001 23:40:30 -0000	1.1.2.10
+++ ./drivers/net/wireless/airo.c	5 Dec 2001 14:03:31 -0000
@@ -19,7 +19,6 @@
 
 #include <linux/config.h>
 #include <linux/version.h>
-#include <asm/segment.h>
 #include <linux/init.h>
 
 #include <linux/kernel.h>
Index: ./drivers/sbus/char/bpp.c
===================================================================
RCS file: /inst/cvs/linux/drivers/sbus/char/bpp.c,v
retrieving revision 1.2.2.19
diff -u -r1.2.2.19 bpp.c
--- ./drivers/sbus/char/bpp.c	12 Oct 2001 15:31:49 -0000	1.2.2.19
+++ ./drivers/sbus/char/bpp.c	5 Dec 2001 14:03:31 -0000
@@ -28,7 +28,6 @@
 
 #if defined(__i386__)
 # include <asm/system.h>
-# include <asm/segment.h>
 #endif
 
 #if defined(__sparc__)
Index: ./drivers/sbus/char/aurora.c
===================================================================
RCS file: /inst/cvs/linux/drivers/sbus/char/aurora.c,v
retrieving revision 1.2.2.18
diff -u -r1.2.2.18 aurora.c
--- ./drivers/sbus/char/aurora.c	31 Oct 2001 12:04:00 -0000	1.2.2.18
+++ ./drivers/sbus/char/aurora.c	5 Dec 2001 14:03:31 -0000
@@ -66,7 +66,6 @@
 #include <asm/irq.h>
 #include <asm/oplib.h>
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 #include <asm/kdebug.h>
 #include <asm/sbus.h>
Index: ./drivers/scsi/qla1280.c
===================================================================
RCS file: /inst/cvs/linux/drivers/scsi/Attic/qla1280.c,v
retrieving revision 1.1.2.11
diff -u -r1.1.2.11 qla1280.c
--- ./drivers/scsi/qla1280.c	1 Oct 2001 21:50:56 -0000	1.1.2.11
+++ ./drivers/scsi/qla1280.c	5 Dec 2001 14:03:31 -0000
@@ -192,7 +192,6 @@
 #include <stdarg.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/segment.h>
 #include <asm/byteorder.h>
 #include <linux/version.h>
 #include <linux/types.h>
Index: ./drivers/sound/os.h
===================================================================
RCS file: /inst/cvs/linux/drivers/sound/os.h,v
retrieving revision 1.1.1.1.2.2
diff -u -r1.1.1.1.2.2 os.h
--- ./drivers/sound/os.h	24 Feb 2001 19:01:36 -0000	1.1.1.1.2.2
+++ ./drivers/sound/os.h	5 Dec 2001 14:03:31 -0000
@@ -25,7 +25,6 @@
 #include <asm/page.h>
 #include <asm/system.h>
 #ifdef __alpha__
-#include <asm/segment.h>
 #endif
 #include <linux/vmalloc.h>
 #include <asm/uaccess.h>
Index: ./drivers/sound/msnd.c
===================================================================
RCS file: /inst/cvs/linux/drivers/sound/msnd.c,v
retrieving revision 1.1.1.1.2.7
diff -u -r1.1.1.1.2.7 msnd.c
--- ./drivers/sound/msnd.c	1 Oct 2001 21:50:58 -0000	1.1.1.1.2.7
+++ ./drivers/sound/msnd.c	5 Dec 2001 14:03:31 -0000
@@ -39,7 +39,6 @@
 #  include <linux/major.h>
 #  include <linux/fs.h>
 #  include <linux/sound.h>
-#  include <asm/segment.h>
 #  include "sound_config.h"
 #else
 #  include <linux/init.h>
Index: ./drivers/sound/soundcard.c
===================================================================
RCS file: /inst/cvs/linux/drivers/sound/soundcard.c,v
retrieving revision 1.2.2.20
diff -u -r1.2.2.20 soundcard.c
--- ./drivers/sound/soundcard.c	1 Oct 2001 21:50:58 -0000	1.2.2.20
+++ ./drivers/sound/soundcard.c	5 Dec 2001 14:03:31 -0000
@@ -35,7 +35,6 @@
 #include <linux/kmod.h>
 #include <asm/dma.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
Index: ./drivers/sound/sscape.c
===================================================================
RCS file: /inst/cvs/linux/drivers/sound/sscape.c,v
retrieving revision 1.2.2.12
diff -u -r1.2.2.12 sscape.c
--- ./drivers/sound/sscape.c	1 Oct 2001 21:50:58 -0000	1.2.2.12
+++ ./drivers/sound/sscape.c	5 Dec 2001 14:03:31 -0000
@@ -34,7 +34,6 @@
 #include <linux/kmod.h>
 #include <asm/dma.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
Index: ./drivers/video/dnfb.c
===================================================================
RCS file: /inst/cvs/linux/drivers/video/dnfb.c,v
retrieving revision 1.1.1.1.2.10
diff -u -r1.1.1.1.2.10 dnfb.c
--- ./drivers/video/dnfb.c	17 Sep 2001 13:10:18 -0000	1.1.1.1.2.10
+++ ./drivers/video/dnfb.c	5 Dec 2001 14:03:31 -0000
@@ -7,7 +7,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <asm/setup.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/amigahw.h>
Index: ./drivers/video/q40fb.c
===================================================================
RCS file: /inst/cvs/linux/drivers/video/q40fb.c,v
retrieving revision 1.1.2.8
diff -u -r1.1.2.8 q40fb.c
--- ./drivers/video/q40fb.c	17 Sep 2001 13:10:18 -0000	1.1.2.8
+++ ./drivers/video/q40fb.c	5 Dec 2001 14:03:31 -0000
@@ -9,7 +9,6 @@
 
 #include <asm/uaccess.h>
 #include <asm/setup.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 /*#include <asm/irq.h>*/
 #include <asm/q40_master.h>
Index: ./drivers/video/dn_cfb4.c
===================================================================
RCS file: /inst/cvs/linux/drivers/video/Attic/dn_cfb4.c,v
retrieving revision 1.1.2.6
diff -u -r1.1.2.6 dn_cfb4.c
--- ./drivers/video/dn_cfb4.c	17 Sep 2001 13:10:18 -0000	1.1.2.6
+++ ./drivers/video/dn_cfb4.c	5 Dec 2001 14:03:31 -0000
@@ -7,7 +7,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <asm/setup.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/amigahw.h>
Index: ./drivers/video/dn_cfb8.c
===================================================================
RCS file: /inst/cvs/linux/drivers/video/Attic/dn_cfb8.c,v
retrieving revision 1.1.2.7
diff -u -r1.1.2.7 dn_cfb8.c
--- ./drivers/video/dn_cfb8.c	19 Oct 2001 14:02:14 -0000	1.1.2.7
+++ ./drivers/video/dn_cfb8.c	5 Dec 2001 14:03:31 -0000
@@ -7,7 +7,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <asm/setup.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/amigahw.h>
Index: ./drivers/tc/zs.c
===================================================================
RCS file: /inst/cvs/linux/drivers/tc/zs.c,v
retrieving revision 1.1.2.6
diff -u -r1.1.2.6 zs.c
--- ./drivers/tc/zs.c	7 Sep 2001 10:58:50 -0000	1.1.2.6
+++ ./drivers/tc/zs.c	5 Dec 2001 14:03:31 -0000
@@ -64,7 +64,6 @@
 #include <asm/pgtable.h>
 #include <asm/irq.h>
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/wbflush.h>
Index: ./drivers/atm/fore200e.c
===================================================================
RCS file: /inst/cvs/linux/drivers/atm/Attic/fore200e.c,v
retrieving revision 1.1.2.14
diff -u -r1.1.2.14 fore200e.c
--- ./drivers/atm/fore200e.c	17 Sep 2001 13:10:02 -0000	1.1.2.14
+++ ./drivers/atm/fore200e.c	5 Dec 2001 14:03:31 -0000
@@ -39,7 +39,6 @@
 #include <linux/atm_suni.h>
 #include <asm/io.h>
 #include <asm/string.h>
-#include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/irq.h>
 #include <asm/dma.h>
Index: ./drivers/pcmcia/i82365.c
===================================================================
RCS file: /inst/cvs/linux/drivers/pcmcia/Attic/i82365.c,v
retrieving revision 1.1.2.23.2.1
diff -u -r1.1.2.23.2.1 i82365.c
--- ./drivers/pcmcia/i82365.c	28 Nov 2001 13:55:46 -0000	1.1.2.23.2.1
+++ ./drivers/pcmcia/i82365.c	5 Dec 2001 14:03:31 -0000
@@ -49,7 +49,6 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/bitops.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 
 #include <pcmcia/version.h>
Index: ./drivers/pcmcia/tcic.c
===================================================================
RCS file: /inst/cvs/linux/drivers/pcmcia/Attic/tcic.c,v
retrieving revision 1.1.2.14
diff -u -r1.1.2.14 tcic.c
--- ./drivers/pcmcia/tcic.c	1 Oct 2001 21:50:51 -0000	1.1.2.14
+++ ./drivers/pcmcia/tcic.c	5 Dec 2001 14:03:31 -0000
@@ -39,7 +39,6 @@
 
 #include <asm/io.h>
 #include <asm/bitops.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 
 #include <linux/kernel.h>
Index: ./drivers/telephony/ixj.c
===================================================================
RCS file: /inst/cvs/linux/drivers/telephony/ixj.c,v
retrieving revision 1.5.2.23
diff -u -r1.5.2.23 ixj.c
--- ./drivers/telephony/ixj.c	26 Oct 2001 15:29:02 -0000	1.5.2.23
+++ ./drivers/telephony/ixj.c	5 Dec 2001 14:03:31 -0000
@@ -268,7 +268,6 @@
 #include <linux/pci.h>
 
 #include <asm/io.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 
 #include <linux/isapnp.h>
Index: ./drivers/ieee1394/ohci1394.c
===================================================================
RCS file: /inst/cvs/linux/drivers/ieee1394/Attic/ohci1394.c,v
retrieving revision 1.1.2.19
diff -u -r1.1.2.19 ohci1394.c
--- ./drivers/ieee1394/ohci1394.c	4 Oct 2001 07:21:50 -0000	1.1.2.19
+++ ./drivers/ieee1394/ohci1394.c	5 Dec 2001 14:03:31 -0000
@@ -99,7 +99,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 #include <linux/wrapper.h>
 #include <linux/vmalloc.h>
Index: ./drivers/ieee1394/video1394.c
===================================================================
RCS file: /inst/cvs/linux/drivers/ieee1394/Attic/video1394.c,v
retrieving revision 1.1.2.13
diff -u -r1.1.2.13 video1394.c
--- ./drivers/ieee1394/video1394.c	4 Oct 2001 07:21:50 -0000	1.1.2.13
+++ ./drivers/ieee1394/video1394.c	5 Dec 2001 14:03:31 -0000
@@ -43,7 +43,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 #include <linux/wrapper.h>
 #include <linux/vmalloc.h>
Index: ./drivers/input/joydev.c
===================================================================
RCS file: /inst/cvs/linux/drivers/input/Attic/joydev.c,v
retrieving revision 1.1.2.5.2.1
diff -u -r1.1.2.5.2.1 joydev.c
--- ./drivers/input/joydev.c	29 Nov 2001 10:42:43 -0000	1.1.2.5.2.1
+++ ./drivers/input/joydev.c	5 Dec 2001 14:03:31 -0000
@@ -31,7 +31,6 @@
 
 #include <asm/io.h>
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/joystick.h>
Index: ./drivers/media/video/bttv-driver.c
===================================================================
RCS file: /inst/cvs/linux/drivers/media/video/Attic/bttv-driver.c,v
retrieving revision 1.1.2.14
diff -u -r1.1.2.14 bttv-driver.c
--- ./drivers/media/video/bttv-driver.c	19 Oct 2001 14:08:21 -0000	1.1.2.14
+++ ./drivers/media/video/bttv-driver.c	5 Dec 2001 14:03:31 -0000
@@ -37,7 +37,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 #include <linux/wrapper.h>
 #include <linux/interrupt.h>
Index: ./drivers/media/video/saa7185.c
===================================================================
RCS file: /inst/cvs/linux/drivers/media/video/Attic/saa7185.c,v
retrieving revision 1.1.2.5
diff -u -r1.1.2.5 saa7185.c
--- ./drivers/media/video/saa7185.c	1 Oct 2001 21:50:41 -0000	1.1.2.5
+++ ./drivers/media/video/saa7185.c	5 Dec 2001 14:03:31 -0000
@@ -36,7 +36,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 #include <linux/wrapper.h>
 
Index: ./drivers/media/video/zr36120.c
===================================================================
RCS file: /inst/cvs/linux/drivers/media/video/Attic/zr36120.c,v
retrieving revision 1.1.2.13
diff -u -r1.1.2.13 zr36120.c
--- ./drivers/media/video/zr36120.c	9 Nov 2001 23:40:29 -0000	1.1.2.13
+++ ./drivers/media/video/zr36120.c	5 Dec 2001 14:03:31 -0000
@@ -35,7 +35,6 @@
 #include <asm/page.h>
 #include <linux/sched.h>
 #include <linux/video_decoder.h>
-#include <asm/segment.h>
 
 #include <linux/version.h>
 #include <asm/uaccess.h>
Index: ./drivers/media/video/stradis.c
===================================================================
RCS file: /inst/cvs/linux/drivers/media/video/Attic/stradis.c,v
retrieving revision 1.1.2.9
diff -u -r1.1.2.9 stradis.c
--- ./drivers/media/video/stradis.c	1 Oct 2001 21:50:41 -0000	1.1.2.9
+++ ./drivers/media/video/stradis.c	5 Dec 2001 14:03:31 -0000
@@ -37,7 +37,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <asm/types.h>
 #include <linux/types.h>
 #include <linux/wrapper.h>
Index: ./drivers/media/video/bt856.c
===================================================================
RCS file: /inst/cvs/linux/drivers/media/video/Attic/bt856.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 bt856.c
--- ./drivers/media/video/bt856.c	1 Oct 2001 21:50:41 -0000	1.1.2.3
+++ ./drivers/media/video/bt856.c	5 Dec 2001 14:03:31 -0000
@@ -40,7 +40,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 #include <linux/wrapper.h>
 
Index: ./drivers/media/video/adv7175.c
===================================================================
RCS file: /inst/cvs/linux/drivers/media/video/Attic/adv7175.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 adv7175.c
--- ./drivers/media/video/adv7175.c	1 Oct 2001 21:50:41 -0000	1.1.2.3
+++ ./drivers/media/video/adv7175.c	5 Dec 2001 14:03:31 -0000
@@ -38,7 +38,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 #include <linux/wrapper.h>
 
Index: ./drivers/media/video/zr36067.c
===================================================================
RCS file: /inst/cvs/linux/drivers/media/video/Attic/zr36067.c,v
retrieving revision 1.1.2.5
diff -u -r1.1.2.5 zr36067.c
--- ./drivers/media/video/zr36067.c	9 Nov 2001 23:40:29 -0000	1.1.2.5
+++ ./drivers/media/video/zr36067.c	5 Dec 2001 14:03:31 -0000
@@ -58,7 +58,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 #include <linux/wrapper.h>
 
Index: ./drivers/md/lvm.c
===================================================================
RCS file: /inst/cvs/linux/drivers/md/Attic/lvm.c,v
retrieving revision 1.1.2.18.2.2
diff -u -r1.1.2.18.2.2 lvm.c
--- ./drivers/md/lvm.c	30 Nov 2001 10:42:33 -0000	1.1.2.18.2.2
+++ ./drivers/md/lvm.c	5 Dec 2001 14:03:32 -0000
@@ -209,7 +209,6 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 #include <asm/ioctl.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_KERNELD
Index: ./fs/coda/cache.c
===================================================================
RCS file: /inst/cvs/linux/fs/coda/cache.c,v
retrieving revision 1.1.1.1.2.7
diff -u -r1.1.1.1.2.7 cache.c
--- ./fs/coda/cache.c	14 May 2001 09:53:16 -0000	1.1.1.1.2.7
+++ ./fs/coda/cache.c	5 Dec 2001 14:03:32 -0000
@@ -14,7 +14,6 @@
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/locks.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #include <linux/list.h>
Index: ./fs/coda/psdev.c
===================================================================
RCS file: /inst/cvs/linux/fs/coda/psdev.c,v
retrieving revision 1.1.1.1.2.19
diff -u -r1.1.1.1.2.19 psdev.c
--- ./fs/coda/psdev.c	23 Sep 2001 15:08:16 -0000	1.1.1.1.2.19
+++ ./fs/coda/psdev.c	5 Dec 2001 14:03:32 -0000
@@ -38,7 +38,6 @@
 #include <linux/list.h>
 #include <linux/smp_lock.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/poll.h>
 #include <asm/uaccess.h>
Index: ./fs/coda/coda_linux.c
===================================================================
RCS file: /inst/cvs/linux/fs/coda/coda_linux.c,v
retrieving revision 1.1.1.1.2.4
diff -u -r1.1.1.1.2.4 coda_linux.c
--- ./fs/coda/coda_linux.c	14 May 2001 09:53:16 -0000	1.1.1.1.2.4
+++ ./fs/coda/coda_linux.c	5 Dec 2001 14:03:32 -0000
@@ -15,7 +15,6 @@
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/locks.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 
Index: ./fs/coda/file.c
===================================================================
RCS file: /inst/cvs/linux/fs/coda/file.c,v
retrieving revision 1.1.1.1.2.14
diff -u -r1.1.1.1.2.14 file.c
--- ./fs/coda/file.c	23 Sep 2001 15:08:16 -0000	1.1.1.1.2.14
+++ ./fs/coda/file.c	5 Dec 2001 14:03:32 -0000
@@ -16,7 +16,6 @@
 #include <linux/errno.h>
 #include <linux/locks.h>
 #include <linux/smp_lock.h>
-#include <asm/segment.h>
 #include <linux/string.h>
 #include <asm/uaccess.h>
 
Index: ./fs/coda/inode.c
===================================================================
RCS file: /inst/cvs/linux/fs/coda/inode.c,v
retrieving revision 1.2.2.14
diff -u -r1.2.2.14 inode.c
--- ./fs/coda/inode.c	14 May 2001 10:32:25 -0000	1.2.2.14
+++ ./fs/coda/inode.c	5 Dec 2001 14:03:32 -0000
@@ -25,7 +25,6 @@
 
 #include <linux/fs.h>
 #include <linux/vmalloc.h>
-#include <asm/segment.h>
 
 #include <linux/coda.h>
 #include <linux/coda_linux.h>
Index: ./fs/coda/pioctl.c
===================================================================
RCS file: /inst/cvs/linux/fs/coda/pioctl.c,v
retrieving revision 1.1.1.1.2.10
diff -u -r1.1.1.1.2.10 pioctl.c
--- ./fs/coda/pioctl.c	5 Dec 2000 11:37:50 -0000	1.1.1.1.2.10
+++ ./fs/coda/pioctl.c	5 Dec 2001 14:03:32 -0000
@@ -14,7 +14,6 @@
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/locks.h>
-#include <asm/segment.h>
 #include <linux/string.h>
 #define __NO_VERSION__
 #include <linux/module.h>
Index: ./fs/coda/upcall.c
===================================================================
RCS file: /inst/cvs/linux/fs/coda/upcall.c,v
retrieving revision 1.2.2.13
diff -u -r1.2.2.13 upcall.c
--- ./fs/coda/upcall.c	12 Sep 2001 09:56:49 -0000	1.2.2.13
+++ ./fs/coda/upcall.c	5 Dec 2001 14:03:32 -0000
@@ -15,7 +15,6 @@
  */
 
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/signal.h>
 #include <linux/signal.h>
 
Index: ./fs/coda/sysctl.c
===================================================================
RCS file: /inst/cvs/linux/fs/coda/sysctl.c,v
retrieving revision 1.2.2.10
diff -u -r1.2.2.10 sysctl.c
--- ./fs/coda/sysctl.c	14 May 2001 09:53:16 -0000	1.2.2.10
+++ ./fs/coda/sysctl.c	5 Dec 2001 14:03:32 -0000
@@ -21,7 +21,6 @@
 #include <linux/stat.h>
 #include <linux/ctype.h>
 #include <asm/bitops.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/utsname.h>
 #define __NO_VERSION__
Index: ./fs/hpfs/hpfs_fn.h
===================================================================
RCS file: /inst/cvs/linux/fs/hpfs/Attic/hpfs_fn.h,v
retrieving revision 1.1.2.14
diff -u -r1.1.2.14 hpfs_fn.h
--- ./fs/hpfs/hpfs_fn.h	24 Feb 2001 19:01:45 -0000	1.1.2.14
+++ ./fs/hpfs/hpfs_fn.h	5 Dec 2001 14:03:32 -0000
@@ -19,7 +19,6 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <asm/bitops.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/smp_lock.h>
 
Index: ./fs/ncpfs/symlink.c
===================================================================
RCS file: /inst/cvs/linux/fs/ncpfs/symlink.c,v
retrieving revision 1.1.2.10
diff -u -r1.1.2.10 symlink.c
--- ./fs/ncpfs/symlink.c	1 Jan 2001 12:25:01 -0000	1.1.2.10
+++ ./fs/ncpfs/symlink.c	5 Dec 2001 14:03:32 -0000
@@ -21,7 +21,6 @@
 #ifdef CONFIG_NCPFS_EXTRAS
 
 #include <asm/uaccess.h>
-#include <asm/segment.h>
 
 #include <linux/errno.h>
 #include <linux/fs.h>
Index: ./fs/qnx4/dir.c
===================================================================
RCS file: /inst/cvs/linux/fs/qnx4/dir.c,v
retrieving revision 1.2.2.8
diff -u -r1.2.2.8 dir.c
--- ./fs/qnx4/dir.c	5 Dec 2000 11:11:50 -0000	1.2.2.8
+++ ./fs/qnx4/dir.c	5 Dec 2001 14:03:32 -0000
@@ -18,7 +18,6 @@
 #include <linux/qnx4_fs.h>
 #include <linux/stat.h>
 
-#include <asm/segment.h>
 
 static int qnx4_readdir(struct file *filp, void *dirent, filldir_t filldir)
 {
Index: ./fs/qnx4/fsync.c
===================================================================
RCS file: /inst/cvs/linux/fs/qnx4/fsync.c,v
retrieving revision 1.1.1.1.2.3
diff -u -r1.1.1.1.2.3 fsync.c
--- ./fs/qnx4/fsync.c	5 Dec 2000 09:55:38 -0000	1.1.1.1.2.3
+++ ./fs/qnx4/fsync.c	5 Dec 2001 14:03:32 -0000
@@ -21,7 +21,6 @@
 #include <linux/fs.h>
 #include <linux/qnx4_fs.h>
 
-#include <asm/segment.h>
 #include <asm/system.h>
 
 #define blocksize QNX4_BLOCK_SIZE
Index: ./fs/qnx4/namei.c
===================================================================
RCS file: /inst/cvs/linux/fs/qnx4/namei.c,v
retrieving revision 1.3.2.7
diff -u -r1.3.2.7 namei.c
--- ./fs/qnx4/namei.c	5 Dec 2000 11:20:11 -0000	1.3.2.7
+++ ./fs/qnx4/namei.c	5 Dec 2001 14:03:32 -0000
@@ -21,7 +21,6 @@
 #include <linux/fcntl.h>
 #include <linux/errno.h>
 
-#include <asm/segment.h>
 
 /*
  * check if the filename is correct. For some obscure reason, qnx writes a
Index: ./fs/intermezzo/dcache.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/dcache.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 dcache.c
--- ./fs/intermezzo/dcache.c	16 Nov 2001 16:38:51 -0000	1.1.2.2
+++ ./fs/intermezzo/dcache.c	5 Dec 2001 14:03:32 -0000
@@ -16,7 +16,6 @@
 #include <linux/errno.h>
 #include <linux/locks.h>
 #include <linux/slab.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 
Index: ./fs/intermezzo/ext_attr.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/ext_attr.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 ext_attr.c
--- ./fs/intermezzo/ext_attr.c	11 Nov 2001 21:51:47 -0000	1.1.2.1
+++ ./fs/intermezzo/ext_attr.c	5 Dec 2001 14:03:32 -0000
@@ -28,7 +28,6 @@
 #include <asm/uaccess.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <asm/segment.h>
 #include <linux/smp_lock.h>
 
 #include <linux/intermezzo_fs.h>
Index: ./fs/intermezzo/inode.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/inode.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 inode.c
--- ./fs/intermezzo/inode.c	11 Nov 2001 21:51:47 -0000	1.1.2.1
+++ ./fs/intermezzo/inode.c	5 Dec 2001 14:03:32 -0000
@@ -29,7 +29,6 @@
 #include <asm/uaccess.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <asm/segment.h>
 
 #include <linux/intermezzo_fs.h>
 #include <linux/intermezzo_upcall.h>
Index: ./fs/intermezzo/journal.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/journal.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 journal.c
--- ./fs/intermezzo/journal.c	16 Nov 2001 16:38:51 -0000	1.1.2.2
+++ ./fs/intermezzo/journal.c	5 Dec 2001 14:03:32 -0000
@@ -14,7 +14,6 @@
 #include <linux/time.h>
 #include <linux/errno.h>
 #include <linux/locks.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
Index: ./fs/intermezzo/journal_ext2.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/journal_ext2.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 journal_ext2.c
--- ./fs/intermezzo/journal_ext2.c	11 Nov 2001 21:51:47 -0000	1.1.2.1
+++ ./fs/intermezzo/journal_ext2.c	5 Dec 2001 14:03:32 -0000
@@ -12,7 +12,6 @@
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/locks.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #include <linux/ext2_fs.h> 
Index: ./fs/intermezzo/journal_ext3.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/journal_ext3.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 journal_ext3.c
--- ./fs/intermezzo/journal_ext3.c	11 Nov 2001 21:51:47 -0000	1.1.2.1
+++ ./fs/intermezzo/journal_ext3.c	5 Dec 2001 14:03:32 -0000
@@ -17,7 +17,6 @@
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/locks.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
Index: ./fs/intermezzo/journal_obdfs.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/journal_obdfs.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 journal_obdfs.c
--- ./fs/intermezzo/journal_obdfs.c	11 Nov 2001 21:51:47 -0000	1.1.2.1
+++ ./fs/intermezzo/journal_obdfs.c	5 Dec 2001 14:03:32 -0000
@@ -17,7 +17,6 @@
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/locks.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #ifdef CONFIG_OBDFS_FS
Index: ./fs/intermezzo/journal_reiserfs.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/journal_reiserfs.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 journal_reiserfs.c
--- ./fs/intermezzo/journal_reiserfs.c	11 Nov 2001 21:51:47 -0000	1.1.2.1
+++ ./fs/intermezzo/journal_reiserfs.c	5 Dec 2001 14:03:32 -0000
@@ -17,7 +17,6 @@
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
 #include <linux/locks.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #if 0
Index: ./fs/intermezzo/journal_xfs.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/journal_xfs.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 journal_xfs.c
--- ./fs/intermezzo/journal_xfs.c	16 Nov 2001 16:38:51 -0000	1.1.2.2
+++ ./fs/intermezzo/journal_xfs.c	5 Dec 2001 14:03:32 -0000
@@ -12,7 +12,6 @@
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/locks.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #ifdef CONFIG_FS_XFS
Index: ./fs/intermezzo/presto.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/presto.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 presto.c
--- ./fs/intermezzo/presto.c	16 Nov 2001 16:38:51 -0000	1.1.2.2
+++ ./fs/intermezzo/presto.c	5 Dec 2001 14:03:32 -0000
@@ -17,7 +17,6 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/locks.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
Index: ./fs/intermezzo/psdev.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/psdev.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 psdev.c
--- ./fs/intermezzo/psdev.c	11 Nov 2001 21:51:47 -0000	1.1.2.1
+++ ./fs/intermezzo/psdev.c	5 Dec 2001 14:03:32 -0000
@@ -46,7 +46,6 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/poll.h>
 #include <asm/uaccess.h>
Index: ./fs/intermezzo/sysctl.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/sysctl.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 sysctl.c
--- ./fs/intermezzo/sysctl.c	11 Nov 2001 21:51:47 -0000	1.1.2.1
+++ ./fs/intermezzo/sysctl.c	5 Dec 2001 14:03:32 -0000
@@ -16,7 +16,6 @@
 #include <linux/ctype.h>
 #include <linux/init.h>
 #include <asm/bitops.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <linux/utsname.h>
 #include <linux/blk.h>
Index: ./fs/intermezzo/upcall.c
===================================================================
RCS file: /inst/cvs/linux/fs/intermezzo/Attic/upcall.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 upcall.c
--- ./fs/intermezzo/upcall.c	11 Nov 2001 21:51:47 -0000	1.1.2.1
+++ ./fs/intermezzo/upcall.c	5 Dec 2001 14:03:32 -0000
@@ -20,7 +20,6 @@
  */
 
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/signal.h>
 #include <linux/signal.h>
 
@@ -37,7 +36,6 @@
 #include <linux/string.h>
 #include <asm/uaccess.h>
 #include <linux/vmalloc.h>
-#include <asm/segment.h>
 
 #include <linux/intermezzo_fs.h>
 #include <linux/intermezzo_upcall.h>
Index: ./include/linux/isdn.h
===================================================================
RCS file: /inst/cvs/linux/include/linux/isdn.h,v
retrieving revision 1.1.1.1.2.22
diff -u -r1.1.1.1.2.22 isdn.h
--- ./include/linux/isdn.h	1 Oct 2001 21:51:05 -0000	1.1.1.1.2.22
+++ ./include/linux/isdn.h	5 Dec 2001 14:03:32 -0000
@@ -150,7 +150,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
Index: ./net/802/fddi.c
===================================================================
RCS file: /inst/cvs/linux/net/802/fddi.c,v
retrieving revision 1.1.1.1.2.2
diff -u -r1.1.1.1.2.2 fddi.c
--- ./net/802/fddi.c	5 Dec 2000 13:33:39 -0000	1.1.1.1.2.2
+++ ./net/802/fddi.c	5 Dec 2001 14:03:32 -0000
@@ -27,7 +27,6 @@
  */
  
 #include <linux/config.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
Index: ./net/802/hippi.c
===================================================================
RCS file: /inst/cvs/linux/net/802/hippi.c,v
retrieving revision 1.1.1.1.2.2
diff -u -r1.1.1.1.2.2 hippi.c
--- ./net/802/hippi.c	21 Jun 2001 09:40:19 -0000	1.1.1.1.2.2
+++ ./net/802/hippi.c	5 Dec 2001 14:03:32 -0000
@@ -36,7 +36,6 @@
 #include <net/sock.h>
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 
 /*
Index: ./net/8021q/vlanproc.c
===================================================================
RCS file: /inst/cvs/linux/net/8021q/Attic/vlanproc.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 vlanproc.c
--- ./net/8021q/vlanproc.c	16 Nov 2001 16:38:51 -0000	1.1.2.2
+++ ./net/8021q/vlanproc.c	5 Dec 2001 14:03:32 -0000
@@ -25,7 +25,6 @@
 #include <linux/mm.h>		/* verify_area(), etc. */
 #include <linux/string.h>	/* inline mem*, str* functions */
 #include <linux/init.h>		/* __initfunc et al. */
-#include <asm/segment.h>	/* kernel <-> user copy */
 #include <asm/byteorder.h>	/* htons(), etc. */
 #include <asm/uaccess.h>	/* copy_to_user */
 #include <asm/io.h>
Index: ./net/decnet/af_decnet.c
===================================================================
RCS file: /inst/cvs/linux/net/decnet/Attic/af_decnet.c,v
retrieving revision 1.1.2.27
diff -u -r1.1.2.27 af_decnet.c
--- ./net/decnet/af_decnet.c	9 Nov 2001 23:40:39 -0000	1.1.2.27
+++ ./net/decnet/af_decnet.c	5 Dec 2001 14:03:32 -0000
@@ -112,7 +112,6 @@
 #include <linux/route.h>
 #include <linux/netfilter.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/ioctls.h>
 #include <linux/mm.h>
Index: ./net/decnet/dn_nsp_in.c
===================================================================
RCS file: /inst/cvs/linux/net/decnet/Attic/dn_nsp_in.c,v
retrieving revision 1.1.2.14
diff -u -r1.1.2.14 dn_nsp_in.c
--- ./net/decnet/dn_nsp_in.c	9 Nov 2001 23:40:39 -0000	1.1.2.14
+++ ./net/decnet/dn_nsp_in.c	5 Dec 2001 14:03:32 -0000
@@ -59,7 +59,6 @@
 #include <linux/inet.h>
 #include <linux/route.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
Index: ./net/decnet/dn_nsp_out.c
===================================================================
RCS file: /inst/cvs/linux/net/decnet/Attic/dn_nsp_out.c,v
retrieving revision 1.1.2.9
diff -u -r1.1.2.9 dn_nsp_out.c
--- ./net/decnet/dn_nsp_out.c	30 Jan 2001 15:36:14 -0000	1.1.2.9
+++ ./net/decnet/dn_nsp_out.c	5 Dec 2001 14:03:32 -0000
@@ -51,7 +51,6 @@
 #include <linux/inet.h>
 #include <linux/route.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
Index: ./net/irda/irda_device.c
===================================================================
RCS file: /inst/cvs/linux/net/irda/irda_device.c,v
retrieving revision 1.4.2.23
diff -u -r1.4.2.23 irda_device.c
--- ./net/irda/irda_device.c	16 Nov 2001 16:38:51 -0000	1.4.2.23
+++ ./net/irda/irda_device.c	5 Dec 2001 14:03:32 -0000
@@ -44,7 +44,6 @@
 #include <linux/spinlock.h>
 
 #include <asm/ioctls.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <asm/dma.h>
 #include <asm/io.h>
Index: ./net/irda/irsyms.c
===================================================================
RCS file: /inst/cvs/linux/net/irda/Attic/irsyms.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 irsyms.c
--- ./net/irda/irsyms.c	9 Nov 2001 23:40:40 -0000	1.1.2.3
+++ ./net/irda/irsyms.c	5 Dec 2001 14:03:32 -0000
@@ -31,7 +31,6 @@
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
 
-#include <asm/segment.h>
 
 #include <net/irda/irda.h>
 #include <net/irda/irmod.h>
Index: ./net/irda/irsysctl.c
===================================================================
RCS file: /inst/cvs/linux/net/irda/irsysctl.c,v
retrieving revision 1.3.2.5.2.1
diff -u -r1.3.2.5.2.1 irsysctl.c
--- ./net/irda/irsysctl.c	1 Dec 2001 16:14:22 -0000	1.3.2.5.2.1
+++ ./net/irda/irsysctl.c	5 Dec 2001 14:03:32 -0000
@@ -27,7 +27,6 @@
 #include <linux/mm.h>
 #include <linux/ctype.h>
 #include <linux/sysctl.h>
-#include <asm/segment.h>
 
 #include <net/irda/irda.h>
 #include <net/irda/irias_object.h>
Index: ./net/irda/ircomm/ircomm_tty.c
===================================================================
RCS file: /inst/cvs/linux/net/irda/ircomm/ircomm_tty.c,v
retrieving revision 1.2.2.14
diff -u -r1.2.2.14 ircomm_tty.c
--- ./net/irda/ircomm/ircomm_tty.c	1 Oct 2001 21:51:06 -0000	1.2.2.14
+++ ./net/irda/ircomm/ircomm_tty.c	5 Dec 2001 14:03:32 -0000
@@ -38,7 +38,6 @@
 #include <linux/tty.h>
 #include <linux/interrupt.h>
 
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 
 #include <net/irda/irda.h>
Index: ./net/irda/ircomm/ircomm_tty_ioctl.c
===================================================================
RCS file: /inst/cvs/linux/net/irda/ircomm/ircomm_tty_ioctl.c,v
retrieving revision 1.1.2.6
diff -u -r1.1.2.6 ircomm_tty_ioctl.c
--- ./net/irda/ircomm/ircomm_tty_ioctl.c	5 Jul 2001 09:10:24 -0000	1.1.2.6
+++ ./net/irda/ircomm/ircomm_tty_ioctl.c	5 Dec 2001 14:03:32 -0000
@@ -35,7 +35,6 @@
 #include <linux/tty.h>
 #include <linux/serial.h>
 
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 
 #include <net/irda/irda.h>
Index: ./net/rose/rose_route.c
===================================================================
RCS file: /inst/cvs/linux/net/rose/rose_route.c,v
retrieving revision 1.1.1.1.2.7
diff -u -r1.1.1.1.2.7 rose_route.c
--- ./net/rose/rose_route.c	3 Jul 2001 08:05:08 -0000	1.1.1.1.2.7
+++ ./net/rose/rose_route.c	5 Dec 2001 14:03:32 -0000
@@ -36,7 +36,6 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <linux/fcntl.h>
Index: ./net/rose/af_rose.c
===================================================================
RCS file: /inst/cvs/linux/net/rose/af_rose.c,v
retrieving revision 1.1.1.1.2.19
diff -u -r1.1.1.1.2.19 af_rose.c
--- ./net/rose/af_rose.c	12 Sep 2001 09:56:52 -0000	1.1.1.1.2.19
+++ ./net/rose/af_rose.c	5 Dec 2001 14:03:32 -0000
@@ -44,7 +44,6 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <linux/fcntl.h>
Index: ./net/rose/rose_dev.c
===================================================================
RCS file: /inst/cvs/linux/net/rose/rose_dev.c,v
retrieving revision 1.1.1.1.2.6
diff -u -r1.1.1.1.2.6 rose_dev.c
--- ./net/rose/rose_dev.c	28 Jun 2001 11:16:56 -0000	1.1.1.1.2.6
+++ ./net/rose/rose_dev.c	5 Dec 2001 14:03:32 -0000
@@ -32,7 +32,6 @@
 #include <linux/if_ether.h>	/* For the statistics structure. */
 
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 
 #include <linux/inet.h>
Index: ./net/rose/rose_in.c
===================================================================
RCS file: /inst/cvs/linux/net/rose/rose_in.c,v
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1.2.1 rose_in.c
--- ./net/rose/rose_in.c	1 Jan 2001 12:25:02 -0000	1.1.1.1.2.1
+++ ./net/rose/rose_in.c	5 Dec 2001 14:03:32 -0000
@@ -38,7 +38,6 @@
 #include <linux/skbuff.h>
 #include <net/sock.h>
 #include <net/ip.h>			/* For ip_rcv */
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
Index: ./net/rose/rose_link.c
===================================================================
RCS file: /inst/cvs/linux/net/rose/rose_link.c,v
retrieving revision 1.1.1.1.2.3
diff -u -r1.1.1.1.2.3 rose_link.c
--- ./net/rose/rose_link.c	1 Jan 2001 12:25:02 -0000	1.1.1.1.2.3
+++ ./net/rose/rose_link.c	5 Dec 2001 14:03:32 -0000
@@ -29,7 +29,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
Index: ./net/rose/rose_out.c
===================================================================
RCS file: /inst/cvs/linux/net/rose/rose_out.c,v
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1.2.1 rose_out.c
--- ./net/rose/rose_out.c	1 Jan 2001 12:25:02 -0000	1.1.1.1.2.1
+++ ./net/rose/rose_out.c	5 Dec 2001 14:03:32 -0000
@@ -30,7 +30,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
Index: ./net/rose/rose_subr.c
===================================================================
RCS file: /inst/cvs/linux/net/rose/rose_subr.c,v
retrieving revision 1.1.1.1.2.2
diff -u -r1.1.1.1.2.2 rose_subr.c
--- ./net/rose/rose_subr.c	3 Jul 2001 08:05:08 -0000	1.1.1.1.2.2
+++ ./net/rose/rose_subr.c	5 Dec 2001 14:03:32 -0000
@@ -30,7 +30,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
Index: ./net/rose/rose_timer.c
===================================================================
RCS file: /inst/cvs/linux/net/rose/rose_timer.c,v
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1.2.1 rose_timer.c
--- ./net/rose/rose_timer.c	1 Jan 2001 12:25:02 -0000	1.1.1.1.2.1
+++ ./net/rose/rose_timer.c	5 Dec 2001 14:03:32 -0000
@@ -30,7 +30,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
Index: ./net/wanrouter/wanmain.c
===================================================================
RCS file: /inst/cvs/linux/net/wanrouter/wanmain.c,v
retrieving revision 1.1.1.1.2.12
diff -u -r1.1.1.1.2.12 wanmain.c
--- ./net/wanrouter/wanmain.c	17 Aug 2001 09:29:32 -0000	1.1.1.1.2.12
+++ ./net/wanrouter/wanmain.c	5 Dec 2001 14:03:32 -0000
@@ -75,7 +75,6 @@
  #include <../drivers/net/syncppp.h>
 
 #else
- #include <asm/segment.h>	/* kernel <-> user copy */
 #endif
 
 #define KMEM_SAFETYZONE 8
Index: ./net/wanrouter/wanproc.c
===================================================================
RCS file: /inst/cvs/linux/net/wanrouter/wanproc.c,v
retrieving revision 1.1.1.1.2.16
diff -u -r1.1.1.1.2.16 wanproc.c
--- ./net/wanrouter/wanproc.c	12 Sep 2001 09:56:52 -0000	1.1.1.1.2.16
+++ ./net/wanrouter/wanproc.c	5 Dec 2001 14:03:32 -0000
@@ -40,7 +40,6 @@
  #define PROC_STATS_FORMAT "%30s: %12lu\n"
 #else
  #define PROC_STATS_FORMAT "%30s: %12u\n"
- #include <asm/segment.h>	/* kernel <-> user copy */
 #endif
 
 
Index: ./net/x25/af_x25.c
===================================================================
RCS file: /inst/cvs/linux/net/x25/af_x25.c,v
retrieving revision 1.1.1.1.2.23
diff -u -r1.1.1.1.2.23 af_x25.c
--- ./net/x25/af_x25.c	12 Sep 2001 09:56:52 -0000	1.1.1.1.2.23
+++ ./net/x25/af_x25.c	5 Dec 2001 14:03:32 -0000
@@ -46,7 +46,6 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <linux/fcntl.h>
Index: ./net/x25/x25_in.c
===================================================================
RCS file: /inst/cvs/linux/net/x25/x25_in.c,v
retrieving revision 1.1.1.1.2.6
diff -u -r1.1.1.1.2.6 x25_in.c
--- ./net/x25/x25_in.c	30 Jan 2001 15:47:49 -0000	1.1.1.1.2.6
+++ ./net/x25/x25_in.c	5 Dec 2001 14:03:32 -0000
@@ -37,7 +37,6 @@
 #include <linux/skbuff.h>
 #include <net/sock.h>
 #include <net/ip.h>			/* For ip_rcv */
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
Index: ./net/x25/x25_dev.c
===================================================================
RCS file: /inst/cvs/linux/net/x25/x25_dev.c,v
retrieving revision 1.1.1.1.2.6
diff -u -r1.1.1.1.2.6 x25_dev.c
--- ./net/x25/x25_dev.c	30 Jan 2001 15:36:14 -0000	1.1.1.1.2.6
+++ ./net/x25/x25_dev.c	5 Dec 2001 14:03:32 -0000
@@ -33,7 +33,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <linux/fcntl.h>
Index: ./net/x25/x25_facilities.c
===================================================================
RCS file: /inst/cvs/linux/net/x25/x25_facilities.c,v
retrieving revision 1.1.1.1.2.3
diff -u -r1.1.1.1.2.3 x25_facilities.c
--- ./net/x25/x25_facilities.c	30 Jan 2001 15:47:49 -0000	1.1.1.1.2.3
+++ ./net/x25/x25_facilities.c	5 Dec 2001 14:03:32 -0000
@@ -32,7 +32,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
Index: ./net/x25/x25_link.c
===================================================================
RCS file: /inst/cvs/linux/net/x25/x25_link.c,v
retrieving revision 1.1.1.1.2.8
diff -u -r1.1.1.1.2.8 x25_link.c
--- ./net/x25/x25_link.c	3 Jul 2001 08:05:08 -0000	1.1.1.1.2.8
+++ ./net/x25/x25_link.c	5 Dec 2001 14:03:32 -0000
@@ -34,7 +34,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <linux/fcntl.h>
Index: ./net/x25/x25_out.c
===================================================================
RCS file: /inst/cvs/linux/net/x25/x25_out.c,v
retrieving revision 1.1.1.1.2.5
diff -u -r1.1.1.1.2.5 x25_out.c
--- ./net/x25/x25_out.c	17 Apr 2001 08:51:59 -0000	1.1.1.1.2.5
+++ ./net/x25/x25_out.c	5 Dec 2001 14:03:32 -0000
@@ -35,7 +35,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
Index: ./net/x25/x25_route.c
===================================================================
RCS file: /inst/cvs/linux/net/x25/x25_route.c,v
retrieving revision 1.1.1.1.2.4
diff -u -r1.1.1.1.2.4 x25_route.c
--- ./net/x25/x25_route.c	30 Jan 2001 15:36:14 -0000	1.1.1.1.2.4
+++ ./net/x25/x25_route.c	5 Dec 2001 14:03:32 -0000
@@ -33,7 +33,6 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <linux/fcntl.h>
Index: ./net/x25/x25_subr.c
===================================================================
RCS file: /inst/cvs/linux/net/x25/x25_subr.c,v
retrieving revision 1.1.1.1.2.4
diff -u -r1.1.1.1.2.4 x25_subr.c
--- ./net/x25/x25_subr.c	3 Jul 2001 08:05:08 -0000	1.1.1.1.2.4
+++ ./net/x25/x25_subr.c	5 Dec 2001 14:03:32 -0000
@@ -34,7 +34,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
Index: ./net/x25/x25_timer.c
===================================================================
RCS file: /inst/cvs/linux/net/x25/x25_timer.c,v
retrieving revision 1.1.1.1.2.3
diff -u -r1.1.1.1.2.3 x25_timer.c
--- ./net/x25/x25_timer.c	30 Jan 2001 15:47:50 -0000	1.1.1.1.2.3
+++ ./net/x25/x25_timer.c	5 Dec 2001 14:03:32 -0000
@@ -32,7 +32,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
Index: ./net/atm/resources.c
===================================================================
RCS file: /inst/cvs/linux/net/atm/Attic/resources.c,v
retrieving revision 1.1.2.5
diff -u -r1.1.2.5 resources.c
--- ./net/atm/resources.c	9 Nov 2001 23:40:39 -0000	1.1.2.5
+++ ./net/atm/resources.c	5 Dec 2001 14:03:32 -0000
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/bitops.h>
 #include <net/sock.h>	 /* for struct sock */
-#include <asm/segment.h> /* for get_fs_long and put_fs_long */
 
 #include "common.h"
 #include "resources.h"

--
dwmw2


