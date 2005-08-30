Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVH3WVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVH3WVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVH3WVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:21:37 -0400
Received: from fmr19.intel.com ([134.134.136.18]:30855 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750804AbVH3WVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:21:36 -0400
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Telecom Clock driver for MPCBL0010 ATCA compute blade.
Date: Tue, 30 Aug 2005 15:19:35 -0700
User-Agent: KMail/1.7.1
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <200508301159.34053.mgross@linux.intel.com> <200508301336.16112.mgross@linux.intel.com> <9a87484905083014197ecb835a@mail.gmail.com>
In-Reply-To: <9a87484905083014197ecb835a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3tNFD/v4NZahMT1"
Message-Id: <200508301519.35395.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_3tNFD/v4NZahMT1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 30 August 2005 14:19, Jesper Juhl wrote:
> On 8/30/05, Mark Gross <mgross@linux.intel.com> wrote:
> > On Tuesday 30 August 2005 13:31, Mark Gross wrote:
> > > On Tuesday 30 August 2005 12:16, Marcelo Tosatti wrote:
> > > >
> > > > Mark,
> > > >
> > > > Please fix identation accordingly to CodingStyle and repost, it
> > > > looks quite ugly at the moment.
> > > >
> > > Sorry about that.
> > >
> > 
> > My email client is f-ing with me.  See attached.
> > 
> 
> ok, a few small comments  : 
> 
> 
> +/* sysFS interface definition:
> 
> Isn't it just called "sysfs" without the caps?
> 
> +Uppon loading the driver will create a sysfs directory under class/misc/tlclk.
> 
> s/Uppon/Upon/
> 
> +This directory exports the following interfaces.  There opperation is
> documented
> 
> Line is longer than 80 chars - there are a few more such long lines,
> not going to point them all out, just one example. Ohh, and
> "opperation" should be "operation".
> 
> +All sysfs interaces are integers in hex format, i.e echo 99 > refalign
> 
> s/interaces/interfaces/
> 
> +#if CONFIG_DEBUG_KERNEL
> 
> I believe this should be "#ifdef CONFIG_DEBUG_KERNEL" or "#if
> defined(CONFIG_DEBUG_KERNEL)" or you'll run afoul of the -Wundef
> crowd.
> 
> + int ret_val = 0;
> 
> There seems to be a preference for the name "retval" in the kernel source.
> 
> + val = (unsigned char)arg;
> 
> 
> That cast looks pointless.
> 
> +tlclk_read(struct file * filp, char __user * buf, size_t count, loff_t * f_pos)
> 
> 
> tlclk_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
> "*" next to the variable name is generally the preffered coding style
> (several cases of this, only pointing out one).
> 
> + val = (unsigned char)tmp;
> 
> pointless cast. Do take a look at all your casts and check if they are
> really needed and remove them if not.
> 
> + * This is also the probe opperation to avoid driver use on 
> 
> s/opperation/operation/
> 
> +/* switchover_timer.function = switchover_timeout; */
> 
> +/* switchover_timer.data = 0; */
> 
> Why submit a driver with commented out code? If this is not supposed
> to be there, then just remove it. If it needs to be added later, then
> submit a patch later to add it.
> Some people may disagree with me here, but that's my oppinion.
> 
> +      out3:
> 
> 
> labels belong at column 0 (zero).
> 
> 
Thank you for your input.  See attached.


-- 
--mgross
BTW: This may or may not be the opinion of my employer, more likely not.  

--Boundary-00=_3tNFD/v4NZahMT1
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="tlclk_2.6.13_aug30.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tlclk_2.6.13_aug30.diff"

diff -urN -X dontdiff_osdl vanilla/linux-2.6.13/drivers/char/Kconfig linux-2.6.13/drivers/char/Kconfig
--- vanilla/linux-2.6.13/drivers/char/Kconfig	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/drivers/char/Kconfig	2005-08-30 10:52:25.950853752 -0700
@@ -1002,5 +1002,15 @@
 
 source "drivers/char/tpm/Kconfig"
 
+config TELCLOCK
+	tristate "Telecom clock driver for ATCA"
+	depends on EXPERIMENTAL
+	default n
+	help
+	  The telecom clock device allows direct userspace access to the
+	  configuration of the telecom clock configuration settings.
+	  This device is used for hardware synchronization across the ATCA
+	  backplane fabric.
+
 endmenu
 
diff -urN -X dontdiff_osdl vanilla/linux-2.6.13/drivers/char/Makefile linux-2.6.13/drivers/char/Makefile
--- vanilla/linux-2.6.13/drivers/char/Makefile	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/drivers/char/Makefile	2005-08-30 10:52:25.952853448 -0700
@@ -82,6 +82,7 @@
 obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
 obj-$(CONFIG_GPIO_VR41XX) += vr41xx_giu.o
 obj-$(CONFIG_TANBAC_TB0219) += tb0219.o
+obj-$(CONFIG_TELCLOCK) += tlclk.o
 
 obj-$(CONFIG_WATCHDOG)	+= watchdog/
 obj-$(CONFIG_MWAVE) += mwave/
diff -urN -X dontdiff_osdl vanilla/linux-2.6.13/drivers/char/tlclk.c linux-2.6.13/drivers/char/tlclk.c
--- vanilla/linux-2.6.13/drivers/char/tlclk.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.13/drivers/char/tlclk.c	2005-08-30 15:11:42.760859152 -0700
@@ -0,0 +1,937 @@
+/*
+ * Telecom Clock driver for Intel NetStructure(tm) MPCBL0010
+ *
+ * Copyright (C) 2005 Kontron Canada
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <sebastien.bouchard@ca.kontron.com>
+ * 
+ * 2.6 driver version being maintained by <mark.gross@intel.com>
+ *
+ * Description : This is the TELECOM CLOCK module driver for the ATCA platform.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>	/* printk() */
+#include <linux/fs.h>		/* everything... */
+#include <linux/errno.h>	/* error codes */
+#include <linux/delay.h>	/* udelay */
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/sysfs.h>
+#include <linux/device.h>
+#include <linux/miscdevice.h>
+#include <asm/io.h>		/* inb/outb */
+#include <asm/uaccess.h>
+
+#include "tlclk.h"		/* TELECOM IOCTL DEFINE */
+
+MODULE_AUTHOR("Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>");
+MODULE_LICENSE("GPL");
+
+/* Telecom clock I/O register definition */
+#define TLCLK_BASE 0xa08
+#define TLCLK_REG0 TLCLK_BASE
+#define TLCLK_REG1 (TLCLK_BASE+1)
+#define TLCLK_REG2 (TLCLK_BASE+2)
+#define TLCLK_REG3 (TLCLK_BASE+3)
+#define TLCLK_REG4 (TLCLK_BASE+4)
+#define TLCLK_REG5 (TLCLK_BASE+5)
+#define TLCLK_REG6 (TLCLK_BASE+6)
+#define TLCLK_REG7 (TLCLK_BASE+7)
+
+#define SET_PORT_BITS(port, mask, val) outb(((inb(port) & mask) | val), port)
+
+/* 0 = Dynamic allocation of the major device number */
+#define TLCLK_MAJOR 252
+
+/*
+uncomment to include classic IOCTL's 
+#define TLCLK_IOCTL
+*/
+
+/* sysfs interface definition:
+Uppon loading the driver will create a sysfs directory under class/misc/tlclk.
+
+This directory exports the following interfaces.  There operation is
+documented in the MCPBL0010 TPS under the Telecom Clock API section, 11.4.
+
+alarms				:
+current_ref			:
+enable_clk3a_output		:
+enable_clk3b_output		:
+enable_clka0_output		:
+enable_clka1_output		:
+enable_clkb0_output		:
+enable_clkb1_output		:
+filter_select			:
+hardware_switching		:
+hardware_switching_mode		:
+interrupt_switch		:
+mode_select			:
+refalign			:
+reset				: 
+select_amcb1_transmit_clock	:
+select_amcb2_transmit_clock	:
+select_redundant_clock		:
+select_ref_frequency		:
+test_mode			:
+
+All sysfs interaces are integers in hex format, i.e echo 99 > refalign
+has the same effect as echo 0x99 > refalign.
+
+*/
+
+#ifdef CONFIG_DEBUG_KERNEL
+#define debug_printk( args... ) printk( args)
+#else
+#define debug_printk( args... )
+#endif
+
+static unsigned int telclk_interrupt;
+
+static int int_events;		/* Event that generate a interrupt */
+static int got_event;		/* if events processing have been done */
+
+static void switchover_timeout(unsigned long data);
+static struct timer_list switchover_timer =
+TIMER_INITIALIZER(switchover_timeout, 0, 0);
+
+static struct tlclk_alarms *alarm_events;
+
+DEFINE_SPINLOCK(event_lock);
+
+static int tlclk_major = TLCLK_MAJOR;
+
+irqreturn_t tlclk_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+
+DECLARE_WAIT_QUEUE_HEAD(wq);
+
+#ifdef TLCLK_IOCTL
+static int
+tlclk_ioctl(struct inode *inode,
+	    struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	unsigned long flags;
+	unsigned char val;
+	int retval = 0;
+
+	val = arg;
+	if (_IOC_TYPE(cmd) != TLCLK_IOC_MAGIC)
+		return -ENOTTY;
+
+	if (_IOC_NR(cmd) > TLCLK_IOC_MAXNR)
+		return -ENOTTY;
+
+	spin_lock_irqsave(&event_lock, flags);
+	switch (cmd) {
+	case IOCTL_RESET:
+		SET_PORT_BITS(TLCLK_REG4, 0xfd, val);
+		break;
+	case IOCTL_MODE_SELECT:
+		SET_PORT_BITS(TLCLK_REG0, 0xcf, val);
+		break;
+	case IOCTL_REFALIGN:
+		/* GENERATING 0 to 1 transistion */
+		SET_PORT_BITS(TLCLK_REG0, 0xf7, 0);
+		udelay(2);
+		SET_PORT_BITS(TLCLK_REG0, 0xf7, 0x08);
+		udelay(2);
+		SET_PORT_BITS(TLCLK_REG0, 0xf7, 0);
+		break;
+	case IOCTL_HARDWARE_SWITCHING:
+		SET_PORT_BITS(TLCLK_REG0, 0x7f, val);
+		break;
+	case IOCTL_HARDWARE_SWITCHING_MODE:
+		SET_PORT_BITS(TLCLK_REG0, 0xbf, val);
+		break;
+	case IOCTL_FILTER_SELECT:
+		SET_PORT_BITS(TLCLK_REG0, 0xfb, val);
+		break;
+	case IOCTL_SELECT_REF_FREQUENCY:
+		SET_PORT_BITS(TLCLK_REG1, 0xfd, val);
+		break;
+	case IOCTL_SELECT_REDUNDANT_CLOCK:
+		SET_PORT_BITS(TLCLK_REG1, 0xfe, val);
+		break;
+	case IOCTL_SELECT_AMCB1_TRANSMIT_CLOCK:
+		if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
+			SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x5);
+			SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
+		} else if (val >= CLK_8_592MHz) {
+			SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x7);
+			switch (val) {
+			case CLK_8_592MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
+				break;
+			case CLK_11_184MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
+				break;
+			case CLK_34_368MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
+				break;
+			case CLK_44_736MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
+				break;
+			}
+		} else
+			SET_PORT_BITS(TLCLK_REG3, 0xf8, val);
+		break;
+	case IOCTL_SELECT_AMCB2_TRANSMIT_CLOCK:
+		if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
+			SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x28);
+			SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
+		} else if (val >= CLK_8_592MHz) {
+			SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x38);
+			switch (val) {
+			case CLK_8_592MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
+				break;
+			case CLK_11_184MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
+				break;
+			case CLK_34_368MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
+				break;
+			case CLK_44_736MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
+				break;
+			}
+		} else
+			SET_PORT_BITS(TLCLK_REG3, 0xc7, val << 3);
+		break;
+	case IOCTL_TEST_MODE:
+		SET_PORT_BITS(TLCLK_REG4, 0xfd, 2);
+		break;
+	case IOCTL_ENABLE_CLKA0_OUTPUT:
+		SET_PORT_BITS(TLCLK_REG2, 0xfe, val);
+		break;
+	case IOCTL_ENABLE_CLKB0_OUTPUT:
+		SET_PORT_BITS(TLCLK_REG2, 0xfd, val << 1);
+		break;
+	case IOCTL_ENABLE_CLKA1_OUTPUT:
+		SET_PORT_BITS(TLCLK_REG2, 0xfb, val << 2);
+		break;
+	case IOCTL_ENABLE_CLKB1_OUTPUT:
+		SET_PORT_BITS(TLCLK_REG2, 0xf7, val << 3);
+		break;
+	case IOCTL_ENABLE_CLK3A_OUTPUT:
+		SET_PORT_BITS(TLCLK_REG3, 0xbf, val << 6);
+		break;
+	case IOCTL_ENABLE_CLK3B_OUTPUT:
+		SET_PORT_BITS(TLCLK_REG3, 0x7f, val << 7);
+		break;
+	case IOCTL_READ_ALARMS:
+		retval = (inb(TLCLK_REG2) & 0xf0);
+		break;
+	case IOCTL_READ_INTERRUPT_SWITCH:
+		retval = inb(TLCLK_REG6);
+		break;
+	case IOCTL_READ_CURRENT_REF:
+		retval = ((inb(TLCLK_REG1) & 0x08) >> 3);
+		break;
+	}
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return retval;
+}
+#endif
+
+static int tlclk_open(struct inode *inode, struct file *filp)
+{
+	int result;
+
+	/* Make sure there is no interrupt pending while 
+	 * initialising interrupt handler */
+	inb(TLCLK_REG6);
+
+	/* This device is wired through the FPGA IO space of the ATCA blade 
+	 * we can't share this IRQ */
+	result = request_irq(telclk_interrupt, &tlclk_interrupt,
+			     SA_INTERRUPT, "telclock", tlclk_interrupt);
+	if (result == -EBUSY) {
+		printk(KERN_ERR "telclock: Interrupt can't be reserved!\n");
+		return -EBUSY;
+	}
+	inb(TLCLK_REG6);	/* Clear interrupt events */
+
+	return 0;
+}
+
+static int tlclk_release(struct inode *inode, struct file *filp)
+{
+	free_irq(telclk_interrupt, tlclk_interrupt);
+
+	return 0;
+}
+
+ssize_t
+tlclk_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
+{
+	int count0 = sizeof(struct tlclk_alarms);
+
+	wait_event_interruptible(wq, got_event);
+	if (copy_to_user(buf, alarm_events, sizeof(struct tlclk_alarms)))
+		return -EFAULT;
+
+	memset(alarm_events, 0, sizeof(struct tlclk_alarms));
+	got_event = 0;
+
+	return count0;
+}
+
+ssize_t
+tlclk_write(struct file *filp, const char __user *buf, size_t count,
+	    loff_t *f_pos)
+{
+	return 0;
+}
+
+static struct file_operations tlclk_fops = {
+	.read = tlclk_read,
+	.write = tlclk_write,
+#ifdef TLCLK_IOCTL
+	.ioctl = tlclk_ioctl,
+#endif
+	.open = tlclk_open,
+	.release = tlclk_release,
+
+};
+
+#ifdef CONFIG_SYSFS
+static struct miscdevice tlclk_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "tlclk",
+	.fops = &tlclk_fops,
+};
+
+static ssize_t show_current_ref(struct class_device *d, char *buf)
+{
+	unsigned long retval;
+	unsigned long flags;
+
+	spin_lock_irqsave(&event_lock, flags);
+	retval = ((inb(TLCLK_REG1) & 0x08) >> 3);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return sprintf(buf, "0x%lX\n", retval);
+}
+
+static CLASS_DEVICE_ATTR(current_ref, S_IRUGO, show_current_ref, NULL);
+
+static ssize_t show_interrupt_switch(struct class_device *d, char *buf)
+{
+	unsigned long retval;
+	unsigned long flags;
+
+	spin_lock_irqsave(&event_lock, flags);
+	retval = inb(TLCLK_REG6);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return sprintf(buf, "0x%lX\n", retval);
+}
+
+static CLASS_DEVICE_ATTR(interrupt_switch, S_IRUGO,
+			 show_interrupt_switch, NULL);
+
+static ssize_t show_alarms(struct class_device *d, char *buf)
+{
+	unsigned long retval;
+	unsigned long flags;
+
+	spin_lock_irqsave(&event_lock, flags);
+	retval = (inb(TLCLK_REG2) & 0xf0);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return sprintf(buf, "0x%lX\n", retval);
+}
+
+static CLASS_DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+
+static ssize_t store_enable_clk3b_output(struct class_device *d,
+					 const char *buf, size_t count)
+{
+	unsigned long tmp;
+	unsigned char val;
+	unsigned long flags;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG3, 0x7f, val << 7);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(enable_clk3b_output, S_IWUGO, NULL,
+			 store_enable_clk3b_output);
+
+static ssize_t store_enable_clk3a_output(struct class_device *d,
+					 const char *buf, size_t count)
+{
+	unsigned long flags;
+	unsigned long tmp;
+	unsigned char val;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG3, 0xbf, val << 6);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(enable_clk3a_output, S_IWUGO, NULL,
+			 store_enable_clk3a_output);
+
+static ssize_t store_enable_clkb1_output(struct class_device *d,
+					 const char *buf, size_t count)
+{
+	unsigned long flags;
+	unsigned long tmp;
+	unsigned char val;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG2, 0xf7, val << 3);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(enable_clkb1_output, S_IWUGO, NULL,
+			 store_enable_clkb1_output);
+
+static ssize_t store_enable_clka1_output(struct class_device *d,
+					 const char *buf, size_t count)
+{
+	unsigned long flags;
+	unsigned long tmp;
+	unsigned char val;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG2, 0xfb, val << 2);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(enable_clka1_output, S_IWUGO, NULL,
+			 store_enable_clka1_output);
+
+static ssize_t store_enable_clkb0_output(struct class_device *d,
+					 const char *buf, size_t count)
+{
+	unsigned long flags;
+	unsigned long tmp;
+	unsigned char val;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG2, 0xfd, val << 1);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(enable_clkb0_output, S_IWUGO, NULL,
+			 store_enable_clkb0_output);
+
+static ssize_t store_enable_clka0_output(struct class_device *d,
+					 const char *buf, size_t count)
+{
+	unsigned long flags;
+	unsigned long tmp;
+	unsigned char val;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG2, 0xfe, val);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(enable_clka0_output, S_IWUGO, NULL,
+			 store_enable_clka0_output);
+
+static ssize_t store_test_mode(struct class_device *d, const char *buf,
+			       size_t count)
+{
+	unsigned long flags;
+	unsigned long tmp;
+	unsigned char val;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG4, 0xfd, 2);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(test_mode, S_IWUGO, NULL, store_test_mode);
+
+static ssize_t store_select_amcb2_transmit_clock(struct class_device *d,
+						 const char *buf, size_t count)
+{
+	unsigned long flags;
+	unsigned long tmp;
+	unsigned char val;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
+		SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x28);
+		SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
+	} else if (val >= CLK_8_592MHz) {
+		SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x38);
+		switch (val) {
+		case CLK_8_592MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
+			break;
+		case CLK_11_184MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
+			break;
+		case CLK_34_368MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
+			break;
+		case CLK_44_736MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
+			break;
+		}
+	} else
+		SET_PORT_BITS(TLCLK_REG3, 0xc7, val << 3);
+
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(select_amcb2_transmit_clock, S_IWUGO, NULL,
+			 store_select_amcb2_transmit_clock);
+
+static ssize_t store_select_amcb1_transmit_clock(struct class_device *d,
+						 const char *buf, size_t count)
+{
+	unsigned long tmp;
+	unsigned char val;
+	unsigned long flags;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
+		SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x5);
+		SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
+	} else if (val >= CLK_8_592MHz) {
+		SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x7);
+		switch (val) {
+		case CLK_8_592MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
+			break;
+		case CLK_11_184MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
+			break;
+		case CLK_34_368MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
+			break;
+		case CLK_44_736MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
+			break;
+		}
+	} else
+		SET_PORT_BITS(TLCLK_REG3, 0xf8, val);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(select_amcb1_transmit_clock, S_IWUGO, NULL,
+			 store_select_amcb1_transmit_clock);
+
+static ssize_t store_select_redundant_clock(struct class_device *d,
+					    const char *buf, size_t count)
+{
+	unsigned long tmp;
+	unsigned char val;
+	unsigned long flags;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG1, 0xfe, val);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(select_redundant_clock, S_IWUGO, NULL,
+			 store_select_redundant_clock);
+
+static ssize_t store_select_ref_frequency(struct class_device *d,
+					  const char *buf, size_t count)
+{
+	unsigned long tmp;
+	unsigned char val;
+	unsigned long flags;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG1, 0xfd, val);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(select_ref_frequency, S_IWUGO, NULL,
+			 store_select_ref_frequency);
+
+static ssize_t store_filter_select(struct class_device *d,
+				   const char *buf, size_t count)
+{
+	unsigned long tmp;
+	unsigned char val;
+	unsigned long flags;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG0, 0xfb, val);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(filter_select, S_IWUGO, NULL, store_filter_select);
+
+static ssize_t store_hardware_switching_mode(struct class_device *d,
+					     const char *buf, size_t count)
+{
+	unsigned long tmp;
+	unsigned char val;
+	unsigned long flags;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG0, 0xbf, val);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(hardware_switching_mode, S_IWUGO, NULL,
+			 store_hardware_switching_mode);
+
+static ssize_t store_hardware_switching(struct class_device *d,
+					const char *buf, size_t count)
+{
+	unsigned long tmp;
+	unsigned char val;
+	unsigned long flags;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG0, 0x7f, val);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(hardware_switching, S_IWUGO, NULL,
+			 store_hardware_switching);
+
+static ssize_t store_refalign(struct class_device *d,
+			      const char *buf, size_t count)
+{
+	unsigned long tmp;
+	unsigned long flags;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG0, 0xf7, 0);
+	udelay(2);
+	SET_PORT_BITS(TLCLK_REG0, 0xf7, 0x08);
+	udelay(2);
+	SET_PORT_BITS(TLCLK_REG0, 0xf7, 0);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(refalign, S_IWUGO, NULL, store_refalign);
+
+static ssize_t store_mode_select(struct class_device *d,
+				 const char *buf, size_t count)
+{
+	unsigned long tmp;
+	unsigned char val;
+	unsigned long flags;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG0, 0xcf, val);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(mode_select, S_IWUGO, NULL, store_mode_select);
+
+static ssize_t store_reset(struct class_device *d,
+			   const char *buf, size_t count)
+{
+	unsigned long tmp;
+	unsigned char val;
+	unsigned long flags;
+
+	sscanf(buf, "%lX", &tmp);
+	debug_printk(KERN_ERR "tmp = 0x%lX \n", tmp);
+
+	val = tmp & 0xff;
+	spin_lock_irqsave(&event_lock, flags);
+	SET_PORT_BITS(TLCLK_REG4, 0xfd, val);
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return strnlen(buf, count);
+}
+
+static CLASS_DEVICE_ATTR(reset, S_IWUGO, NULL, store_reset);
+#endif				/*  CONFIG_SYSFS */
+
+static int __init tlclk_init(void)
+{
+	int ret;
+#ifdef  CONFIG_SYSFS
+	struct class_device *class;
+#endif
+	ret = register_chrdev(tlclk_major, "telclock", &tlclk_fops);
+
+	if (ret < 0) {
+		printk(KERN_ERR "telclock: can't get major! %d\n", tlclk_major);
+		return ret;
+	}
+
+	alarm_events = kcalloc(1, sizeof(struct tlclk_alarms), GFP_KERNEL);
+
+	if (!alarm_events)
+		goto out1;
+
+	if (!request_region(TLCLK_BASE, 8, "telclock")) {
+		printk(KERN_ERR "tlclk: request_region failed! 0x%X\n",
+		       TLCLK_BASE);
+		ret = -EBUSY;
+		goto out2;
+	}
+
+/* Read telecom clock IRQ number (Set by BIOS) 
+ * This is also the probe operation to avoid driver use on 
+ * non MCPBL0010 hardware. */
+	telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
+
+	if (0x0F == telclk_interrupt) {	/* not MCPBL0010 ? */
+		printk(KERN_ERR "telclk_interrup = 0x%x non-mcpbl0010 hw \n",
+		       telclk_interrupt);
+		ret = -ENXIO;
+		goto out3;
+	}
+
+	init_timer(&switchover_timer);
+
+#ifdef  CONFIG_SYSFS
+	if (0 > (ret = misc_register(&tlclk_miscdev))) {
+		printk(KERN_ERR " misc_register retruns %d \n", ret);
+		ret = -EBUSY;
+		goto out3;
+	}
+	class = tlclk_miscdev.class;
+	class_device_create_file(class, &class_device_attr_current_ref);
+	class_device_create_file(class, &class_device_attr_interrupt_switch);
+	class_device_create_file(class, &class_device_attr_alarms);
+	class_device_create_file(class, &class_device_attr_enable_clk3b_output);
+	class_device_create_file(class, &class_device_attr_enable_clk3a_output);
+	class_device_create_file(class, &class_device_attr_enable_clkb1_output);
+	class_device_create_file(class, &class_device_attr_enable_clka1_output);
+	class_device_create_file(class, &class_device_attr_enable_clkb0_output);
+	class_device_create_file(class, &class_device_attr_enable_clka0_output);
+	class_device_create_file(class, &class_device_attr_test_mode);
+	class_device_create_file(class,
+				 &class_device_attr_select_amcb2_transmit_clock);
+	class_device_create_file(class,
+				 &class_device_attr_select_amcb1_transmit_clock);
+	class_device_create_file(class,
+				 &class_device_attr_select_redundant_clock);
+	class_device_create_file(class,
+				 &class_device_attr_select_ref_frequency);
+	class_device_create_file(class, &class_device_attr_filter_select);
+	class_device_create_file(class,
+				 &class_device_attr_hardware_switching_mode);
+	class_device_create_file(class, &class_device_attr_hardware_switching);
+	class_device_create_file(class, &class_device_attr_refalign);
+	class_device_create_file(class, &class_device_attr_mode_select);
+	class_device_create_file(class, &class_device_attr_reset);
+
+#endif				/*  CONFIG_SYSFS */
+	return 0;
+out3:
+	release_region(TLCLK_BASE, 8);
+out2:
+	kfree(alarm_events);
+out1:
+	return ret;
+}
+
+static void __exit tlclk_cleanup(void)
+{
+#ifdef  CONFIG_SYSFS
+	misc_deregister(&tlclk_miscdev);
+#endif
+	unregister_chrdev(tlclk_major, "telclock");
+
+	release_region(TLCLK_BASE, 8);
+	del_timer_sync(&switchover_timer);
+	kfree(alarm_events);
+
+}
+static void switchover_timeout(unsigned long data)
+{
+	if ((data & 1)) {
+		if ((inb(TLCLK_REG1) & 0x08) != (data & 0x08))
+			alarm_events->switchover_primary++;
+	} else {
+		if ((inb(TLCLK_REG1) & 0x08) != (data & 0x08))
+			alarm_events->switchover_secondary++;
+	}
+
+	/* Alarm processing is done, wake up read task */
+	del_timer(&switchover_timer);
+	got_event = 1;
+	wake_up(&wq);
+}
+
+irqreturn_t tlclk_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&event_lock, flags);
+	/* Read and clear interrupt events */
+	int_events = inb(TLCLK_REG6);
+
+	/* Primary_Los changed from 0 to 1 ? */
+	if (int_events & PRI_LOS_01_MASK) {
+		if (inb(TLCLK_REG2) & SEC_LOST_MASK)
+			alarm_events->lost_clocks++;
+		else
+			alarm_events->lost_primary_clock++;
+	}
+
+	/* Primary_Los changed from 1 to 0 ? */
+	if (int_events & PRI_LOS_10_MASK) {
+		alarm_events->primary_clock_back++;
+		SET_PORT_BITS(TLCLK_REG1, 0xFE, 1);
+	}
+	/* Secondary_Los changed from 0 to 1 ? */
+	if (int_events & SEC_LOS_01_MASK) {
+		if (inb(TLCLK_REG2) & PRI_LOST_MASK)
+			alarm_events->lost_clocks++;
+		else
+			alarm_events->lost_secondary_clock++;
+	}
+	/* Secondary_Los changed from 1 to 0 ? */
+	if (int_events & SEC_LOS_10_MASK) {
+		alarm_events->secondary_clock_back++;
+		SET_PORT_BITS(TLCLK_REG1, 0xFE, 0);
+	}
+	if (int_events & HOLDOVER_10_MASK)
+		alarm_events->pll_end_holdover++;
+
+	if (int_events & UNLOCK_01_MASK)
+		alarm_events->pll_lost_sync++;
+
+	if (int_events & UNLOCK_10_MASK)
+		alarm_events->pll_sync++;
+
+	/* Holdover changed from 0 to 1 ? */
+	if (int_events & HOLDOVER_01_MASK) {
+		alarm_events->pll_holdover++;
+
+		switchover_timer.expires = jiffies + msecs_to_jiffies(10);	/* TIMEOUT in ~10ms */
+		switchover_timer.data = inb(TLCLK_REG1);
+		add_timer(&switchover_timer);
+	} else {
+		got_event = 1;
+		wake_up(&wq);
+	}
+	spin_unlock_irqrestore(&event_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+module_init(tlclk_init);
+module_exit(tlclk_cleanup);
diff -urN -X dontdiff_osdl vanilla/linux-2.6.13/drivers/char/tlclk.h linux-2.6.13/drivers/char/tlclk.h
--- vanilla/linux-2.6.13/drivers/char/tlclk.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.13/drivers/char/tlclk.h	2005-08-30 10:52:25.961852080 -0700
@@ -0,0 +1,166 @@
+/*
+ * Telecom Clock driver for Wainwright board
+ *
+ * Copyright (C) 2005 Kontron Canada
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <sebastien.bouchard@ca.kontron.com>
+ *
+ */
+
+/* Ioctl definitions  */
+
+/* Use 0xA1 as magic number */
+#define TLCLK_IOC_MAGIC 0xA1
+
+/*Hardware Reset of the PLL */
+
+#define RESET_ON	0x00
+#define RESET_OFF	0x01
+#define IOCTL_RESET			_IO(TLCLK_IOC_MAGIC,  1)
+
+#define IOCTL_REFALIGN			_IO(TLCLK_IOC_MAGIC,  2)
+
+/* MODE SELECT */
+
+#define NORMAL_MODE 	0x00
+#define HOLDOVER_MODE	0x10
+#define FREERUN_MODE	0x20
+
+#define IOCTL_MODE_SELECT		_IOR(TLCLK_IOC_MAGIC,  3, char)
+
+/* FILTER SELECT */
+
+#define FILTER_6HZ	0x04
+#define FILTER_12HZ	0x00
+
+#define IOCTL_FILTER_SELECT		_IOR(TLCLK_IOC_MAGIC,  4, char)
+
+/* SELECT REFERENCE FREQUENCY */
+
+#define REF_CLK1_8kHz		0x00
+#define REF_CLK2_19_44MHz	0x02
+
+#define IOCTL_SELECT_REF_FREQUENCY	_IOR(TLCLK_IOC_MAGIC,  6, char)
+
+/* Select primary or secondary redundant clock */
+
+#define PRIMARY_CLOCK	0x00
+#define SECONDARY_CLOCK	0x01
+#define IOCTL_SELECT_REDUNDANT_CLOCK	_IOR(TLCLK_IOC_MAGIC,  7, char)
+
+/* CLOCK TRANSMISSION DEFINE */
+
+#define CLK_8kHz	0xff
+#define CLK_16_384MHz	0xfb
+
+#define CLK_1_544MHz	0x00
+#define CLK_2_048MHz	0x01
+#define CLK_4_096MHz	0x02
+#define CLK_6_312MHz	0x03
+#define CLK_8_192MHz	0x04
+#define CLK_19_440MHz	0x06
+
+#define CLK_8_592MHz	0x08
+#define CLK_11_184MHz	0x09
+#define CLK_34_368MHz	0x0b
+#define CLK_44_736MHz	0x0a
+
+#define IOCTL_SELECT_AMCB1_TRANSMIT_CLOCK _IOR(TLCLK_IOC_MAGIC,  9, char)
+#define IOCTL_SELECT_AMCB2_TRANSMIT_CLOCK _IOR(TLCLK_IOC_MAGIC,  10, char)
+
+/* RECEIVED REFERENCE */
+
+#define AMC_B1 0
+#define AMC_B2 1
+
+#define IOCTL_SELECT_RECEIVED_REF_CLK3A _IOR(TLCLK_IOC_MAGIC,  11, char)
+#define IOCTL_SELECT_RECEIVED_REF_CLK3B _IOR(TLCLK_IOC_MAGIC,  12, char)
+
+/* OEM COMMAND - NOT IN FINAL VERSION */
+
+#define IOCTL_TEST_MODE	_IO(TLCLK_IOC_MAGIC,  13)
+
+/* HARDWARE SWITCHING DEFINE */
+
+#define HW_ENABLE	0x80
+#define HW_DISABLE	0x00
+
+#define IOCTL_HARDWARE_SWITCHING	_IOR(TLCLK_IOC_MAGIC,  14, char)
+
+/* HARDWARE SWITCHING MODE DEFINE */
+
+#define PLL_HOLDOVER	0x40
+#define LOST_CLOCK	0x00
+
+#define IOCTL_HARDWARE_SWITCHING_MODE	_IOR(TLCLK_IOC_MAGIC,  15, char)
+
+/* CLOCK OUTPUT DEFINE */
+
+#define IOCTL_ENABLE_CLKA0_OUTPUT	_IOR(TLCLK_IOC_MAGIC,  16, char)
+#define IOCTL_ENABLE_CLKB0_OUTPUT	_IOR(TLCLK_IOC_MAGIC,  17, char)
+#define IOCTL_ENABLE_CLKA1_OUTPUT	_IOR(TLCLK_IOC_MAGIC,  18, char)
+#define IOCTL_ENABLE_CLKB1_OUTPUT	_IOR(TLCLK_IOC_MAGIC,  19, char)
+
+#define IOCTL_ENABLE_CLK3A_OUTPUT	_IOR(TLCLK_IOC_MAGIC,  20, char)
+#define IOCTL_ENABLE_CLK3B_OUTPUT	_IOR(TLCLK_IOC_MAGIC,  21, char)
+
+/* ALARMS DEFINE */
+
+#define UNLOCK_MASK	0x10
+#define HOLDOVER_MASK	0x20
+#define SEC_LOST_MASK	0x40
+#define PRI_LOST_MASK	0x80
+
+#define IOCTL_READ_ALARMS		_IO(TLCLK_IOC_MAGIC,  22)
+
+/* INTERRUPT CAUSE DEFINE */
+
+#define PRI_LOS_01_MASK		0x01
+#define PRI_LOS_10_MASK		0x02
+
+#define SEC_LOS_01_MASK		0x04
+#define SEC_LOS_10_MASK		0x08
+
+#define HOLDOVER_01_MASK	0x10
+#define HOLDOVER_10_MASK	0x20
+
+#define UNLOCK_01_MASK		0x40
+#define UNLOCK_10_MASK		0x80
+
+#define IOCTL_READ_INTERRUPT_SWITCH	_IO(TLCLK_IOC_MAGIC,  23)
+
+#define IOCTL_READ_CURRENT_REF		_IO(TLCLK_IOC_MAGIC,  25)
+
+/* MAX NUMBER OF IOCTL */
+#define TLCLK_IOC_MAXNR 25
+
+struct tlclk_alarms {
+	__u32 lost_clocks;
+	__u32 lost_primary_clock;
+	__u32 lost_secondary_clock;
+	__u32 primary_clock_back;
+	__u32 secondary_clock_back;
+	__u32 switchover_primary;
+	__u32 switchover_secondary;
+	__u32 pll_holdover;
+	__u32 pll_end_holdover;
+	__u32 pll_lost_sync;
+	__u32 pll_sync;
+};

--Boundary-00=_3tNFD/v4NZahMT1--
