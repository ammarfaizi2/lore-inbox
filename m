Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318113AbSGWPvZ>; Tue, 23 Jul 2002 11:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318114AbSGWPvZ>; Tue, 23 Jul 2002 11:51:25 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:24009 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S318113AbSGWPvT>; Tue, 23 Jul 2002 11:51:19 -0400
Message-Id: <200207231554.g6NFsJW114946@d06relay02.portsmouth.uk.ibm.com>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] 2.5.27: s390 fixes.
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Mail-Copies-To: arndb@de.ibm.com
Date: Tue, 23 Jul 2002 19:42:34 +0200
References: <200207221950.45748.schwidefsky@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:

> Hi Linus,
> s390 fixes for 2.5.27:

This patch no longer applies to the bk version because of changes in 
dasd_ioctl.c. I have fixed that and split the patch into six smaller
ones following here.

	Arnd <><

part 1/6:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683   -> 1.683.1.1
#	drivers/s390/cio/chsc.c	1.1     -> 1.2    
#	drivers/s390/char/hwc_con.c	1.5     -> 1.6    
#	arch/s390/kernel/setup.c	1.9     -> 1.10   
#	drivers/s390/cio/proc.c	1.1     -> 1.2    
#	arch/s390/kernel/debug.c	1.7     -> 1.8    
#	arch/s390x/kernel/debug.c	1.7     -> 1.8    
#	drivers/s390/net/ctcmain.c	1.8     -> 1.9    
#	arch/s390x/kernel/setup.c	1.7     -> 1.8    
#	drivers/s390/char/tapechar.c	1.7     -> 1.8    
#	drivers/s390/net/netiucv.c	1.11    -> 1.12   
#	drivers/s390/char/tubfs.c	1.4     -> 1.5    
#	drivers/s390/char/tape.c	1.5     -> 1.6    
#	drivers/s390/block/xpram.c	1.23    -> 1.24   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/23	arnd@bergmann-dalldorf.de	1.683.1.1
# convert named struct initializers to C99 syntax in s390 specific files
# --------------------------------------------
#
diff -Nru a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
--- a/arch/s390/kernel/debug.c	Tue Jul 23 18:53:41 2002
+++ b/arch/s390/kernel/debug.c	Tue Jul 23 18:53:41 2002
@@ -149,10 +149,10 @@
 static int initialized = 0;
 
 static struct file_operations debug_file_ops = {
-	read:    debug_output,
-	write:   debug_input,	
-	open:    debug_open,
-	release: debug_close,
+	.read    = debug_output,
+	.write   = debug_input,	
+	.open    = debug_open,
+	.release = debug_close,
 };
 
 static struct proc_dir_entry *debug_proc_root_entry;
diff -Nru a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
--- a/arch/s390/kernel/setup.c	Tue Jul 23 18:53:41 2002
+++ b/arch/s390/kernel/setup.c	Tue Jul 23 18:53:41 2002
@@ -524,7 +524,7 @@
 		seq_printf(m, "vendor_id       : IBM/S390\n"
 			       "# processors    : %i\n"
 			       "bogomips per cpu: %lu.%02lu\n",
-			       smp_num_cpus, loops_per_jiffy/(500000/HZ),
+			       num_online_cpus(), loops_per_jiffy/(500000/HZ),
 			       (loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
@@ -553,8 +553,8 @@
 {
 }
 struct seq_operations cpuinfo_op = {
-	start:	c_start,
-	next:	c_next,
-	stop:	c_stop,
-	show:	show_cpuinfo,
+	.start = c_start,
+	.next  = c_next,
+	.stop  = c_stop,
+	.show  = show_cpuinfo,
 };
diff -Nru a/arch/s390x/kernel/debug.c b/arch/s390x/kernel/debug.c
--- a/arch/s390x/kernel/debug.c	Tue Jul 23 18:53:41 2002
+++ b/arch/s390x/kernel/debug.c	Tue Jul 23 18:53:41 2002
@@ -149,10 +149,10 @@
 static int initialized = 0;
 
 static struct file_operations debug_file_ops = {
-	read:    debug_output,
-	write:   debug_input,	
-	open:    debug_open,
-	release: debug_close,
+	.read    = debug_output,
+	.write   = debug_input,	
+	.open    = debug_open,
+	.release = debug_close,
 };
 
 static struct proc_dir_entry *debug_proc_root_entry;
diff -Nru a/arch/s390x/kernel/setup.c b/arch/s390x/kernel/setup.c
--- a/arch/s390x/kernel/setup.c	Tue Jul 23 18:53:41 2002
+++ b/arch/s390x/kernel/setup.c	Tue Jul 23 18:53:41 2002
@@ -514,7 +514,7 @@
 		seq_printf(m, "vendor_id       : IBM/S390\n"
 				"# processors    : %i\n"
 				"bogomips per cpu: %lu.%02lu\n",
-				smp_num_cpus, loops_per_jiffy/(500000/HZ),
+				num_online_cpus(), loops_per_jiffy/(500000/HZ),
 				(loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
@@ -543,8 +543,8 @@
 {
 }
 struct seq_operations cpuinfo_op = {
-	start:	c_start,
-	next:	c_next,
-	stop:	c_stop,
-	show:	show_cpuinfo,
+	.start = c_start,
+	.next  = c_next,
+	.stop  = c_stop,
+	.show  = show_cpuinfo,
 };
diff -Nru a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
--- a/drivers/s390/block/xpram.c	Tue Jul 23 18:53:41 2002
+++ b/drivers/s390/block/xpram.c	Tue Jul 23 18:53:41 2002
@@ -15,7 +15,6 @@
  *   Device specific file operations
  *        xpram_iotcl
  *        xpram_open
- *        xpram_release
  *
  * "ad-hoc" partitioning:
  *    the expanded memory can be partitioned among several devices 
@@ -36,6 +35,7 @@
 #include <linux/blkpg.h>
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
 #include <linux/device.h>
+#include <linux/bio.h>
 #include <asm/uaccess.h>
 
 #define XPRAM_NAME	"xpram"
@@ -48,8 +48,8 @@
 #define PRINT_ERR(x...)		printk(KERN_ERR XPRAM_NAME " error:" x)
 
 static struct device xpram_sys_device = {
-	name: "S/390 expanded memory RAM disk",
-	bus_id: "xpram",
+	.name   = "S/390 expanded memory RAM disk",
+	.bus_id = "xpram",
 };
 
 typedef struct {
@@ -328,7 +328,6 @@
 	return 0;
 }
 
-
 static int xpram_ioctl (struct inode *inode, struct file *filp,
 		 unsigned int cmd, unsigned long arg)
 {
@@ -336,8 +335,6 @@
 	unsigned long size;
 	int idx;
 
-	if ((!inode) || kdev_none(inode->i_rdev))
-		return -EINVAL;
 	idx = minor(inode->i_rdev);
 	if (idx >= xpram_devs)
 		return -ENODEV;
@@ -367,10 +364,9 @@
 
 static struct block_device_operations xpram_devops =
 {
-	owner:   THIS_MODULE,
-	ioctl:   xpram_ioctl,
-	open:    xpram_open,
-	release: xpram_release,
+	.owner = THIS_MODULE,
+	.ioctl = xpram_ioctl,
+	.open  = xpram_open,
 };
 
 /*
diff -Nru a/drivers/s390/char/hwc_con.c b/drivers/s390/char/hwc_con.c
--- a/drivers/s390/char/hwc_con.c	Tue Jul 23 18:53:41 2002
+++ b/drivers/s390/char/hwc_con.c	Tue Jul 23 18:53:41 2002
@@ -34,11 +34,11 @@
 struct console hwc_console =
 {
 
-	name:hwc_console_name,
-	write:hwc_console_write,
-	device:hwc_console_device,
-	unblank:hwc_console_unblank,
-	flags:CON_PRINTBUFFER,
+	.name	= hwc_console_name,
+	.write	= hwc_console_write,
+	.device	= hwc_console_device,
+	.unblank= hwc_console_unblank,
+	.flags	= CON_PRINTBUFFER,
 };
 
 void 
diff -Nru a/drivers/s390/char/tape.c b/drivers/s390/char/tape.c
--- a/drivers/s390/char/tape.c	Tue Jul 23 18:53:41 2002
+++ b/drivers/s390/char/tape.c	Tue Jul 23 18:53:41 2002
@@ -199,9 +199,9 @@
 
 static struct file_operations tape_proc_devices_file_ops =
 {
-	read:tape_proc_devices_read,	/* read */
-	open:tape_proc_devices_open,	/* open */
-	release:tape_proc_devices_release,	/* close */
+	.read	 = tape_proc_devices_read,
+	.open	 = tape_proc_devices_open,
+	.release = tape_proc_devices_release,
 };
 
 /* 
diff -Nru a/drivers/s390/char/tapechar.c b/drivers/s390/char/tapechar.c
--- a/drivers/s390/char/tapechar.c	Tue Jul 23 18:53:41 2002
+++ b/drivers/s390/char/tapechar.c	Tue Jul 23 18:53:41 2002
@@ -40,11 +40,11 @@
  */
 static struct file_operations tape_fops =
 {
-	read:tapechar_read,
-	write:tapechar_write,
-	ioctl:tapechar_ioctl,
-	open:tapechar_open,
-	release:tapechar_release,
+	.read	 = tapechar_read,
+	.write	 = tapechar_write,
+	.ioctl	 = tapechar_ioctl,
+	.open	 = tapechar_open,
+	.release = tapechar_release,
 };
 
 int tapechar_major = TAPECHAR_MAJOR;
diff -Nru a/drivers/s390/char/tubfs.c b/drivers/s390/char/tubfs.c
--- a/drivers/s390/char/tubfs.c	Tue Jul 23 18:53:41 2002
+++ b/drivers/s390/char/tubfs.c	Tue Jul 23 18:53:41 2002
@@ -24,13 +24,13 @@
 
 static struct file_operations fs3270_fops = {
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,0))
-	owner: THIS_MODULE,		/* owner */
+	.owner   = THIS_MODULE,		/* owner */
 #endif
-	read: 	fs3270_read,	/* read */
-	write:	fs3270_write,	/* write */
-	ioctl:	fs3270_ioctl,	/* ioctl */
-	open: 	fs3270_open,	/* open */
-	release:fs3270_close,	/* release */
+	.read    = fs3270_read,
+	.write   = fs3270_write,
+	.ioctl   = fs3270_ioctl,
+	.open    = fs3270_open,
+	.release = fs3270_close,
 };
 
 #ifdef CONFIG_DEVFS_FS
diff -Nru a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
--- a/drivers/s390/cio/chsc.c	Tue Jul 23 18:53:41 2002
+++ b/drivers/s390/cio/chsc.c	Tue Jul 23 18:53:41 2002
@@ -70,13 +70,13 @@
 		*ssd_res = &chsc_area_ssd.response_block.response_block_data.ssd_res;
 
 	chsc_area_ssd = (chsc_area_t) {
-		request_block: {
-			command_code1: 0x0010,
-			command_code2: 0x0004,
-			request_block_data: {
-				ssd_req: {
-					f_sch: irq,
-					l_sch: irq,
+		.request_block = {
+			.command_code1 = 0x0010,
+			.command_code2 = 0x0004,
+			.request_block_data = {
+				.ssd_req = {
+					.f_sch = irq,
+					.l_sch = irq,
 				}
 			}
 		}
@@ -554,9 +554,9 @@
 	 * allocation or prove that this function does not have to be
 	 * reentrant! */
 	static chsc_area_t chsc_area_sei __attribute__ ((aligned(PAGE_SIZE))) = {
-		request_block: {
-			command_code1: 0x0010,
-			command_code2: 0x000e
+		.request_block = {
+			.command_code1 = 0x0010,
+			.command_code2 = 0x000e
 		}
 	};
 
diff -Nru a/drivers/s390/cio/proc.c b/drivers/s390/cio/proc.c
--- a/drivers/s390/cio/proc.c	Tue Jul 23 18:53:41 2002
+++ b/drivers/s390/cio/proc.c	Tue Jul 23 18:53:41 2002
@@ -154,7 +154,7 @@
 }
 
 static struct file_operations chan_subch_file_ops = {
-	read:chan_subch_read, open:chan_subch_open, release:chan_subch_close,
+	.read=chan_subch_read, .open=chan_subch_open, .release=chan_subch_close,
 };
 
 static int
@@ -245,8 +245,8 @@
 }
 
 static struct file_operations cio_irq_proc_file_ops = {
-	read:cio_irq_proc_read, open:cio_irq_proc_open,
-	release:cio_irq_proc_close,
+	.read=cio_irq_proc_read, .open=cio_irq_proc_open,
+	.release=cio_irq_proc_close,
 };
 
 static int
diff -Nru a/drivers/s390/net/ctcmain.c b/drivers/s390/net/ctcmain.c
--- a/drivers/s390/net/ctcmain.c	Tue Jul 23 18:53:41 2002
+++ b/drivers/s390/net/ctcmain.c	Tue Jul 23 18:53:41 2002
@@ -49,6 +49,7 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 
 #include <linux/signal.h>
 #include <linux/string.h>
@@ -2888,17 +2889,17 @@
 }
 
 static struct file_operations ctc_stat_fops = {
-	read:    ctc_stat_read,
-	write:   ctc_stat_write,
-	open:    ctc_stat_open,
-	release: ctc_stat_close,
+	.read    = ctc_stat_read,
+	.write   = ctc_stat_write,
+	.open    = ctc_stat_open,
+	.release = ctc_stat_close,
 };
 
 static struct file_operations ctc_ctrl_fops = {
-	read:    ctc_ctrl_read,
-	write:   ctc_ctrl_write,
-	open:    ctc_ctrl_open,
-	release: ctc_ctrl_close,
+	.read    = ctc_ctrl_read,
+	.write   = ctc_ctrl_write,
+	.open    = ctc_ctrl_open,
+	.release = ctc_ctrl_close,
 };
 
 static struct proc_dir_entry *ctc_dir = NULL;
diff -Nru a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
--- a/drivers/s390/net/netiucv.c	Tue Jul 23 18:53:41 2002
+++ b/drivers/s390/net/netiucv.c	Tue Jul 23 18:53:41 2002
@@ -465,13 +465,13 @@
 }
 
 static iucv_interrupt_ops_t netiucv_ops = {
-	ConnectionPending:  netiucv_callback_connreq,
-	ConnectionComplete: netiucv_callback_connack,
-	ConnectionSevered:  netiucv_callback_connrej,
-	ConnectionQuiesced: netiucv_callback_connsusp,
-	ConnectionResumed:  netiucv_callback_connres,
-	MessagePending:     netiucv_callback_rx,
-	MessageComplete:    netiucv_callback_txdone
+	.ConnectionPending  = netiucv_callback_connreq,
+	.ConnectionComplete = netiucv_callback_connack,
+	.ConnectionSevered  = netiucv_callback_connrej,
+	.ConnectionQuiesced = netiucv_callback_connsusp,
+	.ConnectionResumed  = netiucv_callback_connres,
+	.MessagePending     = netiucv_callback_rx,
+	.MessageComplete    = netiucv_callback_txdone
 };
 
 /**
@@ -1566,24 +1566,24 @@
 }
 
 static struct file_operations netiucv_stat_fops = {
-	read:    netiucv_stat_read,
-	write:   netiucv_stat_write,
-	open:    netiucv_stat_open,
-	release: netiucv_stat_close,
+	.read    = netiucv_stat_read,
+	.write   = netiucv_stat_write,
+	.open    = netiucv_stat_open,
+	.release = netiucv_stat_close,
 };
 
 static struct file_operations netiucv_buffer_fops = {
-	read:    netiucv_buffer_read,
-	write:   netiucv_buffer_write,
-	open:    netiucv_buffer_open,
-	release: netiucv_buffer_close,
+	.read    = netiucv_buffer_read,
+	.write   = netiucv_buffer_write,
+	.open    = netiucv_buffer_open,
+	.release = netiucv_buffer_close,
 };
 
 static struct file_operations netiucv_user_fops = {
-	read:    netiucv_user_read,
-	write:   netiucv_user_write,
-	open:    netiucv_user_open,
-	release: netiucv_user_close,
+	.read    = netiucv_user_read,
+	.write   = netiucv_user_write,
+	.open    = netiucv_user_open,
+	.release = netiucv_user_close,
 };
 
 static struct proc_dir_entry *netiucv_dir = NULL;
