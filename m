Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVAQNvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVAQNvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVAQNvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:51:37 -0500
Received: from quark.didntduck.org ([69.55.226.66]:11467 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262786AbVAQNuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:50:40 -0500
Message-ID: <41EBC2AA.8040307@didntduck.org>
Date: Mon, 17 Jan 2005 08:50:34 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] clean up UTS_RELEASE usage
Content-Type: multipart/mixed;
 boundary="------------050108030409090508010501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050108030409090508010501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch cleans up usage of UTS_RELEASE, by replacing many references 
with system_utsname.release, and deleting others.  This eliminates a 
dependency on version.h for these files, so they don't get rebuilt if 
EXTRAVERSION or localversion change.

Compile tested on x86 only.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--
				Brian Gerst

--------------050108030409090508010501
Content-Type: text/plain;
 name="utsname"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="utsname"

diff -urN linux-2.6.11-rc1-mm1/arch/ppc64/kernel/process.c linux/arch/ppc64/kernel/process.c
--- linux-2.6.11-rc1-mm1/arch/ppc64/kernel/process.c	2005-01-12 09:34:34.000000000 -0500
+++ linux/arch/ppc64/kernel/process.c	2005-01-17 08:48:16.594485476 -0500
@@ -35,7 +35,7 @@
 #include <linux/ptrace.h>
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
-#include <linux/version.h>
+#include <linux/utsname.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -255,7 +255,7 @@
 	printk("NIP: %016lX XER: %08X LR: %016lX CTR: %016lX\n",
 	       regs->nip, (unsigned int)regs->xer, regs->link, regs->ctr);
 	printk("REGS: %p TRAP: %04lx   %s  (%s)\n",
-	       regs, regs->trap, print_tainted(), UTS_RELEASE);
+	       regs, regs->trap, print_tainted(), system_utsname.release);
 	printk("MSR: %016lx EE: %01x PR: %01x FP: %01x ME: %01x "
 	       "IR/DR: %01x%01x CR: %08X\n",
 	       regs->msr, regs->msr&MSR_EE ? 1 : 0, regs->msr&MSR_PR ? 1 : 0,
diff -urN linux-2.6.11-rc1-mm1/arch/um/sys-x86_64/sysrq.c linux/arch/um/sys-x86_64/sysrq.c
--- linux-2.6.11-rc1-mm1/arch/um/sys-x86_64/sysrq.c	2005-01-12 09:34:37.000000000 -0500
+++ linux/arch/um/sys-x86_64/sysrq.c	2005-01-17 08:48:16.594485476 -0500
@@ -5,7 +5,7 @@
  */
 
 #include "linux/kernel.h"
-#include "linux/version.h"
+#include "linux/utsname.h"
 #include "linux/module.h"
 #include "asm/current.h"
 #include "asm/ptrace.h"
@@ -16,7 +16,7 @@
 	printk("\n");
 	print_modules();
 	printk("Pid: %d, comm: %.20s %s %s\n",
-	       current->pid, current->comm, print_tainted(), UTS_RELEASE);
+	       current->pid, current->comm, print_tainted(), system_utsname.release);
 	printk("RIP: %04lx:[<%016lx>] ", PT_REGS_CS(regs) & 0xffff,
 	       PT_REGS_RIP(regs));
 	printk("\nRSP: %016lx  EFLAGS: %08lx\n", PT_REGS_RSP(regs),
diff -urN linux-2.6.11-rc1-mm1/arch/x86_64/kernel/process.c linux/arch/x86_64/kernel/process.c
--- linux-2.6.11-rc1-mm1/arch/x86_64/kernel/process.c	2005-01-17 08:47:48.290649458 -0500
+++ linux/arch/x86_64/kernel/process.c	2005-01-17 08:48:59.828063765 -0500
@@ -33,7 +33,7 @@
 #include <linux/irq.h>
 #include <linux/ptrace.h>
 #include <linux/perfctr.h>
-#include <linux/version.h>
+#include <linux/utsname.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -233,7 +233,7 @@
 	printk("\n");
 	print_modules();
 	printk("Pid: %d, comm: %.20s %s %s\n", 
-	       current->pid, current->comm, print_tainted(), UTS_RELEASE);
+	       current->pid, current->comm, print_tainted(), system_utsname.release);
 	printk("RIP: %04lx:[<%016lx>] ", regs->cs & 0xffff, regs->rip);
 	printk_address(regs->rip); 
 	printk("\nRSP: %04lx:%016lx  EFLAGS: %08lx\n", regs->ss, regs->rsp, regs->eflags);
diff -urN linux-2.6.11-rc1-mm1/drivers/cdrom/aztcd.c linux/drivers/cdrom/aztcd.c
--- linux-2.6.11-rc1-mm1/drivers/cdrom/aztcd.c	2005-01-17 08:47:49.992280569 -0500
+++ linux/drivers/cdrom/aztcd.c	2005-01-17 08:48:16.597484822 -0500
@@ -165,7 +165,6 @@
 			 Torben Mathiasen <tmm@image.dk>
 */
 
-#include <linux/version.h>
 #include <linux/blkdev.h>
 #include "aztcd.h"
 
@@ -1708,8 +1707,8 @@
 	printk(KERN_INFO "aztcd: (C) 1994-98 W.Zimmermann\n");
 	if (azt_port == -1) {
 		printk
-		    ("aztcd: KernelVersion=%s DriverVersion=%s For IDE/ATAPI-drives use ide-cd.c\n",
-		     UTS_RELEASE, AZT_VERSION);
+		    ("aztcd: DriverVersion=%s For IDE/ATAPI-drives use ide-cd.c\n",
+		     AZT_VERSION);
 	} else
 		printk
 		    ("aztcd: DriverVersion=%s BaseAddress=0x%x  For IDE/ATAPI-drives use ide-cd.c\n",
diff -urN linux-2.6.11-rc1-mm1/drivers/cdrom/mcdx.c linux/drivers/cdrom/mcdx.c
--- linux-2.6.11-rc1-mm1/drivers/cdrom/mcdx.c	2005-01-17 08:47:50.161243940 -0500
+++ linux/drivers/cdrom/mcdx.c	2005-01-17 08:48:16.598484605 -0500
@@ -56,7 +56,6 @@
     = "$Id: mcdx.c,v 1.21 1997/01/26 07:12:59 davem Exp $";
 #endif
 
-#include <linux/version.h>
 #include <linux/module.h>
 
 #include <linux/errno.h>
@@ -1265,11 +1264,7 @@
 int __init mcdx_init(void)
 {
 	int drive;
-#ifdef MODULE
-	xwarn("Version 2.14(hs) for " UTS_RELEASE "\n");
-#else
 	xwarn("Version 2.14(hs) \n");
-#endif
 
 	xwarn("$Id: mcdx.c,v 1.21 1997/01/26 07:12:59 davem Exp $\n");
 
diff -urN linux-2.6.11-rc1-mm1/drivers/char/ftape/compressor/zftape-compress.c linux/drivers/char/ftape/compressor/zftape-compress.c
--- linux-2.6.11-rc1-mm1/drivers/char/ftape/compressor/zftape-compress.c	2005-01-12 09:34:40.000000000 -0500
+++ linux/drivers/char/ftape/compressor/zftape-compress.c	2005-01-17 08:48:16.599484387 -0500
@@ -27,7 +27,6 @@
  *     changed * appropriately. See below.
  */
 
-#include <linux/version.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -1174,11 +1173,10 @@
 		printk(
 KERN_INFO "(c) 1997 Claus-Justus Heine (claus@momo.math.rwth-aachen.de)\n"
 KERN_INFO "Compressor for zftape (lzrw3 algorithm)\n"
-KERN_INFO "Compiled for kernel version %s\n", UTS_RELEASE);
         }
 #else /* !MODULE */
 	/* print a short no-nonsense boot message */
-	printk("zftape compressor v1.00a 970514 for Linux " UTS_RELEASE "\n");
+	printk("zftape compressor v1.00a 970514\n");
 	printk("For use with " FTAPE_VERSION "\n");
 #endif /* MODULE */
 	TRACE(ft_t_info, "zft_compressor_init @ 0x%p", zft_compressor_init);
diff -urN linux-2.6.11-rc1-mm1/drivers/char/ftape/lowlevel/ftape-init.c linux/drivers/char/ftape/lowlevel/ftape-init.c
--- linux-2.6.11-rc1-mm1/drivers/char/ftape/lowlevel/ftape-init.c	2005-01-12 09:34:40.000000000 -0500
+++ linux/drivers/char/ftape/lowlevel/ftape-init.c	2005-01-17 08:48:16.600484169 -0500
@@ -23,7 +23,6 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
@@ -74,11 +73,10 @@
 KERN_INFO "(c) 1995-1996 Kai Harrekilde-Petersen (khp@dolphinics.no)\n"
 KERN_INFO "(c) 1996-1997 Claus-Justus Heine (claus@momo.math.rwth-aachen.de)\n"
 KERN_INFO "QIC-117 driver for QIC-40/80/3010/3020 floppy tape drives\n"
-KERN_INFO "Compiled for Linux version %s\n", UTS_RELEASE);
         }
 #else /* !MODULE */
 	/* print a short no-nonsense boot message */
-	printk(KERN_INFO FTAPE_VERSION " for Linux " UTS_RELEASE "\n");
+	printk(KERN_INFO FTAPE_VERSION "\n");
 #endif /* MODULE */
 	TRACE(ft_t_info, "installing QIC-117 floppy tape hardware drive ... ");
 	TRACE(ft_t_info, "ftape_init @ 0x%p", ftape_init);
diff -urN linux-2.6.11-rc1-mm1/drivers/char/ftape/zftape/zftape-init.c linux/drivers/char/ftape/zftape/zftape-init.c
--- linux-2.6.11-rc1-mm1/drivers/char/ftape/zftape/zftape-init.c	2005-01-12 09:34:40.000000000 -0500
+++ linux/drivers/char/ftape/zftape/zftape-init.c	2005-01-17 08:48:16.600484169 -0500
@@ -23,7 +23,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
-#include <linux/version.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
@@ -319,13 +318,11 @@
 KERN_INFO
 "Support for QIC-113 compatible volume table, dynamic memory allocation\n"
 KERN_INFO
-"and builtin compression (lzrw3 algorithm).\n"
-KERN_INFO
-"Compiled for Linux version %s\n", UTS_RELEASE);
+"and builtin compression (lzrw3 algorithm).\n");
         }
 #else /* !MODULE */
 	/* print a short no-nonsense boot message */
-	printk(KERN_INFO ZFTAPE_VERSION " for Linux " UTS_RELEASE "\n");
+	printk(KERN_INFO ZFTAPE_VERSION "\n");
 #endif /* MODULE */
 	TRACE(ft_t_info, "zft_init @ 0x%p", zft_init);
 	TRACE(ft_t_info,
diff -urN linux-2.6.11-rc1-mm1/drivers/parisc/led.c linux/drivers/parisc/led.c
--- linux-2.6.11-rc1-mm1/drivers/parisc/led.c	2004-08-24 08:42:56.000000000 -0400
+++ linux/drivers/parisc/led.c	2005-01-17 08:48:16.601483951 -0500
@@ -26,7 +26,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
-#include <linux/version.h>
+#include <linux/utsname.h>
 #include <linux/delay.h>
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
@@ -56,7 +56,7 @@
 static int led_diskio = 1;
 static int led_lanrxtx = 1;
 static char lcd_text[32];
-static char lcd_text_default[] = "Linux " UTS_RELEASE;
+static char lcd_text_default[32];
 
 #if 0
 #define DPRINTK(x)	printk x
@@ -676,6 +676,9 @@
 	struct pdc_chassis_info chassis_info;
 	int ret;
 
+	snprintf(lcd_text_default, sizeof(lcd_text_default),
+		"Linux %s", system_utsname.release);
+
 	/* Work around the buggy PDC of KittyHawk-machines */
 	switch (CPU_HVERSION) {
 	case 0x580:		/* KittyHawk DC2-100 (K100) */
diff -urN linux-2.6.11-rc1-mm1/drivers/scsi/aic7xxx_old.c linux/drivers/scsi/aic7xxx_old.c
--- linux-2.6.11-rc1-mm1/drivers/scsi/aic7xxx_old.c	2005-01-12 09:34:51.000000000 -0500
+++ linux/drivers/scsi/aic7xxx_old.c	2005-01-17 08:48:16.633476979 -0500
@@ -224,7 +224,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/byteorder.h>
-#include <linux/version.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -10564,8 +10563,7 @@
 aic7xxx_panic_abort(struct aic7xxx_host *p, Scsi_Cmnd *cmd)
 {
 
-  printk("aic7xxx driver version %s/%s\n", AIC7XXX_C_VERSION,
-         UTS_RELEASE);
+  printk("aic7xxx driver version %s\n", AIC7XXX_C_VERSION);
   printk("Controller type:\n    %s\n", board_names[p->board_name_index]);
   printk("p->flags=0x%lx, p->chip=0x%x, p->features=0x%x, "
          "sequencer %s paused\n",
diff -urN linux-2.6.11-rc1-mm1/drivers/usb/core/hcd.c linux/drivers/usb/core/hcd.c
--- linux-2.6.11-rc1-mm1/drivers/usb/core/hcd.c	2005-01-17 08:47:56.121947029 -0500
+++ linux/drivers/usb/core/hcd.c	2005-01-17 08:48:16.635476543 -0500
@@ -33,7 +33,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
-#include <linux/uts.h>			/* for UTS_SYSNAME */
+#include <linux/utsname.h>
 #include <linux/mm.h>
 #include <asm/io.h>
 #include <asm/scatterlist.h>
@@ -309,8 +309,8 @@
 
  	// id 3 == vendor description
 	} else if (id == 3) {
-                sprintf (buf, "%s %s %s", UTS_SYSNAME, UTS_RELEASE,
-			hcd->driver->description);
+                sprintf (buf, "%s %s %s",  system_utsname.sysname,
+			system_utsname.release, hcd->driver->description);
 
 	// unsupported IDs --> "protocol stall"
 	} else
diff -urN linux-2.6.11-rc1-mm1/drivers/usb/gadget/ether.c linux/drivers/usb/gadget/ether.c
--- linux-2.6.11-rc1-mm1/drivers/usb/gadget/ether.c	2004-12-29 14:08:24.000000000 -0500
+++ linux/drivers/usb/gadget/ether.c	2005-01-17 08:48:16.636476325 -0500
@@ -36,8 +36,7 @@
 #include <linux/timer.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
-#include <linux/uts.h>
-#include <linux/version.h>
+#include <linux/utsname.h>
 #include <linux/device.h>
 #include <linux/moduleparam.h>
 #include <linux/ctype.h>
@@ -2337,8 +2336,8 @@
 			gadget->name);
 		return -ENODEV;
 	}
-	snprintf (manufacturer, sizeof manufacturer,
-		UTS_SYSNAME " " UTS_RELEASE "/%s",
+	snprintf (manufacturer, sizeof manufacturer, "%s %s/%s",
+		system_utsname.sysname, system_utsname.release,
 		gadget->name);
 
 	/* If there's an RNDIS configuration, that's what Windows wants to
diff -urN linux-2.6.11-rc1-mm1/drivers/usb/gadget/file_storage.c linux/drivers/usb/gadget/file_storage.c
--- linux-2.6.11-rc1-mm1/drivers/usb/gadget/file_storage.c	2005-01-12 09:34:53.000000000 -0500
+++ linux/drivers/usb/gadget/file_storage.c	2005-01-17 08:48:16.639475671 -0500
@@ -236,8 +236,7 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/suspend.h>
-#include <linux/uts.h>
-#include <linux/version.h>
+#include <linux/utsname.h>
 #include <linux/wait.h>
 
 #include <linux/usb_ch9.h>
@@ -3954,8 +3953,8 @@
 	/* This should reflect the actual gadget power source */
 	usb_gadget_set_selfpowered(gadget);
 
-	snprintf(manufacturer, sizeof manufacturer,
-			UTS_SYSNAME " " UTS_RELEASE " with %s",
+	snprintf(manufacturer, sizeof manufacturer, "%s %s with %s",
+			system_utsname.sysname, system_utsname.release,
 			gadget->name);
 
 	/* On a real device, serial[] would be loaded from permanent
diff -urN linux-2.6.11-rc1-mm1/drivers/usb/gadget/serial.c linux/drivers/usb/gadget/serial.c
--- linux-2.6.11-rc1-mm1/drivers/usb/gadget/serial.c	2005-01-12 09:34:53.000000000 -0500
+++ linux/drivers/usb/gadget/serial.c	2005-01-17 08:48:16.641475236 -0500
@@ -30,8 +30,7 @@
 #include <linux/timer.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
-#include <linux/uts.h>
-#include <linux/version.h>
+#include <linux/utsname.h>
 #include <linux/wait.h>
 #include <linux/proc_fs.h>
 #include <linux/device.h>
@@ -1596,8 +1595,9 @@
 	if (dev == NULL)
 		return -ENOMEM;
 
-	snprintf(manufacturer, sizeof(manufacturer),
-		UTS_SYSNAME " " UTS_RELEASE " with %s", gadget->name);
+	snprintf(manufacturer, sizeof(manufacturer), "%s %s with %s",
+		system_utsname.sysname, system_utsname.release,
+		gadget->name);
 
 	memset(dev, 0, sizeof(struct gs_dev));
 	dev->dev_gadget = gadget;
diff -urN linux-2.6.11-rc1-mm1/drivers/usb/gadget/zero.c linux/drivers/usb/gadget/zero.c
--- linux-2.6.11-rc1-mm1/drivers/usb/gadget/zero.c	2004-12-29 14:08:24.000000000 -0500
+++ linux/drivers/usb/gadget/zero.c	2005-01-17 08:48:16.642475018 -0500
@@ -75,8 +75,7 @@
 #include <linux/timer.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
-#include <linux/uts.h>
-#include <linux/version.h>
+#include <linux/utsname.h>
 #include <linux/device.h>
 #include <linux/moduleparam.h>
 
@@ -1265,8 +1264,8 @@
 	INFO (dev, "using %s, OUT %s IN %s\n", gadget->name,
 		EP_OUT_NAME, EP_IN_NAME);
 
-	snprintf (manufacturer, sizeof manufacturer,
-		UTS_SYSNAME " " UTS_RELEASE " with %s",
+	snprintf (manufacturer, sizeof manufacturer, "%s %s with %s",
+		system_utsname.sysname, system_utsname.release,
 		gadget->name);
 
 	return 0;
diff -urN linux-2.6.11-rc1-mm1/fs/cifs/connect.c linux/fs/cifs/connect.c
--- linux-2.6.11-rc1-mm1/fs/cifs/connect.c	2005-01-17 08:47:57.198712370 -0500
+++ linux/fs/cifs/connect.c	2005-01-17 08:48:16.644474582 -0500
@@ -23,7 +23,6 @@
 #include <linux/string.h>
 #include <linux/list.h>
 #include <linux/wait.h>
-#include <linux/version.h>
 #include <linux/ipv6.h>
 #include <linux/pagemap.h>
 #include <linux/ctype.h>
@@ -1647,7 +1646,7 @@
 				  32, nls_codepage);
 		bcc_ptr += 2 * bytes_returned;
 		bytes_returned =
-		    cifs_strtoUCS((wchar_t *) bcc_ptr, UTS_RELEASE, 32,
+		    cifs_strtoUCS((wchar_t *) bcc_ptr, system_utsname.release, 32,
 				  nls_codepage);
 		bcc_ptr += 2 * bytes_returned;
 		bcc_ptr += 2;
@@ -1674,8 +1673,8 @@
 		}
 		strcpy(bcc_ptr, "Linux version ");
 		bcc_ptr += strlen("Linux version ");
-		strcpy(bcc_ptr, UTS_RELEASE);
-		bcc_ptr += strlen(UTS_RELEASE) + 1;
+		strcpy(bcc_ptr, system_utsname.release);
+		bcc_ptr += strlen(system_utsname.release) + 1;
 		strcpy(bcc_ptr, CIFS_NETWORK_OPSYS);
 		bcc_ptr += strlen(CIFS_NETWORK_OPSYS) + 1;
 	}
@@ -1891,7 +1890,7 @@
 				  32, nls_codepage);
 		bcc_ptr += 2 * bytes_returned;
 		bytes_returned =
-		    cifs_strtoUCS((wchar_t *) bcc_ptr, UTS_RELEASE, 32,
+		    cifs_strtoUCS((wchar_t *) bcc_ptr, system_utsname.release, 32,
 				  nls_codepage);
 		bcc_ptr += 2 * bytes_returned;
 		bcc_ptr += 2;
@@ -1916,8 +1915,8 @@
 		}
 		strcpy(bcc_ptr, "Linux version ");
 		bcc_ptr += strlen("Linux version ");
-		strcpy(bcc_ptr, UTS_RELEASE);
-		bcc_ptr += strlen(UTS_RELEASE) + 1;
+		strcpy(bcc_ptr, system_utsname.release);
+		bcc_ptr += strlen(system_utsname.release) + 1;
 		strcpy(bcc_ptr, CIFS_NETWORK_OPSYS);
 		bcc_ptr += strlen(CIFS_NETWORK_OPSYS) + 1;
 	}
@@ -2180,7 +2179,7 @@
 				  32, nls_codepage);
 		bcc_ptr += 2 * bytes_returned;
 		bytes_returned =
-		    cifs_strtoUCS((wchar_t *) bcc_ptr, UTS_RELEASE, 32,
+		    cifs_strtoUCS((wchar_t *) bcc_ptr, system_utsname.release, 32,
 				  nls_codepage);
 		bcc_ptr += 2 * bytes_returned;
 		bcc_ptr += 2;	/* null terminate Linux version */
@@ -2197,8 +2196,8 @@
 	} else {		/* ASCII */
 		strcpy(bcc_ptr, "Linux version ");
 		bcc_ptr += strlen("Linux version ");
-		strcpy(bcc_ptr, UTS_RELEASE);
-		bcc_ptr += strlen(UTS_RELEASE) + 1;
+		strcpy(bcc_ptr, system_utsname.release);
+		bcc_ptr += strlen(system_utsname.release) + 1;
 		strcpy(bcc_ptr, CIFS_NETWORK_OPSYS);
 		bcc_ptr += strlen(CIFS_NETWORK_OPSYS) + 1;
 		bcc_ptr++;	/* empty domain field */
@@ -2565,7 +2564,7 @@
 				  32, nls_codepage);
 		bcc_ptr += 2 * bytes_returned;
 		bytes_returned =
-		    cifs_strtoUCS((wchar_t *) bcc_ptr, UTS_RELEASE, 32,
+		    cifs_strtoUCS((wchar_t *) bcc_ptr, system_utsname.release, 32,
 				  nls_codepage);
 		bcc_ptr += 2 * bytes_returned;
 		bcc_ptr += 2;	/* null term version string */
@@ -2617,8 +2616,8 @@
 
 		strcpy(bcc_ptr, "Linux version ");
 		bcc_ptr += strlen("Linux version ");
-		strcpy(bcc_ptr, UTS_RELEASE);
-		bcc_ptr += strlen(UTS_RELEASE) + 1;
+		strcpy(bcc_ptr, system_utsname.release);
+		bcc_ptr += strlen(system_utsname.release) + 1;
 		strcpy(bcc_ptr, CIFS_NETWORK_OPSYS);
 		bcc_ptr += strlen(CIFS_NETWORK_OPSYS) + 1;
 		bcc_ptr++;	/* null domain */

--------------050108030409090508010501--
