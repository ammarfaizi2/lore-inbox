Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272563AbTHKNPD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272584AbTHKNPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:15:03 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:28108 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272563AbTHKNOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:14:47 -0400
Date: Mon, 11 Aug 2003 15:14:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Christoph Bartelmus <columbus@hit.handshake.de>
Cc: lirc-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811131419.GB2526@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes> <20030808231733.GF389@elf.ucw.cz> <8rZ2nqa1z9B@hit-columbus.hit.handshake.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8rZ2nqa1z9B@hit-columbus.hit.handshake.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's updated "bttv_remote.c" patch. This time with config option.

								Pavel

--- /usr/src/tmp/linux/drivers/input/keyboard/Kconfig	2003-08-10 21:22:48.000000000 +0200
+++ /usr/src/linux/drivers/input/keyboard/Kconfig	2003-08-11 14:51:53.000000000 +0200
@@ -99,6 +99,11 @@
 
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called xtkbd.o. If you want to compile it as a
+	  The module will be called 98kbd. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+config KEYBOARD_BTTV
+	tristate "BTTV remote control support"
+	depends on INPUT && INPUT_KEYBOARD
+	help
+	  Say Y here if you want remote control on your bttv card to work.
--- /usr/src/tmp/linux/drivers/input/keyboard/Makefile	2003-03-27 10:40:00.000000000 +0100
+++ /usr/src/linux/drivers/input/keyboard/Makefile	2003-08-11 14:52:08.000000000 +0200
@@ -11,3 +11,4 @@
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
 obj-$(CONFIG_KEYBOARD_98KBD)		+= 98kbd.o
+obj-$(CONFIG_KEYBOARD_BTTV)		+= bttv_remote.o
--- /usr/src/tmp/linux/drivers/input/keyboard/bttv_avermedia.c	2003-08-11 14:06:22.000000000 +0200
+++ /usr/src/linux/drivers/input/keyboard/bttv_avermedia.c	2003-08-11 14:26:23.000000000 +0200
@@ -0,0 +1,49 @@
+/* Copyright 2003 Pavel Machek <pavel@ucw.cz>, distribute under GPLv2.
+ *
+ * Translation codes for controller that came with TVPhone98w/VCR. It has
+ * only one label "AVerMedia" on it.
+ */
+
+int
+decode_bttv_avermedia(long code)
+{
+	switch (code) {
+	case 0x8577c0: return KEY_TUNER;
+	case 0x4577c0: return KEY_TV;
+	case 0xc577c0: return KEY_EJECTCD;	/* Unmarked on my controller */
+	case 0x577c0: return KEY_POWER;
+	case 0xa577c0: return KEY_KP1;
+	case 0x6577c0: return KEY_KP2; 
+	case 0xe577c0: return KEY_KP3; 
+	case 0x2577c0: return KEY_VIDEO;
+	case 0x9577c0: return KEY_KP4;
+	case 0x5577c0: return KEY_KP5;
+	case 0xd577c0: return KEY_KP6;
+	case 0x1577c0: return KEY_AUDIO;
+	case 0xb577c0: return KEY_KP7;
+	case 0x7577c0: return KEY_KP8;
+	case 0xf577c0: return KEY_KP9;
+	case 0x3577c0: return KEY_ZOOM;
+	case 0x8d77c0: return KEY_KP0;
+	case 0x4d77c0: return KEY_CYCLEWINDOWS; /* DISPLAY/L */
+	case 0xcd77c0: return KEY_AGAIN; /* LOOP/R */
+	case 0xd77c0: return KEY_INFO; /* preview */
+	case 0xad77c0: return KEY_SEARCH; /* autoscan */
+	case 0x6d77c0: return KEY_BREAK; /* freeze */
+	case 0xed77c0: return KEY_PVR; /* capture */
+	case 0x2d77c0: return KEY_MUTE;
+	case 0x9d77c0: return KEY_RECORD;
+	case 0x5d77c0: return KEY_PAUSE;
+	case 0xdd77c0: return KEY_STOP;
+	case 0x1d77c0: return KEY_PLAY;
+	case 0xbd77c0: return KEY_RED;
+	case 0x7d77c0: return KEY_VOLUMEDOWN;
+	case 0xfd77c0: return KEY_VOLUMEUP;
+	case 0x3d77c0: return KEY_GREEN;
+	case 0x85f7c0: return KEY_YELLOW;
+	case 0x45f7c0: return KEY_CHANNELDOWN; 
+	case 0xc5f7c0: return KEY_CHANNELUP;
+	case 0x5f7c0: return KEY_BLUE;
+	default: printk("bttv_avermedia: unknown code %lx\n", code);
+	}
+}
--- /usr/src/tmp/linux/drivers/input/keyboard/bttv_remote.c	2003-08-11 00:55:34.000000000 +0200
+++ /usr/src/linux/drivers/input/keyboard/bttv_remote.c	2003-08-11 15:02:22.000000000 +0200
@@ -0,0 +1,341 @@
+/*
+ *  Copyright (c) 2000-2001 Vojtech Pavlik
+ *  Copyright (c) 2003 Pavel Machek
+ *
+ * (L) by Artur Lipowski <alipowski@interia.pl>
+ *     patch for the AverMedia by Santiago Garcia Mantinan <manty@i.am>
+ *                            and Christoph Bartelmus <lirc@bartelmus.de>
+ *     patch for the BestBuy by Miguel Angel Alvarez <maacruz@navegalia.com>
+ *     patch for the Winfast TV2000 by Juan Toledo
+ *     <toledo@users.sourceforge.net>
+ *     patch for the I-O Data GV-BCTV5/PCI by Jens C. Rasmussen
+ *     <jens.rasmussen@ieee.org>
+ */
+
+/*
+ * Driver for bttv cards.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Should you need to contact me, the author, you can do so either by
+ * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
+ * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+
+#include "../../media/video/bttv.h"
+#include "../../media/video/bttvp.h"
+#include "bttv_avermedia.c"
+
+MODULE_AUTHOR("Pavel Machek <pavel@ucw.cz>");
+MODULE_DESCRIPTION("BTTV infrared remote control");
+MODULE_LICENSE("GPL");
+
+static struct input_dev gpio_dev;
+
+static char *gpio_name = "BTTV remote control";
+static char *gpio_phys = "bttv/input0";
+
+static unsigned short gpio_keycode[KEY_MAX];
+
+struct rcv_info {
+	int bttv_id;
+	int card_id;
+	unsigned long gpio_mask;
+	unsigned long gpio_enable;
+	unsigned long gpio_lock_mask;
+	unsigned long gpio_xor_mask;
+	unsigned int soft_gap;
+	unsigned char sample_rate;
+	unsigned char code_length;
+};
+
+static struct rcv_info rcv_infos[] = {
+	{BTTV_UNKNOWN,                0,          0,          0,         0,          0,   0,  1,  0},
+	{BTTV_AVERMEDIA,              0, 0x00f88000,          0, 0x0010000, 0x00010000,   0, 10, 32},
+	{BTTV_AVPHONE98,     0x00011461, 0x003b8000, 0x00004000, 0x0800000, 0x00800000,   0, 10,  0}, /*mapped to Capture98*/
+	{BTTV_AVERMEDIA98,   0x00021461, 0x003b8000, 0x00004000, 0x0800000, 0x00800000,   0, 10,  0}, /*mapped to Capture98*/
+	{BTTV_AVPHONE98,     0x00031461, 0x00f88000,          0, 0x0010000, 0x00010000,   0, 10, 32}, /*mapped to Phone98*/
+	/* is this one correct? */
+	{BTTV_AVERMEDIA98,   0x00041461, 0x00f88000,          0, 0x0010000, 0x00010000,   0, 10, 32}, /*mapped to Phone98*/
+	/* work-around for VDOMATE */
+	{BTTV_AVERMEDIA98,   0x03001461, 0x00f88000,          0, 0x0010000, 0x00010000,   0, 10, 32}, /*mapped to Phone98*/
+	/* reported by Danijel Korzinek, AVerTV GOw/FM */
+	{BTTV_AVERMEDIA98,   0x00000000, 0x00f88000,          0, 0x0010000, 0x00010000,   0, 10, 32}, /*mapped to Phone98*/
+};
+
+static int debug = 0;
+static int card = 0;
+static int minor = -1;
+static int bttv_id = BTTV_UNKNOWN;
+static unsigned long gpio_mask = 0;
+static unsigned long gpio_enable = 0;
+static unsigned long gpio_lock_mask = 0;
+static unsigned long gpio_xor_mask = 0;
+static unsigned int soft_gap = 0;
+static unsigned char sample_rate = 10;
+
+static unsigned char code_length = 0;
+static unsigned char code_bytes = 1;
+
+#define MAX_BYTES 8
+
+#define SUCCESS 0
+#define LOGHEAD "lirc_gpio (%d): "
+
+/* how many bits GPIO value can be shifted right before processing
+ * it is computed from the value of gpio_mask_parameter
+ */
+static unsigned char gpio_pre_shift = 0;
+
+static int build_key(unsigned long gpio_val, unsigned char codes[MAX_BYTES])
+{
+	unsigned long mask = gpio_mask;
+	unsigned char shift = 0;
+
+	dprintk(LOGHEAD "gpio_val is %lx\n",card,(unsigned long) gpio_val);
+
+	gpio_val ^= gpio_xor_mask;
+
+	if (gpio_lock_mask && (gpio_val & gpio_lock_mask)) {
+		return -EBUSY;
+	}
+
+	switch (bttv_id)
+	{
+	case BTTV_AVERMEDIA98:
+		if (bttv_write_gpio(card, gpio_enable, gpio_enable)) {
+			dprintk(LOGHEAD "cannot write to GPIO\n", card);
+			return -EIO;
+		}
+		if (bttv_read_gpio(card, &gpio_val)) {
+			dprintk(LOGHEAD "cannot read GPIO\n", card);
+			return -EIO;
+		}
+		if (bttv_write_gpio(card, gpio_enable, 0)) {
+			dprintk(LOGHEAD "cannot write to GPIO\n", card);
+			return -EIO;
+		}
+		break;
+	default:
+		break;
+	}
+
+	/* extract bits from "raw" GPIO value using gpio_mask */
+	codes[0] = 0;
+	gpio_val >>= gpio_pre_shift;
+	while (mask) {
+		if (mask & 1u) {
+			codes[0] |= (gpio_val & 1u) << shift++;
+		}
+		mask >>= 1;
+		gpio_val >>= 1;
+	}
+
+	dprintk(LOGHEAD "code is %lx\n",card,(unsigned long) codes[0]);
+	switch (bttv_id)
+	{
+	case BTTV_AVERMEDIA:
+		codes[2] = (codes[0]<<2)&0xff;
+		codes[3] = (~codes[2])&0xff;
+		codes[0] = 0x02;
+		codes[1] = 0xFD;
+		break;
+	case BTTV_AVPHONE98:
+		codes[2] = ((codes[0]&(~0x1))<<2)&0xff;
+		codes[3] = (~codes[2])&0xff;
+		if (codes[0]&0x1) {
+			codes[0] = 0xc0;
+			codes[1] = 0x3f;
+		} else {
+			codes[0] = 0x40;
+			codes[1] = 0xbf;
+		}
+		break;
+	case BTTV_AVERMEDIA98:
+		break;
+	default:
+		break;
+	}
+
+	return SUCCESS;
+}
+
+static void poll_me(void)
+{
+	static unsigned long next_time = 0;
+	static unsigned char codes[MAX_BYTES];
+	unsigned long code = 0;
+	unsigned char cur_codes[MAX_BYTES];
+
+	if (bttv_read_gpio(card, &code)) {
+		dprintk(LOGHEAD "cannot read GPIO\n", card);
+		return -EIO;
+	}
+
+	if (build_key(code, cur_codes)) {
+		return -EFAULT;
+	}
+
+	if (soft_gap) {
+		if (!memcmp(codes, cur_codes, code_bytes) &&
+		    jiffies < next_time) {
+			return -EAGAIN;
+		}
+		next_time = jiffies + soft_gap;
+	}
+
+	memcpy(codes, cur_codes, code_bytes);
+
+	input_report_key(&gpio_dev, decode_bttv_avermedia(code), 1);
+	input_report_key(&gpio_dev, decode_bttv_avermedia(code), 0);
+	input_sync(&gpio_dev);
+	return 0;
+}
+
+/* main function of the polling thread
+ */
+static int lirc_thread(void *unused)
+{
+	daemonize("bttv_remote_poller");
+	do {
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(HZ/10);
+		poll_me();
+	} while (1);
+	return 0;
+}
+
+int gpio_remote_init(void)
+{
+	int ret;
+	unsigned int mask;
+
+	/* "normalize" gpio_mask
+	 * this means shift it right until first bit is set
+	 */
+	while (!(gpio_mask & 1u)) {
+		gpio_pre_shift++;
+		gpio_mask >>= 1;
+	}
+
+	if (gpio_enable) {
+		if(bttv_gpio_enable(card, gpio_enable, gpio_enable)) {
+			printk(LOGHEAD "gpio_enable failure\n", minor);
+			return -EIO;
+		}
+	}
+
+	/* translate ms to jiffies */
+	soft_gap = (soft_gap*HZ) / 1000;
+	return 0;
+}
+
+static int __init gpio_init(void)
+{
+	int i;
+	int type,cardid,card_type;
+
+	request_module("bttv");
+
+	if(bttv_get_cardinfo(card,&type,&cardid)==-1) {
+		printk(LOGHEAD "could not get card type\n", minor);
+	}
+	printk(LOGHEAD "card type 0x%x, id 0x%x\n",minor, type, cardid);
+
+	if (type == BTTV_UNKNOWN) {
+		printk(LOGHEAD "cannot detect TV card nr %d!\n",
+		       minor, card);
+		return -EBADRQC;
+	}
+	for (card_type = 1;
+	     card_type < sizeof(rcv_infos)/sizeof(struct rcv_info);
+	     card_type++) {
+		if (rcv_infos[card_type].bttv_id == type &&
+		    (rcv_infos[card_type].card_id == 0 ||
+		     rcv_infos[card_type].card_id == cardid)) {
+			bttv_id = rcv_infos[card_type].bttv_id;
+			gpio_mask = rcv_infos[card_type].gpio_mask;
+			gpio_enable = rcv_infos[card_type].gpio_enable;
+			gpio_lock_mask = rcv_infos[card_type].gpio_lock_mask;
+			gpio_xor_mask = rcv_infos[card_type].gpio_xor_mask;
+			soft_gap = rcv_infos[card_type].soft_gap;
+			sample_rate = rcv_infos[card_type].sample_rate;
+			code_length = rcv_infos[card_type].code_length;
+			break;
+		}
+		if (type==BTTV_AVPHONE98 && cardid==0x00011461)	{
+			bttv_id = BTTV_AVERMEDIA98;
+		}
+		if (type==BTTV_AVERMEDIA98 && cardid==0x00041461) {
+			bttv_id = BTTV_AVPHONE98;
+		}
+		if (type==BTTV_AVERMEDIA98 && cardid==0x03001461) {
+			bttv_id = BTTV_AVPHONE98;
+		}
+		if (type==BTTV_AVERMEDIA98 && cardid==0x00000000) {
+			bttv_id = BTTV_AVPHONE98;
+		}
+		if (card_type == sizeof(rcv_infos)/sizeof(struct rcv_info)) {
+			printk(LOGHEAD "TV card type %x not supported!\n",
+			       minor, type);
+			return -EBADRQC;
+		}
+	}
+
+	if (gpio_remote_init())
+		return -EIO;
+
+	init_input_dev(&gpio_dev);
+
+	for (i=0; i<KEY_MAX; i++)
+		gpio_keycode[i] = i;
+	gpio_dev.evbit[0] = BIT(EV_KEY);
+	gpio_dev.keycode = gpio_keycode;
+	gpio_dev.keycodesize = sizeof(unsigned short);
+	gpio_dev.keycodemax = KEY_MAX;
+
+	for (i = 0; i < 0x78; i++)
+		if (gpio_keycode[i])
+			set_bit(gpio_keycode[i], gpio_dev.keybit);
+
+	gpio_dev.name = gpio_name;
+	gpio_dev.phys = gpio_phys;
+	gpio_dev.id.bustype = BUS_AMIGA;
+	gpio_dev.id.vendor = 0x1234;
+	gpio_dev.id.product = 0x5678;
+	gpio_dev.id.version = 0x90ab;
+
+	input_register_device(&gpio_dev);
+	kernel_thread(lirc_thread, NULL, 0);
+
+	printk(KERN_INFO "input: %s\n", gpio_name);
+	return 0;
+}
+
+static void __exit gpio_exit(void)
+{
+	input_unregister_device(&gpio_dev);
+}
+
+late_initcall(gpio_init);
+module_exit(gpio_exit);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
