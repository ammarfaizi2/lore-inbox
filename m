Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbTLXWbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 17:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTLXWbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 17:31:23 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:266 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263946AbTLXWbO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 17:31:14 -0500
Date: Wed, 24 Dec 2003 23:32:10 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, second wave (2/5)
Message-Id: <20031224233210.4573f541.khali@linux-fr.org>
In-Reply-To: <20031224225707.749707e5.khali@linux-fr.org>
References: <20031224225707.749707e5.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch drops almost all compatibility stuff that was leftover from
times of kernel 2.2. A few extra includes may have survived, we will
take care of them later.

Most of the work was done by Kyösti Mälkki. Original comment follows:
***
Remove code for KERNEL_VERSION tests.
***

Note that this patch was voluntarily generated using diff -U1, because
it contains only removals, so much context isn't required. Doing so
makes this patch apply successfully even if you don't apply the patch #1
of this second wave first.

diff -r -U1 linux-2.4.24-pre2-k1/drivers/i2c/i2c-adap-ite.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-adap-ite.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-adap-ite.c	Mon Dec 22 22:04:00 2003
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-adap-ite.c	Tue Dec 23 19:02:05 2003
@@ -40,3 +40,2 @@
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
@@ -63,7 +62,3 @@
 static struct iic_ite gpi;
-#if (LINUX_VERSION_CODE < 0x020301)
-static struct wait_queue *iic_wait = NULL;
-#else
 static wait_queue_head_t iic_wait;
-#endif
 static int iic_pending;
@@ -273,5 +268,2 @@
 	iic_ite_data.data = (void *)piic;
-#if (LINUX_VERSION_CODE >= 0x020301)
-	init_waitqueue_head(&iic_wait);
-#endif
 	if (iic_hw_resrc_init() == 0) {
diff -r -U1 linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-bit.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-algo-bit.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-bit.c	Mon Dec 22 22:04:00 2003
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-algo-bit.c	Tue Dec 23 19:02:05 2003
@@ -29,3 +29,2 @@
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
diff -r -U1 linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-ite.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-algo-ite.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-ite.c	Mon Dec 22 22:04:00 2003
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-algo-ite.c	Tue Dec 23 19:02:05 2003
@@ -40,3 +40,2 @@
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
diff -r -U1 linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-pcf.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-algo-pcf.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-pcf.c	Mon Dec 22 22:04:00 2003
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-algo-pcf.c	Tue Dec 23 19:02:05 2003
@@ -33,3 +33,2 @@
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
diff -r -U1 linux-2.4.24-pre2-k1/drivers/i2c/i2c-core.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-core.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-core.c	Mon Dec 22 22:04:00 2003
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-core.c	Tue Dec 23 19:02:05 2003
@@ -35,9 +35,4 @@
 
-#include <linux/version.h>
 #include <linux/init.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-#define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
-#endif
-
 #include <asm/uaccess.h>
@@ -86,6 +81,2 @@
 
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,3,27))
-static void monitor_bus_i2c(struct inode *inode, int fill);
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,58)) */
-
 static ssize_t i2cproc_bus_read(struct file * file, char * buf,size_t count, 
@@ -101,8 +92,2 @@
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,48))
-static struct inode_operations i2cproc_inode_operations = {
-	&i2cproc_operations
-};
-#endif
-
 static int i2cproc_initialized = 0;
@@ -166,12 +151,4 @@
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,48))
 		proc_entry->proc_fops = &i2cproc_operations;
-#else
-		proc_entry->ops = &i2cproc_inode_operations;
-#endif
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27))
 		proc_entry->owner = THIS_MODULE;
-#else
-		proc_entry->fill_inode = &monitor_bus_i2c;
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,58)) */
 		adap->inode = proc_entry->low_ino;
@@ -613,14 +590,2 @@
 
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,3,27))
-/* Monitor access to /proc/bus/i2c*; make unloading i2c-proc impossible
-   if some process still uses it or some file in it */
-void monitor_bus_i2c(struct inode *inode, int fill)
-{
-	if (fill)
-		MOD_INC_USE_COUNT;
-	else
-		MOD_DEC_USE_COUNT;
-}
-#endif /* (LINUX_VERSION_CODE <= KERNEL_VERSION(2,3,37)) */
-
 /* This function generates the output for /proc/bus/i2c */
@@ -734,7 +699,3 @@
 	proc_bus_i2c->read_proc = &read_bus_i2c;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27))
 	proc_bus_i2c->owner = THIS_MODULE;
-#else
-	proc_bus_i2c->fill_inode = &monitor_bus_i2c;
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27)) */
 	i2cproc_initialized += 2;
diff -r -U1 linux-2.4.24-pre2-k1/drivers/i2c/i2c-dev.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-dev.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-dev.c	Mon Dec 22 22:04:00 2003
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-dev.c	Tue Dec 23 19:02:05 2003
@@ -37,6 +37,3 @@
 #include <linux/slab.h>
-#include <linux/version.h>
-#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
 #include <linux/smp_lock.h>
-#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
 #ifdef CONFIG_DEVFS_FS
@@ -57,5 +54,2 @@
 
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,9)
-static loff_t i2cdev_lseek (struct file *file, loff_t offset, int origin);
-#endif
 static ssize_t i2cdev_read (struct file *file, char *buf, size_t count, 
@@ -79,10 +73,4 @@
 static struct file_operations i2cdev_fops = {
-#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
 	owner:		THIS_MODULE,
-#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,9)
-	llseek:		i2cdev_lseek,
-#else
 	llseek:		no_llseek,
-#endif
 	read:		i2cdev_read,
@@ -124,16 +112,2 @@
 
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,9)
-/* Note that the lseek function is called llseek in 2.1 kernels. But things
-   are complicated enough as is. */
-loff_t i2cdev_lseek (struct file *file, loff_t offset, int origin)
-{
-#ifdef DEBUG
-	struct inode *inode = file->f_dentry->d_inode;
-	printk("i2c-dev.o: i2c-%d lseek to %ld bytes relative to %d.\n",
-	       MINOR(inode->i_rdev),(long) offset,origin);
-#endif /* DEBUG */
-	return -ESPIPE;
-}
-#endif
-
 static ssize_t i2cdev_read (struct file *file, char *buf, size_t count,
@@ -425,5 +399,2 @@
 		i2cdev_adaps[minor]->inc_use(i2cdev_adaps[minor]);
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0)
-	MOD_INC_USE_COUNT;
-#endif /* LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0) */
 
@@ -443,12 +414,6 @@
 #endif
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0)
-	MOD_DEC_USE_COUNT;
-#else /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
 	lock_kernel();
-#endif /* LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0) */
 	if (i2cdev_adaps[minor]->dec_use)
 		i2cdev_adaps[minor]->dec_use(i2cdev_adaps[minor]);
-#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
 	unlock_kernel();
-#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
 	return 0;
diff -r -U1 linux-2.4.24-pre2-k1/drivers/i2c/i2c-elektor.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-elektor.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-elektor.c	Mon Dec 22 22:04:00 2003
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-elektor.c	Tue Dec 23 19:02:05 2003
@@ -32,3 +32,2 @@
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
@@ -57,7 +56,3 @@
 
-#if (LINUX_VERSION_CODE < 0x020301)
-static struct wait_queue *pcf_wait = NULL;
-#else
 static wait_queue_head_t pcf_wait;
-#endif
 static int pcf_pending;
@@ -270,5 +265,3 @@
 
-#if (LINUX_VERSION_CODE >= 0x020301)
 	init_waitqueue_head(&pcf_wait);
-#endif
 	if (pcf_isa_init() == 0) {
diff -r -U1 linux-2.4.24-pre2-k1/drivers/i2c/i2c-elv.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-elv.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-elv.c	Mon Dec 22 22:04:00 2003
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-elv.c	Tue Dec 23 19:02:05 2003
@@ -29,3 +29,2 @@
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
diff -r -U1 linux-2.4.24-pre2-k1/drivers/i2c/i2c-keywest.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-keywest.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-keywest.c	Fri Nov 29 00:53:13 2002
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-keywest.c	Tue Dec 23 19:02:05 2003
@@ -47,3 +47,2 @@
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
diff -r -U1 linux-2.4.24-pre2-k1/drivers/i2c/i2c-philips-par.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-philips-par.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-philips-par.c	Mon Dec 22 22:04:00 2003
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-philips-par.c	Tue Dec 23 19:02:05 2003
@@ -248,3 +248,2 @@
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 static struct parport_driver i2c_driver = {
@@ -255,3 +254,2 @@
 };
-#endif
 
@@ -259,13 +257,5 @@
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,4)
-	struct parport *port;
-#endif
 	printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 	parport_register_driver(&i2c_driver);
-#else
-	for (port = parport_enumerate(); port; port=port->next)
-		i2c_parport_attach(port);
-#endif
 	
@@ -276,9 +266,3 @@
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 	parport_unregister_driver(&i2c_driver);
-#else
-	struct parport *port;
-	for (port = parport_enumerate(); port; port=port->next)
-		i2c_parport_detach(port);
-#endif
 }
diff -r -U1 linux-2.4.24-pre2-k1/drivers/i2c/i2c-proc.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-proc.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-proc.c	Mon Dec 22 22:04:00 2003
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-proc.c	Tue Dec 23 19:02:05 2003
@@ -25,3 +25,2 @@
 
-#include <linux/version.h>
 #include <linux/module.h>
@@ -63,6 +62,2 @@
 static unsigned short i2c_inodes[SENSORS_ENTRY_MAX];
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-static void i2c_fill_inode(struct inode *inode, int fill);
-static void i2c_dir_fill_inode(struct inode *inode, int fill);
-#endif			/* LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1) */
 
@@ -196,8 +191,3 @@
 	    new_header->ctl_table->child->child->de->low_ino;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27))
 	new_header->ctl_table->child->child->de->owner = controlling_mod;
-#else
-	new_header->ctl_table->child->child->de->fill_inode =
-	    &i2c_dir_fill_inode;
-#endif	/* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27)) */
 
@@ -863,8 +853,3 @@
 	     register_sysctl_table(i2c_proc, 0))) return -ENOMEM;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,1))
 	i2c_proc_header->ctl_table->child->de->owner = THIS_MODULE;
-#else
-	i2c_proc_header->ctl_table->child->de->fill_inode =
-	    &i2c_fill_inode;
-#endif			/* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,1)) */
 	i2c_initialized++;
diff -r -U1 linux-2.4.24-pre2-k1/include/linux/i2c.h linux-2.4.24-pre2-k2/include/linux/i2c.h
--- linux-2.4.24-pre2-k1/include/linux/i2c.h	Mon Dec 22 22:20:29 2003
+++ linux-2.4.24-pre2-k2/include/linux/i2c.h	Tue Dec 23 20:05:40 2003
@@ -44,13 +44,3 @@
 
-#include <linux/version.h>
-#ifndef KERNEL_VERSION
-#define KERNEL_VERSION(a,b,c) (((a) << 16) | ((b) << 8) | (c))
-#endif
-
-#include <asm/page.h>			/* for 2.2.xx 			*/
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,0,25)
-#include <linux/sched.h>
-#else
 #include <asm/semaphore.h>
-#endif
 #include <linux/config.h>
@@ -228,6 +218,2 @@
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,29)
-struct proc_dir_entry;
-#endif
-
 /*
@@ -269,5 +255,2 @@
 	int inode;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,29)
-	struct proc_dir_entry *proc_entry;
-#endif
 #endif /* def CONFIG_PROC_FS */


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
