Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWKGMHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWKGMHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 07:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWKGMHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 07:07:10 -0500
Received: from nz-out-0102.google.com ([64.233.162.192]:2296 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1754226AbWKGMHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 07:07:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=Z8raTZEHWbz5POPu72tJH3HDd+Ig/5wsLgVj7v9JvbURTx+bHu0dIgxb+gyDRQzAijbvTb66kW3lAh8G994TANTku0H2Wy9Dl07eDfvUNpm9INwcBw4vxdNMv+7+L5Q2WkmdzRa7P2YNWVt0ND7b3BpM68C5wrm6kaOrZE5WMfE=
Date: Tue, 7 Nov 2006 21:07:00 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] input: check return value of serio_register_driver()
Message-ID: <20061107120700.GB13896@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check return value of serio_register_driver()

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/input/joystick/iforce/iforce-main.c |   14 +++++++++++---
 drivers/input/joystick/magellan.c           |    3 +--
 drivers/input/joystick/spaceball.c          |    3 +--
 drivers/input/joystick/spaceorb.c           |    3 +--
 drivers/input/joystick/stinger.c            |    3 +--
 drivers/input/joystick/twidjoy.c            |    3 +--
 drivers/input/joystick/warrior.c            |    3 +--
 drivers/input/keyboard/atkbd.c              |    3 +--
 drivers/input/keyboard/hil_kbd.c            |    3 +--
 drivers/input/keyboard/lkkbd.c              |    3 +--
 drivers/input/keyboard/newtonkbd.c          |    3 +--
 drivers/input/keyboard/stowaway.c           |    3 +--
 drivers/input/keyboard/sunkbd.c             |    3 +--
 drivers/input/keyboard/xtkbd.c              |    3 +--
 drivers/input/mouse/hil_ptr.c               |    3 +--
 drivers/input/mouse/psmouse-base.c          |    8 ++++++--
 drivers/input/mouse/sermouse.c              |    3 +--
 drivers/input/mouse/vsxxxaa.c               |    3 +--
 drivers/input/touchscreen/elo.c             |    3 +--
 drivers/input/touchscreen/gunze.c           |    3 +--
 drivers/input/touchscreen/h3600_ts_input.c  |    3 +--
 drivers/input/touchscreen/mtouch.c          |    3 +--
 drivers/input/touchscreen/penmount.c        |    3 +--
 drivers/input/touchscreen/touchright.c      |    3 +--
 drivers/input/touchscreen/touchwin.c        |    3 +--
 25 files changed, 40 insertions(+), 51 deletions(-)

Index: work-fault-inject/drivers/input/mouse/vsxxxaa.c
===================================================================
--- work-fault-inject.orig/drivers/input/mouse/vsxxxaa.c
+++ work-fault-inject/drivers/input/mouse/vsxxxaa.c
@@ -571,8 +571,7 @@ static struct serio_driver vsxxxaa_drv =
 static int __init
 vsxxxaa_init (void)
 {
-	serio_register_driver(&vsxxxaa_drv);
-	return 0;
+	return serio_register_driver(&vsxxxaa_drv);
 }
 
 static void __exit
Index: work-fault-inject/drivers/input/mouse/psmouse-base.c
===================================================================
--- work-fault-inject.orig/drivers/input/mouse/psmouse-base.c
+++ work-fault-inject/drivers/input/mouse/psmouse-base.c
@@ -1509,15 +1509,19 @@ static int psmouse_get_maxproto(char *bu
 
 static int __init psmouse_init(void)
 {
+	int err;
+
 	kpsmoused_wq = create_singlethread_workqueue("kpsmoused");
 	if (!kpsmoused_wq) {
 		printk(KERN_ERR "psmouse: failed to create kpsmoused workqueue\n");
 		return -ENOMEM;
 	}
 
-	serio_register_driver(&psmouse_drv);
+	err = serio_register_driver(&psmouse_drv);
+	if (err)
+		destroy_workqueue(kpsmoused_wq);
 
-	return 0;
+	return err;
 }
 
 static void __exit psmouse_exit(void)
Index: work-fault-inject/drivers/input/touchscreen/elo.c
===================================================================
--- work-fault-inject.orig/drivers/input/touchscreen/elo.c
+++ work-fault-inject/drivers/input/touchscreen/elo.c
@@ -397,8 +397,7 @@ static struct serio_driver elo_drv = {
 
 static int __init elo_init(void)
 {
-	serio_register_driver(&elo_drv);
-	return 0;
+	return serio_register_driver(&elo_drv);
 }
 
 static void __exit elo_exit(void)
Index: work-fault-inject/drivers/input/touchscreen/gunze.c
===================================================================
--- work-fault-inject.orig/drivers/input/touchscreen/gunze.c
+++ work-fault-inject/drivers/input/touchscreen/gunze.c
@@ -190,8 +190,7 @@ static struct serio_driver gunze_drv = {
 
 static int __init gunze_init(void)
 {
-	serio_register_driver(&gunze_drv);
-	return 0;
+	return serio_register_driver(&gunze_drv);
 }
 
 static void __exit gunze_exit(void)
Index: work-fault-inject/drivers/input/touchscreen/h3600_ts_input.c
===================================================================
--- work-fault-inject.orig/drivers/input/touchscreen/h3600_ts_input.c
+++ work-fault-inject/drivers/input/touchscreen/h3600_ts_input.c
@@ -478,8 +478,7 @@ static struct serio_driver h3600ts_drv =
 
 static int __init h3600ts_init(void)
 {
-	serio_register_driver(&h3600ts_drv);
-	return 0;
+	return serio_register_driver(&h3600ts_drv);
 }
 
 static void __exit h3600ts_exit(void)
Index: work-fault-inject/drivers/input/touchscreen/mtouch.c
===================================================================
--- work-fault-inject.orig/drivers/input/touchscreen/mtouch.c
+++ work-fault-inject/drivers/input/touchscreen/mtouch.c
@@ -205,8 +205,7 @@ static struct serio_driver mtouch_drv = 
 
 static int __init mtouch_init(void)
 {
-	serio_register_driver(&mtouch_drv);
-	return 0;
+	return serio_register_driver(&mtouch_drv);
 }
 
 static void __exit mtouch_exit(void)
Index: work-fault-inject/drivers/input/touchscreen/penmount.c
===================================================================
--- work-fault-inject.orig/drivers/input/touchscreen/penmount.c
+++ work-fault-inject/drivers/input/touchscreen/penmount.c
@@ -171,8 +171,7 @@ static struct serio_driver pm_drv = {
 
 static int __init pm_init(void)
 {
-	serio_register_driver(&pm_drv);
-	return 0;
+	return serio_register_driver(&pm_drv);
 }
 
 static void __exit pm_exit(void)
Index: work-fault-inject/drivers/input/touchscreen/touchright.c
===================================================================
--- work-fault-inject.orig/drivers/input/touchscreen/touchright.c
+++ work-fault-inject/drivers/input/touchscreen/touchright.c
@@ -182,8 +182,7 @@ static struct serio_driver tr_drv = {
 
 static int __init tr_init(void)
 {
-	serio_register_driver(&tr_drv);
-	return 0;
+	return serio_register_driver(&tr_drv);
 }
 
 static void __exit tr_exit(void)
Index: work-fault-inject/drivers/input/touchscreen/touchwin.c
===================================================================
--- work-fault-inject.orig/drivers/input/touchscreen/touchwin.c
+++ work-fault-inject/drivers/input/touchscreen/touchwin.c
@@ -189,8 +189,7 @@ static struct serio_driver tw_drv = {
 
 static int __init tw_init(void)
 {
-	serio_register_driver(&tw_drv);
-	return 0;
+	return serio_register_driver(&tw_drv);
 }
 
 static void __exit tw_exit(void)
Index: work-fault-inject/drivers/input/keyboard/atkbd.c
===================================================================
--- work-fault-inject.orig/drivers/input/keyboard/atkbd.c
+++ work-fault-inject/drivers/input/keyboard/atkbd.c
@@ -1293,8 +1293,7 @@ static ssize_t atkbd_show_err_count(stru
 
 static int __init atkbd_init(void)
 {
-	serio_register_driver(&atkbd_drv);
-	return 0;
+	return serio_register_driver(&atkbd_drv);
 }
 
 static void __exit atkbd_exit(void)
Index: work-fault-inject/drivers/input/keyboard/hil_kbd.c
===================================================================
--- work-fault-inject.orig/drivers/input/keyboard/hil_kbd.c
+++ work-fault-inject/drivers/input/keyboard/hil_kbd.c
@@ -381,8 +381,7 @@ struct serio_driver hil_kbd_serio_drv = 
 
 static int __init hil_kbd_init(void)
 {
-	serio_register_driver(&hil_kbd_serio_drv);
-        return 0;
+	return serio_register_driver(&hil_kbd_serio_drv);
 }
                 
 static void __exit hil_kbd_exit(void)
Index: work-fault-inject/drivers/input/keyboard/lkkbd.c
===================================================================
--- work-fault-inject.orig/drivers/input/keyboard/lkkbd.c
+++ work-fault-inject/drivers/input/keyboard/lkkbd.c
@@ -754,8 +754,7 @@ static struct serio_driver lkkbd_drv = {
 static int __init
 lkkbd_init (void)
 {
-	serio_register_driver(&lkkbd_drv);
-	return 0;
+	return serio_register_driver(&lkkbd_drv);
 }
 
 static void __exit
Index: work-fault-inject/drivers/input/keyboard/newtonkbd.c
===================================================================
--- work-fault-inject.orig/drivers/input/keyboard/newtonkbd.c
+++ work-fault-inject/drivers/input/keyboard/newtonkbd.c
@@ -165,8 +165,7 @@ static struct serio_driver nkbd_drv = {
 
 static int __init nkbd_init(void)
 {
-	serio_register_driver(&nkbd_drv);
-	return 0;
+	return serio_register_driver(&nkbd_drv);
 }
 
 static void __exit nkbd_exit(void)
Index: work-fault-inject/drivers/input/keyboard/stowaway.c
===================================================================
--- work-fault-inject.orig/drivers/input/keyboard/stowaway.c
+++ work-fault-inject/drivers/input/keyboard/stowaway.c
@@ -173,8 +173,7 @@ static struct serio_driver skbd_drv = {
 
 static int __init skbd_init(void)
 {
-	serio_register_driver(&skbd_drv);
-	return 0;
+	return serio_register_driver(&skbd_drv);
 }
 
 static void __exit skbd_exit(void)
Index: work-fault-inject/drivers/input/keyboard/sunkbd.c
===================================================================
--- work-fault-inject.orig/drivers/input/keyboard/sunkbd.c
+++ work-fault-inject/drivers/input/keyboard/sunkbd.c
@@ -346,8 +346,7 @@ static struct serio_driver sunkbd_drv = 
 
 static int __init sunkbd_init(void)
 {
-	serio_register_driver(&sunkbd_drv);
-	return 0;
+	return serio_register_driver(&sunkbd_drv);
 }
 
 static void __exit sunkbd_exit(void)
Index: work-fault-inject/drivers/input/keyboard/xtkbd.c
===================================================================
--- work-fault-inject.orig/drivers/input/keyboard/xtkbd.c
+++ work-fault-inject/drivers/input/keyboard/xtkbd.c
@@ -170,8 +170,7 @@ static struct serio_driver xtkbd_drv = {
 
 static int __init xtkbd_init(void)
 {
-	serio_register_driver(&xtkbd_drv);
-	return 0;
+	return serio_register_driver(&xtkbd_drv);
 }
 
 static void __exit xtkbd_exit(void)
Index: work-fault-inject/drivers/input/mouse/hil_ptr.c
===================================================================
--- work-fault-inject.orig/drivers/input/mouse/hil_ptr.c
+++ work-fault-inject/drivers/input/mouse/hil_ptr.c
@@ -417,8 +417,7 @@ static struct serio_driver hil_ptr_serio
 
 static int __init hil_ptr_init(void)
 {
-	serio_register_driver(&hil_ptr_serio_driver);
-        return 0;
+	return serio_register_driver(&hil_ptr_serio_driver);
 }
                 
 static void __exit hil_ptr_exit(void)
Index: work-fault-inject/drivers/input/mouse/sermouse.c
===================================================================
--- work-fault-inject.orig/drivers/input/mouse/sermouse.c
+++ work-fault-inject/drivers/input/mouse/sermouse.c
@@ -348,8 +348,7 @@ static struct serio_driver sermouse_drv 
 
 static int __init sermouse_init(void)
 {
-	serio_register_driver(&sermouse_drv);
-	return 0;
+	return serio_register_driver(&sermouse_drv);
 }
 
 static void __exit sermouse_exit(void)
Index: work-fault-inject/drivers/input/joystick/iforce/iforce-main.c
===================================================================
--- work-fault-inject.orig/drivers/input/joystick/iforce/iforce-main.c
+++ work-fault-inject/drivers/input/joystick/iforce/iforce-main.c
@@ -464,13 +464,21 @@ int iforce_init_device(struct iforce *if
 
 static int __init iforce_init(void)
 {
+	int err = 0;
+
 #ifdef CONFIG_JOYSTICK_IFORCE_USB
-	usb_register(&iforce_usb_driver);
+	err = usb_register(&iforce_usb_driver);
+	if (err)
+		return err;
 #endif
 #ifdef CONFIG_JOYSTICK_IFORCE_232
-	serio_register_driver(&iforce_serio_drv);
+	err = serio_register_driver(&iforce_serio_drv);
+#ifdef CONFIG_JOYSTICK_IFORCE_USB
+	if (err)
+		usb_deregister(&iforce_usb_driver);
+#endif
 #endif
-	return 0;
+	return err;
 }
 
 static void __exit iforce_exit(void)
Index: work-fault-inject/drivers/input/joystick/magellan.c
===================================================================
--- work-fault-inject.orig/drivers/input/joystick/magellan.c
+++ work-fault-inject/drivers/input/joystick/magellan.c
@@ -227,8 +227,7 @@ static struct serio_driver magellan_drv 
 
 static int __init magellan_init(void)
 {
-	serio_register_driver(&magellan_drv);
-	return 0;
+	return serio_register_driver(&magellan_drv);
 }
 
 static void __exit magellan_exit(void)
Index: work-fault-inject/drivers/input/joystick/spaceball.c
===================================================================
--- work-fault-inject.orig/drivers/input/joystick/spaceball.c
+++ work-fault-inject/drivers/input/joystick/spaceball.c
@@ -296,8 +296,7 @@ static struct serio_driver spaceball_drv
 
 static int __init spaceball_init(void)
 {
-	serio_register_driver(&spaceball_drv);
-	return 0;
+	return serio_register_driver(&spaceball_drv);
 }
 
 static void __exit spaceball_exit(void)
Index: work-fault-inject/drivers/input/joystick/spaceorb.c
===================================================================
--- work-fault-inject.orig/drivers/input/joystick/spaceorb.c
+++ work-fault-inject/drivers/input/joystick/spaceorb.c
@@ -242,8 +242,7 @@ static struct serio_driver spaceorb_drv 
 
 static int __init spaceorb_init(void)
 {
-	serio_register_driver(&spaceorb_drv);
-	return 0;
+	return serio_register_driver(&spaceorb_drv);
 }
 
 static void __exit spaceorb_exit(void)
Index: work-fault-inject/drivers/input/joystick/stinger.c
===================================================================
--- work-fault-inject.orig/drivers/input/joystick/stinger.c
+++ work-fault-inject/drivers/input/joystick/stinger.c
@@ -212,8 +212,7 @@ static struct serio_driver stinger_drv =
 
 static int __init stinger_init(void)
 {
-	serio_register_driver(&stinger_drv);
-	return 0;
+	return serio_register_driver(&stinger_drv);
 }
 
 static void __exit stinger_exit(void)
Index: work-fault-inject/drivers/input/joystick/twidjoy.c
===================================================================
--- work-fault-inject.orig/drivers/input/joystick/twidjoy.c
+++ work-fault-inject/drivers/input/joystick/twidjoy.c
@@ -265,8 +265,7 @@ static struct serio_driver twidjoy_drv =
 
 static int __init twidjoy_init(void)
 {
-	serio_register_driver(&twidjoy_drv);
-	return 0;
+	return serio_register_driver(&twidjoy_drv);
 }
 
 static void __exit twidjoy_exit(void)
Index: work-fault-inject/drivers/input/joystick/warrior.c
===================================================================
--- work-fault-inject.orig/drivers/input/joystick/warrior.c
+++ work-fault-inject/drivers/input/joystick/warrior.c
@@ -220,8 +220,7 @@ static struct serio_driver warrior_drv =
 
 static int __init warrior_init(void)
 {
-	serio_register_driver(&warrior_drv);
-	return 0;
+	return serio_register_driver(&warrior_drv);
 }
 
 static void __exit warrior_exit(void)
