Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbUJ1Kex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbUJ1Kex (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbUJ1KZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:25:20 -0400
Received: from sd291.sivit.org ([194.146.225.122]:51094 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262887AbUJ1KIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:08:34 -0400
Date: Thu, 28 Oct 2004 12:09:59 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 7/8] sonypi: whitespace and coding style fixes
Message-ID: <20041028100958.GH3893@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20041028100525.GA3893@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041028100525.GA3893@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2197, 2004-10-28 10:52:05+02:00, stelian@popies.net
  sonypi: whitespace and coding style fixes

  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 drivers/char/sonypi.c  |  285 ++++++++++++++++++++++++++-----------------------
 drivers/char/sonypi.h  |   18 +--
 include/linux/sonypi.h |   16 +-
 3 files changed, 172 insertions(+), 147 deletions(-)

===================================================================

diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2004-10-28 11:18:59 +02:00
+++ b/drivers/char/sonypi.c	2004-10-28 11:18:59 +02:00
@@ -1,7 +1,7 @@
 /*
  * Sony Programmable I/O Control Device driver for VAIO
  *
- * Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2001-2004 Stelian Pop <stelian@popies.net>
  *
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
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
@@ -125,7 +125,8 @@
 	return 0;
 }
 
-static int ec_read16(u8 addr, u16 *value) {
+static int ec_read16(u8 addr, u16 *value)
+{
 	u8 val_lb, val_hb;
 	if (sonypi_ec_read(addr, &val_lb))
 		return -1;
@@ -136,21 +137,22 @@
 }
 
 /* Initializes the device - this comes from the AML code in the ACPI bios */
-static void sonypi_type1_srs(void) {
+static void sonypi_type1_srs(void)
+{
 	u32 v;
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
-	v = (v & 0xFFFF0000) | ((u32)sonypi_device.ioport1);
+	v = (v & 0xFFFF0000) | ((u32) sonypi_device.ioport1);
 	pci_write_config_dword(sonypi_device.dev, SONYPI_G10A, v);
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
-	v = (v & 0xFFF0FFFF) | 
-	    (((u32)sonypi_device.ioport1 ^ sonypi_device.ioport2) << 16);
+	v = (v & 0xFFF0FFFF) |
+	    (((u32) sonypi_device.ioport1 ^ sonypi_device.ioport2) << 16);
 	pci_write_config_dword(sonypi_device.dev, SONYPI_G10A, v);
 
 	v = inl(SONYPI_IRQ_PORT);
-	v &= ~(((u32)0x3) << SONYPI_IRQ_SHIFT);
-	v |= (((u32)sonypi_device.bits) << SONYPI_IRQ_SHIFT);
+	v &= ~(((u32) 0x3) << SONYPI_IRQ_SHIFT);
+	v |= (((u32) sonypi_device.bits) << SONYPI_IRQ_SHIFT);
 	outl(v, SONYPI_IRQ_PORT);
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
@@ -158,18 +160,20 @@
 	pci_write_config_dword(sonypi_device.dev, SONYPI_G10A, v);
 }
 
-static void sonypi_type2_srs(void) {
+static void sonypi_type2_srs(void)
+{
 	if (sonypi_ec_write(SONYPI_SHIB, (sonypi_device.ioport1 & 0xFF00) >> 8))
 		printk(KERN_WARNING "ec_write failed\n");
-	if (sonypi_ec_write(SONYPI_SLOB,  sonypi_device.ioport1 & 0x00FF))
+	if (sonypi_ec_write(SONYPI_SLOB, sonypi_device.ioport1 & 0x00FF))
 		printk(KERN_WARNING "ec_write failed\n");
-	if (sonypi_ec_write(SONYPI_SIRQ,  sonypi_device.bits))
+	if (sonypi_ec_write(SONYPI_SIRQ, sonypi_device.bits))
 		printk(KERN_WARNING "ec_write failed\n");
 	udelay(10);
 }
 
 /* Disables the device - this comes from the AML code in the ACPI bios */
-static void sonypi_type1_dis(void) {
+static void sonypi_type1_dis(void)
+{
 	u32 v;
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
@@ -181,7 +185,8 @@
 	outl(v, SONYPI_IRQ_PORT);
 }
 
-static void sonypi_type2_dis(void) {
+static void sonypi_type2_dis(void)
+{
 	if (sonypi_ec_write(SONYPI_SHIB, 0))
 		printk(KERN_WARNING "ec_write failed\n");
 	if (sonypi_ec_write(SONYPI_SLOB, 0))
@@ -190,7 +195,8 @@
 		printk(KERN_WARNING "ec_write failed\n");
 }
 
-static u8 sonypi_call1(u8 dev) {
+static u8 sonypi_call1(u8 dev)
+{
 	u8 v1, v2;
 
 	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2, ITERATIONS_LONG);
@@ -200,7 +206,8 @@
 	return v2;
 }
 
-static u8 sonypi_call2(u8 dev, u8 fn) {
+static u8 sonypi_call2(u8 dev, u8 fn)
+{
 	u8 v1;
 
 	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2, ITERATIONS_LONG);
@@ -211,7 +218,8 @@
 	return v1;
 }
 
-static u8 sonypi_call3(u8 dev, u8 fn, u8 v) {
+static u8 sonypi_call3(u8 dev, u8 fn, u8 v)
+{
 	u8 v1;
 
 	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2, ITERATIONS_LONG);
@@ -224,7 +232,8 @@
 	return v1;
 }
 
-static u8 sonypi_read(u8 fn) {
+static u8 sonypi_read(u8 fn)
+{
 	u8 v1, v2;
 	int n = 100;
 
@@ -238,13 +247,14 @@
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
@@ -252,19 +262,20 @@
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
@@ -287,7 +298,7 @@
 		if (i)
 			break;
 	}
-	
+
 	if (j == 0) {
 		printk(KERN_WARNING "sonypi: failed to power on camera\n");
 		return;
@@ -298,12 +309,13 @@
 }
 
 /* sets the bluetooth subsystem power state */
-static void sonypi_setbluetoothpower(u8 state) {
-
+static void sonypi_setbluetoothpower(u8 state)
+{
 	state = !!state;
-	if (sonypi_device.bluetooth_power == state) 
+
+	if (sonypi_device.bluetooth_power == state)
 		return;
-	
+
 	sonypi_call2(0x96, state);
 	sonypi_call1(0x82);
 	sonypi_device.bluetooth_power = state;
@@ -331,7 +343,8 @@
 }
 
 /* Interrupt handler: some event is available */
-static irqreturn_t sonypi_irq(int irq, void *dev_id, struct pt_regs *regs) {
+static irqreturn_t sonypi_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
 	u8 v1, v2, event = 0;
 	int i, j;
 
@@ -341,9 +354,10 @@
 	for (i = 0; sonypi_eventtypes[i].model; i++) {
 		if (sonypi_device.model != sonypi_eventtypes[i].model)
 			continue;
-		if ((v2 & sonypi_eventtypes[i].data) != sonypi_eventtypes[i].data)
+		if ((v2 & sonypi_eventtypes[i].data) !=
+		    sonypi_eventtypes[i].data)
 			continue;
-		if (! (mask & sonypi_eventtypes[i].mask))
+		if (!(mask & sonypi_eventtypes[i].mask))
 			continue;
 		for (j = 0; sonypi_eventtypes[i].events[j].event; j++) {
 			if (v1 == sonypi_eventtypes[i].events[j].data) {
@@ -354,16 +368,17 @@
 	}
 
 	if (verbose)
-		printk(KERN_WARNING 
-		       "sonypi: unknown event port1=0x%02x,port2=0x%02x\n",v1,v2);
+		printk(KERN_WARNING
+		       "sonypi: unknown event port1=0x%02x,port2=0x%02x\n",
+		       v1, v2);
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
 
 	if (useinput) {
@@ -420,7 +435,8 @@
 }
 
 /* External camera command (exported to the motion eye v4l driver) */
-u8 sonypi_camera_command(int command, u8 value) {
+u8 sonypi_camera_command(int command, u8 value)
+{
 	u8 ret = 0;
 
 	if (!camera)
@@ -428,68 +444,68 @@
 
 	down(&sonypi_device.lock);
 
-	switch(command) {
-		case SONYPI_COMMAND_GETCAMERA:
-			ret = sonypi_camera_ready();
-			break;
-		case SONYPI_COMMAND_SETCAMERA:
-			if (value)
-				sonypi_camera_on();
-			else
-				sonypi_camera_off();
-			break;
-		case SONYPI_COMMAND_GETCAMERABRIGHTNESS:
-			ret = sonypi_read(SONYPI_CAMERA_BRIGHTNESS);
-			break;
-		case SONYPI_COMMAND_SETCAMERABRIGHTNESS:
-			sonypi_set(SONYPI_CAMERA_BRIGHTNESS, value);
-			break;
-		case SONYPI_COMMAND_GETCAMERACONTRAST:
-			ret = sonypi_read(SONYPI_CAMERA_CONTRAST);
-			break;
-		case SONYPI_COMMAND_SETCAMERACONTRAST:
-			sonypi_set(SONYPI_CAMERA_CONTRAST, value);
-			break;
-		case SONYPI_COMMAND_GETCAMERAHUE:
-			ret = sonypi_read(SONYPI_CAMERA_HUE);
-			break;
-		case SONYPI_COMMAND_SETCAMERAHUE:
-			sonypi_set(SONYPI_CAMERA_HUE, value);
-			break;
-		case SONYPI_COMMAND_GETCAMERACOLOR:
-			ret = sonypi_read(SONYPI_CAMERA_COLOR);
-			break;
-		case SONYPI_COMMAND_SETCAMERACOLOR:
-			sonypi_set(SONYPI_CAMERA_COLOR, value);
-			break;
-		case SONYPI_COMMAND_GETCAMERASHARPNESS:
-			ret = sonypi_read(SONYPI_CAMERA_SHARPNESS);
-			break;
-		case SONYPI_COMMAND_SETCAMERASHARPNESS:
-			sonypi_set(SONYPI_CAMERA_SHARPNESS, value);
-			break;
-		case SONYPI_COMMAND_GETCAMERAPICTURE:
-			ret = sonypi_read(SONYPI_CAMERA_PICTURE);
-			break;
-		case SONYPI_COMMAND_SETCAMERAPICTURE:
-			sonypi_set(SONYPI_CAMERA_PICTURE, value);
-			break;
-		case SONYPI_COMMAND_GETCAMERAAGC:
-			ret = sonypi_read(SONYPI_CAMERA_AGC);
-			break;
-		case SONYPI_COMMAND_SETCAMERAAGC:
-			sonypi_set(SONYPI_CAMERA_AGC, value);
-			break;
-		case SONYPI_COMMAND_GETCAMERADIRECTION:
-			ret = sonypi_read(SONYPI_CAMERA_STATUS);
-			ret &= SONYPI_DIRECTION_BACKWARDS;
-			break;
-		case SONYPI_COMMAND_GETCAMERAROMVERSION:
-			ret = sonypi_read(SONYPI_CAMERA_ROMVERSION);
-			break;
-		case SONYPI_COMMAND_GETCAMERAREVISION:
-			ret = sonypi_read(SONYPI_CAMERA_REVISION);
-			break;
+	switch (command) {
+	case SONYPI_COMMAND_GETCAMERA:
+		ret = sonypi_camera_ready();
+		break;
+	case SONYPI_COMMAND_SETCAMERA:
+		if (value)
+			sonypi_camera_on();
+		else
+			sonypi_camera_off();
+		break;
+	case SONYPI_COMMAND_GETCAMERABRIGHTNESS:
+		ret = sonypi_read(SONYPI_CAMERA_BRIGHTNESS);
+		break;
+	case SONYPI_COMMAND_SETCAMERABRIGHTNESS:
+		sonypi_set(SONYPI_CAMERA_BRIGHTNESS, value);
+		break;
+	case SONYPI_COMMAND_GETCAMERACONTRAST:
+		ret = sonypi_read(SONYPI_CAMERA_CONTRAST);
+		break;
+	case SONYPI_COMMAND_SETCAMERACONTRAST:
+		sonypi_set(SONYPI_CAMERA_CONTRAST, value);
+		break;
+	case SONYPI_COMMAND_GETCAMERAHUE:
+		ret = sonypi_read(SONYPI_CAMERA_HUE);
+		break;
+	case SONYPI_COMMAND_SETCAMERAHUE:
+		sonypi_set(SONYPI_CAMERA_HUE, value);
+		break;
+	case SONYPI_COMMAND_GETCAMERACOLOR:
+		ret = sonypi_read(SONYPI_CAMERA_COLOR);
+		break;
+	case SONYPI_COMMAND_SETCAMERACOLOR:
+		sonypi_set(SONYPI_CAMERA_COLOR, value);
+		break;
+	case SONYPI_COMMAND_GETCAMERASHARPNESS:
+		ret = sonypi_read(SONYPI_CAMERA_SHARPNESS);
+		break;
+	case SONYPI_COMMAND_SETCAMERASHARPNESS:
+		sonypi_set(SONYPI_CAMERA_SHARPNESS, value);
+		break;
+	case SONYPI_COMMAND_GETCAMERAPICTURE:
+		ret = sonypi_read(SONYPI_CAMERA_PICTURE);
+		break;
+	case SONYPI_COMMAND_SETCAMERAPICTURE:
+		sonypi_set(SONYPI_CAMERA_PICTURE, value);
+		break;
+	case SONYPI_COMMAND_GETCAMERAAGC:
+		ret = sonypi_read(SONYPI_CAMERA_AGC);
+		break;
+	case SONYPI_COMMAND_SETCAMERAAGC:
+		sonypi_set(SONYPI_CAMERA_AGC, value);
+		break;
+	case SONYPI_COMMAND_GETCAMERADIRECTION:
+		ret = sonypi_read(SONYPI_CAMERA_STATUS);
+		ret &= SONYPI_DIRECTION_BACKWARDS;
+		break;
+	case SONYPI_COMMAND_GETCAMERAROMVERSION:
+		ret = sonypi_read(SONYPI_CAMERA_ROMVERSION);
+		break;
+	case SONYPI_COMMAND_GETCAMERAREVISION:
+		ret = sonypi_read(SONYPI_CAMERA_REVISION);
+		break;
 	}
 	up(&sonypi_device.lock);
 	return ret;
@@ -497,7 +513,8 @@
 
 EXPORT_SYMBOL(sonypi_camera_command);
 
-static int sonypi_misc_fasync(int fd, struct file *filp, int on) {
+static int sonypi_misc_fasync(int fd, struct file *filp, int on)
+{
 	int retval;
 
 	retval = fasync_helper(fd, filp, on, &sonypi_device.fifo_async);
@@ -506,7 +523,8 @@
 	return 0;
 }
 
-static int sonypi_misc_release(struct inode * inode, struct file * file) {
+static int sonypi_misc_release(struct inode *inode, struct file *file)
+{
 	sonypi_misc_fasync(-1, file, 0);
 	down(&sonypi_device.lock);
 	sonypi_device.open_count--;
@@ -514,7 +532,8 @@
 	return 0;
 }
 
-static int sonypi_misc_open(struct inode * inode, struct file * file) {
+static int sonypi_misc_open(struct inode *inode, struct file *file)
+{
 	down(&sonypi_device.lock);
 	/* Flush input queue on first open */
 	if (!sonypi_device.open_count)
@@ -524,8 +543,8 @@
 	return 0;
 }
 
-static ssize_t sonypi_misc_read(struct file * file, char __user * buf,
-			size_t count, loff_t *pos)
+static ssize_t sonypi_misc_read(struct file *file, char __user *buf,
+				size_t count, loff_t *pos)
 {
 	ssize_t ret;
 	unsigned char c;
@@ -552,15 +571,17 @@
 	return ret;
 }
 
-static unsigned int sonypi_misc_poll(struct file *file, poll_table * wait) {
+static unsigned int sonypi_misc_poll(struct file *file, poll_table *wait)
+{
 	poll_wait(file, &sonypi_device.fifo_proc_list, wait);
 	if (kfifo_len(sonypi_device.fifo))
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
@@ -655,7 +676,9 @@
 };
 
 struct miscdevice sonypi_misc_device = {
-	-1, "sonypi", &sonypi_misc_fops
+	.minor		= -1,
+	.name		= "sonypi",
+	.fops		= &sonypi_misc_fops,
 };
 
 static void sonypi_enable(unsigned int camera_on)
@@ -755,18 +778,17 @@
 	init_waitqueue_head(&sonypi_device.fifo_proc_list);
 	init_MUTEX(&sonypi_device.lock);
 	sonypi_device.bluetooth_power = -1;
-	
+
 	if (pcidev && pci_enable_device(pcidev)) {
 		printk(KERN_ERR "sonypi: pci_enable_device failed\n");
 		ret = -EIO;
-		goto out1;
+		goto out_pcienable;
 	}
 
-	sonypi_misc_device.minor = (minor == -1) ? 
-		MISC_DYNAMIC_MINOR : minor;
+	sonypi_misc_device.minor = (minor == -1) ? MISC_DYNAMIC_MINOR : minor;
 	if ((ret = misc_register(&sonypi_misc_device))) {
 		printk(KERN_ERR "sonypi: misc_register failed\n");
-		goto out1;
+		goto out_miscreg;
 	}
 
 	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2) {
@@ -774,8 +796,7 @@
 		sonypi_device.region_size = SONYPI_TYPE2_REGION_SIZE;
 		sonypi_device.evtype_offset = SONYPI_TYPE2_EVTYPE_OFFSET;
 		irq_list = sonypi_type2_irq_list;
-	}
-	else {
+	} else {
 		ioport_list = sonypi_type1_ioport_list;
 		sonypi_device.region_size = SONYPI_TYPE1_REGION_SIZE;
 		sonypi_device.evtype_offset = SONYPI_TYPE1_EVTYPE_OFFSET;
@@ -783,8 +804,8 @@
 	}
 
 	for (i = 0; ioport_list[i].port1; i++) {
-		if (request_region(ioport_list[i].port1, 
-				   sonypi_device.region_size, 
+		if (request_region(ioport_list[i].port1,
+				   sonypi_device.region_size,
 				   "Sony Programable I/O Device")) {
 			/* get the ioport */
 			sonypi_device.ioport1 = ioport_list[i].port1;
@@ -795,7 +816,7 @@
 	if (!sonypi_device.ioport1) {
 		printk(KERN_ERR "sonypi: request_region failed\n");
 		ret = -ENODEV;
-		goto out2;
+		goto out_reqreg;
 	}
 
 	for (i = 0; irq_list[i].irq; i++) {
@@ -811,18 +832,19 @@
 	if (!irq_list[i].irq) {
 		printk(KERN_ERR "sonypi: request_irq failed\n");
 		ret = -ENODEV;
-		goto out3;
+		goto out_reqirq;
 	}
 
 	if (useinput) {
 		/* Initialize the Input Drivers: jogdial */
 		int i;
-		sonypi_device.input_jog_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+		sonypi_device.input_jog_dev.evbit[0] =
+			BIT(EV_KEY) | BIT(EV_REL);
 		sonypi_device.input_jog_dev.keybit[LONG(BTN_MOUSE)] =
 			BIT(BTN_MIDDLE);
 		sonypi_device.input_jog_dev.relbit[0] = BIT(REL_WHEEL);
 		sonypi_device.input_jog_dev.name =
-			(char *) kmalloc(sizeof(SONYPI_JOG_INPUTNAME), GFP_KERNEL);
+			kmalloc(sizeof(SONYPI_JOG_INPUTNAME), GFP_KERNEL);
 		if (!sonypi_device.input_jog_dev.name) {
 			printk(KERN_ERR "sonypi: kmalloc failed\n");
 			ret = -ENOMEM;
@@ -843,7 +865,7 @@
 				set_bit(sonypi_inputkeys[i].inputev,
 					sonypi_device.input_key_dev.keybit);
 		sonypi_device.input_key_dev.name =
-			(char *) kmalloc(sizeof(SONYPI_KEY_INPUTNAME), GFP_KERNEL);
+			kmalloc(sizeof(SONYPI_KEY_INPUTNAME), GFP_KERNEL);
 		if (!sonypi_device.input_key_dev.name) {
 			printk(KERN_ERR "sonypi: kmalloc failed\n");
 			ret = -ENOMEM;
@@ -879,8 +901,8 @@
 
 	sonypi_enable(0);
 
-	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver v%s.\n",
-	       SONYPI_DRIVER_VERSION);
+	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver"
+	       "v%s.\n", SONYPI_DRIVER_VERSION);
 	printk(KERN_INFO "sonypi: detected %s model, "
 	       "verbose = %d, fnkeyinit = %s, camera = %s, "
 	       "compat = %s, mask = 0x%08lx, useinput = %s, acpi = %s\n",
@@ -894,7 +916,7 @@
 	       useinput ? "on" : "off",
 	       SONYPI_ACPI_ACTIVE ? "on" : "off");
 	printk(KERN_INFO "sonypi: enabled at irq=%d, port1=0x%x, port2=0x%x\n",
-	       sonypi_device.irq, 
+	       sonypi_device.irq,
 	       sonypi_device.ioport1, sonypi_device.ioport2);
 
 	if (minor == -1)
@@ -913,11 +935,14 @@
 	kfree(sonypi_device.input_jog_dev.name);
 out_inkmallocinput1:
 	free_irq(sonypi_device.irq, sonypi_irq);
-out3:
+out_reqirq:
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
-out2:
+out_reqreg:
 	misc_deregister(&sonypi_misc_device);
-out1:
+out_miscreg:
+	if (pcidev)
+		pci_disable_device(pcidev);
+out_pcienable:
 	kfifo_free(sonypi_device.fifo);
 out_fifo:
 	pci_dev_put(sonypi_device.dev);
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	2004-10-28 11:18:59 +02:00
+++ b/drivers/char/sonypi.h	2004-10-28 11:18:59 +02:00
@@ -1,7 +1,7 @@
-/* 
+/*
  * Sony Programmable I/O Control Device driver for VAIO
  *
- * Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2001-2004 Stelian Pop <stelian@popies.net>
  *
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
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
@@ -424,8 +424,8 @@
 #define SONYPI_ACPI_ACTIVE (!acpi_disabled)
 #else
 #define SONYPI_ACPI_ACTIVE 0
-#endif /* CONFIG_ACPI */
+#endif				/* CONFIG_ACPI */
 
-#endif /* __KERNEL__ */
+#endif				/* __KERNEL__ */
 
-#endif /* _SONYPI_PRIV_H_ */
+#endif				/* _SONYPI_PRIV_H_ */
diff -Nru a/include/linux/sonypi.h b/include/linux/sonypi.h
--- a/include/linux/sonypi.h	2004-10-28 11:18:59 +02:00
+++ b/include/linux/sonypi.h	2004-10-28 11:18:59 +02:00
@@ -1,7 +1,7 @@
-/* 
+/*
  * Sony Programmable I/O Control Device driver for VAIO
  *
- * Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2001-2004 Stelian Pop <stelian@popies.net>
  *
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
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
@@ -144,6 +144,6 @@
 
 u8 sonypi_camera_command(int command, u8 value);
 
-#endif /* __KERNEL__ */
+#endif				/* __KERNEL__ */
 
-#endif /* _SONYPI_H_ */
+#endif				/* _SONYPI_H_ */
