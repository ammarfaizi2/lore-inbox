Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUG2O0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUG2O0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUG2OWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:22:32 -0400
Received: from styx.suse.cz ([82.119.242.94]:27798 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264991AbUG2OIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:14 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 34/47] more renames in serio in preparation for sysfs integration
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <109111019631@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <1091110196468@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1757.15.29, 2004-06-29 01:27:11-05:00, dtor_core@ameritech.net
  Input: more renames in serio in preparations to sysfs integration
         - serio_dev -> serio_driver
         - serio_[un]register_device -> serio_[un]register_driver
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/joystick/iforce/iforce-main.c  |    4 -
 drivers/input/joystick/iforce/iforce-serio.c |    6 +-
 drivers/input/joystick/iforce/iforce.h       |    2 
 drivers/input/joystick/magellan.c            |   10 +--
 drivers/input/joystick/spaceball.c           |   10 +--
 drivers/input/joystick/spaceorb.c            |   10 +--
 drivers/input/joystick/stinger.c             |   10 +--
 drivers/input/joystick/twidjoy.c             |   10 +--
 drivers/input/joystick/warrior.c             |   10 +--
 drivers/input/keyboard/atkbd.c               |   14 ++---
 drivers/input/keyboard/lkkbd.c               |   10 +--
 drivers/input/keyboard/newtonkbd.c           |   10 +--
 drivers/input/keyboard/sunkbd.c              |   10 +--
 drivers/input/keyboard/xtkbd.c               |   10 +--
 drivers/input/mouse/psmouse-base.c           |   14 ++---
 drivers/input/mouse/sermouse.c               |   10 +--
 drivers/input/mouse/synaptics.c              |    2 
 drivers/input/mouse/vsxxxaa.c                |   10 +--
 drivers/input/serio/serio.c                  |   72 +++++++++++++--------------
 drivers/input/serio/serport.c                |    2 
 drivers/input/touchscreen/gunze.c            |   10 +--
 drivers/input/touchscreen/h3600_ts_input.c   |   10 +--
 include/linux/serio.h                        |   22 ++++----
 23 files changed, 139 insertions(+), 139 deletions(-)

===================================================================

diff -Nru a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
--- a/drivers/input/joystick/iforce/iforce-main.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/joystick/iforce/iforce-main.c	Thu Jul 29 14:39:31 2004
@@ -524,7 +524,7 @@
 	usb_register(&iforce_usb_driver);
 #endif
 #ifdef CONFIG_JOYSTICK_IFORCE_232
-	serio_register_device(&iforce_serio_dev);
+	serio_register_driver(&iforce_serio_drv);
 #endif
 	return 0;
 }
@@ -535,7 +535,7 @@
 	usb_deregister(&iforce_usb_driver);
 #endif
 #ifdef CONFIG_JOYSTICK_IFORCE_232
-	serio_unregister_device(&iforce_serio_dev);
+	serio_unregister_driver(&iforce_serio_drv);
 #endif
 }
 
diff -Nru a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
--- a/drivers/input/joystick/iforce/iforce-serio.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/joystick/iforce/iforce-serio.c	Thu Jul 29 14:39:31 2004
@@ -124,7 +124,7 @@
 	return IRQ_HANDLED;
 }
 
-static void iforce_serio_connect(struct serio *serio, struct serio_dev *dev)
+static void iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct iforce *iforce;
 	if (serio->type != (SERIO_RS232 | SERIO_IFORCE))
@@ -137,7 +137,7 @@
 	iforce->serio = serio;
 	serio->private = iforce;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(iforce);
 		return;
 	}
@@ -158,7 +158,7 @@
 	kfree(iforce);
 }
 
-struct serio_dev iforce_serio_dev = {
+struct serio_driver iforce_serio_drv = {
 	.write_wakeup =	iforce_serio_write_wakeup,
 	.interrupt =	iforce_serio_irq,
 	.connect =	iforce_serio_connect,
diff -Nru a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
--- a/drivers/input/joystick/iforce/iforce.h	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/joystick/iforce/iforce.h	Thu Jul 29 14:39:31 2004
@@ -187,5 +187,5 @@
 int iforce_upload_condition(struct iforce*, struct ff_effect*, int is_update);
 
 /* Public variables */
-extern struct serio_dev iforce_serio_dev;
+extern struct serio_driver iforce_serio_drv;
 extern struct usb_driver iforce_usb_driver;
diff -Nru a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
--- a/drivers/input/joystick/magellan.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/joystick/magellan.c	Thu Jul 29 14:39:31 2004
@@ -146,7 +146,7 @@
  * it as an input device.
  */
 
-static void magellan_connect(struct serio *serio, struct serio_dev *dev)
+static void magellan_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct magellan *magellan;
 	int i, t;
@@ -184,7 +184,7 @@
 
 	serio->private = magellan;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(magellan);
 		return;
 	}
@@ -199,7 +199,7 @@
  * The serio device structure.
  */
 
-static struct serio_dev magellan_dev = {
+static struct serio_driver magellan_drv = {
 	.interrupt =	magellan_interrupt,
 	.connect =	magellan_connect,
 	.disconnect =	magellan_disconnect,
@@ -211,13 +211,13 @@
 
 int __init magellan_init(void)
 {
-	serio_register_device(&magellan_dev);
+	serio_register_driver(&magellan_drv);
 	return 0;
 }
 
 void __exit magellan_exit(void)
 {
-	serio_unregister_device(&magellan_dev);
+	serio_unregister_driver(&magellan_drv);
 }
 
 module_init(magellan_init);
diff -Nru a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
--- a/drivers/input/joystick/spaceball.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/joystick/spaceball.c	Thu Jul 29 14:39:31 2004
@@ -201,7 +201,7 @@
  * it as an input device.
  */
 
-static void spaceball_connect(struct serio *serio, struct serio_dev *dev)
+static void spaceball_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct spaceball *spaceball;
 	int i, t, id;
@@ -254,7 +254,7 @@
 
 	serio->private = spaceball;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(spaceball);
 		return;
 	}
@@ -269,7 +269,7 @@
  * The serio device structure.
  */
 
-static struct serio_dev spaceball_dev = {
+static struct serio_driver spaceball_drv = {
 	.interrupt =	spaceball_interrupt,
 	.connect =	spaceball_connect,
 	.disconnect =	spaceball_disconnect,
@@ -281,13 +281,13 @@
 
 int __init spaceball_init(void)
 {
-	serio_register_device(&spaceball_dev);
+	serio_register_driver(&spaceball_drv);
 	return 0;
 }
 
 void __exit spaceball_exit(void)
 {
-	serio_unregister_device(&spaceball_dev);
+	serio_unregister_driver(&spaceball_drv);
 }
 
 module_init(spaceball_init);
diff -Nru a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
--- a/drivers/input/joystick/spaceorb.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/joystick/spaceorb.c	Thu Jul 29 14:39:31 2004
@@ -162,7 +162,7 @@
  * it as an input device.
  */
 
-static void spaceorb_connect(struct serio *serio, struct serio_dev *dev)
+static void spaceorb_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct spaceorb *spaceorb;
 	int i, t;
@@ -201,7 +201,7 @@
 
 	serio->private = spaceorb;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(spaceorb);
 		return;
 	}
@@ -213,7 +213,7 @@
  * The serio device structure.
  */
 
-static struct serio_dev spaceorb_dev = {
+static struct serio_driver spaceorb_drv = {
 	.interrupt =	spaceorb_interrupt,
 	.connect =	spaceorb_connect,
 	.disconnect =	spaceorb_disconnect,
@@ -225,13 +225,13 @@
 
 int __init spaceorb_init(void)
 {
-	serio_register_device(&spaceorb_dev);
+	serio_register_driver(&spaceorb_drv);
 	return 0;
 }
 
 void __exit spaceorb_exit(void)
 {
-	serio_unregister_device(&spaceorb_dev);
+	serio_unregister_driver(&spaceorb_drv);
 }
 
 module_init(spaceorb_init);
diff -Nru a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
--- a/drivers/input/joystick/stinger.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/joystick/stinger.c	Thu Jul 29 14:39:31 2004
@@ -134,7 +134,7 @@
  * it as an input device.
  */
 
-static void stinger_connect(struct serio *serio, struct serio_dev *dev)
+static void stinger_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct stinger *stinger;
 	int i;
@@ -172,7 +172,7 @@
 	stinger->dev.private = stinger;
 	serio->private = stinger;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(stinger);
 		return;
 	}
@@ -187,7 +187,7 @@
  * The serio device structure.
  */
 
-static struct serio_dev stinger_dev = {
+static struct serio_driver stinger_drv = {
 	.interrupt =	stinger_interrupt,
 	.connect =	stinger_connect,
 	.disconnect =	stinger_disconnect,
@@ -199,13 +199,13 @@
 
 int __init stinger_init(void)
 {
-	serio_register_device(&stinger_dev);
+	serio_register_driver(&stinger_drv);
 	return 0;
 }
 
 void __exit stinger_exit(void)
 {
-	serio_unregister_device(&stinger_dev);
+	serio_unregister_driver(&stinger_drv);
 }
 
 module_init(stinger_init);
diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/joystick/twidjoy.c	Thu Jul 29 14:39:31 2004
@@ -187,7 +187,7 @@
  * it as an input device.
  */
 
-static void twidjoy_connect(struct serio *serio, struct serio_dev *dev)
+static void twidjoy_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct twidjoy_button_spec *bp;
 	struct twidjoy *twidjoy;
@@ -232,7 +232,7 @@
 	twidjoy->dev.private = twidjoy;
 	serio->private = twidjoy;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(twidjoy);
 		return;
 	}
@@ -246,7 +246,7 @@
  * The serio device structure.
  */
 
-static struct serio_dev twidjoy_dev = {
+static struct serio_driver twidjoy_drv = {
 	.interrupt =	twidjoy_interrupt,
 	.connect =	twidjoy_connect,
 	.disconnect =	twidjoy_disconnect,
@@ -258,13 +258,13 @@
 
 int __init twidjoy_init(void)
 {
-	serio_register_device(&twidjoy_dev);
+	serio_register_driver(&twidjoy_drv);
 	return 0;
 }
 
 void __exit twidjoy_exit(void)
 {
-	serio_unregister_device(&twidjoy_dev);
+	serio_unregister_driver(&twidjoy_drv);
 }
 
 module_init(twidjoy_init);
diff -Nru a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
--- a/drivers/input/joystick/warrior.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/joystick/warrior.c	Thu Jul 29 14:39:31 2004
@@ -139,7 +139,7 @@
  * it as an input device.
  */
 
-static void warrior_connect(struct serio *serio, struct serio_dev *dev)
+static void warrior_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct warrior *warrior;
 	int i;
@@ -185,7 +185,7 @@
 
 	serio->private = warrior;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(warrior);
 		return;
 	}
@@ -199,7 +199,7 @@
  * The serio device structure.
  */
 
-static struct serio_dev warrior_dev = {
+static struct serio_driver warrior_drv = {
 	.interrupt =	warrior_interrupt,
 	.connect =	warrior_connect,
 	.disconnect =	warrior_disconnect,
@@ -211,13 +211,13 @@
 
 int __init warrior_init(void)
 {
-	serio_register_device(&warrior_dev);
+	serio_register_driver(&warrior_drv);
 	return 0;
 }
 
 void __exit warrior_exit(void)
 {
-	serio_unregister_device(&warrior_dev);
+	serio_unregister_driver(&warrior_drv);
 }
 
 module_init(warrior_init);
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/keyboard/atkbd.c	Thu Jul 29 14:39:31 2004
@@ -732,7 +732,7 @@
  * to the input module.
  */
 
-static void atkbd_connect(struct serio *serio, struct serio_dev *dev)
+static void atkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct atkbd *atkbd;
 	int i;
@@ -785,7 +785,7 @@
 
 	serio->private = atkbd;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(atkbd);
 		return;
 	}
@@ -861,10 +861,10 @@
 static int atkbd_reconnect(struct serio *serio)
 {
 	struct atkbd *atkbd = serio->private;
-	struct serio_dev *dev = serio->dev;
+	struct serio_driver *drv = serio->drv;
 	unsigned char param[1];
 
-	if (!dev) {
+	if (!drv) {
 		printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
 		return -1;
 	}
@@ -890,7 +890,7 @@
 	return 0;
 }
 
-static struct serio_dev atkbd_dev = {
+static struct serio_driver atkbd_drv = {
 	.interrupt =	atkbd_interrupt,
 	.connect =	atkbd_connect,
 	.reconnect = 	atkbd_reconnect,
@@ -900,13 +900,13 @@
 
 int __init atkbd_init(void)
 {
-	serio_register_device(&atkbd_dev);
+	serio_register_driver(&atkbd_drv);
 	return 0;
 }
 
 void __exit atkbd_exit(void)
 {
-	serio_unregister_device(&atkbd_dev);
+	serio_unregister_driver(&atkbd_drv);
 }
 
 module_init(atkbd_init);
diff -Nru a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
--- a/drivers/input/keyboard/lkkbd.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/keyboard/lkkbd.c	Thu Jul 29 14:39:31 2004
@@ -622,7 +622,7 @@
  * lkkbd_connect() probes for a LK keyboard and fills the necessary structures.
  */
 static void
-lkkbd_connect (struct serio *serio, struct serio_dev *dev)
+lkkbd_connect (struct serio *serio, struct serio_driver *drv)
 {
 	struct lkkbd *lk;
 	int i;
@@ -665,7 +665,7 @@
 
 	serio->private = lk;
 
-	if (serio_open (serio, dev)) {
+	if (serio_open (serio, drv)) {
 		kfree (lk);
 		return;
 	}
@@ -703,7 +703,7 @@
 	kfree (lk);
 }
 
-static struct serio_dev lkkbd_dev = {
+static struct serio_driver lkkbd_drv = {
 	.connect = lkkbd_connect,
 	.disconnect = lkkbd_disconnect,
 	.interrupt = lkkbd_interrupt,
@@ -715,14 +715,14 @@
 int __init
 lkkbd_init (void)
 {
-	serio_register_device (&lkkbd_dev);
+	serio_register_driver(&lkkbd_drv);
 	return 0;
 }
 
 void __exit
 lkkbd_exit (void)
 {
-	serio_unregister_device (&lkkbd_dev);
+	serio_unregister_driver(&lkkbd_drv);
 }
 
 module_init (lkkbd_init);
diff -Nru a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
--- a/drivers/input/keyboard/newtonkbd.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/keyboard/newtonkbd.c	Thu Jul 29 14:39:31 2004
@@ -82,7 +82,7 @@
 
 }
 
-void nkbd_connect(struct serio *serio, struct serio_dev *dev)
+void nkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct nkbd *nkbd;
 	int i;
@@ -106,7 +106,7 @@
 	nkbd->dev.private = nkbd;
 	serio->private = nkbd;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(nkbd);
 		return;
 	}
@@ -138,7 +138,7 @@
 	kfree(nkbd);
 }
 
-struct serio_dev nkbd_dev = {
+struct serio_driver nkbd_drv = {
 	.interrupt =	nkbd_interrupt,
 	.connect =	nkbd_connect,
 	.disconnect =	nkbd_disconnect
@@ -146,13 +146,13 @@
 
 int __init nkbd_init(void)
 {
-	serio_register_device(&nkbd_dev);
+	serio_register_driver(&nkbd_drv);
 	return 0;
 }
 
 void __exit nkbd_exit(void)
 {
-	serio_unregister_device(&nkbd_dev);
+	serio_unregister_driver(&nkbd_drv);
 }
 
 module_init(nkbd_init);
diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/keyboard/sunkbd.c	Thu Jul 29 14:39:31 2004
@@ -221,7 +221,7 @@
  * sunkbd_connect() probes for a Sun keyboard and fills the necessary structures.
  */
 
-static void sunkbd_connect(struct serio *serio, struct serio_dev *dev)
+static void sunkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct sunkbd *sunkbd;
 	int i;
@@ -257,7 +257,7 @@
 
 	serio->private = sunkbd;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(sunkbd);
 		return;
 	}
@@ -301,7 +301,7 @@
 	kfree(sunkbd);
 }
 
-static struct serio_dev sunkbd_dev = {
+static struct serio_driver sunkbd_drv = {
 	.interrupt =	sunkbd_interrupt,
 	.connect =	sunkbd_connect,
 	.disconnect =	sunkbd_disconnect
@@ -313,13 +313,13 @@
 
 int __init sunkbd_init(void)
 {
-	serio_register_device(&sunkbd_dev);
+	serio_register_driver(&sunkbd_drv);
 	return 0;
 }
 
 void __exit sunkbd_exit(void)
 {
-	serio_unregister_device(&sunkbd_dev);
+	serio_unregister_driver(&sunkbd_drv);
 }
 
 module_init(sunkbd_init);
diff -Nru a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
--- a/drivers/input/keyboard/xtkbd.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/keyboard/xtkbd.c	Thu Jul 29 14:39:31 2004
@@ -86,7 +86,7 @@
 	return IRQ_HANDLED;
 }
 
-void xtkbd_connect(struct serio *serio, struct serio_dev *dev)
+void xtkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct xtkbd *xtkbd;
 	int i;
@@ -111,7 +111,7 @@
 
 	serio->private = xtkbd;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(xtkbd);
 		return;
 	}
@@ -143,7 +143,7 @@
 	kfree(xtkbd);
 }
 
-struct serio_dev xtkbd_dev = {
+struct serio_driver xtkbd_drv = {
 	.interrupt =	xtkbd_interrupt,
 	.connect =	xtkbd_connect,
 	.disconnect =	xtkbd_disconnect
@@ -151,13 +151,13 @@
 
 int __init xtkbd_init(void)
 {
-	serio_register_device(&xtkbd_dev);
+	serio_register_driver(&xtkbd_drv);
 	return 0;
 }
 
 void __exit xtkbd_exit(void)
 {
-	serio_unregister_device(&xtkbd_dev);
+	serio_unregister_driver(&xtkbd_drv);
 }
 
 module_init(xtkbd_init);
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/mouse/psmouse-base.c	Thu Jul 29 14:39:31 2004
@@ -678,7 +678,7 @@
  * psmouse_connect() is a callback from the serio module when
  * an unhandled serio port is found.
  */
-static void psmouse_connect(struct serio *serio, struct serio_dev *dev)
+static void psmouse_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct psmouse *psmouse;
 
@@ -700,7 +700,7 @@
 	psmouse->dev.private = psmouse;
 
 	serio->private = psmouse;
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(psmouse);
 		serio->private = NULL;
 		return;
@@ -753,9 +753,9 @@
 static int psmouse_reconnect(struct serio *serio)
 {
 	struct psmouse *psmouse = serio->private;
-	struct serio_dev *dev = serio->dev;
+	struct serio_driver *drv = serio->drv;
 
-	if (!dev || !psmouse) {
+	if (!drv || !psmouse) {
 		printk(KERN_DEBUG "psmouse: reconnect request, but serio is disconnected, ignoring...\n");
 		return -1;
 	}
@@ -793,7 +793,7 @@
 }
 
 
-static struct serio_dev psmouse_dev = {
+static struct serio_driver psmouse_drv = {
 	.interrupt =	psmouse_interrupt,
 	.connect =	psmouse_connect,
 	.reconnect =	psmouse_reconnect,
@@ -818,13 +818,13 @@
 int __init psmouse_init(void)
 {
 	psmouse_parse_proto();
-	serio_register_device(&psmouse_dev);
+	serio_register_driver(&psmouse_drv);
 	return 0;
 }
 
 void __exit psmouse_exit(void)
 {
-	serio_unregister_device(&psmouse_dev);
+	serio_unregister_driver(&psmouse_drv);
 }
 
 module_init(psmouse_init);
diff -Nru a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
--- a/drivers/input/mouse/sermouse.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/mouse/sermouse.c	Thu Jul 29 14:39:31 2004
@@ -237,7 +237,7 @@
  * an unhandled serio port is found.
  */
 
-static void sermouse_connect(struct serio *serio, struct serio_dev *dev)
+static void sermouse_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct sermouse *sermouse;
 	unsigned char c;
@@ -279,7 +279,7 @@
 	sermouse->dev.id.product = c;
 	sermouse->dev.id.version = 0x0100;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(sermouse);
 		return;
 	}
@@ -289,7 +289,7 @@
 	printk(KERN_INFO "input: %s on %s\n", sermouse_protocols[sermouse->type], serio->phys);
 }
 
-static struct serio_dev sermouse_dev = {
+static struct serio_driver sermouse_drv = {
 	.interrupt =	sermouse_interrupt,
 	.connect =	sermouse_connect,
 	.disconnect =	sermouse_disconnect
@@ -297,13 +297,13 @@
 
 int __init sermouse_init(void)
 {
-	serio_register_device(&sermouse_dev);
+	serio_register_driver(&sermouse_drv);
 	return 0;
 }
 
 void __exit sermouse_exit(void)
 {
-	serio_unregister_device(&sermouse_dev);
+	serio_unregister_driver(&sermouse_drv);
 }
 
 module_init(sermouse_init);
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/mouse/synaptics.c	Thu Jul 29 14:39:31 2004
@@ -470,7 +470,7 @@
 		if (unlikely(priv->pkt_type == SYN_NEWABS))
 			priv->pkt_type = synaptics_detect_pkt_type(psmouse);
 
-		if (psmouse->ptport && psmouse->ptport->serio.dev && synaptics_is_pt_packet(psmouse->packet))
+		if (psmouse->ptport && psmouse->ptport->serio.drv && synaptics_is_pt_packet(psmouse->packet))
 			synaptics_pass_pt_packet(&psmouse->ptport->serio, psmouse->packet);
 		else
 			synaptics_process_packet(psmouse);
diff -Nru a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
--- a/drivers/input/mouse/vsxxxaa.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/mouse/vsxxxaa.c	Thu Jul 29 14:39:31 2004
@@ -482,7 +482,7 @@
 }
 
 static void
-vsxxxaa_connect (struct serio *serio, struct serio_dev *dev)
+vsxxxaa_connect (struct serio *serio, struct serio_driver *drv)
 {
 	struct vsxxxaa *mouse;
 
@@ -524,7 +524,7 @@
 	mouse->dev.id.bustype = BUS_RS232;
 	mouse->serio = serio;
 
-	if (serio_open (serio, dev)) {
+	if (serio_open (serio, drv)) {
 		kfree (mouse);
 		return;
 	}
@@ -540,7 +540,7 @@
 	printk (KERN_INFO "input: %s on %s\n", mouse->name, mouse->phys);
 }
 
-static struct serio_dev vsxxxaa_dev = {
+static struct serio_driver vsxxxaa_drv = {
 	.connect = vsxxxaa_connect,
 	.interrupt = vsxxxaa_interrupt,
 	.disconnect = vsxxxaa_disconnect,
@@ -549,14 +549,14 @@
 int __init
 vsxxxaa_init (void)
 {
-	serio_register_device (&vsxxxaa_dev);
+	serio_register_driver(&vsxxxaa_drv);
 	return 0;
 }
 
 void __exit
 vsxxxaa_exit (void)
 {
-	serio_unregister_device (&vsxxxaa_dev);
+	serio_unregister_driver(&vsxxxaa_drv);
 }
 
 module_init (vsxxxaa_init);
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/serio/serio.c	Thu Jul 29 14:39:31 2004
@@ -48,27 +48,27 @@
 EXPORT_SYMBOL(serio_unregister_port);
 EXPORT_SYMBOL(serio_unregister_port_delayed);
 EXPORT_SYMBOL(__serio_unregister_port);
-EXPORT_SYMBOL(serio_register_device);
-EXPORT_SYMBOL(serio_unregister_device);
+EXPORT_SYMBOL(serio_register_driver);
+EXPORT_SYMBOL(serio_unregister_driver);
 EXPORT_SYMBOL(serio_open);
 EXPORT_SYMBOL(serio_close);
 EXPORT_SYMBOL(serio_rescan);
 EXPORT_SYMBOL(serio_reconnect);
 
-static DECLARE_MUTEX(serio_sem);				/* protects serio_list and serio_dev_list */
+static DECLARE_MUTEX(serio_sem);	/* protects serio_list and serio_diriver_list */
 static LIST_HEAD(serio_list);
-static LIST_HEAD(serio_dev_list);
+static LIST_HEAD(serio_driver_list);
 
-/* serio_find_dev() must be called with serio_sem down.  */
+/* serio_find_driver() must be called with serio_sem down.  */
 
-static void serio_find_dev(struct serio *serio)
+static void serio_find_driver(struct serio *serio)
 {
-	struct serio_dev *dev;
+	struct serio_driver *drv;
 
-	list_for_each_entry(dev, &serio_dev_list, node) {
-		if (serio->dev)
+	list_for_each_entry(drv, &serio_driver_list, node) {
+		if (serio->drv)
 			break;
-		dev->connect(serio, dev);
+		drv->connect(serio, drv);
 	}
 }
 
@@ -153,15 +153,15 @@
 				break;
 
 			case SERIO_RECONNECT :
-				if (event->serio->dev && event->serio->dev->reconnect)
-					if (event->serio->dev->reconnect(event->serio) == 0)
+				if (event->serio->drv && event->serio->drv->reconnect)
+					if (event->serio->drv->reconnect(event->serio) == 0)
 						break;
 				/* reconnect failed - fall through to rescan */
 
 			case SERIO_RESCAN :
-				if (event->serio->dev)
-					event->serio->dev->disconnect(event->serio);
-				serio_find_dev(event->serio);
+				if (event->serio->drv)
+					event->serio->drv->disconnect(event->serio);
+				serio_find_driver(event->serio);
 				break;
 			default:
 				break;
@@ -252,7 +252,7 @@
 {
 	spin_lock_init(&serio->lock);
 	list_add_tail(&serio->node, &serio_list);
-	serio_find_dev(serio);
+	serio_find_driver(serio);
 }
 
 void serio_unregister_port(struct serio *serio)
@@ -281,58 +281,58 @@
 {
 	serio_remove_pending_events(serio);
 	list_del_init(&serio->node);
-	if (serio->dev)
-		serio->dev->disconnect(serio);
+	if (serio->drv)
+		serio->drv->disconnect(serio);
 }
 
 /*
- * Serio device operations
+ * Serio driver operations
  */
 
-void serio_register_device(struct serio_dev *dev)
+void serio_register_driver(struct serio_driver *drv)
 {
 	struct serio *serio;
 	down(&serio_sem);
-	list_add_tail(&dev->node, &serio_dev_list);
+	list_add_tail(&drv->node, &serio_driver_list);
 	list_for_each_entry(serio, &serio_list, node)
-		if (!serio->dev)
-			dev->connect(serio, dev);
+		if (!serio->drv)
+			drv->connect(serio, drv);
 	up(&serio_sem);
 }
 
-void serio_unregister_device(struct serio_dev *dev)
+void serio_unregister_driver(struct serio_driver *drv)
 {
 	struct serio *serio;
 
 	down(&serio_sem);
-	list_del_init(&dev->node);
+	list_del_init(&drv->node);
 
 	list_for_each_entry(serio, &serio_list, node) {
-		if (serio->dev == dev)
-			dev->disconnect(serio);
-		serio_find_dev(serio);
+		if (serio->drv == drv)
+			drv->disconnect(serio);
+		serio_find_driver(serio);
 	}
 	up(&serio_sem);
 }
 
-/* called from serio_dev->connect/disconnect methods under serio_sem */
-int serio_open(struct serio *serio, struct serio_dev *dev)
+/* called from serio_driver->connect/disconnect methods under serio_sem */
+int serio_open(struct serio *serio, struct serio_driver *drv)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&serio->lock, flags);
-	serio->dev = dev;
+	serio->drv = drv;
 	spin_unlock_irqrestore(&serio->lock, flags);
 	if (serio->open && serio->open(serio)) {
 		spin_lock_irqsave(&serio->lock, flags);
-		serio->dev = NULL;
+		serio->drv = NULL;
 		spin_unlock_irqrestore(&serio->lock, flags);
 		return -1;
 	}
 	return 0;
 }
 
-/* called from serio_dev->connect/disconnect methods under serio_sem */
+/* called from serio_driver->connect/disconnect methods under serio_sem */
 void serio_close(struct serio *serio)
 {
 	unsigned long flags;
@@ -340,7 +340,7 @@
 	if (serio->close)
 		serio->close(serio);
 	spin_lock_irqsave(&serio->lock, flags);
-	serio->dev = NULL;
+	serio->drv = NULL;
 	spin_unlock_irqrestore(&serio->lock, flags);
 }
 
@@ -352,8 +352,8 @@
 
 	spin_lock_irqsave(&serio->lock, flags);
 
-        if (likely(serio->dev)) {
-                ret = serio->dev->interrupt(serio, data, dfl, regs);
+        if (likely(serio->drv)) {
+                ret = serio->drv->interrupt(serio, data, dfl, regs);
 	} else {
 		if (!dfl) {
 			if ((serio->type != SERIO_8042 &&
diff -Nru a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
--- a/drivers/input/serio/serport.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/serio/serport.c	Thu Jul 29 14:39:31 2004
@@ -170,7 +170,7 @@
 {
 	struct serport *sp = (struct serport *) tty->disc_data;
 
-	serio_dev_write_wakeup(&sp->serio);
+	serio_drv_write_wakeup(&sp->serio);
 }
 
 /*
diff -Nru a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
--- a/drivers/input/touchscreen/gunze.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/touchscreen/gunze.c	Thu Jul 29 14:39:31 2004
@@ -111,7 +111,7 @@
  * and if yes, registers it as an input device.
  */
 
-static void gunze_connect(struct serio *serio, struct serio_dev *dev)
+static void gunze_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct gunze *gunze;
 
@@ -142,7 +142,7 @@
 	gunze->dev.id.product = 0x0051;
 	gunze->dev.id.version = 0x0100;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
 		kfree(gunze);
 		return;
 	}
@@ -156,7 +156,7 @@
  * The serio device structure.
  */
 
-static struct serio_dev gunze_dev = {
+static struct serio_driver gunze_drv = {
 	.interrupt =	gunze_interrupt,
 	.connect =	gunze_connect,
 	.disconnect =	gunze_disconnect,
@@ -168,13 +168,13 @@
 
 int __init gunze_init(void)
 {
-	serio_register_device(&gunze_dev);
+	serio_register_driver(&gunze_drv);
 	return 0;
 }
 
 void __exit gunze_exit(void)
 {
-	serio_unregister_device(&gunze_dev);
+	serio_unregister_driver(&gunze_drv);
 }
 
 module_init(gunze_init);
diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	Thu Jul 29 14:39:31 2004
+++ b/drivers/input/touchscreen/h3600_ts_input.c	Thu Jul 29 14:39:31 2004
@@ -373,7 +373,7 @@
  * new serio device. It looks whether it was registered as a H3600 touchscreen
  * and if yes, registers it as an input device.
  */
-static void h3600ts_connect(struct serio *serio, struct serio_dev *dev)
+static void h3600ts_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct h3600_dev *ts;
 
@@ -441,7 +441,7 @@
 	ts->dev.id.product = 0x0666;  /* FIXME !!! We can ask the hardware */
 	ts->dev.id.version = 0x0100;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, drv)) {
         	free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, ts);
         	free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, ts);
 		kfree(ts);
@@ -478,7 +478,7 @@
  * The serio device structure.
  */
 
-static struct serio_dev h3600ts_dev = {
+static struct serio_driver h3600ts_drv = {
 	.interrupt =	h3600ts_interrupt,
 	.connect =	h3600ts_connect,
 	.disconnect =	h3600ts_disconnect,
@@ -490,13 +490,13 @@
 
 static int __init h3600ts_init(void)
 {
-	serio_register_device(&h3600ts_dev);
+	serio_register_driver(&h3600ts_drv);
 	return 0;
 }
 
 static void __exit h3600ts_exit(void)
 {
-	serio_unregister_device(&h3600ts_dev);
+	serio_unregister_driver(&h3600ts_drv);
 }
 
 module_init(h3600ts_init);
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Thu Jul 29 14:39:31 2004
+++ b/include/linux/serio.h	Thu Jul 29 14:39:31 2004
@@ -39,19 +39,19 @@
 	int (*open)(struct serio *);
 	void (*close)(struct serio *);
 
-	struct serio_dev *dev; /* Accessed from interrupt, writes must be protected by serio_lock */
+	struct serio_driver *drv; /* Accessed from interrupt, writes must be protected by serio_lock */
 
 	struct list_head node;
 };
 
-struct serio_dev {
+struct serio_driver {
 	void *private;
 	char *name;
 
 	void (*write_wakeup)(struct serio *);
 	irqreturn_t (*interrupt)(struct serio *, unsigned char,
 			unsigned int, struct pt_regs *);
-	void (*connect)(struct serio *, struct serio_dev *dev);
+	void (*connect)(struct serio *, struct serio_driver *drv);
 	int  (*reconnect)(struct serio *);
 	void (*disconnect)(struct serio *);
 	void (*cleanup)(struct serio *);
@@ -59,7 +59,7 @@
 	struct list_head node;
 };
 
-int serio_open(struct serio *serio, struct serio_dev *dev);
+int serio_open(struct serio *serio, struct serio_driver *drv);
 void serio_close(struct serio *serio);
 void serio_rescan(struct serio *serio);
 void serio_reconnect(struct serio *serio);
@@ -71,8 +71,8 @@
 void serio_unregister_port(struct serio *serio);
 void serio_unregister_port_delayed(struct serio *serio);
 void __serio_unregister_port(struct serio *serio);
-void serio_register_device(struct serio_dev *dev);
-void serio_unregister_device(struct serio_dev *dev);
+void serio_register_driver(struct serio_driver *drv);
+void serio_unregister_driver(struct serio_driver *drv);
 
 static __inline__ int serio_write(struct serio *serio, unsigned char data)
 {
@@ -82,16 +82,16 @@
 		return -1;
 }
 
-static __inline__ void serio_dev_write_wakeup(struct serio *serio)
+static __inline__ void serio_drv_write_wakeup(struct serio *serio)
 {
-	if (serio->dev && serio->dev->write_wakeup)
-		serio->dev->write_wakeup(serio);
+	if (serio->drv && serio->drv->write_wakeup)
+		serio->drv->write_wakeup(serio);
 }
 
 static __inline__ void serio_cleanup(struct serio *serio)
 {
-	if (serio->dev && serio->dev->cleanup)
-		serio->dev->cleanup(serio);
+	if (serio->drv && serio->drv->cleanup)
+		serio->drv->cleanup(serio);
 }
 
 #endif

