Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSGYOjo>; Thu, 25 Jul 2002 10:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSGYOjo>; Thu, 25 Jul 2002 10:39:44 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:45511 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315218AbSGYOiI>;
	Thu, 25 Jul 2002 10:38:08 -0400
Date: Thu, 25 Jul 2002 01:58:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Subject: [cset] Rusty's C99 update and cli() breakage fixes for input
Message-ID: <20020725015841.A17600@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This changes the input drivers to use C99 initializers and also fixes
the cli() breakage there (safely). It applies on top of the other todays
input update.

===================================================================

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull http://linux-input.bkbits.net:8080/linux-input' should also
work.

===================================================================


ChangeSet@1.441, 2002-07-25 01:47:14+02:00, vojtech@twilight.ucw.cz
  Apply Rusty's C99 initializer patch to input drivers.
  Fix cli() breakage in input (gameport) drivers.


 evbug.c                        |   10 ++++----
 evdev.c                        |   32 +++++++++++++--------------
 gameport/cs461x.c              |    8 +++---
 gameport/emu10k1-gp.c          |    8 +++---
 gameport/fm801-gp.c            |    8 +++---
 gameport/gameport.c            |    5 +---
 gameport/ns558.c               |    4 +--
 gameport/vortex.c              |    8 +++---
 input.c                        |    4 +--
 joydev.c                       |   48 ++++++++++++++++++++---------------------
 joystick/a3d.c                 |    4 +--
 joystick/adi.c                 |    4 +--
 joystick/analog.c              |   14 +++++------
 joystick/cobra.c               |    4 +--
 joystick/gf2k.c                |    4 +--
 joystick/grip.c                |    4 +--
 joystick/guillemot.c           |    4 +--
 joystick/iforce/iforce-serio.c |    8 +++---
 joystick/iforce/iforce-usb.c   |   10 ++++----
 joystick/interact.c            |    4 +--
 joystick/joydump.c             |    4 +--
 joystick/magellan.c            |    6 ++---
 joystick/sidewinder.c          |    4 +--
 joystick/spaceball.c           |    6 ++---
 joystick/spaceorb.c            |    6 ++---
 joystick/stinger.c             |    6 ++---
 joystick/tmdc.c                |    4 +--
 joystick/twidjoy.c             |    6 ++---
 joystick/warrior.c             |    6 ++---
 keybdev.c                      |   14 +++++------
 keyboard/atkbd.c               |    6 ++---
 keyboard/maple_keyb.c          |    8 +++---
 keyboard/newtonkbd.c           |    6 ++---
 keyboard/sunkbd.c              |    6 ++---
 keyboard/xtkbd.c               |    6 ++---
 mouse/inport.c                 |   14 +++++------
 mouse/logibm.c                 |   14 +++++------
 mouse/maplemouse.c             |    8 +++---
 mouse/pc110pad.c               |    3 --
 mouse/psmouse.c                |    6 ++---
 mouse/rpcmouse.c               |   10 ++++----
 mouse/sermouse.c               |    6 ++---
 mousedev.c                     |   44 ++++++++++++++++++-------------------
 power.c                        |   26 +++++++++++-----------
 serio/ct82c710.c               |   12 +++++-----
 serio/i8042.c                  |   48 ++++++++++++++++++++---------------------
 serio/parkbd.c                 |   10 ++++----
 serio/q40kbd.c                 |    8 +++---
 serio/rpckbd.c                 |    8 +++---
 serio/serport.c                |   16 ++++++-------
 touchscreen/gunze.c            |    6 ++---
 touchscreen/h3600_ts_input.c   |    6 ++---
 tsdev.c                        |   28 +++++++++++------------
 uinput.c                       |   20 ++++++++---------
 54 files changed, 288 insertions(+), 294 deletions(-)


diff -Nru a/drivers/input/evbug.c b/drivers/input/evbug.c
--- a/drivers/input/evbug.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/evbug.c	Thu Jul 25 01:55:06 2002
@@ -80,11 +80,11 @@
 MODULE_DEVICE_TABLE(input, evbug_ids);
 	
 static struct input_handler evbug_handler = {
-	event:		evbug_event,
-	connect:	evbug_connect,
-	disconnect:	evbug_disconnect,
-	name:		"evbug",
-	id_table:	evbug_ids,
+	.event =	evbug_event,
+	.connect =	evbug_connect,
+	.disconnect =	evbug_disconnect,
+	.name =		"evbug",
+	.id_table =	evbug_ids,
 };
 
 int __init evbug_init(void)
diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/evdev.c	Thu Jul 25 01:55:06 2002
@@ -399,15 +399,15 @@
 }
 
 static struct file_operations evdev_fops = {
-	owner:		THIS_MODULE,
-	read:		evdev_read,
-	write:		evdev_write,
-	poll:		evdev_poll,
-	open:		evdev_open,
-	release:	evdev_release,
-	ioctl:		evdev_ioctl,
-	fasync:		evdev_fasync,
-	flush:		evdev_flush
+	.owner =	THIS_MODULE,
+	.read =		evdev_read,
+	.write =	evdev_write,
+	.poll =		evdev_poll,
+	.open =		evdev_open,
+	.release =	evdev_release,
+	.ioctl =	evdev_ioctl,
+	.fasync =	evdev_fasync,
+	.flush =	evdev_flush
 };
 
 static struct input_handle *evdev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
@@ -468,13 +468,13 @@
 MODULE_DEVICE_TABLE(input, evdev_ids);
 
 static struct input_handler evdev_handler = {
-	event:		evdev_event,
-	connect:	evdev_connect,
-	disconnect:	evdev_disconnect,
-	fops:		&evdev_fops,
-	minor:		EVDEV_MINOR_BASE,
-	name:		"evdev",
-	id_table:	evdev_ids,
+	.event =	evdev_event,
+	.connect =	evdev_connect,
+	.disconnect =	evdev_disconnect,
+	.fops =		&evdev_fops,
+	.minor =	EVDEV_MINOR_BASE,
+	.name =		"evdev",
+	.id_table =	evdev_ids,
 };
 
 static int __init evdev_init(void)
diff -Nru a/drivers/input/gameport/cs461x.c b/drivers/input/gameport/cs461x.c
--- a/drivers/input/gameport/cs461x.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/gameport/cs461x.c	Thu Jul 25 01:55:06 2002
@@ -312,10 +312,10 @@
 }
 	
 static struct pci_driver cs461x_pci_driver = {
-        name:           "CS461x Gameport",
-        id_table:       cs461x_pci_tbl,
-        probe:          cs461x_pci_probe,
-        remove:         __devexit_p(cs461x_pci_remove),
+        .name =         "CS461x Gameport",
+        .id_table =     cs461x_pci_tbl,
+        .probe =        cs461x_pci_probe,
+        .remove =       __devexit_p(cs461x_pci_remove),
 };
 
 int __init cs461x_init(void)
diff -Nru a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
--- a/drivers/input/gameport/emu10k1-gp.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/gameport/emu10k1-gp.c	Thu Jul 25 01:55:06 2002
@@ -110,10 +110,10 @@
 }
 
 static struct pci_driver emu_driver = {
-        name:           "Emu10k1 Gameport",
-        id_table:       emu_tbl,
-        probe:          emu_probe,
-        remove:         __devexit_p(emu_remove),
+        .name =         "Emu10k1 Gameport",
+        .id_table =     emu_tbl,
+        .probe =        emu_probe,
+        .remove =       __devexit_p(emu_remove),
 };
 
 int __init emu_init(void)
diff -Nru a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
--- a/drivers/input/gameport/fm801-gp.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/gameport/fm801-gp.c	Thu Jul 25 01:55:06 2002
@@ -137,10 +137,10 @@
 };
 
 static struct pci_driver fm801_gp_driver = {
-	name:		"FM801 GP",
-	id_table:	fm801_gp_id_table,
-	probe:		fm801_gp_probe,
-	remove:		fm801_gp_remove,
+	.name =		"FM801 GP",
+	.id_table =	fm801_gp_id_table,
+	.probe =	fm801_gp_probe,
+	.remove =	fm801_gp_remove,
 };
 
 int __init fm801_gp_init(void)
diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/gameport/gameport.c	Thu Jul 25 01:55:06 2002
@@ -94,13 +94,12 @@
 	tx = 1 << 30;
 
 	for(i = 0; i < 50; i++) {
-		save_flags(flags);	/* Yes, all CPUs */
-		cli();
+		local_irq_save(flags);
 		GET_TIME(t1);
 		for(t = 0; t < 50; t++) gameport_read(gameport);
 		GET_TIME(t2);
 		GET_TIME(t3);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		udelay(i * 10);
 		if ((t = DELTA(t2,t1) - DELTA(t3,t2)) < tx) tx = t;
 	}
diff -Nru a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
--- a/drivers/input/gameport/ns558.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/gameport/ns558.c	Thu Jul 25 01:55:06 2002
@@ -163,8 +163,8 @@
 #ifdef __ISAPNP__
 
 #define NS558_DEVICE(a,b,c,d)\
-	card_vendor: ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,\
-	vendor: ISAPNP_VENDOR(a,b,c), function: ISAPNP_DEVICE(d)
+	.card_vendor = ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,\
+	.vendor = ISAPNP_VENDOR(a,b,c), function: ISAPNP_DEVICE(d)
 
 static struct isapnp_device_id pnp_devids[] = {
 	{ NS558_DEVICE('@','P','@',0x0001) }, /* ALS 100 */
diff -Nru a/drivers/input/gameport/vortex.c b/drivers/input/gameport/vortex.c
--- a/drivers/input/gameport/vortex.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/gameport/vortex.c	Thu Jul 25 01:55:06 2002
@@ -165,10 +165,10 @@
  { 0 }};
 
 static struct pci_driver vortex_driver = {
-	name:		"vortex",
-	id_table:	vortex_id_table,
-	probe:		vortex_probe,
-	remove:		vortex_remove,
+	.name =		"vortex",
+	.id_table =	vortex_id_table,
+	.probe =	vortex_probe,
+	.remove =	vortex_remove,
 };
 
 int __init vortex_init(void)
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/input.c	Thu Jul 25 01:55:06 2002
@@ -650,8 +650,8 @@
 }
 
 static struct file_operations input_fops = {
-	owner: THIS_MODULE,
-	open: input_open_file,
+	.owner = THIS_MODULE,
+	.open = input_open_file,
 };
 
 devfs_handle_t input_register_minor(char *name, int minor, int minor_base)
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joydev.c	Thu Jul 25 01:55:06 2002
@@ -402,14 +402,14 @@
 }
 
 static struct file_operations joydev_fops = {
-	owner:		THIS_MODULE,
-	read:		joydev_read,
-	write:		joydev_write,
-	poll:		joydev_poll,
-	open:		joydev_open,
-	release:	joydev_release,
-	ioctl:		joydev_ioctl,
-	fasync:		joydev_fasync,
+	.owner =	THIS_MODULE,
+	.read =		joydev_read,
+	.write =	joydev_write,
+	.poll =		joydev_poll,
+	.open =		joydev_open,
+	.release =	joydev_release,
+	.ioctl =	joydev_ioctl,
+	.fasync =	joydev_fasync,
 };
 
 static struct input_handle *joydev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
@@ -505,19 +505,19 @@
 
 static struct input_device_id joydev_ids[] = {
 	{
-		flags: INPUT_DEVICE_ID_MATCH_EVBIT,
-		evbit: { BIT(EV_KEY) | BIT(EV_ABS) },
-		absbit: { BIT(ABS_X) },
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT(EV_KEY) | BIT(EV_ABS) },
+		.absbit = { BIT(ABS_X) },
 	},
 	{
-		flags: INPUT_DEVICE_ID_MATCH_EVBIT,
-		evbit: { BIT(EV_KEY) | BIT(EV_ABS) },
-		absbit: { BIT(ABS_WHEEL) },
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT(EV_KEY) | BIT(EV_ABS) },
+		.absbit = { BIT(ABS_WHEEL) },
 	},
 	{
-		flags: INPUT_DEVICE_ID_MATCH_EVBIT,
-		evbit: { BIT(EV_KEY) | BIT(EV_ABS) },
-		absbit: { BIT(ABS_THROTTLE) },
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT(EV_KEY) | BIT(EV_ABS) },
+		.absbit = { BIT(ABS_THROTTLE) },
 	},
 	{ }, 	/* Terminating entry */
 };
@@ -525,13 +525,13 @@
 MODULE_DEVICE_TABLE(input, joydev_ids);
 
 static struct input_handler joydev_handler = {
-	event:		joydev_event,
-	connect:	joydev_connect,
-	disconnect:	joydev_disconnect,
-	fops:		&joydev_fops,
-	minor:		JOYDEV_MINOR_BASE,
-	name:		"joydev",
-	id_table:	joydev_ids,
+	.event =	joydev_event,
+	.connect =	joydev_connect,
+	.disconnect =	joydev_disconnect,
+	.fops =		&joydev_fops,
+	.minor =	JOYDEV_MINOR_BASE,
+	.name =		"joydev",
+	.id_table =	joydev_ids,
 };
 
 static int __init joydev_init(void)
diff -Nru a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
--- a/drivers/input/joystick/a3d.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/a3d.c	Thu Jul 25 01:55:06 2002
@@ -378,8 +378,8 @@
 }
 
 static struct gameport_dev a3d_dev = {
-	connect:	a3d_connect,
-	disconnect:	a3d_disconnect,
+	.connect =	a3d_connect,
+	.disconnect =	a3d_disconnect,
 };
 
 int __init a3d_init(void)
diff -Nru a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
--- a/drivers/input/joystick/adi.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/adi.c	Thu Jul 25 01:55:06 2002
@@ -541,8 +541,8 @@
  */
 
 static struct gameport_dev adi_dev = {
-	connect:	adi_connect,
-	disconnect:	adi_disconnect,
+	.connect =	adi_connect,
+	.disconnect =	adi_disconnect,
 };
 
 int __init adi_init(void)
diff -Nru a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
--- a/drivers/input/joystick/analog.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/analog.c	Thu Jul 25 01:55:06 2002
@@ -368,8 +368,7 @@
 	unsigned int i, t, tx, t1, t2, t3;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	GET_TIME(t1);
 #ifdef FAKE_TIME
 	analog_faketime += 830;
@@ -377,19 +376,18 @@
 	udelay(1000);
 	GET_TIME(t2);
 	GET_TIME(t3);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	port->speed = DELTA(t1, t2) - DELTA(t2, t3);
 
 	tx = ~0;
 
 	for (i = 0; i < 50; i++) {
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		GET_TIME(t1);
 		for (t = 0; t < 50; t++) { gameport_read(gameport); GET_TIME(t2); }
 		GET_TIME(t3);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		udelay(i);
 		t = DELTA(t1, t2) - DELTA(t2, t3);
 		if (t < tx) tx = t;
@@ -737,8 +735,8 @@
  */
 
 static struct gameport_dev analog_dev = {
-	connect:	analog_connect,
-	disconnect:	analog_disconnect,
+	.connect =	analog_connect,
+	.disconnect =	analog_disconnect,
 };
 
 #ifndef MODULE
diff -Nru a/drivers/input/joystick/cobra.c b/drivers/input/joystick/cobra.c
--- a/drivers/input/joystick/cobra.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/cobra.c	Thu Jul 25 01:55:06 2002
@@ -235,8 +235,8 @@
 }
 
 static struct gameport_dev cobra_dev = {
-	connect:	cobra_connect,
-	disconnect:	cobra_disconnect,
+	.connect =	cobra_connect,
+	.disconnect =	cobra_disconnect,
 };
 
 int __init cobra_init(void)
diff -Nru a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
--- a/drivers/input/joystick/gf2k.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/gf2k.c	Thu Jul 25 01:55:06 2002
@@ -343,8 +343,8 @@
 }
 
 static struct gameport_dev gf2k_dev = {
-	connect:	gf2k_connect,
-	disconnect:	gf2k_disconnect,
+	.connect =	gf2k_connect,
+	.disconnect =	gf2k_disconnect,
 };
 
 int __init gf2k_init(void)
diff -Nru a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
--- a/drivers/input/joystick/grip.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/grip.c	Thu Jul 25 01:55:06 2002
@@ -408,8 +408,8 @@
 }
 
 static struct gameport_dev grip_dev = {
-	connect:	grip_connect,
-	disconnect:	grip_disconnect,
+	.connect =	grip_connect,
+	.disconnect =	grip_disconnect,
 };
 
 int __init grip_init(void)
diff -Nru a/drivers/input/joystick/guillemot.c b/drivers/input/joystick/guillemot.c
--- a/drivers/input/joystick/guillemot.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/guillemot.c	Thu Jul 25 01:55:06 2002
@@ -265,8 +265,8 @@
 }
 
 static struct gameport_dev guillemot_dev = {
-	connect:	guillemot_connect,
-	disconnect:	guillemot_disconnect,
+	.connect =	guillemot_connect,
+	.disconnect =	guillemot_disconnect,
 };
 
 int __init guillemot_init(void)
diff -Nru a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
--- a/drivers/input/joystick/iforce/iforce-serio.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/iforce/iforce-serio.c	Thu Jul 25 01:55:06 2002
@@ -159,8 +159,8 @@
 }
 
 struct serio_dev iforce_serio_dev = {
-	write_wakeup:	iforce_serio_write_wakeup,
-	interrupt:	iforce_serio_irq,
-	connect:	iforce_serio_connect,
-	disconnect:	iforce_serio_disconnect,
+	.write_wakeup =	iforce_serio_write_wakeup,
+	.interrupt =	iforce_serio_irq,
+	.connect =	iforce_serio_connect,
+	.disconnect =	iforce_serio_disconnect,
 };
diff -Nru a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
--- a/drivers/input/joystick/iforce/iforce-usb.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/iforce/iforce-usb.c	Thu Jul 25 01:55:06 2002
@@ -206,9 +206,9 @@
 MODULE_DEVICE_TABLE (usb, iforce_usb_ids);
 
 struct usb_driver iforce_usb_driver = {
-	owner:		THIS_MODULE,
-	name:		"iforce",
-	probe:		iforce_usb_probe,
-	disconnect:	iforce_usb_disconnect,
-	id_table:	iforce_usb_ids,
+	.owner =	THIS_MODULE,
+	.name =		"iforce",
+	.probe =	iforce_usb_probe,
+	.disconnect =	iforce_usb_disconnect,
+	.id_table =	iforce_usb_ids,
 };
diff -Nru a/drivers/input/joystick/interact.c b/drivers/input/joystick/interact.c
--- a/drivers/input/joystick/interact.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/interact.c	Thu Jul 25 01:55:06 2002
@@ -293,8 +293,8 @@
 }
 
 static struct gameport_dev interact_dev = {
-	connect:	interact_connect,
-	disconnect:	interact_disconnect,
+	.connect =	interact_connect,
+	.disconnect =	interact_disconnect,
 };
 
 int __init interact_init(void)
diff -Nru a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
--- a/drivers/input/joystick/joydump.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/joydump.c	Thu Jul 25 01:55:06 2002
@@ -133,8 +133,8 @@
 }
 
 static struct gameport_dev joydump_dev = {
-	connect:	joydump_connect,
-	disconnect:	joydump_disconnect,
+	.connect =	joydump_connect,
+	.disconnect =	joydump_disconnect,
 };
 
 static int __init joydump_init(void)
diff -Nru a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
--- a/drivers/input/joystick/magellan.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/magellan.c	Thu Jul 25 01:55:06 2002
@@ -192,9 +192,9 @@
  */
 
 static struct serio_dev magellan_dev = {
-	interrupt:	magellan_interrupt,
-	connect:	magellan_connect,
-	disconnect:	magellan_disconnect,
+	.interrupt =	magellan_interrupt,
+	.connect =	magellan_connect,
+	.disconnect =	magellan_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
--- a/drivers/input/joystick/sidewinder.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/sidewinder.c	Thu Jul 25 01:55:06 2002
@@ -743,8 +743,8 @@
 }
 
 static struct gameport_dev sw_dev = {
-	connect:	sw_connect,
-	disconnect:	sw_disconnect,
+	.connect =	sw_connect,
+	.disconnect =	sw_disconnect,
 };
 
 int __init sw_init(void)
diff -Nru a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
--- a/drivers/input/joystick/spaceball.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/spaceball.c	Thu Jul 25 01:55:06 2002
@@ -263,9 +263,9 @@
  */
 
 static struct serio_dev spaceball_dev = {
-	interrupt:	spaceball_interrupt,
-	connect:	spaceball_connect,
-	disconnect:	spaceball_disconnect,
+	.interrupt =	spaceball_interrupt,
+	.connect =	spaceball_connect,
+	.disconnect =	spaceball_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
--- a/drivers/input/joystick/spaceorb.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/spaceorb.c	Thu Jul 25 01:55:06 2002
@@ -207,9 +207,9 @@
  */
 
 static struct serio_dev spaceorb_dev = {
-	interrupt:	spaceorb_interrupt,
-	connect:	spaceorb_connect,
-	disconnect:	spaceorb_disconnect,
+	.interrupt =	spaceorb_interrupt,
+	.connect =	spaceorb_connect,
+	.disconnect =	spaceorb_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
--- a/drivers/input/joystick/stinger.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/stinger.c	Thu Jul 25 01:55:06 2002
@@ -182,9 +182,9 @@
  */
 
 static struct serio_dev stinger_dev = {
-	interrupt:	stinger_interrupt,
-	connect:	stinger_connect,
-	disconnect:	stinger_disconnect,
+	.interrupt =	stinger_interrupt,
+	.connect =	stinger_connect,
+	.disconnect =	stinger_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/joystick/tmdc.c b/drivers/input/joystick/tmdc.c
--- a/drivers/input/joystick/tmdc.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/tmdc.c	Thu Jul 25 01:55:06 2002
@@ -361,8 +361,8 @@
 }
 
 static struct gameport_dev tmdc_dev = {
-	connect:	tmdc_connect,
-	disconnect:	tmdc_disconnect,
+	.connect =	tmdc_connect,
+	.disconnect =	tmdc_disconnect,
 };
 
 int __init tmdc_init(void)
diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/twidjoy.c	Thu Jul 25 01:55:06 2002
@@ -240,9 +240,9 @@
  */
 
 static struct serio_dev twidjoy_dev = {
-	interrupt:	twidjoy_interrupt,
-	connect:	twidjoy_connect,
-	disconnect:	twidjoy_disconnect,
+	.interrupt =	twidjoy_interrupt,
+	.connect =	twidjoy_connect,
+	.disconnect =	twidjoy_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
--- a/drivers/input/joystick/warrior.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/joystick/warrior.c	Thu Jul 25 01:55:06 2002
@@ -194,9 +194,9 @@
  */
 
 static struct serio_dev warrior_dev = {
-	interrupt:	warrior_interrupt,
-	connect:	warrior_connect,
-	disconnect:	warrior_disconnect,
+	.interrupt =	warrior_interrupt,
+	.connect =	warrior_connect,
+	.disconnect =	warrior_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/keybdev.c b/drivers/input/keybdev.c
--- a/drivers/input/keybdev.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/keybdev.c	Thu Jul 25 01:55:06 2002
@@ -197,8 +197,8 @@
 
 static struct input_device_id keybdev_ids[] = {
 	{
-		flags: INPUT_DEVICE_ID_MATCH_EVBIT,
-		evbit: { BIT(EV_KEY) },
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT(EV_KEY) },
 	},	
 	{ }, 	/* Terminating entry */
 };
@@ -206,11 +206,11 @@
 MODULE_DEVICE_TABLE(input, keybdev_ids);
 	
 static struct input_handler keybdev_handler = {
-	event:		keybdev_event,
-	connect:	keybdev_connect,
-	disconnect:	keybdev_disconnect,
-	name:		"keybdev",
-	id_table:	keybdev_ids,
+	.event =	keybdev_event,
+	.connect =	keybdev_connect,
+	.disconnect =	keybdev_disconnect,
+	.name =		"keybdev",
+	.id_table =	keybdev_ids,
 };
 
 static int __init keybdev_init(void)
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/keyboard/atkbd.c	Thu Jul 25 01:55:06 2002
@@ -523,9 +523,9 @@
 
 
 static struct serio_dev atkbd_dev = {
-	interrupt:	atkbd_interrupt,
-	connect:	atkbd_connect,
-	disconnect:	atkbd_disconnect
+	.interrupt =	atkbd_interrupt,
+	.connect =	atkbd_connect,
+	.disconnect =	atkbd_disconnect
 };
 
 #ifndef MODULE
diff -Nru a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
--- a/drivers/input/keyboard/maple_keyb.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/keyboard/maple_keyb.c	Thu Jul 25 01:55:06 2002
@@ -160,10 +160,10 @@
 
 
 static struct maple_driver dc_kbd_driver = {
-	function:	MAPLE_FUNC_KEYBOARD,
-	name:		"Dreamcast keyboard",
-	connect:	dc_kbd_connect,
-	disconnect:	dc_kbd_disconnect,
+	.function =	MAPLE_FUNC_KEYBOARD,
+	.name =		"Dreamcast keyboard",
+	.connect =	dc_kbd_connect,
+	.disconnect =	dc_kbd_disconnect,
 };
 
 
diff -Nru a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
--- a/drivers/input/keyboard/newtonkbd.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/keyboard/newtonkbd.c	Thu Jul 25 01:55:06 2002
@@ -129,9 +129,9 @@
 }
 
 struct serio_dev nkbd_dev = {
-	interrupt:	nkbd_interrupt,
-	connect:	nkbd_connect,
-	disconnect:	nkbd_disconnect
+	.interrupt =	nkbd_interrupt,
+	.connect =	nkbd_connect,
+	.disconnect =	nkbd_disconnect
 };
 
 int __init nkbd_init(void)
diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/keyboard/sunkbd.c	Thu Jul 25 01:55:06 2002
@@ -294,9 +294,9 @@
 }
 
 static struct serio_dev sunkbd_dev = {
-	interrupt:	sunkbd_interrupt,
-	connect:	sunkbd_connect,
-	disconnect:	sunkbd_disconnect
+	.interrupt =	sunkbd_interrupt,
+	.connect =	sunkbd_connect,
+	.disconnect =	sunkbd_disconnect
 };
 
 /*
diff -Nru a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
--- a/drivers/input/keyboard/xtkbd.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/keyboard/xtkbd.c	Thu Jul 25 01:55:06 2002
@@ -137,9 +137,9 @@
 }
 
 struct serio_dev xtkbd_dev = {
-	interrupt:	xtkbd_interrupt,
-	connect:	xtkbd_connect,
-	disconnect:	xtkbd_disconnect
+	.interrupt =	xtkbd_interrupt,
+	.connect =	xtkbd_connect,
+	.disconnect =	xtkbd_disconnect
 };
 
 int __init xtkbd_init(void)
diff -Nru a/drivers/input/mouse/inport.c b/drivers/input/mouse/inport.c
--- a/drivers/input/mouse/inport.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/mouse/inport.c	Thu Jul 25 01:55:06 2002
@@ -108,13 +108,13 @@
 }
 
 static struct input_dev inport_dev = {
-	evbit:		{ BIT(EV_KEY) | BIT(EV_REL) },
-	keybit: 	{ [LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT) },
-	relbit:		{ BIT(REL_X) | BIT(REL_Y) },
-	open:		inport_open,
-	close:		inport_close,
-	name:		INPORT_NAME,
-	phys:		"isa023c/input0",
+	.evbit	= { BIT(EV_KEY) | BIT(EV_REL) },
+	.keybit	= { [LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT) },
+	.relbit	= { BIT(REL_X) | BIT(REL_Y) },
+	.open	= inport_open,
+	.close	= inport_close,
+	.name	= INPORT_NAME,
+	.phys	= "isa023c/input0",
 };
 
 static void inport_interrupt(int irq, void *dev_id, struct pt_regs *regs)
diff -Nru a/drivers/input/mouse/logibm.c b/drivers/input/mouse/logibm.c
--- a/drivers/input/mouse/logibm.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/mouse/logibm.c	Thu Jul 25 01:55:06 2002
@@ -98,13 +98,13 @@
 }
 
 static struct input_dev logibm_dev = {
-	evbit:		{ BIT(EV_KEY) | BIT(EV_REL) },
-	keybit: 	{ [LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT) },
-	relbit:		{ BIT(REL_X) | BIT(REL_Y) },
-	open:		logibm_open,
-	close:		logibm_close,
-	name:		"Logitech bus mouse",
-	phys:		"isa023c/input0",
+	.evbit	= { BIT(EV_KEY) | BIT(EV_REL) },
+	.keybit = { [LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT) },
+	.relbit	= { BIT(REL_X) | BIT(REL_Y) },
+	.open	= logibm_open,
+	.close	= logibm_close,
+	.name	= "Logitech bus mouse",
+	.phys	= "isa023c/input0",
 };
 
 static void logibm_interrupt(int irq, void *dev_id, struct pt_regs *regs)
diff -Nru a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
--- a/drivers/input/mouse/maplemouse.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/mouse/maplemouse.c	Thu Jul 25 01:55:06 2002
@@ -107,10 +107,10 @@
 
 
 static struct maple_driver dc_mouse_driver = {
-	function:	MAPLE_FUNC_MOUSE,
-	name:		"Dreamcast mouse",
-	connect:	dc_mouse_connect,
-	disconnect:	dc_mouse_disconnect,
+	.function =	MAPLE_FUNC_MOUSE,
+	.name =		"Dreamcast mouse",
+	.connect =	dc_mouse_connect,
+	.disconnect =	dc_mouse_disconnect,
 };
 
 
diff -Nru a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
--- a/drivers/input/mouse/pc110pad.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/mouse/pc110pad.c	Thu Jul 25 01:55:06 2002
@@ -95,14 +95,11 @@
 	if (pc110pad_used++)
 		return 0;
 
-	__save_flags(flags);
-	__cli();
 	pc110pad_interrupt(0,0,0);
 	pc110pad_interrupt(0,0,0);
 	pc110pad_interrupt(0,0,0);
 	outb(PC110PAD_ON, pc110pad_io + 2);
 	pc110pad_count = 0;
-	__restore_flags(flags);
 
 	return 0;
 }
diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/mouse/psmouse.c	Thu Jul 25 01:55:06 2002
@@ -613,9 +613,9 @@
 }
 
 static struct serio_dev psmouse_dev = {
-	interrupt:	psmouse_interrupt,
-	connect:	psmouse_connect,
-	disconnect:	psmouse_disconnect
+	.interrupt =	psmouse_interrupt,
+	.connect =	psmouse_connect,
+	.disconnect =	psmouse_disconnect
 };
 
 int __init psmouse_init(void)
diff -Nru a/drivers/input/mouse/rpcmouse.c b/drivers/input/mouse/rpcmouse.c
--- a/drivers/input/mouse/rpcmouse.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/mouse/rpcmouse.c	Thu Jul 25 01:55:06 2002
@@ -36,11 +36,11 @@
 static short rpcmouse_lastx, rpcmouse_lasty;
 
 static struct input_dev rpcmouse_dev = {
-	evbit:		{ BIT(EV_KEY) | BIT(EV_REL) },
-	keybit: 	{ [LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT) },
-	relbit:		{ BIT(REL_X) | BIT(REL_Y) },
-	name:		"Acorn RiscPC Mouse",
-	phys:		"rpcmouse/input0",
+	.evbit	= { BIT(EV_KEY) | BIT(EV_REL) },
+	.keybit = { [LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT) },
+	.relbit	= { BIT(REL_X) | BIT(REL_Y) },
+	.name	= "Acorn RiscPC Mouse",
+	.phys	= "rpcmouse/input0",
 };
 
 static void rpcmouse_irq(int irq, void *dev_id, struct pt_regs *regs)
diff -Nru a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
--- a/drivers/input/mouse/sermouse.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/mouse/sermouse.c	Thu Jul 25 01:55:06 2002
@@ -279,9 +279,9 @@
 }
 
 static struct serio_dev sermouse_dev = {
-	interrupt:	sermouse_interrupt,
-	connect:	sermouse_connect,
-	disconnect:	sermouse_disconnect
+	.interrupt =	sermouse_interrupt,
+	.connect =	sermouse_connect,
+	.disconnect =	sermouse_disconnect
 };
 
 int __init sermouse_init(void)
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/mousedev.c	Thu Jul 25 01:55:06 2002
@@ -414,13 +414,13 @@
 }
 
 struct file_operations mousedev_fops = {
-	owner:		THIS_MODULE,
-	read:		mousedev_read,
-	write:		mousedev_write,
-	poll:		mousedev_poll,
-	open:		mousedev_open,
-	release:	mousedev_release,
-	fasync:		mousedev_fasync,
+	.owner =	THIS_MODULE,
+	.read =		mousedev_read,
+	.write =	mousedev_write,
+	.poll =		mousedev_poll,
+	.open =		mousedev_open,
+	.release =	mousedev_release,
+	.fasync =	mousedev_fasync,
 };
 
 static struct input_handle *mousedev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
@@ -477,17 +477,17 @@
 
 static struct input_device_id mousedev_ids[] = {
 	{
-		flags: INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT | INPUT_DEVICE_ID_MATCH_RELBIT,
-		evbit: { BIT(EV_KEY) | BIT(EV_REL) },
-		keybit: { [LONG(BTN_LEFT)] = BIT(BTN_LEFT) },
-		relbit: { BIT(REL_X) | BIT(REL_Y) },
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT | INPUT_DEVICE_ID_MATCH_RELBIT,
+		.evbit = { BIT(EV_KEY) | BIT(EV_REL) },
+		.keybit = { [LONG(BTN_LEFT)] = BIT(BTN_LEFT) },
+		.relbit = { BIT(REL_X) | BIT(REL_Y) },
 	},	/* A mouse like device, at least one button, two relative axes */
 
 	{
-		flags: INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
-		evbit: { BIT(EV_KEY) | BIT(EV_ABS) },
-		keybit: { [LONG(BTN_TOUCH)] = BIT(BTN_TOUCH) },
-		absbit: { BIT(ABS_X) | BIT(ABS_Y) },
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit = { BIT(EV_KEY) | BIT(EV_ABS) },
+		.keybit = { [LONG(BTN_TOUCH)] = BIT(BTN_TOUCH) },
+		.absbit = { BIT(ABS_X) | BIT(ABS_Y) },
 	},	/* A tablet like device, at least touch detection, two absolute axes */
 
 	{ }, 	/* Terminating entry */
@@ -496,13 +496,13 @@
 MODULE_DEVICE_TABLE(input, mousedev_ids);
 	
 static struct input_handler mousedev_handler = {
-	event:		mousedev_event,
-	connect:	mousedev_connect,
-	disconnect:	mousedev_disconnect,
-	fops:		&mousedev_fops,
-	minor:		MOUSEDEV_MINOR_BASE,
-	name:		"mousedev",
-	id_table:	mousedev_ids,
+	.event =	mousedev_event,
+	.connect =	mousedev_connect,
+	.disconnect =	mousedev_disconnect,
+	.fops =		&mousedev_fops,
+	.minor =	MOUSEDEV_MINOR_BASE,
+	.name =		"mousedev",
+	.id_table =	mousedev_ids,
 };
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
diff -Nru a/drivers/input/power.c b/drivers/input/power.c
--- a/drivers/input/power.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/power.c	Thu Jul 25 01:55:06 2002
@@ -136,18 +136,18 @@
 
 static struct input_device_id power_ids[] = {
 	{
-		flags: INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT,
-		evbit: { BIT(EV_KEY) },
-		keybit: { [LONG(KEY_SUSPEND)] = BIT(KEY_SUSPEND) }
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT(EV_KEY) },
+		.keybit = { [LONG(KEY_SUSPEND)] = BIT(KEY_SUSPEND) }
 	},	
 	{
-		flags: INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT,
-		evbit: { BIT(EV_KEY) },
-		keybit: { [LONG(KEY_POWER)] = BIT(KEY_POWER) }
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT(EV_KEY) },
+		.keybit = { [LONG(KEY_POWER)] = BIT(KEY_POWER) }
 	},	
 	{
-		flags: INPUT_DEVICE_ID_MATCH_EVBIT,
-		evbit: { BIT(EV_PWR) },
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT(EV_PWR) },
 	},	
 	{ }, 	/* Terminating entry */
 };
@@ -155,11 +155,11 @@
 MODULE_DEVICE_TABLE(input, power_ids);
 	
 static struct input_handler power_handler = {
-	event:		power_event,
-	connect:	power_connect,
-	disconnect:	power_disconnect,
-	name:		"power",
-	id_table:	power_ids,
+	.event =	power_event,
+	.connect =	power_connect,
+	.disconnect =	power_disconnect,
+	.name =		"power",
+	.id_table =	power_ids,
 };
 
 static int __init power_init(void)
diff -Nru a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
--- a/drivers/input/serio/ct82c710.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/serio/ct82c710.c	Thu Jul 25 01:55:06 2002
@@ -141,12 +141,12 @@
 
 static struct serio ct82c710_port =
 {
-	type:	SERIO_8042,
-	name:	ct82c710_name,
-	phys:	ct82c710_phys,
-	write:	ct82c710_write,
-	open:	ct82c710_open,
-	close:	ct82c710_close,
+	.type	= SERIO_8042,
+	.name	= ct82c710_name,
+	.phys	= ct82c710_phys,
+	.write	= ct82c710_write,
+	.open	= ct82c710_open,
+	.close	= ct82c710_close,
 };
 
 /*
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/serio/i8042.c	Thu Jul 25 01:55:06 2002
@@ -296,41 +296,41 @@
  */
 
 static struct i8042_values i8042_kbd_values = {
-	irq:		I8042_KBD_IRQ,
-	irqen:		I8042_CTR_KBDINT,
-	disable:	I8042_CTR_KBDDIS,
-	name:		"KBD",
-	exists:		0,
+	.irq =		I8042_KBD_IRQ,
+	.irqen =	I8042_CTR_KBDINT,
+	.disable =	I8042_CTR_KBDDIS,
+	.name =		"KBD",
+	.exists =	0,
 };
 
 static struct serio i8042_kbd_port =
 {
-	type:		SERIO_8042,
-	write:		i8042_kbd_write,
-	open:		i8042_open,
-	close:		i8042_close,
-	driver:		&i8042_kbd_values,
-	name:		"i8042 Kbd Port",
-	phys:		I8042_KBD_PHYS_DESC,
+	.type =		SERIO_8042,
+	.write =	i8042_kbd_write,
+	.open =		i8042_open,
+	.close =	i8042_close,
+	.driver =	&i8042_kbd_values,
+	.name =		"i8042 Kbd Port",
+	.phys =		I8042_KBD_PHYS_DESC,
 };
 
 static struct i8042_values i8042_aux_values = {
-	irq:		I8042_AUX_IRQ,
-	irqen:		I8042_CTR_AUXINT,
-	disable:	I8042_CTR_AUXDIS,
-	name:		"AUX",
-	exists:		0,
+	.irq =		I8042_AUX_IRQ,
+	.irqen =	I8042_CTR_AUXINT,
+	.disable =	I8042_CTR_AUXDIS,
+	.name =		"AUX",
+	.exists =	0,
 };
 
 static struct serio i8042_aux_port =
 {
-	type:		SERIO_8042,
-	write:		i8042_aux_write,
-	open:		i8042_open,
-	close:		i8042_close,
-	driver:		&i8042_aux_values,
-	name:		"i8042 Aux Port",
-	phys:		I8042_AUX_PHYS_DESC,
+	.type =		SERIO_8042,
+	.write =	i8042_aux_write,
+	.open =		i8042_open,
+	.close =	i8042_close,
+	.driver =	&i8042_aux_values,
+	.name =		"i8042 Aux Port",
+	.phys =		I8042_AUX_PHYS_DESC,
 };
 
 /*
diff -Nru a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
--- a/drivers/input/serio/parkbd.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/serio/parkbd.c	Thu Jul 25 01:55:06 2002
@@ -97,11 +97,11 @@
 
 static struct serio parkbd_port =
 {
-	write:	parkbd_write,
-	open:	parkbd_open,
-	close:	parkbd_close,
-	name:	parkbd_name,
-	phys:	parkbd_phys,
+	.write	= parkbd_write,
+	.open	= parkbd_open,
+	.close	= parkbd_close,
+	.name	= parkbd_name,
+	.phys	= parkbd_phys,
 };
 
 static void parkbd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
diff -Nru a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
--- a/drivers/input/serio/q40kbd.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/serio/q40kbd.c	Thu Jul 25 01:55:06 2002
@@ -49,10 +49,10 @@
 
 static struct serio q40kbd_port =
 {
-	type:   SERIO_8042,
-	write:  NULL,
-	name:	"Q40 PS/2 kbd port",
-	phys:	"isa0060/serio0",
+	.type	= SERIO_8042,
+	.write	= NULL,
+	.name	= "Q40 PS/2 kbd port",
+	.phys	= "isa0060/serio0",
 };
 
 static void q40kbd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
diff -Nru a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
--- a/drivers/input/serio/rpckbd.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/serio/rpckbd.c	Thu Jul 25 01:55:06 2002
@@ -55,10 +55,10 @@
 
 static struct serio rpckbd_port =
 {
-	type:	SERIO_8042,
-	write:	rpckbd_write,
-	name: 	"RiscPC PS/2 kbd port",
-	phys:	"rpckbd/serio0",
+	.type	= SERIO_8042,
+	.write	= rpckbd_write,
+	.name	= "RiscPC PS/2 kbd port",
+	.phys	= "rpckbd/serio0",
 };
 
 static void rpckbd_rx(int irq, void *dev_id, struct pt_regs *regs)
diff -Nru a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
--- a/drivers/input/serio/serport.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/serio/serport.c	Thu Jul 25 01:55:06 2002
@@ -216,14 +216,14 @@
  */
 
 static struct tty_ldisc serport_ldisc = {
-	name:		"input",
-	open:		serport_ldisc_open,
-	close:		serport_ldisc_close,
-	read:		serport_ldisc_read,
-	ioctl:		serport_ldisc_ioctl,
-	receive_buf:	serport_ldisc_receive,
-	receive_room:	serport_ldisc_room,
-	write_wakeup:	serport_ldisc_write_wakeup
+	.name =		"input",
+	.open =		serport_ldisc_open,
+	.close =	serport_ldisc_close,
+	.read =		serport_ldisc_read,
+	.ioctl =	serport_ldisc_ioctl,
+	.receive_buf =	serport_ldisc_receive,
+	.receive_room =	serport_ldisc_room,
+	.write_wakeup =	serport_ldisc_write_wakeup
 };
 
 /*
diff -Nru a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
--- a/drivers/input/touchscreen/gunze.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/touchscreen/gunze.c	Thu Jul 25 01:55:06 2002
@@ -154,9 +154,9 @@
  */
 
 static struct serio_dev gunze_dev = {
-	interrupt:	gunze_interrupt,
-	connect:	gunze_connect,
-	disconnect:	gunze_disconnect,
+	.interrupt =	gunze_interrupt,
+	.connect =	gunze_connect,
+	.disconnect =	gunze_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/touchscreen/h3600_ts_input.c	Thu Jul 25 01:55:06 2002
@@ -461,9 +461,9 @@
  */
 
 static struct serio_dev h3600ts_dev = {
-	interrupt:	h3600ts_interrupt,
-	connect:	h3600ts_connect,
-	disconnect:	h3600ts_disconnect,
+	.interrupt =	h3600ts_interrupt,
+	.connect =	h3600ts_connect,
+	.disconnect =	h3600ts_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/tsdev.c	Thu Jul 25 01:55:06 2002
@@ -218,13 +218,13 @@
 }
 
 struct file_operations tsdev_fops = {
-	owner:		THIS_MODULE,
-	open:		tsdev_open,
-	release:	tsdev_release,
-	read:		tsdev_read,
-	poll:		tsdev_poll,
-	fasync:		tsdev_fasync,
-	ioctl:		tsdev_ioctl,
+	.owner =	THIS_MODULE,
+	.open =		tsdev_open,
+	.release =	tsdev_release,
+	.read =		tsdev_read,
+	.poll =		tsdev_poll,
+	.fasync =	tsdev_fasync,
+	.ioctl =	tsdev_ioctl,
 };
 
 static void tsdev_event(struct input_handle *handle, unsigned int type,
@@ -411,13 +411,13 @@
 MODULE_DEVICE_TABLE(input, tsdev_ids);
 
 static struct input_handler tsdev_handler = {
-	event:		tsdev_event,
-	connect:	tsdev_connect,
-	disconnect:	tsdev_disconnect,
-	fops:		&tsdev_fops,
-	minor:		TSDEV_MINOR_BASE,
-	name:		"tsdev",
-	id_table:	tsdev_ids,
+	.event =	tsdev_event,
+	.connect =	tsdev_connect,
+	.disconnect =	tsdev_disconnect,
+	.fops =		&tsdev_fops,
+	.minor =	TSDEV_MINOR_BASE,
+	.name =		"tsdev",
+	.id_table =	tsdev_ids,
 };
 
 static int __init tsdev_init(void)
diff -Nru a/drivers/input/uinput.c b/drivers/input/uinput.c
--- a/drivers/input/uinput.c	Thu Jul 25 01:55:06 2002
+++ b/drivers/input/uinput.c	Thu Jul 25 01:55:06 2002
@@ -351,20 +351,20 @@
 }
 
 struct file_operations uinput_fops = {
-	owner:		THIS_MODULE,
-	open:		uinput_open,
-	release:	uinput_close,
-	read:		uinput_read,
-	write:		uinput_write,
-	poll:		uinput_poll,
+	.owner =	THIS_MODULE,
+	.open =		uinput_open,
+	.release =	uinput_close,
+	.read =		uinput_read,
+	.write =	uinput_write,
+	.poll =		uinput_poll,
 //	fasync:		uinput_fasync,
-	ioctl:		uinput_ioctl,
+	.ioctl =	uinput_ioctl,
 };
 
 static struct miscdevice uinput_misc = {
-	fops:		&uinput_fops,
-	minor:		UINPUT_MINOR,
-	name:		UINPUT_NAME,
+	.fops =		&uinput_fops,
+	.minor =	UINPUT_MINOR,
+	.name =		UINPUT_NAME,
 };
 
 static int __init uinput_init(void)

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch17566
M'XL(`%H^/ST``]1=>7/<.';_6_H4+&]58M=:$FZ"3CDU'DLS5M979'N2J235
MQ0.4>]SJUG:W)'O#?/<\`&R2S:,%0AZ5/+NE-@'P`2!_>!?>`_\2?%JIY;.]
MZ\4?:Y5^WO]+\&JQ6C_;6]],9]/SS^O#J_3F,/T'E)\M%E!^]'EQH8[*UD?)
MEZ/I_/)JO0_U[^-U^CFX5LO5LSU\2*N2];=+]6SO[.373Z]?G.WO/W\>O/P<
MS\_5![4.GC_?7R^6U_$L6_T4KS_/%O/#]3*>KR[4.CY,%Q=%U;0@"!'X'\<A
M15P46"`6%BG.,(X95ADB3`JV7P[LI];PVW1"P@CF%$<%%93+_>,`'S*&`T2.
M4'A$>(#P,Q8^P^ROB#Q#*!@@&_R5L^``[?\<?-]9O-Q/@Q>7E[-OP=G5:OWM
MGU?!RR@*IO/I>AK/IO]0R^#2/MI%8!Y_D"VG^L$?PGV_3+\&Z6SZ^$F0+%7\
M)3Y7T*9L]O@\OE"7B^7Z27W'WP+*"9;[[^O7LG\P\K_]?12C_7\=>DQ%V9G%
MRM'%XFJECF:+\VER<9B6+P113)%DN,",$U;D$0]3B60N4I%%A-Z%-+QKRD(,
MI*,(<1BF>7C];VI#+OT<+X_^6'Q;K:?IER-U<871%WQP?KDA"J^0("PI+@@+
M&2V(8H3AE$L19VF6"<?Q;MY'3P^;82.X)%P/>S?&^D>>+I)EW!@T#AE"O,!<
M4E'$$5,9$8(SJ8LCQT'W$Z\?,X?W2'P><[IB`G]MCE9BA/1[(P16B2"2AXI'
M84R4BO'81[Q-O7Z\F$02.S_>!LXR==UZL@05@D:,%&E,\YAP%B/,29+$8^#;
M(%L_4[ADU!,#\Q7GLHL!1&')%5E&\RAC,E4ICV28CGVJ6\0;F"54A",?JKKN
M?Z+`*\-"13+'4<J2+(U9&.6.X]RB60\/R5#PD0SK,L487<99EV512B4J0B%B
MFF6,RCBFF+BR@`'BU9M'@F'ALYK@+[#S9=]RH@(6/Z(1$CD"OD6S5+D.=XA\
M/6#&H2-/J&Y@U<.QD)"\X+%0<9KB.`TIEJX,JP)KFWP#KS!FS;,2&`X,.9F>
M7R[FV>%<K0_CJZ%'`/_(KBYJCHT$CO1O03"1H@CAAR:*@G"/&"RQL4^X3;YF
ML"$/F3-ZOZAOR0)F=7017\[41%^V(0SSCP#$19PPI$(484040L(5$[MZJ`=-
MF70?]'IQE7Y>I4NEYD?G5_-_J/:028$B%@$NTI2&-$=9CFB2<5=..TR_QC'T
M),<_Y;FZ62_F7Y)Z*6/@!@A860%B%@,L<I"^682%(")%Q)7C[NB@YA6(1<)S
MZ<79M&?5$4RC@J5QCFFJE,))G@^KPT-`;I"N5QQ%.$2>8UU=QJE*XMFL1ZH)
M$6H^$2&5A#D\84%BJ48SMW8']3.F$7#J\;"(U\TW5JT[#+H'+I(DBQ1!*L-4
M1*&KLCM`NT8#9B@<*>26EZGY1W>Y@?``)2Q2&#@#J#8APIBEV=V(U^H-9=%8
M`\(PF][!:J4<`1OF2!&)<D458C'/7%?:(/D&+P/6[CQ<=9U<G7=?/0U#6%LD
M3$C,28Q1S@5C7B2K-<68"'VUQ/.<?.EA`()S7LA(1APE*@WCC*1D-`-HTFZL
M)`("TW>TR^EESVA#(ED!^I*,24XI*#:(YF3T:!NTFZN)AI'S.Z^(3?/%,E7E
MS\%*+:>+)A0(BS2#I3C4<&6Y8C"'1(94<?X]NZJG$7%"?-GN-%,WTWFVK526
M?)='$2[R&(%UEL$4PC@5:K3*T^VAN>@HOY/`6"R3GG&'E##-UA")11HE,A$L
M<;4M!^DWM(@P#-U9A7EIFD^VA`7A`C0'`711`1"1.<AEF>",X\A5MO62KM>B
M%)1Y/MSI?*V6<=JGM$NP?XN08883KG+,N)1T-"C:])N*<"C=P5Q+S0'+G1!X
MQEA1'F/*$J$$9N$(6=QKN#,)\FBD9(-_-XV42JHAC@@O5`9JNH@`K!*#MN#*
M)GI)UP)8"N:N[%HL3248CUV4@FP$71?T`Y6A&*<@>S&HYW>@7#]+$8U6:(#@
M@$)#0D!C@9.4QC+A'&G>RUQ-R@'B-3(EDO2NTN)JE71E!8=QTR*38.Q@X+4B
MR4%3'>VZ&^ZHG@*3D;L+9YLEW,1+>(]]8B(B`AZZ3%`4XP0>.U%Y,EK2M<@W
M83S&,EZOFDNVUG0CA(`=I)F4,DJ$3-),Y*ZV\#;-&KH1HNYBH')8Y!?`09M.
M81@D@`!6&2&4R")*%!5Q$F9)1N+$^4$.TZ]424$Q\_7BK"^RM$_21@*4G"P/
M90A\(J1)B$9[G9JD&XY]+B+?P5[$YVHVB^<]`]:N\0*C!*41(5F2)"#/Q@ZX
M3;ZQOJ)0N.LS%=E^V4688/#.4,)R2C*5QB1%KKZ0;:)-)RF1'AKO^=5TIBVG
M=9MWR8)$0D,+%)@49YE48)_E:O3J[W90JS&8"7<Q5J/J9IK!19?9@H'"6)'G
M*%8RPTAD3"6CG0EMZC5L"6?N#_C*_#2]2J!6,:'G'()`B#G'*(["-!:"<-=!
MMHANZ0/N_.IR<=/0V"M&2D.`4)%RI6#]D(2$&&Q=5TU@FV;-2!F(D)&*2KJ6
M)`5$=W45T/@8+])0:0]!$G*%E7*UP0=HUX\0S/FQ*M5EO.S5_#D&F[8(E781
MQ2E+XXPS[FK8]I*NV1"'O[X^0YIUV2;`$L1GE&88T"UIFL/24:,738-TS9%`
MN(]X^95_;'4U[W&^P?JCH>3`-46<`N=,H#BFH>M3':+>=!*AR-=>5<O^;1#$
MJ=904IH)&+7D29Y1Y[T;"X06[29@HQ$>CG+?:C6@72,ID"B2$)02F5$)RC6H
M>JXHZ*==<WD11NXV5?6BOO:Y8+7OD7"PJA*5<$)`+^%2*%<F-4"[:08(#[7O
M&OZHKUVE#T:*<)&C'(.)!>I4#K`=K?.UB#?VP4&-@K'^L9I>7"SFJY\^J^E*
MS1.U/+>8O9XNUU?QK$<ML<#Z.T-;VQZ($*3##(`P&%HD1VF>DY#P'%8<=56D
M>DDWQ)3D[F96<]/G,Q4(3=:K24NJPJ`!&*Q`&/.PD+$(H:]4$J0BCEP]\PX=
M-1P$L%1&JH%;I!I:(!C(O""9!!40U.P,='N5N_JR>H>'"JKW[7S%PSR>+<Y[
MF%@445KD<<QC'">,")(29[$[0+U^H"!V.3)Q9K?MJ^KPLS]SP_>[$)=:ZF%B
M0M1()T`-WQ:@1H(#\J?$I[4BTDPDF=V8?A<<+&_,_P\.]M_?^A8\HLV.,14!
MV3\%`0X_>S"'^5REZ^#Y7DEU4I8\A<ILNNK6UX5/>Z"RS70T3.Z)*7[O?D*M
MR(?8%SPL.&#W!A[+RW>"9WNJ/L`!I9GMGW(.?_<.=63JWO/@P\G9Z;N)=CEJ
MN-PLIVM=^O;3Z]?Z>@YR$RX?_3M#P?L/1R2`O@,M2!_IVLO/WU:Z=KJ*$1+(
MCA`]Z@-5)Q!-X^I/CI$;C(=UCI%#'(PX'2.'J4&1[*`(/2@4V6B^G2CJS-8'
M2!1K#)U2+.$G*/\S8`F>;RZ#1R\_Z!Z"7\L>`1=5TVDV6<?);-/<CF5RF4XG
MZV36:'>Y7"0-FHUVIJ;1<JDN%M=UT\DD4]?JZW0]N7S<N,NV>K(3H<UH5"^4
MC@^8'8O4_H!9BU;=46C0&CYPM-K07C>T-F?L)3,QU8C%6.Q"[(GMQ06R,*#=
M6-4-1H!4-]^!SF[DH1<T1X9%.N)R5UBD!273&S<&E&*\(*;!`;TW4-H`3C<M
MKIJN%R(E#R@@4H;PLW=H]GF75Y=:3ROI3JJRIUMJWJ9Z2,W;U.]6\[:=3;<G
MH]S9"3863"TGF`42#RDHBAI(T7CN=L_F@';7N0')3-5+$$NL30$J2<L4`(J#
M^-!UKMC0P8O>V'`/JAR-C>V@2HL-BA"RV4RXF\STL,!AXS\=P:'GZJ7N,Z;!
MP1EO@R.;#H,#ZES!4?H@O/$QRD,R&B(=#XE%B:"<1A8E=+PL$L&!O#>46&>.
M(TK*Z7IQD=!RD9`$>']OMDCCV62Z_/MD%5^KQ_DL/E\]^1?-:Q!4G]J?1JNE
M6L'CV&H86J8D=<-A>A$Q],S/WBZ"``M-,&2X#60SZ6$LVVI'.)<)7;YH'I5L
M-A;,G62S4AHB(:TTQ.BA>\=,7IP;ELO9^D"94*FA0FC4@HJA.8@46[L;*#V)
M-+Y8&9GI,]8\[&3ZZ*U48'M@'`I,A:\K@]RG'FYSDMR,PWJ^/I")#+>*=C,K
MC*AF5O9G%[/:P6!L(+@W9D:$J(]E+^T0]5*?`NA%`[KVPV(N-IC>C;G8N7J)
M26;\[I2U_>Z:Y"!K,96.(L@&WWLC9$1:P&B$M-("+$(0://A#X$0D[_@"!`S
M51^`,&ST*(;;UI@F.0P07>D(D#H:W!<D8^/5QP*E+UY]8[H+,F2Z/RRPV,AZ
M-[34\_525R+#4DC49BD;LH.HJ1HX(J<.Q?1%SLA8T;'`Z8L5+8$3\9++=)66
MA^4\M%&M;L"IY^OE/8RL]S#J>@\WA(?<AU7]$+2J!H[Z<'D*@B^N1IW0,%85
M[IS04&Z2$/C'#^%&M&=)N.G!Y62]\"1L3($H&5&\S";7:IXMEL'SX/3#B_=O
MWT]>O/U]<GK\-#"5F;J>INI9J^Z_X=[V;;^=O#U^=_8X?IH\39\\#?*K>;J>
M+N;5K<<GOYV^/'F</1F,1:B"]GPA-C*BT!%D_1&%&/X@IC$F*(M\V9:\3S^3
MC7UT"#ZHYNHEZW`42)!U1,#/7KGWMK?WR'1@X@D6EVJNB\IN)C/-@":ZU'"P
MV6*E[]BN-:6Z>JGBK'NS+M6UTT6ZGG5N-J7VYE3!="?)5=YI5-8UFRT7BXMN
M.RBL8B@F-_$7=779:=2LW+G-U\@%]4;]Z(S5T?M]O1FKI=0&\U'^(+XIDUSK
MN.?7F++/*@BM$1EVC,C5S?"&WHVKEM<XNL$;-6./EQ@-FK[C)4J/@Y3BQ]#T
M[$$8CI"I)^S%-T$T@ZI'A.QN%&\H#VX55PT&L56U&`,QD^U])X2-R$?W`E@K
M'[T,0P@YB09B8QX6OFSF_`A\F?GZB65DX(5)/[R`\$YTZ?J=X-(-'+%E$QQ]
M<34B\W(LI-J9EV5@(.>E-_W!BSB;).J&)SM9+P^I,#O.5+1WG#7)09282D>$
M5,G/OB`9F9P]%B@]R=FEQ2G!GOTA6(]-(W>#2C5=/Q]&:'T848?SE'2'&,^F
M>@A1F_K=H"J/1W1'TM9MG?R3WI,:'?'3.:FQ]*^'G-KD!]P-8+_53X%%<(#%
MO>'&G"JY$S;E++U<ZX@$D7:M(_@!2_%FKI;PHC^^.OTP>?/N^-/KDZ8-:#JJ
M;#]C<T&Q+357)GI],9O5C?55TP:UI1O;<ZEF*E[51,KKIF5I*RJ+,H]7W^9I
M56XO3<7L:O6Y+M=7,+T0!R%,+PSA9^]07:OYNFICKK87@*T8@K^M;8(?NEU<
MKO2\_JGL%RYU\<5TKGTU>R>_'9_\-GES^O;=V>3G%Q].-L'_QD(WMQ@+O0Z"
MW<PW6_4MK3*?:NS2&I7:Y;BT.JE=I:G!L1R4W0_+!6BST':NK'*2/BM+<*IE
MMN#,R.QR906ME667A3U)VZR*23Z=J0%1[<56QYWNX"Z7VZ><$&#48,G2<FO;
MZ^TS>/WW%R=O3J*X31[?@;-R[9;3FY;R=LYJ>^JPUK*XPUO+\C9S+8N[W+4B
MWV&O94V7OY85&P9[S)&VDT^Y,6OV-+^-SU?:&_WV_:>/I;-Y<GH\>?/BX\M7
MDY/??C[]^%2W4]?)%)AG\+\!E#P&9OBWD]^?!,7FZL7/'YX$_V=:QLFJV11J
M)O]IZHXYIK9O?H]]_\>KDY/7F_[MW,E]SOWCJ[-W'S^^/BF'0*269,"RMB19
M^99Z1%E9LRMG<5B8;5Y^2YK]V[O?=X@S>U-;GFT`UB_0JB/.QK*UD2>N.?*U
MGA/7,,94%`R8!1W2&&^U,\+@(+P_%X<Y'&XG7ZNFZ>780"9JE"`3-7K7Q:"Q
M35`4<.TJH?!38[L<91^X-U5#Z-[4;\.[0FI9W8;JYJX!K-8'Z8\%Z]B3_1W1
MVCG9OY+#6%)T!P^*5L/N<2O6?(9@)V#KF?K%#X7&"B#4\,Y;1/&FKXXPKBHZ
MXKBJ:0ODJJ(KDAO=5$*Y$KY5925^F40ZT8Y)G6_GMNI`T/37PL+;57UV\MI1
M@)V5`A):ZK53-OVOU^_>_OKXYX]O)Z]/?OGXY'^@4+>O"LH[8-Y-XD!+B_NB
MNBB9`Y.AF7B$_O2)@]0=+[E[)_[QW:>7K[9F;DMV:CI%=;&9.BP6+?-!DVS*
M_`H</8RQJAL,0MDT&)#\-?):LO_-NT\?3G9(_\V-;:9:$1S@JN6ITYJENOIT
MW$^^]B*)$0(NQJ.",1+:;;-N1LNMQ@P/#OC]R7QS1O<M3B(S1Q_^*;5</H5U
MV)3.AEZ_#T57#/M0=.V`7#:578>(OF,`/3V'3KHCR?M$S#O3K[.FB$[?\(38
MO6:5V[,[W0*FZOEZ^:^9$768&5%7H^.7-T`U^/5]&R"FM\GYY6139D2SS1JO
M*\N<\;TJ6;RNLB4[X;4YW\H#7*/.W;HC\7H+#4N.?@A<V1/"W'"UF:U?))XT
MJ`KQ-JHLS3:F;&DOHLJJ+I[*BF$T]1TVZ@XH_[-0[]Y!(W=E8UCP![XS:T]M
M=4Q-J"?L%TEBD^-$.SFNHCN<I%"U<,U4Z/L>@P>([O`)B>_?%:AO*,*1_"&.
ME#+?NG!,8NB;N1_S,D=,86'/F&J%0EKZ$T-_*Q+R:6O[=ZOA=/GW;<5MJW8P
M/Z+9R`NSYESX.R-VQ#'VW[LC0"MG'"-?M-ZK96`/W/>!JYFXGX-PRYTWX&ZI
MXY1-=X^:(K8$&8R@%K-]*-0-MDV)A@AOM!DP'KJ':7O`<MPQWW>EWC@\;2.(
M/4Y;N->X%WL@N6.(U&:Z7KAC9I>(,-Z)>RGI#L6];*H'(ZG*^MW\KOWI-'<P
M>7W0[6ZTS<X&8^9,6GAYGNF#]PLD_>6Y6_<UFG/U.\Q1V+V^;EBPH3J$(5LY
M>&2&J:V+=L&G^<%+#PR-_R+G=^BAF9X@A@S/AZ7'V6^'NN&I.6,__<T>DR>$
MT=\VN5K:K?KB_>N3R2^?WKXTWNEW+\Z.MZ3C\5+%%VF\6@>;P3S:QEV63G8!
MKZQVY%R-SX!Z(&_T5TKOWD$=TH<(IS^$/-1?4W5#76.Z?N<9$Q,'2EF'D\UW
M,++Y+CC-W=G8YA,&'D`:]VV%.U*O61>)Q(^A4MFO0+B!:#-;OS1Z$TE,>B*)
M+=G!#(:KG2@JJ]UP]-5;FQKS;8:[T6X<QB!Q]&-@R'Q%P@U#7_W5*>W,UTR(
M==-@ONY2I[[N5*>^WJY.;7^:T!T]/E]+O`OI1B8#%D.[C0\KPLA^U_'V@(UJ
MJGXG"YO0;8PWH=O)=+UW>R1"N1^_YQ2(4%37;TZ/CW6H75UR=OKKJS)6H0Q5
MV+LE5,&&?>R9:%Z=F;R58%T75YG5Y2'PIV_?OSO[.'G[XLU)^_!W0E/[//L/
M?[</>;8XGR87XR&^N:\C9!DGK,@C'J82R5RD(HN(J[792UK;FDA0?1HR0S99
MASUPB.,H0K=D76Q/U0OBR$(<>4'<+=;F3X*XG78'XF5Q&^*/7D.Y?JM!<K4*
MS(/K?.C`">O-[Z>/Q?OX3[M_)_($-$LI?XS-#?L1>@?<-Z?KQ][M)C^F.RQB
M$W,T8`[7*-HR=DWQ+FO8-MAM#Y>?"DMAD)?Q*-VS?6<;:)12B8I0B)AF&:,R
MCL%"=G7`#!!O;/H3(7TU"'2?RJ=@^!8CN#U7KQ,H];8L<%D>X.&7O/)D)R,_
M4G<GVD:`2O3_U5U+C]LV$+[G5Q@HT%.+\BWJD,-V':!&T-2U=Y'D9,BR-[LH
MNDFM%;`HU/]>/O6@1(FF`R5[,CPCC41J2`Z',]^@"DNDVQ>1[:K+Z85\XN*"
M681!Y:QEL.^L-7)]^PO+]LT4EA^PQSA]R2-UJ+G352+((4HD8L,1@`R)T0TA
MR4,WJ1[ARN4OP;]D,3H06S5BUM-+A$DZ`0?B-C8JOUX=6!*;?O`"S#!K6%WE
MGT^/BXU0TO7UXO>>866[9=JR:JK.GZO$O7KUM1*CA'*Q*NUSG/$]I4!&D9#0
MXWB/\+:GA8#82*2Y/2T\)+^AU=@H9QU7[E[$^^Y>*]CKKK-\K\/.7C`Z'9KJ
MRN$*=%:)YTMDXHI@0*)-<&&D_@QG/"%0Y:A'%<:T,NY8(-4>.1B<S#B14#&>
MWC64(R%XN^WM=OWFW;*>+-NTQ7_2<TCT>[)O^Y[K/]Z_V73>4E/T.Z8*WI&"
M"W/AUN\W.N<#4B[7(AGPU8ZV5]][*-I>,[Q6C.)ZHNT5TPU\U7=X`F;<ZN3A
M(SVJ9OIEL@U@9%(AFC)?C'U(89+YH#YT=?<`P,BFL7$^>;)@<F2EXL=3L=(8
M&/9!._F_95G4=/F_3I)K,^HD.>,QJAFNSZAF&*^13^T>Y*N=KW/F-E?AL-A1
MH4K8U>*C9#`7:@?O0.@:,R19[=$P2"M"@3F)CMBCS0R!0%@Z%5/3:6O<(:*R
MKC'0YO7#Z1\Y^ZRDP-W;7Y>[U>;/GS1=Y4QJQO7-1C)7[V[,G&:FIPYWN=IV
M)C1!4M/9\?FA>)+I;$!,J&+YETY6#'7BO%1V>?%`?589,ZC$R[.ECOK*&S3+
M!4W5U-K?J;M.T']L)(G/6!Z+;LBC9"[>[@^+=;OF:[=?UK]]W(HE9'LM&P'5
MJH`1ZO?AU>T'?Q\*YD@?"J[;AX(TT(=()=!BC(/[,"N?OU(?2DG>/KPJGWU]
M*/NEU8>^:>5+=CKS?+E[GSNQ4`@9KY*CC-/+<I)G!TIH:(S"H.@:^9C2"V(^
MYXTZI@F<\/YTFQIW?`*4J02(&A1V!=(B>^N/(;NKCR&[)Q:&[*QZAJK7/)]"
MB3UWE$+9^UR%8F)M`978.O,[!#'?PP.%::@_<5!T[0C"')OLPXCSN%G/)3!G
M>")8K]O4J-!/E2'&X'0=;_V41L>L.\8X8OPEO?6-8Q6]GSZ7^7V1GX['QU\^
ME8__GN61&;BYYYY.24HKF.<XP<+BN0-X?Z"AB!-^^0T6+`"F).WW'@%#1)],
M6-L#[8V:J:A&9*3]."HEU>>7T4Q_[ICDCI]DM1MPCQD`NZ=B]]"@R)W_V5TI
MS2(EW<HJGIPF%<]80A#..0+'E(+0\(&`![5`ASEY(1&?'/")XZZQAD=!GC#E
M/"$*X[JK<4J\DCZH<Y;MTSK+G]"[H@;*"?SRA0MDH\]!4@!`Q?(#YSS=,[[/
M#^PN]+QT4"86BI,:Q8EQ!8IE#\ZX04L!GG`%FE9&;<V0"D!!*!D#QK'6NWK0
M`)*-IK=@;"R2CF5H&!T+EJ.I%BFGAKS1Y`;/TP+4:;K!IUL2M8U;B3F@`XFB
M+QIPCVF&-Z^G&$%",2_DP*#<;$<P4-0MKD?--&#8HU:>/1>7SKR+(12=PBJQ
MP4UP=<@HA2!+DSQC#-%0,['TS+$HX?$1!1"(H0)FC4J<&"KE!3,JILIIAJEV
MFDV,%?VD@<%B&+WR*H;N8DX9<@]QRM#U*%IB8;/*DK_JIQDZYB([=B1\.)97
MZ=I6M:*;RUQ-O]5.;*7J;2TW=!VO^.J'Q3I[RN\7^?TQ_ZLH_WY-V&$/4DY>
*_0\Q#2J.!;(`````
`
end

-- 
Vojtech Pavlik
SuSE Labs
