Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSKTP2X>; Wed, 20 Nov 2002 10:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSKTP2X>; Wed, 20 Nov 2002 10:28:23 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:13833 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261295AbSKTP2N>; Wed, 20 Nov 2002 10:28:13 -0500
Date: Wed, 20 Nov 2002 13:35:02 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: fix up header cleanups: add include <linux/interrupt.h>
Message-ID: <20021120153501.GA24201@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	Now there just this outstanding changeset. This tree was
cloned from yours today.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.912, 2002-11-20 11:21:44-02:00, acme@conectiva.com.br
  o scsi: fix up header cleanups: add include <linux/interrupt.h>
  
  Also use strsep in ibmmca.c, as strtok is gone from the kernel.


 BusLogic.c    |    8 +++++---
 NCR_D700.c    |    8 ++++----
 advansys.c    |   14 ++++++--------
 aha1542.c     |   10 ++++------
 aha1740.c     |   10 +++++-----
 atp870u.c     |   14 ++++++--------
 cpqfcTSinit.c |   13 +++++--------
 fd_mcs.c      |    4 ++--
 fdomain.c     |   15 ++++++++-------
 ibmmca.c      |   14 +++++++-------
 in2000.c      |   13 ++++++-------
 inia100.c     |    9 ++++++---
 mca_53c9x.c   |    6 +++---
 psi240i.c     |    8 ++++----
 qlogicfas.c   |    6 ++++--
 seagate.c     |   14 ++++++++------
 u14-34f.c     |   14 ++++++++------
 ultrastor.c   |    8 ++++----
 wd7000.c      |   13 +++++++------
 19 files changed, 102 insertions(+), 99 deletions(-)


diff -Nru a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
--- a/drivers/scsi/BusLogic.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/BusLogic.c	Wed Nov 20 12:01:43 2002
@@ -29,24 +29,26 @@
 #define BusLogic_DriverVersion		"2.1.16"
 #define BusLogic_DriverDate		"18 July 2002"
 
+#include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
-#include <linux/config.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/types.h>
 #include <linux/blk.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/mm.h>
-#include <linux/sched.h>
 #include <linux/stat.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
+/* #include <scsi/scsicam.h> This include file is currently busted */
+
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/system.h>
-/* #include <scsi/scsicam.h> This include file is currently busted */
+
 #include "scsi.h"
 #include "hosts.h"
 #include "BusLogic.h"
diff -Nru a/drivers/scsi/NCR_D700.c b/drivers/scsi/NCR_D700.c
--- a/drivers/scsi/NCR_D700.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/NCR_D700.c	Wed Nov 20 12:01:43 2002
@@ -93,25 +93,25 @@
 #define NCR_D700_VERSION "2.2"
 
 #include <linux/config.h>
+#include <linux/blk.h>
+#include <linux/interrupt.h>
 #include <linux/version.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/sched.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/mca.h>
+
 #include <asm/dma.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/byteorder.h>
-#include <linux/blk.h>
-#include <linux/module.h>
-
 
 #include "scsi.h"
 #include "hosts.h"
diff -Nru a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
--- a/drivers/scsi/advansys.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/advansys.c	Wed Nov 20 12:01:43 2002
@@ -789,25 +789,23 @@
 #endif /* CONFIG_X86 && !CONFIG_ISA */
 
 #include <linux/string.h>
-#include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
+#include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
-#include <asm/io.h>
-#include <asm/system.h>
-#include <asm/dma.h>
 #include <linux/blk.h>
 #include <linux/stat.h>
-#if ASC_LINUX_KERNEL24
 #include <linux/spinlock.h>
-#elif ASC_LINUX_KERNEL22
-#include <asm/spinlock.h>
-#endif
+
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/dma.h>
+
 #include "scsi.h"
 #include "hosts.h"
 #include "advansys.h"
diff -Nru a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
--- a/drivers/scsi/aha1542.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/aha1542.c	Wed Nov 20 12:01:43 2002
@@ -27,28 +27,26 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/sched.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/isapnp.h>
+#include <linux/blk.h>
+#include <linux/mca.h>
+
 #include <asm/dma.h>
 #include <asm/system.h>
 #include <asm/io.h>
-#include <linux/blk.h>
-#include <linux/mca.h>
 
 #include "scsi.h"
 #include "hosts.h"
-
-
 #include "aha1542.h"
 
 #define SCSI_BUF_PA(address)	isa_virt_to_bus(address)
diff -Nru a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
--- a/drivers/scsi/aha1740.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/aha1740.c	Wed Nov 20 12:01:43 2002
@@ -30,23 +30,23 @@
  * are deemed to be part of the source code.
  */
 
+#include <linux/blk.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <linux/proc_fs.h>
-#include <linux/sched.h>
-#include <asm/dma.h>
+#include <linux/stat.h>
 
+#include <asm/dma.h>
 #include <asm/system.h>
 #include <asm/io.h>
-#include <linux/blk.h>
+
 #include "scsi.h"
 #include "hosts.h"
-
 #include "aha1740.h"
-#include<linux/stat.h>
 
 /* IF YOU ARE HAVING PROBLEMS WITH THIS DRIVER, AND WANT TO WATCH
    IT WORK, THEN:
diff -Nru a/drivers/scsi/atp870u.c b/drivers/scsi/atp870u.c
--- a/drivers/scsi/atp870u.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/atp870u.c	Wed Nov 20 12:01:43 2002
@@ -17,26 +17,24 @@
  */
 
 #include <linux/module.h>
-
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/sched.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
-#include <asm/system.h>
-#include <asm/io.h>
 #include <linux/pci.h>
 #include <linux/blk.h>
-#include "scsi.h"
-#include "hosts.h"
+#include <linux/stat.h>
 
+#include <asm/system.h>
+#include <asm/io.h>
 
+#include "scsi.h"
+#include "hosts.h"
 #include "atp870u.h"
-
-#include<linux/stat.h>
 
 /*
  *   static const char RCSid[] = "$Header: /usr/src/linux/kernel/blk_drv/scsi/RCS/atp870u.c,v 1.0 1997/05/07 15:22:00 root Exp root $";
diff -Nru a/drivers/scsi/cpqfcTSinit.c b/drivers/scsi/cpqfcTSinit.c
--- a/drivers/scsi/cpqfcTSinit.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/cpqfcTSinit.c	Wed Nov 20 12:01:43 2002
@@ -31,20 +31,21 @@
 
 #define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
 
+#include <linux/config.h>  
+#include <linux/interrupt.h>  
+#include <linux/module.h>
+#include <linux/version.h> 
 #include <linux/blk.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/ioport.h>  // request_region() prototype
-#include <linux/vmalloc.h> // ioremap()
-//#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,7)
 #include <linux/completion.h>
-//#endif
+
 #ifdef __alpha__
 #define __KERNEL_SYSCALLS__
 #endif
@@ -61,10 +62,6 @@
 #include "cpqfcTStrigger.h"
 
 #include "cpqfcTS.h"
-
-#include <linux/config.h>  
-#include <linux/module.h>
-#include <linux/version.h> 
 
 /* Embedded module documentation macros - see module.h */
 MODULE_AUTHOR("Compaq Computer Corporation");
diff -Nru a/drivers/scsi/fd_mcs.c b/drivers/scsi/fd_mcs.c
--- a/drivers/scsi/fd_mcs.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/fd_mcs.c	Wed Nov 20 12:01:43 2002
@@ -78,8 +78,7 @@
  **************************************************************************/
 
 #include <linux/module.h>
-
-#include <linux/sched.h>
+#include <linux/interrupt.h>
 #include <linux/blk.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -88,6 +87,7 @@
 #include <linux/delay.h>
 #include <linux/mca.h>
 #include <linux/spinlock.h>
+
 #include <asm/io.h>
 #include <asm/system.h>
 
diff -Nru a/drivers/scsi/fdomain.c b/drivers/scsi/fdomain.c
--- a/drivers/scsi/fdomain.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/fdomain.c	Wed Nov 20 12:01:43 2002
@@ -277,14 +277,10 @@
 #undef MODULE
 #endif
 
+#include <linux/config.h>	/* for CONFIG_PCI */
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <asm/io.h>
+#include <linux/interrupt.h>
 #include <linux/blk.h>
-#include "scsi.h"
-#include "hosts.h"
-#include "fdomain.h"
-#include <asm/system.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -294,7 +290,12 @@
 #include <linux/stat.h>
 #include <linux/delay.h>
 
-#include <linux/config.h>	/* for CONFIG_PCI */
+#include <asm/io.h>
+#include <asm/system.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include "fdomain.h"
   
 #define VERSION          "$Revision: 5.50 $"
 
diff -Nru a/drivers/scsi/ibmmca.c b/drivers/scsi/ibmmca.c
--- a/drivers/scsi/ibmmca.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/ibmmca.c	Wed Nov 20 12:01:43 2002
@@ -17,6 +17,7 @@
  
  */
 
+#include <linux/config.h>
 #ifndef LINUX_VERSION_CODE
 #include <linux/version.h>
 #endif
@@ -28,22 +29,23 @@
 #include <linux/types.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/sched.h>
 #include <linux/blk.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/mca.h>
 #include <linux/string.h>
-#include <asm/system.h>
 #include <linux/spinlock.h>
-#include <asm/io.h>
 #include <linux/init.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+
 #include "scsi.h"
 #include "hosts.h"
 #include "ibmmca.h"
-#include <linux/config.h>
 
 /* current version of this driver-source: */
 #define IBMMCA_SCSI_DRIVER_VERSION "4.0b-ac"
@@ -1396,9 +1398,8 @@
 	io_base = 0;
 	id_base = 0;
 	if (str) {
-		token = strtok(str, ",");
 		j = 0;
-		while (token) {
+		while ((token = strsep(&str, ",")) != NULL) {
 			if (!strcmp(token, "activity"))
 				display_mode |= LED_ACTIVITY;
 			if (!strcmp(token, "display"))
@@ -1422,7 +1423,6 @@
 					scsi_id[id_base++] = simple_strtoul(token, NULL, 0);
 				j++;
 			}
-			token = strtok(NULL, ",");
 		}
 	} else if (ints) {
 		for (i = 0; i < IM_MAX_HOSTS && 2 * i + 2 < ints[0]; i++) {
diff -Nru a/drivers/scsi/in2000.c b/drivers/scsi/in2000.c
--- a/drivers/scsi/in2000.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/in2000.c	Wed Nov 20 12:01:43 2002
@@ -114,18 +114,17 @@
  */
 
 #include <linux/module.h>
-
-#include <asm/system.h>
-#include <linux/sched.h>
+#include <linux/blk.h>
+#include <linux/blkdev.h>
+#include <linux/interrupt.h>
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
-#include <asm/io.h>
 #include <linux/ioport.h>
-#include <linux/blkdev.h>
-
-#include <linux/blk.h>
 #include <linux/stat.h>
+
+#include <asm/io.h>
+#include <asm/system.h>
 
 #include "scsi.h"
 #include "hosts.h"
diff -Nru a/drivers/scsi/inia100.c b/drivers/scsi/inia100.c
--- a/drivers/scsi/inia100.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/inia100.c	Wed Nov 20 12:01:43 2002
@@ -75,9 +75,9 @@
 
 #include <linux/module.h>
 
-#include <asm/irq.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/blk.h>
@@ -86,12 +86,15 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
-#include <linux/sched.h>
+//#include <linux/sched.h>
+#include <linux/slab.h>
 #include <linux/proc_fs.h>
+
 #include <asm/io.h>
+#include <asm/irq.h>
+
 #include "scsi.h"
 #include "hosts.h"
-#include <linux/slab.h>
 #include "inia100.h"
 
 static Scsi_Host_Template driver_template = INIA100;
diff -Nru a/drivers/scsi/mca_53c9x.c b/drivers/scsi/mca_53c9x.c
--- a/drivers/scsi/mca_53c9x.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/mca_53c9x.c	Wed Nov 20 12:01:43 2002
@@ -30,8 +30,10 @@
  *  look.
  */
 
-#include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mca.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/slab.h>
@@ -45,10 +47,8 @@
 #include "mca_53c9x.h"
 
 #include <asm/dma.h>
-#include <linux/mca.h>
 #include <asm/irq.h>
 #include <asm/mca_dma.h>
-
 #include <asm/pgtable.h>
 
 static int  dma_bytes_sent(struct NCR_ESP *, int);
diff -Nru a/drivers/scsi/psi240i.c b/drivers/scsi/psi240i.c
--- a/drivers/scsi/psi240i.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/psi240i.c	Wed Nov 20 12:01:43 2002
@@ -26,25 +26,25 @@
 
 #include <linux/module.h>
 
+#include <linux/blk.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/sched.h>
+#include <linux/interrupt.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
+#include <linux/stat.h>
+
 #include <asm/dma.h>
 #include <asm/system.h>
 #include <asm/io.h>
-#include <linux/blk.h>
 #include "scsi.h"
 #include "hosts.h"
 
 #include "psi240i.h"
 #include "psi_chip.h"
-
-#include<linux/stat.h>
 
 //#define DEBUG 1
 
diff -Nru a/drivers/scsi/qlogicfas.c b/drivers/scsi/qlogicfas.c
--- a/drivers/scsi/qlogicfas.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/qlogicfas.c	Wed Nov 20 12:01:43 2002
@@ -136,17 +136,19 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/sched.h>
 #include <linux/proc_fs.h>
 #include <linux/unistd.h>
 #include <linux/spinlock.h>
+#include <linux/stat.h>
+
 #include <asm/io.h>
 #include <asm/irq.h>
+
 #include "scsi.h"
 #include "hosts.h"
 #include "qlogicfas.h"
-#include <linux/stat.h>
 
 /*----------------------------------------------------------------*/
 /* driver state info, local to driver */
diff -Nru a/drivers/scsi/seagate.c b/drivers/scsi/seagate.c
--- a/drivers/scsi/seagate.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/seagate.c	Wed Nov 20 12:01:43 2002
@@ -88,22 +88,24 @@
  */
 
 #include <linux/module.h>
-
-#include <asm/io.h>
-#include <asm/system.h>
+#include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/signal.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/blk.h>
+#include <linux/stat.h>
+
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
 #include "scsi.h"
 #include "hosts.h"
 #include "seagate.h"
-#include <linux/stat.h>
-#include <asm/uaccess.h>
+
 #include <scsi/scsi_ioctl.h>
 
 #ifdef DEBUG
diff -Nru a/drivers/scsi/u14-34f.c b/drivers/scsi/u14-34f.c
--- a/drivers/scsi/u14-34f.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/u14-34f.c	Wed Nov 20 12:01:43 2002
@@ -393,7 +393,7 @@
 #endif
 
 #include <linux/string.h>
-#include <linux/sched.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
@@ -402,11 +402,6 @@
 #include <asm/byteorder.h>
 #include <linux/proc_fs.h>
 #include <linux/blk.h>
-#include "scsi.h"
-#include "hosts.h"
-#include <asm/dma.h>
-#include <asm/irq.h>
-#include "u14-34f.h"
 #include <linux/stat.h>
 #include <linux/config.h>
 #include <linux/pci.h>
@@ -414,6 +409,13 @@
 #include <linux/ctype.h>
 #include <linux/spinlock.h>
 #include <scsi/scsicam.h>
+
+#include <asm/dma.h>
+#include <asm/irq.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include "u14-34f.h"
 
 #if !defined(__BIG_ENDIAN_BITFIELD) && !defined(__LITTLE_ENDIAN_BITFIELD)
 #error "Adjust your <asm/byteorder.h> defines"
diff -Nru a/drivers/scsi/ultrastor.c b/drivers/scsi/ultrastor.c
--- a/drivers/scsi/ultrastor.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/ultrastor.c	Wed Nov 20 12:01:43 2002
@@ -128,25 +128,25 @@
  */
 
 #include <linux/module.h>
-
+#include <linux/blk.h>
+#include <linux/interrupt.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
-#include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
+#include <linux/stat.h>
+
 #include <asm/io.h>
 #include <asm/bitops.h>
 #include <asm/system.h>
 #include <asm/dma.h>
 
 #define ULTRASTOR_PRIVATE	/* Get the private stuff from ultrastor.h */
-#include <linux/blk.h>
 #include "scsi.h"
 #include "hosts.h"
 #include "ultrastor.h"
-#include<linux/stat.h>
 
 #define FALSE 0
 #define TRUE 1
diff -Nru a/drivers/scsi/wd7000.c b/drivers/scsi/wd7000.c
--- a/drivers/scsi/wd7000.c	Wed Nov 20 12:01:43 2002
+++ b/drivers/scsi/wd7000.c	Wed Nov 20 12:01:43 2002
@@ -161,24 +161,25 @@
  */
 
 #include <linux/module.h>
-
-#include <stdarg.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
-#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <asm/system.h>
-#include <asm/dma.h>
-#include <asm/io.h>
 #include <linux/ioport.h>
 #include <linux/proc_fs.h>
 #include <linux/blk.h>
 #include <linux/version.h>
 #include <linux/init.h>
+
+#include <asm/system.h>
+#include <asm/dma.h>
+#include <asm/io.h>
+
 #include "scsi.h"
 #include "hosts.h"
+
 #include <scsi/scsicam.h>
 
 #define ANY2SCSI_INLINE		/* undef this to use old macros */

===================================================================


This BitKeeper patch contains the following changesets:
1.912
## Wrapped with gzip_uu ##


begin 664 bkpatch14511
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
0F\16F(CT_@.M[.]&KT(`````
`
end
