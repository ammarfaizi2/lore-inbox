Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVARPDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVARPDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVARPDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:03:20 -0500
Received: from mail.suse.de ([195.135.220.2]:19101 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261309AbVARO7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 09:59:37 -0500
Message-ID: <41ED2457.1030109@suse.de>
Date: Tue, 18 Jan 2005 15:59:35 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/2] Remove input_call_hotplug
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080100010402050005030101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080100010402050005030101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Implement proper class names for input drivers.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------080100010402050005030101
Content-Type: text/x-patch;
 name="bk-input-sysfs-part2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bk-input-sysfs-part2.patch"

===== drivers/char/sonypi.c 1.33 vs edited =====
--- 1.33/drivers/char/sonypi.c	2005-01-08 06:44:09 +01:00
+++ edited/drivers/char/sonypi.c	2005-01-18 15:26:04 +01:00
@@ -826,6 +826,7 @@
 		sprintf(sonypi_device.input_jog_dev.name, SONYPI_JOG_INPUTNAME);
 		sonypi_device.input_jog_dev.id.bustype = BUS_ISA;
 		sonypi_device.input_jog_dev.id.vendor = PCI_VENDOR_ID_SONY;
+		sprintf(sonypi_device.jog_dev.cdev.class_id,"sonypi-jogdial");
 
 		input_register_device(&sonypi_device.input_jog_dev);
 		printk(KERN_INFO "%s input method installed.\n",
@@ -847,6 +848,7 @@
 		sprintf(sonypi_device.input_key_dev.name, SONYPI_KEY_INPUTNAME);
 		sonypi_device.input_key_dev.id.bustype = BUS_ISA;
 		sonypi_device.input_key_dev.id.vendor = PCI_VENDOR_ID_SONY;
+		sprintf(sonypi_device.input_key_dev.cdev.class_id,"sonypi-keys");
 
 		input_register_device(&sonypi_device.input_key_dev);
 		printk(KERN_INFO "%s input method installed.\n",
===== drivers/input/joystick/a3d.c 1.12 vs edited =====
--- 1.12/drivers/input/joystick/a3d.c	2004-05-10 03:34:07 +02:00
+++ edited/drivers/input/joystick/a3d.c	2005-01-18 11:35:53 +01:00
@@ -69,6 +69,8 @@
 	char adcphys[32];
 };
 
+static int a3d_num;
+
 /*
  * a3d_read_packet() reads an Assassin 3D packet.
  */
@@ -365,6 +367,7 @@
 	a3d->dev.id.vendor = GAMEPORT_ID_VENDOR_MADCATZ;
 	a3d->dev.id.product = a3d->mode;
 	a3d->dev.id.version = 0x0100;
+	sprintf(a3d->dev.cdev.class_id,"a3d-%d",a3d_num++);
 
 	input_register_device(&a3d->dev);
 	printk(KERN_INFO "input: %s on %s\n", a3d_names[a3d->mode], a3d->phys);
===== drivers/input/joystick/adi.c 1.17 vs edited =====
--- 1.17/drivers/input/joystick/adi.c	2004-06-11 23:04:03 +02:00
+++ edited/drivers/input/joystick/adi.c	2005-01-18 11:35:53 +01:00
@@ -134,6 +134,8 @@
 	int used;
 };
 
+static int adi_num;
+
 /*
  * adi_read_packet() reads a Logitech ADI packet.
  */
@@ -424,6 +426,7 @@
 	adi->dev.id.vendor = GAMEPORT_ID_VENDOR_LOGITECH;
 	adi->dev.id.product = adi->id;
 	adi->dev.id.version = 0x0100;
+	sprintf(adi->dev.cdev.class_id,"adi%d",adi_num++);
 
 	adi->dev.private = port;
 	adi->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
===== drivers/input/joystick/amijoy.c 1.15 vs edited =====
--- 1.15/drivers/input/joystick/amijoy.c	2004-10-20 10:12:05 +02:00
+++ edited/drivers/input/joystick/amijoy.c	2005-01-18 11:35:53 +01:00
@@ -137,6 +137,7 @@
 			amijoy_dev[i].id.vendor = 0x0001;
 			amijoy_dev[i].id.product = 0x0003;
 			amijoy_dev[i].id.version = 0x0100;
+			sprintf(amijoy[i].cdev.class_id,"amijoy%d",i);
 
 			amijoy_dev[i].private = amijoy_used + i;
 
===== drivers/input/joystick/analog.c 1.26 vs edited =====
--- 1.26/drivers/input/joystick/analog.c	2004-10-20 10:12:06 +02:00
+++ edited/drivers/input/joystick/analog.c	2005-01-18 11:35:53 +01:00
@@ -136,6 +136,8 @@
 	int axtime;
 };
 
+static int analog_num;
+
 /*
  * Time macros.
  */
@@ -445,6 +447,7 @@
 	analog->dev.id.vendor = GAMEPORT_ID_VENDOR_ANALOG;
 	analog->dev.id.product = analog->mask >> 4;
 	analog->dev.id.version = 0x0100;
+	sprintf(analog->dev.cdev.class_id,"analog%d", analog_num++);
 
 	analog->dev.open = analog_open;
 	analog->dev.close = analog_close;
===== drivers/input/joystick/cobra.c 1.12 vs edited =====
--- 1.12/drivers/input/joystick/cobra.c	2004-05-10 03:34:07 +02:00
+++ edited/drivers/input/joystick/cobra.c	2005-01-18 11:35:53 +01:00
@@ -205,6 +205,7 @@
 			cobra->dev[i].id.vendor = GAMEPORT_ID_VENDOR_CREATIVE;
 			cobra->dev[i].id.product = 0x0008;
 			cobra->dev[i].id.version = 0x0100;
+			sprintf(cobra->dev[i].cdev.class_id,"cobra%d", i);
 
 			cobra->dev[i].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 			cobra->dev[i].absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
===== drivers/input/joystick/db9.c 1.14 vs edited =====
--- 1.14/drivers/input/joystick/db9.c	2004-10-20 10:12:06 +02:00
+++ edited/drivers/input/joystick/db9.c	2005-01-18 11:35:53 +01:00
@@ -597,6 +597,7 @@
 		db9->dev[i].id.vendor = 0x0002;
 		db9->dev[i].id.product = config[1];
 		db9->dev[i].id.version = 0x0100;
+		sprintf(db9->dev[i].cdev.class_id,"db9-%d",i);
 
 		db9->dev[i].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 		for (j = 0; j < db9_buttons[db9->mode]; j++)
===== drivers/input/joystick/gamecon.c 1.20 vs edited =====
--- 1.20/drivers/input/joystick/gamecon.c	2004-10-21 11:59:08 +02:00
+++ edited/drivers/input/joystick/gamecon.c	2005-01-18 11:35:53 +01:00
@@ -646,6 +646,7 @@
                 gc->dev[i].id.vendor = 0x0001;
                 gc->dev[i].id.product = config[i + 1];
                 gc->dev[i].id.version = 0x0100;
+		sprintf(gc->dev[i].cdev.class_id, "gamecon%d",i);
 	}
 
 	parport_release(gc->pd);
===== drivers/input/joystick/gf2k.c 1.16 vs edited =====
--- 1.16/drivers/input/joystick/gf2k.c	2004-06-11 23:04:03 +02:00
+++ edited/drivers/input/joystick/gf2k.c	2005-01-18 11:35:53 +01:00
@@ -90,6 +90,8 @@
 	char phys[32];
 };
 
+static int gf2k_num;
+
 /*
  * gf2k_read_packet() reads a Genius Flight2000 packet.
  */
@@ -303,6 +305,7 @@
 	gf2k->dev.id.vendor = GAMEPORT_ID_VENDOR_GENIUS;
 	gf2k->dev.id.product = gf2k->id;
 	gf2k->dev.id.version = 0x0100;
+	sprintf(gf2k->dev.cdev.class_id,"gf2k-%d",gf2k_num++);
 
 	for (i = 0; i < gf2k_axes[gf2k->id]; i++)
 		set_bit(gf2k_abs[i], gf2k->dev.absbit);
===== drivers/input/joystick/grip.c 1.12 vs edited =====
--- 1.12/drivers/input/joystick/grip.c	2004-07-12 10:01:05 +02:00
+++ edited/drivers/input/joystick/grip.c	2005-01-18 11:35:53 +01:00
@@ -356,6 +356,7 @@
 			grip->dev[i].id.vendor = GAMEPORT_ID_VENDOR_GRAVIS;
 			grip->dev[i].id.product = grip->mode[i];
 			grip->dev[i].id.version = 0x0100;
+			sprintf(grip->dev[i].cdev.class_id,"grip%d",i);
 
 			grip->dev[i].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
===== drivers/input/joystick/grip_mp.c 1.7 vs edited =====
--- 1.7/drivers/input/joystick/grip_mp.c	2004-09-24 10:28:15 +02:00
+++ edited/drivers/input/joystick/grip_mp.c	2005-01-18 11:35:53 +01:00
@@ -584,6 +584,7 @@
 	grip->dev[slot].id.product = 0x0100 + grip->mode[slot];
 	grip->dev[slot].id.version = 0x0100;
 	grip->dev[slot].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	sprintf(grip->dev[slot].cdev.class_id,"grip-mp%d",slot);
 
 	for (j = 0; (t = grip_abs[grip->mode[slot]][j]) >= 0; j++) {
 		set_bit(t, grip->dev[slot].absbit);
===== drivers/input/joystick/guillemot.c 1.7 vs edited =====
--- 1.7/drivers/input/joystick/guillemot.c	2004-05-10 03:34:07 +02:00
+++ edited/drivers/input/joystick/guillemot.c	2005-01-18 11:35:53 +01:00
@@ -76,6 +76,8 @@
 	char phys[32];
 };
 
+static int guillemot_num;
+
 static struct guillemot_type guillemot_type[] = {
 	{ 0x00, guillemot_abs_pad, guillemot_btn_pad, 1, "Guillemot Pad" },
 	{ 0 }};
@@ -228,6 +230,7 @@
 	guillemot->dev.id.vendor = GAMEPORT_ID_VENDOR_GUILLEMOT;
 	guillemot->dev.id.product = guillemot_type[i].id;
 	guillemot->dev.id.version = (int)data[14] << 8 | data[15];
+	sprintf(guillemot->dev.cdev.class_id,"guillemot%d",guillemot_num++);
 
 	guillemot->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
===== drivers/input/joystick/interact.c 1.11 vs edited =====
--- 1.11/drivers/input/joystick/interact.c	2004-05-10 03:34:07 +02:00
+++ edited/drivers/input/joystick/interact.c	2005-01-18 11:35:53 +01:00
@@ -63,6 +63,8 @@
 	char phys[32];
 };
 
+static int interact_num;
+
 static short interact_abs_hhfx[] =
 	{ ABS_RX, ABS_RY, ABS_X, ABS_Y, ABS_HAT0X, ABS_HAT0Y, -1 };
 static short interact_abs_pp8d[] =
@@ -277,6 +279,7 @@
 	for (i = 0; (t = interact_type[interact->type].btn[i]) >= 0; i++)
 		set_bit(t, interact->dev.keybit);
 
+	sprintf(interact->dev.cdev.class_id,"interact%d",interact_num++);
 	input_register_device(&interact->dev);
 	printk(KERN_INFO "input: %s on %s\n",
 		interact_type[interact->type].name, gameport->phys);
===== drivers/input/joystick/magellan.c 1.16 vs edited =====
--- 1.16/drivers/input/joystick/magellan.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/joystick/magellan.c	2005-01-18 11:38:15 +01:00
@@ -62,6 +62,8 @@
 	char phys[32];
 };
 
+static int magellan_num;
+
 /*
  * magellan_crunch_nibbles() verifies that the bytes sent from the Magellan
  * have correct upper nibbles for the lower ones, if not, the packet will
@@ -184,6 +186,7 @@
 	magellan->dev.id.product = 0x0001;
 	magellan->dev.id.version = 0x0100;
 	magellan->dev.dev = &serio->dev;
+	sprintf(magellan->dev.cdev.class_id,"magellan%d", magellan_num++);
 
 	serio->private = magellan;
 
===== drivers/input/joystick/sidewinder.c 1.14 vs edited =====
--- 1.14/drivers/input/joystick/sidewinder.c	2004-05-10 03:34:07 +02:00
+++ edited/drivers/input/joystick/sidewinder.c	2005-01-18 11:35:53 +01:00
@@ -721,6 +721,7 @@
 		sw->dev[i].id.vendor = GAMEPORT_ID_VENDOR_MICROSOFT;
 		sw->dev[i].id.product = sw->type;
 		sw->dev[i].id.version = 0x0100;
+		sprintf(sw->dev[i].cdev.class_id,"sidewinder%d", i );
 
 		sw->dev[i].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
===== drivers/input/joystick/spaceball.c 1.16 vs edited =====
--- 1.16/drivers/input/joystick/spaceball.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/joystick/spaceball.c	2005-01-18 11:39:17 +01:00
@@ -78,6 +78,8 @@
 	char phys[32];
 };
 
+static int spaceball_num;
+
 /*
  * spaceball_process_packet() decodes packets the driver receives from the
  * SpaceBall.
@@ -254,6 +256,7 @@
 	spaceball->dev.id.product = id;
 	spaceball->dev.id.version = 0x0100;
 	spaceball->dev.dev = &serio->dev;
+	sprintf(spaceball->dev.cdev.class_id,"spaceball%d",spaceball_num++);
 
 	serio->private = spaceball;
 
===== drivers/input/joystick/spaceorb.c 1.15 vs edited =====
--- 1.15/drivers/input/joystick/spaceorb.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/joystick/spaceorb.c	2005-01-18 11:39:37 +01:00
@@ -66,6 +66,8 @@
 	char phys[32];
 };
 
+static int spaceorb_num;
+
 static unsigned char spaceorb_xor[] = "SpaceWare";
 
 static unsigned char *spaceorb_errors[] = { "EEPROM storing 0 failed", "Receive queue overflow", "Transmit queue timeout",
@@ -201,6 +203,7 @@
 	spaceorb->dev.id.product = 0x0001;
 	spaceorb->dev.id.version = 0x0100;
 	spaceorb->dev.dev = &serio->dev;
+	sprintf(spaceorb->dev.cdev.class_id,"spaceorb%d", spaceorb_num++);
 
 	serio->private = spaceorb;
 
===== drivers/input/joystick/stinger.c 1.14 vs edited =====
--- 1.14/drivers/input/joystick/stinger.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/joystick/stinger.c	2005-01-18 11:43:08 +01:00
@@ -50,6 +50,8 @@
 
 static char *stinger_name = "Gravis Stinger";
 
+static int stinger_num;
+
 /*
  * Per-Stinger data.
  */
@@ -165,6 +167,7 @@
 	stinger->dev.id.product = 0x0001;
 	stinger->dev.id.version = 0x0100;
 	stinger->dev.dev = &serio->dev;
+	sprintf(stinger->dev.cdev.class_id,"stinger%d",stinger_num++);
 
 	for (i = 0; i < 2; i++) {
 		stinger->dev.absmax[ABS_X+i] =  64;
===== drivers/input/joystick/tmdc.c 1.13 vs edited =====
--- 1.13/drivers/input/joystick/tmdc.c	2004-07-29 13:42:48 +02:00
+++ edited/drivers/input/joystick/tmdc.c	2005-01-18 11:35:53 +01:00
@@ -318,6 +318,7 @@
 			tmdc->dev[j].id.vendor = GAMEPORT_ID_VENDOR_THRUSTMASTER;
 			tmdc->dev[j].id.product = models[m].id;
 			tmdc->dev[j].id.version = 0x0100;
+			sprintf(tmdc->dev[j].cdev.class_id,"tmcd%d",j);
 
 			tmdc->dev[j].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
===== drivers/input/joystick/turbografx.c 1.12 vs edited =====
--- 1.12/drivers/input/joystick/turbografx.c	2004-10-20 10:12:06 +02:00
+++ edited/drivers/input/joystick/turbografx.c	2005-01-18 11:35:53 +01:00
@@ -205,6 +205,7 @@
 			tgfx->dev[i].id.vendor = 0x0003;
 			tgfx->dev[i].id.product = config[i+1];
 			tgfx->dev[i].id.version = 0x0100;
+			sprintf(tgfx->dev[i].cdev.class_id,"turbografx%d",i);
 
 			tgfx->dev[i].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 			tgfx->dev[i].absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
===== drivers/input/joystick/twidjoy.c 1.11 vs edited =====
--- 1.11/drivers/input/joystick/twidjoy.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/joystick/twidjoy.c	2005-01-18 11:44:23 +01:00
@@ -99,6 +99,8 @@
 	char phys[32];
 };
 
+static int twidjoy_num;
+
 /*
  * twidjoy_process_packet() decodes packets the driver receives from the
  * Twiddler. It updates the data accordingly.
@@ -237,6 +239,8 @@
 		kfree(twidjoy);
 		return;
 	}
+
+	sprintf(twidjoy->dev.cdev.class_id,"twidjoy%d", twidjoy_num++);
 
 	input_register_device(&twidjoy->dev);
 
===== drivers/input/joystick/warrior.c 1.15 vs edited =====
--- 1.15/drivers/input/joystick/warrior.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/joystick/warrior.c	2005-01-18 11:48:06 +01:00
@@ -60,6 +60,8 @@
 	char phys[32];
 };
 
+static int warrior_num;
+
 /*
  * warrior_process_packet() decodes packets the driver receives from the
  * Warrior. It updates the data accordingly.
@@ -193,6 +195,7 @@
 		return;
 	}
 
+	sprintf(warrior->dev.cdev.class_id, "warrior%d", warrior_num++);
 	input_register_device(&warrior->dev);
 
 	printk(KERN_INFO "input: Logitech WingMan Warrior on %s\n", serio->phys);
===== drivers/input/joystick/iforce/iforce-main.c 1.6 vs edited =====
--- 1.6/drivers/input/joystick/iforce/iforce-main.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/joystick/iforce/iforce-main.c	2005-01-18 11:35:53 +01:00
@@ -81,7 +81,7 @@
 	{ 0x0000, 0x0000, "Unknown I-Force Device [%04x:%04x]",		btn_joystick, abs_joystick, ff_iforce }
 };
 
-
+static int iforce_num;
 
 static int iforce_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
@@ -520,7 +520,7 @@
 /*
  * Register input device.
  */
-
+	sprintf(iforce->dev.cdev.class_id,"iforce%d",iforce_num++);
 	input_register_device(&iforce->dev);
 
 	printk(KERN_DEBUG "iforce->dev.open = %p\n", iforce->dev.open);
===== drivers/input/keyboard/amikbd.c 1.15 vs edited =====
--- 1.15/drivers/input/keyboard/amikbd.c	2004-03-28 13:31:55 +02:00
+++ edited/drivers/input/keyboard/amikbd.c	2005-01-18 11:35:53 +01:00
@@ -222,6 +222,7 @@
 	amikbd_dev.id.vendor = 0x0001;
 	amikbd_dev.id.product = 0x0001;
 	amikbd_dev.id.version = 0x0100;
+	sprintf(amikbd_dev.cdev.class_id,"amikbd");
 
 	input_register_device(&amikbd_dev);
 
===== drivers/input/keyboard/atkbd.c 1.73 vs edited =====
--- 1.73/drivers/input/keyboard/atkbd.c	2005-01-06 17:42:09 +01:00
+++ edited/drivers/input/keyboard/atkbd.c	2005-01-18 11:57:45 +01:00
@@ -171,6 +171,8 @@
 	{ ATKBD_SCR_CLICK, 0x60 },
 };
 
+static int atkbd_num;
+
 /*
  * The atkbd control structure
  */
@@ -731,6 +733,7 @@
 	atkbd->dev.event = atkbd_event;
 	atkbd->dev.private = atkbd;
 	atkbd->dev.dev = &atkbd->ps2dev.serio->dev;
+	sprintf(atkbd->dev.cdev.class_id,"atkbd%d",atkbd_num++);
 
 	atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_MSC);
 
===== drivers/input/keyboard/lkkbd.c 1.6 vs edited =====
--- 1.6/drivers/input/keyboard/lkkbd.c	2004-10-24 21:01:51 +02:00
+++ edited/drivers/input/keyboard/lkkbd.c	2005-01-18 11:35:53 +01:00
@@ -298,6 +298,8 @@
 	int ctrlclick_volume;
 };
 
+int lkkbd_num;
+
 /*
  * Calculate volume parameter byte for a given volume.
  */
@@ -685,7 +687,8 @@
 	lk->dev.id.vendor = SERIO_LKKBD;
 	lk->dev.id.product = 0;
 	lk->dev.id.version = 0x0100;
-	lk->dev.dev = &serio->dev;
+	lk->dev.dev = get_device(&serio->dev);
+	sprintf(lk->dev.cdev.class_id,"lkkbd%d",lkkbd_num++);
 
 	input_register_device (&lk->dev);
 
===== drivers/input/keyboard/maple_keyb.c 1.8 vs edited =====
--- 1.8/drivers/input/keyboard/maple_keyb.c	2004-05-10 03:31:23 +02:00
+++ edited/drivers/input/keyboard/maple_keyb.c	2005-01-18 11:35:53 +01:00
@@ -43,6 +43,7 @@
 	int open;
 };
 
+static int dc_kbd_num;
 
 static void dc_scan_kbd(struct dc_kbd *kbd)
 {
@@ -139,6 +140,7 @@
 
 	kbd->dev.name = dev->product_name;
 	kbd->dev.id.bustype = BUS_MAPLE;
+	sprintf(kbd->dev.cdev.class_id,"dckbd%d",dc_kdb_num++);
 
 	input_register_device(&kbd->dev);
 
===== drivers/input/keyboard/newtonkbd.c 1.12 vs edited =====
--- 1.12/drivers/input/keyboard/newtonkbd.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/keyboard/newtonkbd.c	2005-01-18 11:45:14 +01:00
@@ -59,6 +59,8 @@
 
 static char *nkbd_name = "Newton Keyboard";
 
+static int nkbd_num;
+
 struct nkbd {
 	unsigned char keycode[128];
 	struct input_dev dev;
@@ -127,6 +129,7 @@
 	nkbd->dev.id.product = 0x0001;
 	nkbd->dev.id.version = 0x0100;
 	nkbd->dev.dev = &serio->dev;
+	sprintf(nkbd->dev.cdev.class_id,"nkbd%d",nkbd_num++);
 
 	input_register_device(&nkbd->dev);
 
===== drivers/input/keyboard/sunkbd.c 1.19 vs edited =====
--- 1.19/drivers/input/keyboard/sunkbd.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/keyboard/sunkbd.c	2005-01-18 11:45:37 +01:00
@@ -70,6 +70,8 @@
 #define SUNKBD_RELEASE		0x80
 #define SUNKBD_KEY		0x7f
 
+static int sunkbd_num;
+
 /*
  * Per-keyboard data.
  */
@@ -286,6 +288,7 @@
 	sunkbd->dev.id.product = sunkbd->type;
 	sunkbd->dev.id.version = 0x0100;
 	sunkbd->dev.dev = &serio->dev;
+	sprintf(sunkbd->dev.cdev.class_id,"sunkbd%d", sunkbd_num++);
 
 	input_register_device(&sunkbd->dev);
 
===== drivers/input/keyboard/xtkbd.c 1.12 vs edited =====
--- 1.12/drivers/input/keyboard/xtkbd.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/keyboard/xtkbd.c	2005-01-18 11:46:09 +01:00
@@ -58,6 +58,8 @@
 
 static char *xtkbd_name = "XT Keyboard";
 
+static int xtkbd_num;
+
 struct xtkbd {
 	unsigned char keycode[256];
 	struct input_dev dev;
@@ -132,6 +134,7 @@
 	xtkbd->dev.id.product = 0x0001;
 	xtkbd->dev.id.version = 0x0100;
 	xtkbd->dev.dev = &serio->dev;
+	sprintf(xtkbd->dev.cdev.class_id,"xtkbd%d",xtkbd_num++);
 
 	input_register_device(&xtkbd->dev);
 
===== drivers/input/misc/m68kspkr.c 1.2 vs edited =====
--- 1.2/drivers/input/misc/m68kspkr.c	2002-10-07 10:39:44 +02:00
+++ edited/drivers/input/misc/m68kspkr.c	2005-01-18 11:35:53 +01:00
@@ -66,6 +66,7 @@
 	m68kspkr_dev.id.vendor = 0x001f;
 	m68kspkr_dev.id.product = 0x0001;
 	m68kspkr_dev.id.version = 0x0100;
+	sprintf(m68kspkr_dev.cdev.class_id,"m68kspeaker");
 
 	input_register_device(&m68kspkr_dev);
 
===== drivers/input/misc/pcspkr.c 1.5 vs edited =====
--- 1.5/drivers/input/misc/pcspkr.c	2004-05-11 05:42:10 +02:00
+++ edited/drivers/input/misc/pcspkr.c	2005-01-18 11:35:53 +01:00
@@ -78,6 +78,7 @@
 	pcspkr_dev.id.vendor = 0x001f;
 	pcspkr_dev.id.product = 0x0001;
 	pcspkr_dev.id.version = 0x0100;
+	sprintf(pcspkr_dev.cdev.class_id,"pcspeaker");
 
 	input_register_device(&pcspkr_dev);
 
===== drivers/input/misc/sparcspkr.c 1.3 vs edited =====
--- 1.3/drivers/input/misc/sparcspkr.c	2004-04-23 04:50:37 +02:00
+++ edited/drivers/input/misc/sparcspkr.c	2005-01-18 11:35:53 +01:00
@@ -26,6 +26,7 @@
 static char *sparcspkr_ebus_name = "Sparc EBUS Speaker";
 static char *sparcspkr_phys = "sparc/input0";
 static struct input_dev sparcspkr_dev;
+static int sparcspkr_num;
 
 spinlock_t beep_lock = SPIN_LOCK_UNLOCKED;
 
@@ -88,6 +89,7 @@
 
 	sparcspkr_dev.name = sparcspkr_ebus_name;
 	sparcspkr_dev.event = ebus_spkr_event;
+	sprintf(sparcspkr_dev.cdev.class_id,"sparcspeaker%d", sparcspkr_num++);
 
 	input_register_device(&sparcspkr_dev);
 
@@ -142,6 +144,7 @@
 	sparcspkr_dev.name = sparcspkr_isa_name;
 	sparcspkr_dev.event = isa_spkr_event;
 	sparcspkr_dev.id.bustype = BUS_ISA;
+	sprintf(sparcspkr_dev.cdev.class_id,"sparcspeaker%d", sparcspkr_num++);
 
 	input_register_device(&sparcspkr_dev);
 
===== drivers/input/mouse/amimouse.c 1.8 vs edited =====
--- 1.8/drivers/input/mouse/amimouse.c	2003-05-06 15:50:50 +02:00
+++ edited/drivers/input/mouse/amimouse.c	2005-01-18 11:35:53 +01:00
@@ -121,6 +121,7 @@
 	amimouse_dev.id.vendor = 0x0001;
 	amimouse_dev.id.product = 0x0002;
 	amimouse_dev.id.version = 0x0100;
+	sprintf(amimouse_dev.cdev.class_id,"amimouse");
 
 	input_register_device(&amimouse_dev);
 
===== drivers/input/mouse/inport.c 1.10 vs edited =====
--- 1.10/drivers/input/mouse/inport.c	2004-03-03 01:36:23 +01:00
+++ edited/drivers/input/mouse/inport.c	2005-01-18 11:35:53 +01:00
@@ -126,6 +126,9 @@
         	.product = 0x0001,
         	.version = 0x0100,
 	},
+	.cdev = {
+		.class_id = "inport",
+	},
 };
 
 static irqreturn_t inport_interrupt(int irq, void *dev_id, struct pt_regs *regs)
===== drivers/input/mouse/logibm.c 1.11 vs edited =====
--- 1.11/drivers/input/mouse/logibm.c	2004-03-03 01:36:23 +01:00
+++ edited/drivers/input/mouse/logibm.c	2005-01-18 11:35:53 +01:00
@@ -116,6 +116,9 @@
 		.product = 0x0001,
 		.version = 0x0100,
 	},
+	.cdev    = {
+		.class_id  = "logibm",
+	},
 };
 
 static irqreturn_t logibm_interrupt(int irq, void *dev_id, struct pt_regs *regs)
===== drivers/input/mouse/maplemouse.c 1.4 vs edited =====
--- 1.4/drivers/input/mouse/maplemouse.c	2004-03-23 11:05:27 +01:00
+++ edited/drivers/input/mouse/maplemouse.c	2005-01-18 11:35:53 +01:00
@@ -20,6 +20,7 @@
 	int open;
 };
 
+static int dc_mouse_num;
 
 static void dc_mouse_callback(struct mapleq *mq)
 {
@@ -83,6 +84,7 @@
 
 	mouse->dev.name = dev->product_name;
 	mouse->dev.id.bustype = BUS_MAPLE;
+	sprintf(mouse->dev.cdev.class_id,"dcmouse%d", dc_mouse_num++);
 	
 	input_register_device(&mouse->dev);
 
===== drivers/input/mouse/pc110pad.c 1.11 vs edited =====
--- 1.11/drivers/input/mouse/pc110pad.c	2004-11-07 23:43:42 +01:00
+++ edited/drivers/input/mouse/pc110pad.c	2005-01-18 14:01:26 +01:00
@@ -155,6 +155,7 @@
 	pc110pad_dev.id.vendor = 0x0003;
 	pc110pad_dev.id.product = 0x0001;
 	pc110pad_dev.id.version = 0x0100;
+	sprintf(pc110pad_dev.cdev.class_id,"pc110pad");
 
 	input_register_device(&pc110pad_dev);	
 
===== drivers/input/mouse/psmouse-base.c 1.81 vs edited =====
--- 1.81/drivers/input/mouse/psmouse-base.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/mouse/psmouse-base.c	2005-01-18 12:03:28 +01:00
@@ -64,6 +64,8 @@
 
 static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "ThinkPS/2", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2", "AlpsPS/2" };
 
+static int psmouse_num;
+
 /*
  * psmouse_process_byte() analyzes the PS/2 data stream and reports
  * relevant events to the input module once full packet has arrived.
@@ -738,6 +740,7 @@
 	psmouse->dev.id.vendor = 0x0002;
 	psmouse->dev.id.product = psmouse->type;
 	psmouse->dev.id.version = psmouse->model;
+	sprintf(psmouse->dev.cdev.class_id,"psmouse%d",psmouse_num++);
 
 	input_register_device(&psmouse->dev);
 
===== drivers/input/mouse/rpcmouse.c 1.14 vs edited =====
--- 1.14/drivers/input/mouse/rpcmouse.c	2003-05-13 01:21:24 +02:00
+++ edited/drivers/input/mouse/rpcmouse.c	2005-01-18 11:35:53 +01:00
@@ -47,6 +47,9 @@
 		.product = 0x0001,
 		.version = 0x0100,
 	},
+	.cdev	= {
+		.class_id = "rpcmouse",
+	},
 };
 
 static irqreturn_t rpcmouse_irq(int irq, void *dev_id, struct pt_regs *regs)
===== drivers/input/mouse/sermouse.c 1.14 vs edited =====
--- 1.14/drivers/input/mouse/sermouse.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/mouse/sermouse.c	2005-01-18 11:47:04 +01:00
@@ -47,6 +47,8 @@
 					"Logitech M+ Mouse", "Microsoft MZ Mouse", "Logitech MZ+ Mouse",
 					"Logitech MZ++ Mouse"};
 
+static int sermouse_num;
+
 struct sermouse {
 	struct input_dev dev;
 	signed char buf[8];
@@ -281,6 +283,7 @@
 	sermouse->dev.id.product = c;
 	sermouse->dev.id.version = 0x0100;
 	sermouse->dev.dev = &serio->dev;
+	sprintf(sermouse->dev.cdev.class_id,"sermouse%d", sermouse_num++);
 
 	if (serio_open(serio, drv)) {
 		kfree(sermouse);
===== drivers/input/mouse/vsxxxaa.c 1.7 vs edited =====
--- 1.7/drivers/input/mouse/vsxxxaa.c	2004-10-22 06:51:23 +02:00
+++ edited/drivers/input/mouse/vsxxxaa.c	2005-01-18 11:49:33 +01:00
@@ -109,7 +109,7 @@
 #define VSXXXAA_PACKET_POR	0xa0
 #define MATCH_PACKET_TYPE(data, type)	(((data) & VSXXXAA_PACKET_MASK) == (type))
 
-
+static int vsxxxaa_num;
 
 struct vsxxxaa {
 	struct input_dev dev;
@@ -530,6 +530,7 @@
 	mouse->dev.phys = mouse->phys;
 	mouse->dev.id.bustype = BUS_RS232;
 	mouse->dev.dev = &serio->dev;
+	sprintf(mouse->dev.cdev.class_id,"decmouse%d", vsxxxaa_num++);
 	mouse->serio = serio;
 
 	if (serio_open (serio, drv)) {
===== drivers/input/touchscreen/gunze.c 1.11 vs edited =====
--- 1.11/drivers/input/touchscreen/gunze.c	2004-06-29 08:28:37 +02:00
+++ edited/drivers/input/touchscreen/gunze.c	2005-01-18 11:49:57 +01:00
@@ -49,6 +49,7 @@
 #define	GUNZE_MAX_LENGTH	10
 
 static char *gunze_name = "Gunze AHL-51S TouchScreen";
+static int gunze_num;
 
 /*
  * Per-touchscreen data.
@@ -143,6 +144,7 @@
 	gunze->dev.id.vendor = SERIO_GUNZE;
 	gunze->dev.id.product = 0x0051;
 	gunze->dev.id.version = 0x0100;
+	sprintf(gunze->dev.cdev.class_id,"gunze%d",gunze_num++);
 
 	if (serio_open(serio, drv)) {
 		kfree(gunze);
===== drivers/input/touchscreen/h3600_ts_input.c 1.12 vs edited =====
--- 1.12/drivers/input/touchscreen/h3600_ts_input.c	2004-10-22 06:56:15 +02:00
+++ edited/drivers/input/touchscreen/h3600_ts_input.c	2005-01-18 12:00:30 +01:00
@@ -110,6 +110,8 @@
 	char phys[32];
 };
 
+static int h3600_num;
+
 static irqreturn_t action_button_handler(int irq, void *dev_id, struct pt_regs *regs)
 {
         int down = (GPLR & GPIO_BITSY_ACTION_BUTTON) ? 0 : 1;
@@ -443,6 +445,7 @@
 	ts->dev.id.vendor = SERIO_H3600;
 	ts->dev.id.product = 0x0666;  /* FIXME !!! We can ask the hardware */
 	ts->dev.id.version = 0x0100;
+	sprintf(ts->dev.cdev.class_id,"h3600ts%d", h3600_num++);
 
 	if (serio_open(serio, drv)) {
         	free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, ts);
===== drivers/macintosh/adbhid.c 1.22 vs edited =====
--- 1.22/drivers/macintosh/adbhid.c	2004-09-24 06:44:53 +02:00
+++ edited/drivers/macintosh/adbhid.c	2005-01-18 12:44:21 +01:00
@@ -694,6 +694,7 @@
 	adbhid[id]->input.id.vendor = 0x0001;
 	adbhid[id]->input.id.product = (id << 12) | (default_id << 8) | original_handler_id;
 	adbhid[id]->input.id.version = 0x0100;
+	sprintf(adbhid[id]->input.cdev.class_id,"adbhid%d", id);
 
 	switch (default_id) {
 	case ADB_KEYBOARD:
===== drivers/macintosh/mac_hid.c 1.9 vs edited =====
--- 1.9/drivers/macintosh/mac_hid.c	2003-02-17 00:46:38 +01:00
+++ edited/drivers/macintosh/mac_hid.c	2005-01-18 12:47:08 +01:00
@@ -119,6 +119,7 @@
 	emumousebtn.id.vendor = 0x0001;
 	emumousebtn.id.product = 0x0001;
 	emumousebtn.id.version = 0x0100;
+	sprintf(emumousebtn.cdev.class_id,"emumousebtn");
 
 	input_register_device(&emumousebtn);
 
===== drivers/media/video/ir-kbd-gpio.c 1.7 vs edited =====
--- 1.7/drivers/media/video/ir-kbd-gpio.c	2004-10-28 09:39:55 +02:00
+++ edited/drivers/media/video/ir-kbd-gpio.c	2005-01-18 13:58:40 +01:00
@@ -424,6 +424,8 @@
 	ir->input.phys = ir->phys;
 	ir->input.id.bustype = BUS_PCI;
 	ir->input.id.version = 1;
+	ir->input.dev = dev;
+	sprintf(ir->input.cdev.class_id, "irkbd-gpio-%s", pci_name(sub->core->pci));
 	if (sub->core->pci->subsystem_vendor) {
 		ir->input.id.vendor  = sub->core->pci->subsystem_vendor;
 		ir->input.id.product = sub->core->pci->subsystem_device;
===== drivers/media/video/ir-kbd-i2c.c 1.6 vs edited =====
--- 1.6/drivers/media/video/ir-kbd-i2c.c	2005-01-08 06:44:29 +01:00
+++ edited/drivers/media/video/ir-kbd-i2c.c	2005-01-18 13:56:06 +01:00
@@ -389,6 +389,7 @@
 	ir->input.id.bustype = BUS_I2C;
 	ir->input.name       = ir->c.name;
 	ir->input.phys       = ir->phys;
+	sprintf(ir->input.cdev.class_id, "irkbd-i2c-%02x", addr);
 	input_register_device(&ir->input);
 	printk(DEVNAME ": %s detected at %s [%s]\n",
 	       ir->input.name,ir->input.phys,adap->name);
===== drivers/media/video/saa7134/saa7134-input.c 1.7 vs edited =====
--- 1.7/drivers/media/video/saa7134/saa7134-input.c	2004-11-11 09:36:51 +01:00
+++ edited/drivers/media/video/saa7134/saa7134-input.c	2005-01-18 14:30:00 +01:00
@@ -398,6 +398,7 @@
 		ir->dev.id.vendor  = dev->pci->vendor;
 		ir->dev.id.product = dev->pci->device;
 	}
+	sprintf(ir->dev.cdev.class_id,"irkbd-saa7134-%s", pci_name(dev->pci));
 
 	/* all done */
 	dev->remote = ir;
===== drivers/usb/input/aiptek.c 1.32 vs edited =====
--- 1.32/drivers/usb/input/aiptek.c	2004-12-21 00:43:29 +01:00
+++ edited/drivers/usb/input/aiptek.c	2005-01-18 15:13:35 +01:00
@@ -2102,8 +2102,10 @@
 	 * & a tablet, and the inputX number actually will tell
 	 * us something...
 	 */
-	if (usb_make_path(usbdev, path, 64) > 0)
+	if (usb_make_path(usbdev, path, 64) > 0) {
 		sprintf(aiptek->features.usbPath, "%s/input0", path);
+		sprintf(aiptek->inputdev.cdev.class_id,"aiptek-%s", path);
+	}
 
 	/* Program the input device coordinate capacities. We do not yet
 	 * know what maximum X, Y, and Z values are, so we're putting fake
===== drivers/usb/input/ati_remote.c 1.12 vs edited =====
--- 1.12/drivers/usb/input/ati_remote.c	2004-12-21 02:15:10 +01:00
+++ edited/drivers/usb/input/ati_remote.c	2005-01-18 15:10:47 +01:00
@@ -798,6 +798,7 @@
 		sprintf(ati_remote->name, DRIVER_DESC "(%04x,%04x)",
 			le16_to_cpu(ati_remote->udev->descriptor.idVendor), 
 			le16_to_cpu(ati_remote->udev->descriptor.idProduct));
+	sprintf(ati_remote->input.cdev.class_id,"ati-%s",path);
 
 	/* Device Hardware Initialization - fills in ati_remote->idev from udev. */
 	retval = ati_remote_initialize(ati_remote);
===== drivers/usb/input/hid-input.c 1.27 vs edited =====
--- 1.27/drivers/usb/input/hid-input.c	2005-01-07 23:22:55 +01:00
+++ edited/drivers/usb/input/hid-input.c	2005-01-18 14:47:01 +01:00
@@ -72,6 +72,8 @@
 #define map_key_clear(c)	do { map_key(c); clear_bit(c, bit); } while (0)
 #define map_ff_effect(c)	do { set_bit(c, input->ffbit); } while (0)
 
+static int hidinput_num;
+
 static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
 				     struct hid_usage *usage)
 {
@@ -521,6 +523,7 @@
 	struct hid_report *report;
 	struct list_head *list;
 	struct hid_input *hidinput = NULL;
+	char *ptr;
 	int i, j, k;
 
 	INIT_LIST_HEAD(&hid->inputs);
@@ -568,6 +571,8 @@
 				hidinput->input.id.product = le16_to_cpu(dev->descriptor.idProduct);
 				hidinput->input.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
 				hidinput->input.dev = &hid->intf->dev;
+				usb_make_path(dev,path,64);
+				sprintf(hidinput->input.dev.cdev.class_id,"hid-%s", path);
 			}
 
 			for (i = 0; i < report->maxfield; i++)
===== drivers/usb/input/kbtab.c 1.14 vs edited =====
--- 1.14/drivers/usb/input/kbtab.c	2004-12-21 00:43:29 +01:00
+++ edited/drivers/usb/input/kbtab.c	2005-01-18 14:32:45 +01:00
@@ -179,6 +179,7 @@
 	kbtab->dev.id.product = le16_to_cpu(dev->descriptor.idProduct);
 	kbtab->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
 	kbtab->dev.dev = &intf->dev;
+	snprintf(kbtab->dev.cdev.class_id,BUS_ID_SIZE,"kbtab-%s",path);
 	kbtab->usbdev = dev;
 
 	endpoint = &intf->cur_altsetting->endpoint[0].desc;
===== drivers/usb/input/mtouchusb.c 1.10 vs edited =====
--- 1.10/drivers/usb/input/mtouchusb.c	2004-12-21 00:43:29 +01:00
+++ edited/drivers/usb/input/mtouchusb.c	2005-01-18 15:08:45 +01:00
@@ -227,6 +227,7 @@
         mtouch->input.id.product = le16_to_cpu(udev->descriptor.idProduct);
         mtouch->input.id.version = le16_to_cpu(udev->descriptor.bcdDevice);
         mtouch->input.dev = &intf->dev;
+	sprintf(mtouch->input.cdev.class_id,"mtouch-%s", path);
 
         mtouch->input.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
         mtouch->input.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
===== drivers/usb/input/powermate.c 1.25 vs edited =====
--- 1.25/drivers/usb/input/powermate.c	2004-12-21 00:43:29 +01:00
+++ edited/drivers/usb/input/powermate.c	2005-01-18 15:06:53 +01:00
@@ -396,12 +396,13 @@
 	pm->input.event = powermate_input_event;
 	pm->input.dev = &intf->dev;
 
-	input_register_device(&pm->input);
-
 	usb_make_path(udev, path, 64);
 	snprintf(pm->phys, 64, "%s/input0", path);
 	printk(KERN_INFO "input: %s on %s\n", pm->input.name, pm->input.phys);
+	sprintf(pm->input.cdev.class_id,"pm-%s", path);
 	
+	input_register_device(&pm->input);
+
 	/* force an update of everything */
 	pm->requires_update = UPDATE_PULSE_ASLEEP | UPDATE_PULSE_AWAKE | UPDATE_PULSE_MODE | UPDATE_STATIC_BRIGHTNESS;
 	powermate_pulse_led(pm, 0x80, 255, 0, 1, 0); // set default pulse parameters
===== drivers/usb/input/touchkitusb.c 1.4 vs edited =====
--- 1.4/drivers/usb/input/touchkitusb.c	2004-12-21 00:43:29 +01:00
+++ edited/drivers/usb/input/touchkitusb.c	2005-01-18 15:16:24 +01:00
@@ -215,6 +215,7 @@
 	touchkit->input.id.product = le16_to_cpu(udev->descriptor.idProduct);
 	touchkit->input.id.version = le16_to_cpu(udev->descriptor.bcdDevice);
 	touchkit->input.dev = &intf->dev;
+	sprintf(touchkit->input.cdev.class_id,"touchkit-%s", path);
 
 	touchkit->input.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 	touchkit->input.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
===== drivers/usb/input/usbkbd.c 1.37 vs edited =====
--- 1.37/drivers/usb/input/usbkbd.c	2004-12-21 00:43:29 +01:00
+++ edited/drivers/usb/input/usbkbd.c	2005-01-18 15:17:52 +01:00
@@ -300,6 +300,7 @@
 	kbd->dev.id.product = le16_to_cpu(dev->descriptor.idProduct);
 	kbd->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
 	kbd->dev.dev = &iface->dev;
+	sprintf(kbd->dev.cdev.class_id,"kbd-%s", path);
 
 	if (!(buf = kmalloc(63, GFP_KERNEL))) {
 		usb_free_urb(kbd->irq);
===== drivers/usb/input/usbmouse.c 1.32 vs edited =====
--- 1.32/drivers/usb/input/usbmouse.c	2004-12-21 00:43:29 +01:00
+++ edited/drivers/usb/input/usbmouse.c	2005-01-18 15:17:18 +01:00
@@ -184,6 +184,7 @@
 	mouse->dev.id.product = le16_to_cpu(dev->descriptor.idProduct);
 	mouse->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
 	mouse->dev.dev = &intf->dev;
+	sprintf(mouse->dev.cdev.class_id,"mouse-%s", path);
 
 	if (!(buf = kmalloc(63, GFP_KERNEL))) {
 		usb_buffer_free(dev, 8, mouse->data, mouse->data_dma);
===== drivers/usb/input/wacom.c 1.41 vs edited =====
--- 1.41/drivers/usb/input/wacom.c	2004-12-21 00:43:29 +01:00
+++ edited/drivers/usb/input/wacom.c	2005-01-18 15:15:34 +01:00
@@ -697,6 +697,7 @@
 	wacom->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
 	wacom->dev.dev = &intf->dev;
 	wacom->usbdev = dev;
+	sprintf(wacom->dev.cdev.class_id,"wacom-%s", path);
 
 	endpoint = &intf->cur_altsetting->endpoint[0].desc;
 
===== drivers/usb/input/xpad.c 1.21 vs edited =====
--- 1.21/drivers/usb/input/xpad.c	2004-12-21 00:43:29 +01:00
+++ edited/drivers/usb/input/xpad.c	2005-01-18 15:14:37 +01:00
@@ -276,6 +276,7 @@
 	
 	usb_make_path(udev, path, 64);
 	snprintf(xpad->phys, 64,  "%s/input0", path);
+	sprintf(xpad->dev.cdev.class_id,"xpad-%s", path);
 	
 	xpad->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 	
===== drivers/usb/media/konicawc.c 1.31 vs edited =====
--- 1.31/drivers/usb/media/konicawc.c	2004-12-21 02:15:10 +01:00
+++ edited/drivers/usb/media/konicawc.c	2005-01-18 15:19:56 +01:00
@@ -849,12 +849,15 @@
 		cam->input.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
 		cam->input.id.product = le16_to_cpu(dev->descriptor.idProduct);
 		cam->input.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
-		input_register_device(&cam->input);
 		
 		usb_make_path(dev, cam->input_physname, 56);
+		sprintf(cam->input.cdev.class_id,"konicawc-%s",
+			cam->input_physname);
 		strcat(cam->input_physname, "/input0");
 		cam->input.phys = cam->input_physname;
 		info("konicawc: %s on %s\n", cam->input.name, cam->input.phys);
+
+		input_register_device(&cam->input);
 #endif
 	}
 
===== net/bluetooth/hidp/core.c 1.2 vs edited =====
--- 1.2/net/bluetooth/hidp/core.c	2004-07-26 19:47:01 +02:00
+++ edited/net/bluetooth/hidp/core.c	2005-01-18 12:59:27 +01:00
@@ -411,6 +411,7 @@
 static inline void hidp_setup_input(struct hidp_session *session, struct hidp_connadd_req *req)
 {
 	struct input_dev *input = session->input;
+	bdaddr_t bdaddr;
 	int i;
 
 	input->private = session;
@@ -420,6 +421,8 @@
 	input->id.product = req->product;
 	input->id.version = req->version;
 
+	baswap(&bdaddr, &session->bdaddr);
+	snprintf(input->cdev.class_id, BUS_ID_SIZE, "hidp_%s", batostr(&bdaddr));
 	if (req->subclass & 0x40) {
 		set_bit(EV_KEY, input->evbit);
 		set_bit(EV_LED, input->evbit);
===== sound/oss/dmasound/dmasound_awacs.c 1.22 vs edited =====
--- 1.22/sound/oss/dmasound/dmasound_awacs.c	2004-11-27 20:02:02 +01:00
+++ edited/sound/oss/dmasound/dmasound_awacs.c	2005-01-18 13:50:30 +01:00
@@ -2820,6 +2820,9 @@
 	.id		= {
 		.bustype	= BUS_HOST,
 	},
+	.cdev		= {
+		.class_id	= "dmasound_awacs",
+	},
 };
 
 int __init dmasound_awacs_init(void)
===== sound/ppc/beep.c 1.1 vs edited =====
--- 1.1/sound/ppc/beep.c	2004-08-02 16:06:03 +02:00
+++ edited/sound/ppc/beep.c	2005-01-18 13:52:13 +01:00
@@ -39,6 +39,8 @@
 	struct input_dev dev;
 };
 
+static int pmac_beep_num;
+
 /*
  * stop beep if running
  */
@@ -236,6 +238,7 @@
 	beep->dev.id.vendor = 0x001f;
 	beep->dev.id.product = 0x0001;
 	beep->dev.id.version = 0x0100;
+	sprintf(beep->dev.cdev.class_id,"beep%d", pmac_beep_num++);
 
 	beep->volume = BEEP_VOLUME;
 	beep->running = 0;

--------------080100010402050005030101--
