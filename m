Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261682AbTCUVes>; Fri, 21 Mar 2003 16:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbTCUVeS>; Fri, 21 Mar 2003 16:34:18 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26334 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263779AbTCUVcj>; Fri, 21 Mar 2003 16:32:39 -0500
Date: Fri, 21 Mar 2003 22:43:34 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: [2.5 patch] kill include/linux/compatmac.h
Message-ID: <20030321214334.GP6940@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/compatmac.h is quite useless. The idea behind this file is 
IMHO not bad but it's too outdated to be useful.

The patch below removes compatmac.h and all #include's of it.

The only file using the #define's from compatmac.h was 
drivers/char/sx.c, the patch expands these #define's.

After this the only effect of compatmac.h was the #include of some other 
header files. The only file that actually needed such an #include was 
drivers/char/applicom.c that needed linux/version.h. This is resolved by 
removing some 2.2 compatibility code from applicom.c.

I've tested the compilation with 2.5.65.


diffstat output:

 arch/i386/kernel/suspend.c                |    1 
 arch/s390/mm/fault.c                      |    1 
 arch/x86_64/kernel/suspend.c              |    1 
 drivers/acpi/processor.c                  |    1 
 drivers/char/applicom.c                   |   18 ---
 drivers/char/sx.c                         |   37 +++---
 drivers/media/dvb/dvb-core/dvb_frontend.c |    1 
 drivers/serial/68360serial.c              |    1 
 fs/nfsd/nfs4xdr.c                         |    1 
 include/linux/compatmac.h                 |  160 ------------------------------
 include/linux/mtd/compatmac.h             |    1 
 11 files changed, 22 insertions(+), 201 deletions(-)



cu
Adrian


--- linux-2.5.65-full/arch/i386/kernel/suspend.c.old	2003-03-21 21:46:52.000000000 +0100
+++ linux-2.5.65-full/arch/i386/kernel/suspend.c	2003-03-21 21:47:19.000000000 +0100
@@ -16,7 +16,6 @@
 #include <linux/poll.h>
 #include <linux/delay.h>
 #include <linux/sysrq.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <linux/irq.h>
 #include <linux/pm.h>
--- linux-2.5.65-full/arch/x86_64/kernel/suspend.c.old	2003-03-21 21:47:20.000000000 +0100
+++ linux-2.5.65-full/arch/x86_64/kernel/suspend.c	2003-03-21 21:47:27.000000000 +0100
@@ -16,7 +16,6 @@
 #include <linux/poll.h>
 #include <linux/delay.h>
 #include <linux/sysrq.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <linux/irq.h>
 #include <linux/pm.h>
--- linux-2.5.65-full/arch/s390/mm/fault.c.old	2003-03-21 21:47:28.000000000 +0100
+++ linux-2.5.65-full/arch/s390/mm/fault.c	2003-03-21 21:47:35.000000000 +0100
@@ -22,7 +22,6 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
-#include <linux/compatmac.h>
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/module.h>
--- linux-2.5.65-full/drivers/media/dvb/dvb-core/dvb_frontend.c.old	2003-03-21 21:47:44.000000000 +0100
+++ linux-2.5.65-full/drivers/media/dvb/dvb-core/dvb_frontend.c	2003-03-21 21:47:51.000000000 +0100
@@ -27,7 +27,6 @@
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/module.h>
-#include <linux/compatmac.h>
 #include <linux/list.h>
 
 #include "compat.h"
--- linux-2.5.65-full/drivers/acpi/processor.c.old	2003-03-21 21:47:52.000000000 +0100
+++ linux-2.5.65-full/drivers/acpi/processor.c	2003-03-21 21:48:00.000000000 +0100
@@ -36,7 +36,6 @@
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/cpufreq.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
--- linux-2.5.65-full/drivers/serial/68360serial.c.old	2003-03-21 21:48:00.000000000 +0100
+++ linux-2.5.65-full/drivers/serial/68360serial.c	2003-03-21 21:48:09.000000000 +0100
@@ -39,7 +39,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <asm/irq.h>
-#include <linux/compatmac.h>
 #include <asm/m68360.h>
 #include <asm/commproc.h>
 
--- linux-2.5.65-full/fs/nfsd/nfs4xdr.c.old	2003-03-21 21:48:09.000000000 +0100
+++ linux-2.5.65-full/fs/nfsd/nfs4xdr.c	2003-03-21 21:48:19.000000000 +0100
@@ -45,7 +45,6 @@
 #include <linux/param.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
-#include <linux/compatmac.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/vfs.h>
--- linux-2.5.65-full/include/linux/mtd/compatmac.h.old	2003-03-21 21:48:20.000000000 +0100
+++ linux-2.5.65-full/include/linux/mtd/compatmac.h	2003-03-21 21:48:28.000000000 +0100
@@ -17,7 +17,6 @@
 #ifndef __LINUX_MTD_COMPATMAC_H__
 #define __LINUX_MTD_COMPATMAC_H__
 
-#include <linux/compatmac.h>
 #include <linux/types.h> /* used later in this header */
 #include <linux/module.h>
 #ifndef LINUX_VERSION_CODE
--- linux-2.5.65-full/include/linux/compatmac.h	2003-03-17 22:43:40.000000000 +0100
+++ /dev/null	2003-01-09 00:39:47.000000000 +0100
@@ -1,160 +0,0 @@
-  /* 
-   * This header tries to allow you to write 2.3-compatible drivers, 
-   * but (using this header) still allows you to run them on 2.2 and 
-   * 2.0 kernels. 
-   *
-   * Sometimes, a #define replaces a "construct" that older kernels
-   * had. For example, 
-   *
-   *       DECLARE_MUTEX(name);
-   *
-   * replaces the older 
-   *
-   *       struct semaphore name = MUTEX;
-   *
-   * This file then declares the DECLARE_MUTEX macro to compile into the 
-   * older version. 
-   * 
-   * In some cases, a macro or function changes the number of arguments.
-   * In that case, there is nothing we can do except define an access 
-   * macro that provides the same functionality on both versions of Linux. 
-   * 
-   * This is the case for example with the "get_user" macro 2.0 kernels use:
-   *
-   *          a = get_user (b);
-   *  
-   * while newer kernels use 
-   * 
-   *          get_user (a,b);
-   *
-   * This is unfortunate. We therefore define "Get_user (a,b)" which looks
-   * almost the same as the 2.2+ construct, and translates into the 
-   * appropriate sequence for earlier constructs. 
-   * 
-   * Supported by this file are the 2.0 kernels, 2.2 kernels, and the 
-   * most recent 2.3 kernel. 2.3 support will be dropped as soon when 2.4
-   * comes out. 2.0 support may someday be dropped. But then again, maybe 
-   * not. 
-   *
-   * I'll try to maintain this, provided that Linus agrees with the setup. 
-   * Feel free to mail updates or suggestions. 
-   *
-   * -- R.E.Wolff@BitWizard.nl
-   *
-   */
-
-#ifndef COMPATMAC_H
-#define COMPATMAC_H
-
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < 0x020100    /* Less than 2.1.0 */
-#define TWO_ZERO
-#else
-#if LINUX_VERSION_CODE < 0x020200   /* less than 2.2.x */
-#warning "Please use a 2.2.x kernel. "
-#else
-#if LINUX_VERSION_CODE < 0x020300   /* less than 2.3.x */
-#define TWO_TWO
-#else
-#define TWO_THREE
-#endif
-#endif
-#endif
-
-#ifdef TWO_ZERO
-
-/* Here is the section that makes the 2.2 compatible driver source 
-   work for 2.0 too! We mostly try to adopt the "new thingies" from 2.2, 
-   and provide for compatibility stuff here if possible. */
-
-/* Some 200 days (on intel) */
-#define MAX_SCHEDULE_TIMEOUT     ((long)(~0UL>>1))
-
-#include <linux/bios32.h>
-
-#define Get_user(a,b)                a = get_user(b)
-#define Put_user(a,b)                0,put_user(a,b)
-#define copy_to_user(a,b,c)          memcpy_tofs(a,b,c)
-
-static inline int copy_from_user(void *to,const void *from, int c) 
-{
-  memcpy_fromfs(to, from, c);
-  return 0;
-}
-
-#define pci_present                  pcibios_present
-#define pci_read_config_word         pcibios_read_config_word
-#define pci_read_config_dword        pcibios_read_config_dword
-
-static inline unsigned char get_irq (unsigned char bus, unsigned char fn)
-{
-	unsigned char t; 
-	pcibios_read_config_byte (bus, fn, PCI_INTERRUPT_LINE, &t);
-	return t;
-}
-
-static inline void *ioremap(unsigned long base, long length)
-{
-	if (base < 0x100000) return (void *)base;
-	return vremap (base, length);
-}
-
-#define my_iounmap(x, b)             (((long)x<0x100000)?0:vfree ((void*)x))
-
-#define tty_flip_buffer_push(tty)    schedule_delayed_work(&tty->flip.work, 1)
-#define signal_pending(current)      (current->signal & ~current->blocked)
-#define schedule_timeout(to)         do {current->timeout = jiffies + (to);schedule ();} while (0)
-#define time_after(t1,t2)            (((long)t1-t2) > 0)
-
-
-#define test_and_set_bit(nr, addr)   set_bit(nr, addr)
-#define test_and_clear_bit(nr, addr) clear_bit(nr, addr)
-
-/* Not yet implemented on 2.0 */
-#define ASYNC_SPD_SHI  -1
-#define ASYNC_SPD_WARP -1
-
-
-/* Ugly hack: the driver_name doesn't exist in 2.0.x . So we define it
-   to the "name" field that does exist. As long as the assignments are
-   done in the right order, there is nothing to worry about. */
-#define driver_name           name 
-
-/* Should be in a header somewhere. They are in tty.h on 2.2 */
-#define TTY_HW_COOK_OUT       14 /* Flag to tell ntty what we can handle */
-#define TTY_HW_COOK_IN        15 /* in hardware - output and input       */
-
-/* The return type of a "close" routine. */
-#define INT                   void
-#define NO_ERROR              /* Nothing */
-
-#else
-
-/* The 2.2.x compatibility section. */
-#include <asm/uaccess.h>
-
-
-#define Get_user(a,b)         get_user(a,b)
-#define Put_user(a,b)         put_user(a,b)
-#define get_irq(pdev)         pdev->irq
-
-#define INT                   int
-#define NO_ERROR              0
-
-#define my_iounmap(x,b)       (iounmap((char *)(b)))
-
-#endif
-
-#ifndef TWO_THREE
-/* These are new in 2.3. The source now uses 2.3 syntax, and here is 
-   the compatibility define... */
-#define wait_queue_head_t     struct wait_queue *
-#define DECLARE_MUTEX(name)   struct semaphore name = MUTEX
-#define DECLARE_WAITQUEUE(wait, current) \
-                              struct wait_queue wait = { current, NULL }
-
-#endif
-
-
-#endif
--- linux-2.5.65-full/drivers/char/sx.c.old	2003-03-21 21:49:01.000000000 +0100
+++ linux-2.5.65-full/drivers/char/sx.c	2003-03-21 22:02:02.000000000 +0100
@@ -238,7 +238,6 @@
 #include "sxboards.h"
 #include "sxwindow.h"
 
-#include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 #include "sx.h"
 
@@ -1726,9 +1725,9 @@
 
 		tmp = kmalloc (SX_CHUNK_SIZE, GFP_USER);
 		if (!tmp) return -ENOMEM;
-		Get_user (nbytes, descr++);
-		Get_user (offset, descr++); 
-		Get_user (data,	 descr++);
+		get_user (nbytes, descr++);
+		get_user (offset, descr++); 
+		get_user (data,	 descr++);
 		while (nbytes && data) {
 			for (i=0;i<nbytes;i += SX_CHUNK_SIZE) {
 				if (copy_from_user(tmp, (char *)data + i, 
@@ -1740,9 +1739,9 @@
 				                (i+SX_CHUNK_SIZE>nbytes)?nbytes-i:SX_CHUNK_SIZE);
 			}
 
-			Get_user (nbytes, descr++);
-			Get_user (offset, descr++); 
-			Get_user (data,   descr++);
+			get_user (nbytes, descr++);
+			get_user (offset, descr++); 
+			get_user (data,   descr++);
 		}
 		kfree (tmp);
 		sx_nports += sx_init_board (board);
@@ -1816,13 +1815,13 @@
 	rc = 0;
 	switch (cmd) {
 	case TIOCGSOFTCAR:
-		rc = Put_user(((tty->termios->c_cflag & CLOCAL) ? 1 : 0),
+		rc = put_user(((tty->termios->c_cflag & CLOCAL) ? 1 : 0),
 		              (unsigned int *) arg);
 		break;
 	case TIOCSSOFTCAR:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
 		                      sizeof(int))) == 0) {
-			Get_user(ival, (unsigned int *) arg);
+			get_user(ival, (unsigned int *) arg);
 			tty->termios->c_cflag =
 				(tty->termios->c_cflag & ~CLOCAL) |
 				(ival ? CLOCAL : 0);
@@ -1848,7 +1847,7 @@
 	case TIOCMBIS:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
 		                      sizeof(unsigned int))) == 0) {
-			Get_user(ival, (unsigned int *) arg);
+			get_user(ival, (unsigned int *) arg);
 			sx_setsignals(port, ((ival & TIOCM_DTR) ? 1 : -1),
 			                     ((ival & TIOCM_RTS) ? 1 : -1));
 			sx_reconfigure_port(port);
@@ -1857,7 +1856,7 @@
 	case TIOCMBIC:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
 		                      sizeof(unsigned int))) == 0) {
-			Get_user(ival, (unsigned int *) arg);
+			get_user(ival, (unsigned int *) arg);
 			sx_setsignals(port, ((ival & TIOCM_DTR) ? 0 : -1),
 			                     ((ival & TIOCM_RTS) ? 0 : -1));
 			sx_reconfigure_port(port);
@@ -1866,7 +1865,7 @@
 	case TIOCMSET:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
 		                      sizeof(unsigned int))) == 0) {
-			Get_user(ival, (unsigned int *) arg);
+			get_user(ival, (unsigned int *) arg);
 			sx_setsignals(port, ((ival & TIOCM_DTR) ? 1 : 0),
 			                     ((ival & TIOCM_RTS) ? 1 : 0));
 			sx_reconfigure_port(port);
@@ -2484,7 +2483,7 @@
 		printk (KERN_DEBUG "sx: performing cntrl reg fix: %08x -> %08x\n", t, CNTRL_REG_GOODVALUE); 
 		writel (CNTRL_REG_GOODVALUE, rebase + CNTRL_REG_OFFSET);
 	}
-	my_iounmap (hwbase, rebase);
+	iounmap ((char *) rebase);
 }
 #endif
 
@@ -2574,7 +2573,7 @@
 			   0x18000 ....  */
 			if (IS_CF_BOARD (board)) board->base += 0x18000;
 
-			board->irq = get_irq (pdev);
+			board->irq = pdev->irq;
 
 			sx_dprintk (SX_DEBUG_PROBE, "Got a specialix card: %x/%lx(%d) %x.\n", 
 			            tint, boards[found].base, board->irq, board->flags);
@@ -2583,7 +2582,7 @@
 				found++;
 				fix_sx_pci (pdev, board);
 			} else 
-				my_iounmap (board->hw_base, board->base);
+				iounmap ((char *) (board->base));
 		}
 	}
 #endif
@@ -2600,7 +2599,7 @@
 		if (probe_sx (board)) {
 			found++;
 		} else {
-			my_iounmap (board->hw_base, board->base);
+			iounmap ((char *) (board->base));
 		}
 	}
 
@@ -2616,7 +2615,7 @@
 		if (probe_si (board)) {
 			found++;
 		} else {
-			my_iounmap (board->hw_base, board->base);
+			iounmap ((char *) (board->base));
 		}
 	}
 	for (i=0;i<NR_SI1_ADDRS;i++) {
@@ -2631,7 +2630,7 @@
 		if (probe_si (board)) {
 			found++;
 		} else {
-			my_iounmap (board->hw_base, board->base);
+			iounmap ((char *) (board->base));
 		}
 	}
 
@@ -2692,7 +2691,7 @@
 
 			/* It is safe/allowed to del_timer a non-active timer */
 			del_timer (& board->timer);
-			my_iounmap (board->hw_base, board->base);
+			iounmap ((char *) (board->base));
 		}
 	}
 	if (misc_deregister(&sx_fw_device) < 0) {
--- linux-2.5.65-full/drivers/char/applicom.c.old	2003-03-21 21:47:36.000000000 +0100
+++ linux-2.5.65-full/drivers/char/applicom.c	2003-03-21 22:07:30.000000000 +0100
@@ -29,22 +29,12 @@
 #include <linux/pci.h>
 #include <linux/wait.h>
 #include <linux/init.h>
-#include <linux/compatmac.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
 #include "applicom.h"
 
-#if LINUX_VERSION_CODE < 0x20300 
-/* These probably want adding to <linux/compatmac.h> */
-#define init_waitqueue_head(x) do { *(x) = NULL; } while (0)
-#define PCI_BASE_ADDRESS(dev) (dev->base_address[0])
-#define DECLARE_WAIT_QUEUE_HEAD(x) struct wait_queue *x
-#define __setup(x,y) /* */
-#else
-#define PCI_BASE_ADDRESS(dev) (dev->resource[0].start)
-#endif
 
 /* NOTE: We use for loops with {write,read}b() instead of 
    memcpy_{from,to}io throughout this driver. This is because
@@ -220,18 +210,18 @@
 		if (pci_enable_device(dev))
 			return -EIO;
 
-		RamIO = ioremap(PCI_BASE_ADDRESS(dev), LEN_RAM_IO);
+		RamIO = ioremap(dev->resource[0].start, LEN_RAM_IO);
 
 		if (!RamIO) {
-			printk(KERN_INFO "ac.o: Failed to ioremap PCI memory space at 0x%lx\n", PCI_BASE_ADDRESS(dev));
+			printk(KERN_INFO "ac.o: Failed to ioremap PCI memory space at 0x%lx\n", dev->resource[0].start);
 			return -EIO;
 		}
 
 		printk(KERN_INFO "Applicom %s found at mem 0x%lx, irq %d\n",
-		       applicom_pci_devnames[dev->device-1], PCI_BASE_ADDRESS(dev), 
+		       applicom_pci_devnames[dev->device-1], dev->resource[0].start, 
 		       dev->irq);
 
-		if (!(boardno = ac_register_board(PCI_BASE_ADDRESS(dev),
+		if (!(boardno = ac_register_board(dev->resource[0].start,
 						  (unsigned long)RamIO,0))) {
 			printk(KERN_INFO "ac.o: PCI Applicom device doesn't have correct signature.\n");
 			iounmap(RamIO);
