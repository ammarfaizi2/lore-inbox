Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269119AbUJUHMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269119AbUJUHMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269192AbUJUHKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:10:10 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:12680 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269119AbUJUG7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:59:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Sonypi: whitespace fixes
Date: Thu, 21 Oct 2004 01:56:25 -0500
User-Agent: KMail/1.6.2
Cc: stelian@popies.net
References: <200410210154.58301.dtor_core@ameritech.net>
In-Reply-To: <200410210154.58301.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210156.27067.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1976, 2004-10-21 01:43:04-05:00, dtor_core@ameritech.net
  Sonypi: whitespace and coding style fixes.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/char/sonypi.c  |  153 +++++++++++++++++++++++++++++--------------------
 drivers/char/sonypi.h  |   18 +++--
 include/linux/sonypi.h |   10 +--
 3 files changed, 106 insertions(+), 75 deletions(-)


===================================================================



diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2004-10-21 01:53:49 -05:00
+++ b/drivers/char/sonypi.c	2004-10-21 01:53:49 -05:00
@@ -19,12 +19,12 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
@@ -64,7 +64,8 @@
 static unsigned long mask = 0xffffffff;
 
 /* Inits the queue */
-static inline void sonypi_initq(void) {
+static inline void sonypi_initq(void)
+{
         sonypi_device.queue.head = sonypi_device.queue.tail = 0;
 	sonypi_device.queue.len = 0;
 	sonypi_device.queue.s_lock = SPIN_LOCK_UNLOCKED;
@@ -72,7 +73,8 @@
 }
 
 /* Pulls an event from the queue */
-static inline unsigned char sonypi_pullq(void) {
+static inline unsigned char sonypi_pullq(void)
+{
         unsigned char result;
 	unsigned long flags;
 
@@ -90,7 +92,8 @@
 }
 
 /* Pushes an event into the queue */
-static inline void sonypi_pushq(unsigned char event) {
+static inline void sonypi_pushq(unsigned char event)
+{
 	unsigned long flags;
 
 	spin_lock_irqsave(&sonypi_device.queue.s_lock, flags);
@@ -111,7 +114,8 @@
 }
 
 /* Tests if the queue is empty */
-static inline int sonypi_emptyq(void) {
+static inline int sonypi_emptyq(void)
+{
         int result;
 	unsigned long flags;
 
@@ -121,7 +125,8 @@
         return result;
 }
 
-static int ec_read16(u8 addr, u16 *value) {
+static int ec_read16(u8 addr, u16 *value)
+{
 	u8 val_lb, val_hb;
 	if (sonypi_ec_read(addr, &val_lb))
 		return -1;
@@ -132,7 +137,8 @@
 }
 
 /* Initializes the device - this comes from the AML code in the ACPI bios */
-static void sonypi_type1_srs(void) {
+static void sonypi_type1_srs(void)
+{
 	u32 v;
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
@@ -140,7 +146,7 @@
 	pci_write_config_dword(sonypi_device.dev, SONYPI_G10A, v);
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
-	v = (v & 0xFFF0FFFF) | 
+	v = (v & 0xFFF0FFFF) |
 	    (((u32)sonypi_device.ioport1 ^ sonypi_device.ioport2) << 16);
 	pci_write_config_dword(sonypi_device.dev, SONYPI_G10A, v);
 
@@ -154,7 +160,8 @@
 	pci_write_config_dword(sonypi_device.dev, SONYPI_G10A, v);
 }
 
-static void sonypi_type2_srs(void) {
+static void sonypi_type2_srs(void)
+{
 	if (sonypi_ec_write(SONYPI_SHIB, (sonypi_device.ioport1 & 0xFF00) >> 8))
 		printk(KERN_WARNING "ec_write failed\n");
 	if (sonypi_ec_write(SONYPI_SLOB,  sonypi_device.ioport1 & 0x00FF))
@@ -165,7 +172,8 @@
 }
 
 /* Disables the device - this comes from the AML code in the ACPI bios */
-static void sonypi_type1_dis(void) {
+static void sonypi_type1_dis(void)
+{
 	u32 v;
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
@@ -177,7 +185,8 @@
 	outl(v, SONYPI_IRQ_PORT);
 }
 
-static void sonypi_type2_dis(void) {
+static void sonypi_type2_dis(void)
+{
 	if (sonypi_ec_write(SONYPI_SHIB, 0))
 		printk(KERN_WARNING "ec_write failed\n");
 	if (sonypi_ec_write(SONYPI_SLOB, 0))
@@ -186,7 +195,8 @@
 		printk(KERN_WARNING "ec_write failed\n");
 }
 
-static u8 sonypi_call1(u8 dev) {
+static u8 sonypi_call1(u8 dev)
+{
 	u8 v1, v2;
 
 	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2, ITERATIONS_LONG);
@@ -196,7 +206,8 @@
 	return v2;
 }
 
-static u8 sonypi_call2(u8 dev, u8 fn) {
+static u8 sonypi_call2(u8 dev, u8 fn)
+{
 	u8 v1;
 
 	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2, ITERATIONS_LONG);
@@ -207,7 +218,8 @@
 	return v1;
 }
 
-static u8 sonypi_call3(u8 dev, u8 fn, u8 v) {
+static u8 sonypi_call3(u8 dev, u8 fn, u8 v)
+{
 	u8 v1;
 
 	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2, ITERATIONS_LONG);
@@ -220,7 +232,8 @@
 	return v1;
 }
 
-static u8 sonypi_read(u8 fn) {
+static u8 sonypi_read(u8 fn)
+{
 	u8 v1, v2;
 	int n = 100;
 
@@ -234,13 +247,14 @@
 }
 
 /* Set brightness, hue etc */
-static void sonypi_set(u8 fn, u8 v) {
-	
+static void sonypi_set(u8 fn, u8 v)
+{
 	wait_on_command(0, sonypi_call3(0x90, fn, v), ITERATIONS_SHORT);
 }
 
 /* Tests if the camera is ready */
-static int sonypi_camera_ready(void) {
+static int sonypi_camera_ready(void)
+{
 	u8 v;
 
 	v = sonypi_call2(0x8f, SONYPI_CAMERA_STATUS);
@@ -248,19 +262,20 @@
 }
 
 /* Turns the camera off */
-static void sonypi_camera_off(void) {
-
+static void sonypi_camera_off(void)
+{
 	sonypi_set(SONYPI_CAMERA_PICTURE, SONYPI_CAMERA_MUTE_MASK);
 
 	if (!sonypi_device.camera_power)
 		return;
 
-	sonypi_call2(0x91, 0); 
+	sonypi_call2(0x91, 0);
 	sonypi_device.camera_power = 0;
 }
 
 /* Turns the camera on */
-static void sonypi_camera_on(void) {
+static void sonypi_camera_on(void)
+{
 	int i, j;
 
 	if (sonypi_device.camera_power)
@@ -283,7 +298,7 @@
 		if (i)
 			break;
 	}
-	
+
 	if (j == 0) {
 		printk(KERN_WARNING "sonypi: failed to power on camera\n");
 		return;
@@ -294,19 +309,20 @@
 }
 
 /* sets the bluetooth subsystem power state */
-static void sonypi_setbluetoothpower(u8 state) {
-
+static void sonypi_setbluetoothpower(u8 state)
+{
 	state = !!state;
-	if (sonypi_device.bluetooth_power == state) 
+	if (sonypi_device.bluetooth_power == state)
 		return;
-	
+
 	sonypi_call2(0x96, state);
 	sonypi_call1(0x82);
 	sonypi_device.bluetooth_power = state;
 }
 
 /* Interrupt handler: some event is available */
-static irqreturn_t sonypi_irq(int irq, void *dev_id, struct pt_regs *regs) {
+static irqreturn_t sonypi_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
 	u8 v1, v2, event = 0;
 	int i, j;
 
@@ -329,16 +345,17 @@
 	}
 
 	if (verbose)
-		printk(KERN_WARNING 
+		printk(KERN_WARNING
 		       "sonypi: unknown event port1=0x%02x,port2=0x%02x\n",v1,v2);
+
 	/* We need to return IRQ_HANDLED here because there *are*
-	 * events belonging to the sonypi device we don't know about, 
+	 * events belonging to the sonypi device we don't know about,
 	 * but we still don't want those to pollute the logs... */
 	return IRQ_HANDLED;
 
 found:
 	if (verbose > 1)
-		printk(KERN_INFO 
+		printk(KERN_INFO
 		       "sonypi: event port1=0x%02x,port2=0x%02x\n", v1, v2);
 
 #ifdef SONYPI_USE_INPUT
@@ -357,12 +374,14 @@
 		input_sync(jog_dev);
 	}
 #endif /* SONYPI_USE_INPUT */
+
 	sonypi_pushq(event);
 	return IRQ_HANDLED;
 }
 
 /* External camera command (exported to the motion eye v4l driver) */
-u8 sonypi_camera_command(int command, u8 value) {
+u8 sonypi_camera_command(int command, u8 value)
+{
 	u8 ret = 0;
 
 	if (!camera)
@@ -437,7 +456,8 @@
 	return ret;
 }
 
-static int sonypi_misc_fasync(int fd, struct file *filp, int on) {
+static int sonypi_misc_fasync(int fd, struct file *filp, int on)
+{
 	int retval;
 
 	retval = fasync_helper(fd, filp, on, &sonypi_device.queue.fasync);
@@ -446,7 +466,8 @@
 	return 0;
 }
 
-static int sonypi_misc_release(struct inode * inode, struct file * file) {
+static int sonypi_misc_release(struct inode * inode, struct file * file)
+{
 	sonypi_misc_fasync(-1, file, 0);
 	down(&sonypi_device.lock);
 	sonypi_device.open_count--;
@@ -454,7 +475,8 @@
 	return 0;
 }
 
-static int sonypi_misc_open(struct inode * inode, struct file * file) {
+static int sonypi_misc_open(struct inode * inode, struct file * file)
+{
 	down(&sonypi_device.lock);
 	/* Flush input queue on first open */
 	if (!sonypi_device.open_count)
@@ -498,15 +520,17 @@
 	return 0;
 }
 
-static unsigned int sonypi_misc_poll(struct file *file, poll_table * wait) {
+static unsigned int sonypi_misc_poll(struct file *file, poll_table * wait)
+{
 	poll_wait(file, &sonypi_device.queue.proc_list, wait);
 	if (!sonypi_emptyq())
 		return POLLIN | POLLRDNORM;
 	return 0;
 }
 
-static int sonypi_misc_ioctl(struct inode *ip, struct file *fp, 
-			     unsigned int cmd, unsigned long arg) {
+static int sonypi_misc_ioctl(struct inode *ip, struct file *fp,
+			     unsigned int cmd, unsigned long arg)
+{
 	int ret = 0;
 	void __user *argp = (void __user *)arg;
 	u8 val8;
@@ -607,7 +631,8 @@
 #ifdef CONFIG_PM
 static int old_camera_power;
 
-static int sonypi_suspend(struct sys_device *dev, u32 state) {
+static int sonypi_suspend(struct sys_device *dev, u32 state)
+{
 	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
 	if (camera) {
 		old_camera_power = sonypi_device.camera_power;
@@ -623,7 +648,8 @@
 	return 0;
 }
 
-static int sonypi_resume(struct sys_device *dev) {
+static int sonypi_resume(struct sys_device *dev)
+{
 	/* Enable ACPI mode to get Fn key events */
 	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
 		outb(0xf0, 0xb2);
@@ -634,7 +660,7 @@
 	sonypi_call1(0x82);
 	sonypi_call2(0x81, 0xff);
 	if (compat)
-		sonypi_call1(0x92); 
+		sonypi_call1(0x92);
 	else
 		sonypi_call1(0x82);
 	if (camera && old_camera_power)
@@ -643,8 +669,8 @@
 }
 
 /* Old PM scheme */
-static int sonypi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data) {
-
+static int sonypi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+{
 	switch (rqst) {
 		case PM_SUSPEND:
 			sonypi_suspend(NULL, 0);
@@ -669,7 +695,8 @@
 };
 #endif
 
-static int __devinit sonypi_probe(struct pci_dev *pcidev) {
+static int __devinit sonypi_probe(struct pci_dev *pcidev)
+{
 	int i, ret;
 	struct sonypi_ioport_list *ioport_list;
 	struct sonypi_irq_list *irq_list;
@@ -682,14 +709,14 @@
 	sonypi_initq();
 	init_MUTEX(&sonypi_device.lock);
 	sonypi_device.bluetooth_power = 0;
-	
+
 	if (pcidev && pci_enable_device(pcidev)) {
 		printk(KERN_ERR "sonypi: pci_enable_device failed\n");
 		ret = -EIO;
 		goto out1;
 	}
 
-	sonypi_misc_device.minor = (minor == -1) ? 
+	sonypi_misc_device.minor = (minor == -1) ?
 		MISC_DYNAMIC_MINOR : minor;
 	if ((ret = misc_register(&sonypi_misc_device))) {
 		printk(KERN_ERR "sonypi: misc_register failed\n");
@@ -710,8 +737,8 @@
 	}
 
 	for (i = 0; ioport_list[i].port1; i++) {
-		if (request_region(ioport_list[i].port1, 
-				   sonypi_device.region_size, 
+		if (request_region(ioport_list[i].port1,
+				   sonypi_device.region_size,
 				   "Sony Programable I/O Device")) {
 			/* get the ioport */
 			sonypi_device.ioport1 = ioport_list[i].port1;
@@ -739,12 +766,12 @@
 		sonypi_call1(0x82);
 		sonypi_call2(0x81, 0xff);
 		if (compat)
-			sonypi_call1(0x92); 
+			sonypi_call1(0x92);
 		else
 			sonypi_call1(0x82);
 
 		/* Now try requesting the irq from the system */
-		if (!request_irq(sonypi_device.irq, sonypi_irq, 
+		if (!request_irq(sonypi_device.irq, sonypi_irq,
 				 SA_SHIRQ, "sonypi", sonypi_irq))
 			break;
 
@@ -796,7 +823,7 @@
 	       useinput ? "on" : "off",
 	       SONYPI_ACPI_ACTIVE ? "on" : "off");
 	printk(KERN_INFO "sonypi: enabled at irq=%d, port1=0x%x, port2=0x%x\n",
-	       sonypi_device.irq, 
+	       sonypi_device.irq,
 	       sonypi_device.ioport1, sonypi_device.ioport2);
 
 	if (minor == -1)
@@ -814,7 +841,7 @@
 		sprintf(sonypi_device.jog_dev.name, SONYPI_INPUTNAME);
 		sonypi_device.jog_dev.id.bustype = BUS_ISA;
 		sonypi_device.jog_dev.id.vendor = PCI_VENDOR_ID_SONY;
-	  
+
 		input_register_device(&sonypi_device.jog_dev);
 		printk(KERN_INFO "%s installed.\n", sonypi_device.jog_dev.name);
 	}
@@ -836,8 +863,8 @@
 	return ret;
 }
 
-static void __devexit sonypi_remove(void) {
-
+static void __devexit sonypi_remove(void)
+{
 #ifdef CONFIG_PM
 	pm_unregister(sonypi_device.pm);
 
@@ -846,7 +873,7 @@
 #endif
 
 	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
-	
+
 #ifdef SONYPI_USE_INPUT
 	if (useinput) {
 		input_unregister_device(&sonypi_device.jog_dev);
@@ -891,8 +918,8 @@
 {
 	struct pci_dev *pcidev = NULL;
 	if (dmi_check_system(sonypi_dmi_table)) {
-		pcidev = pci_find_device(PCI_VENDOR_ID_INTEL, 
-					 PCI_DEVICE_ID_INTEL_82371AB_3, 
+		pcidev = pci_find_device(PCI_VENDOR_ID_INTEL,
+					 PCI_DEVICE_ID_INTEL_82371AB_3,
 					 NULL);
 		return sonypi_probe(pcidev);
 	}
@@ -900,16 +927,18 @@
 		return -ENODEV;
 }
 
-static void __exit sonypi_cleanup_module(void) {
+static void __exit sonypi_cleanup_module(void)
+{
 	sonypi_remove();
 }
 
 #ifndef MODULE
-static int __init sonypi_setup(char *str)  {
+static int __init sonypi_setup(char *str)
+{
 	int ints[8];
 
 	str = get_options(str, ARRAY_SIZE(ints), ints);
-	if (ints[0] <= 0) 
+	if (ints[0] <= 0)
 		goto out;
 	minor = ints[1];
 	if (ints[0] == 1)
@@ -936,7 +965,7 @@
 
 __setup("sonypi=", sonypi_setup);
 #endif /* !MODULE */
-	
+
 /* Module entry points */
 module_init(sonypi_init_module);
 module_exit(sonypi_cleanup_module);
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	2004-10-21 01:53:49 -05:00
+++ b/drivers/char/sonypi.h	2004-10-21 01:53:49 -05:00
@@ -1,4 +1,4 @@
-/* 
+/*
  * Sony Programmable I/O Control Device driver for VAIO
  *
  * Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
@@ -14,24 +14,24 @@
  * Copyright (C) 2000 Andrew Tridgell <tridge@valinux.com>
  *
  * Earlier work by Werner Almesberger, Paul `Rusty' Russell and Paul Mackerras.
- * 
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  */
 
-#ifndef _SONYPI_PRIV_H_ 
+#ifndef _SONYPI_PRIV_H_
 #define _SONYPI_PRIV_H_
 
 #ifdef __KERNEL__
@@ -350,7 +350,7 @@
 	unsigned char buf[SONYPI_BUF_SIZE];
 };
 
-/* We enable input subsystem event forwarding if the input 
+/* We enable input subsystem event forwarding if the input
  * subsystem is compiled in, but only if sonypi is not into the
  * kernel and input as a module... */
 #if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
@@ -401,7 +401,8 @@
 #define SONYPI_ACPI_ACTIVE 0
 #endif /* CONFIG_ACPI */
 
-static inline int sonypi_ec_write(u8 addr, u8 value) {
+static inline int sonypi_ec_write(u8 addr, u8 value)
+{
 #ifdef CONFIG_ACPI_EC
 	if (SONYPI_ACPI_ACTIVE)
 		return ec_write(addr, value);
@@ -416,7 +417,8 @@
 	return 0;
 }
 
-static inline int sonypi_ec_read(u8 addr, u8 *value) {
+static inline int sonypi_ec_read(u8 addr, u8 *value)
+{
 #ifdef CONFIG_ACPI_EC
 	if (SONYPI_ACPI_ACTIVE)
 		return ec_read(addr, value);
diff -Nru a/include/linux/sonypi.h b/include/linux/sonypi.h
--- a/include/linux/sonypi.h	2004-10-21 01:53:49 -05:00
+++ b/include/linux/sonypi.h	2004-10-21 01:53:49 -05:00
@@ -1,4 +1,4 @@
-/* 
+/*
  * Sony Programmable I/O Control Device driver for VAIO
  *
  * Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
@@ -14,24 +14,24 @@
  * Copyright (C) 2000 Andrew Tridgell <tridge@valinux.com>
  *
  * Earlier work by Werner Almesberger, Paul `Rusty' Russell and Paul Mackerras.
- * 
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  */
 
-#ifndef _SONYPI_H_ 
+#ifndef _SONYPI_H_
 #define _SONYPI_H_
 
 #include <linux/types.h>
