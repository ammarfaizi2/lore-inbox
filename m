Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUDUMqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUDUMqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 08:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUDUMqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 08:46:32 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:39047 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261631AbUDUMnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 08:43:05 -0400
Date: Wed, 21 Apr 2004 14:43:00 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 0/15] New set of input patches
Message-ID: <20040421124300.GD12700@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
	Dmitry Torokhov <dtor_core@ameritech.net>
References: <200404210049.17139.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/dFl7e5Y0zcWrcPL"
Content-Disposition: inline
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/dFl7e5Y0zcWrcPL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-21 00:49:17 -0500, Dmitry Torokhov <dtor_core@ameritech.net>
wrote in message <200404210049.17139.dtor_core@ameritech.net>:

=2E..and while we are at it, here's a patch to bring vsxxxaa.c to current
version. I'm running this for daily use on my Athlon (right, the
hardware was developed some 20 years ago for DECstations and
VAXstations).

It also correctly supports the VSXXX-AB digitizer tablet :)


#
# This patch updates the vsxxx driver to it's current version.
# Even DEC tablet support (VSXXX-AB) is now tested - it works:)
# You can even hotplug between mouse and digitizer...
#

Index: linux-2.6.6-rc2/drivers/input/mouse/vsxxxaa.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.6-rc2.orig/drivers/input/mouse/vsxxxaa.c	2004-04-04 05:38:27.=
000000000 +0200
+++ linux-2.6.6-rc2/drivers/input/mouse/vsxxxaa.c	2004-04-21 14:27:03.00000=
0000 +0200
@@ -11,14 +11,14 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or=20
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- *=20
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
- *=20
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
@@ -45,32 +45,32 @@
  *=20
  *	DEC socket	DB9	DB25	Note
  *	1 (GND)		5	7	-
- *	2 (RxD)		3	3	-
- *	3 (TxD)		2	2	-
+ *	2 (RxD)		2	3	-
+ *	3 (TxD)		3	2	-
  *	4 (-12V)	-	-	Somewhere from the PSU. At ATX, it's
- *					the blue wire at pin 12 of the ATX
- *					power connector. Please note that the
- *					docs say this should be +12V! However,
- *					I measured -12V...
- *	5 (+5V)		-	-	PSU (red wire of ATX power connector
+ *					the thin blue wire at pin 12 of the
+ *					ATX power connector. Only required for
+ *					VSXXX-AA/-GA mice.
+ *	5 (+5V)		-	-	PSU (red wires of ATX power connector
  *					on pin 4, 6, 19 or 20) or HDD power
- *					connector (also red wire)
- *	6 (not conn.)	-	-	-
+ *					connector (also red wire).
+ *	6 (+12V)	-	-	HDD power connector, yellow wire. Only
+ *					required for VSXXX-AB digitizer.
  *	7 (dev. avail.)	-	-	The mouse shorts this one to pin 1.
  *					This way, the host computer can detect
  *					the mouse. To use it with the adaptor,
  *					simply don't connect this pin.
  *
  * So to get a working adaptor, you need to connect the mouse with three
- * wires to a RS232 port and two additional wires for +5V and -12V to the
- * PSU.
+ * wires to a RS232 port and two or three additional wires for +5V, +12V a=
nd
+ * -12V to the PSU.
  *
  * Flow specification for the link is 4800, 8o1.
- */
-
-/*
- * TODO list:
- * - Automatically attach to a given serial port (no need for inputattach).
+ *
+ * The mice and tablet are described in "VCB02 Video Subsystem - Technical
+ * Manual", DEC EK-104AA-TM-001. You'll find it at MANX, a search engine
+ * specific for DEC documentation. Try
+ * http://www.vt100.net/manx/details?pn=3DEK-104AA-TM-001;id=3D21;cp=3D1
  */
=20
 #include <linux/delay.h>
@@ -115,6 +115,7 @@
 	unsigned char version;
 	unsigned char country;
 	unsigned char type;
+	char name[64];
 	char phys[32];
 };
=20
@@ -134,27 +135,34 @@
 {
 	if (mouse->count =3D=3D BUFLEN) {
 		printk (KERN_ERR "%s on %s: Dropping a byte of full buffer.\n",
-				mouse->dev.name, mouse->dev.phys);
+				mouse->name, mouse->phys);
 		vsxxxaa_drop_bytes (mouse, 1);
 	}
+	DBG (KERN_INFO "Queueing byte 0x%02x\n", byte);
=20
 	mouse->buf[mouse->count++] =3D byte;
 }
=20
 static void
-vsxxxaa_report_mouse (struct vsxxxaa *mouse)
+vsxxxaa_detection_done (struct vsxxxaa *mouse)
 {
-	char *devtype;
-
 	switch (mouse->type) {
-		case 0x02:	devtype =3D "DEC mouse"; break;
-		case 0x04:	devtype =3D "DEC tablet"; break;
-		default:	devtype =3D "unknown DEC device"; break;
+		case 0x02:
+			sprintf (mouse->name, "DEC VSXXX-AA/GA mouse");
+			break;
+
+		case 0x04:
+			sprintf (mouse->name, "DEC VSXXX-AB digitizer");
+			break;
+
+		default:
+			sprintf (mouse->name, "unknown DEC pointer device");
+			break;
 	}
=20
-	printk (KERN_INFO "Found %s version 0x%x from country 0x%x "
-			"on port %s\n", devtype, mouse->version,
-			mouse->country, mouse->dev.phys);
+	printk (KERN_INFO "Found %s version 0x%02x from country 0x%02x "
+			"on port %s\n", mouse->name, mouse->version,
+			mouse->country, mouse->phys);
 }
=20
 /*
@@ -216,7 +224,7 @@
 	 * 0, bit 4 of byte 0 is direction.
 	 */
 	dx =3D buf[1] & 0x7f;
-	dx *=3D ((buf[0] >> 4) & 0x01)? -1: 1;
+	dx *=3D ((buf[0] >> 4) & 0x01)? 1: -1;
=20
 	/*
 	 * Low 7 bit of byte 2 are abs(dy), bit 7 is
@@ -236,7 +244,7 @@
 	vsxxxaa_drop_bytes (mouse, 3);
=20
 	DBG (KERN_INFO "%s on %s: dx=3D%d, dy=3D%d, buttons=3D%s%s%s\n",
-			mouse->dev.name, mouse->dev.phys, dx, dy,
+			mouse->name, mouse->phys, dx, dy,
 			left? "L": "l", middle? "M": "m", right? "R": "r");
=20
 	/*
@@ -246,6 +254,7 @@
 	input_report_key (dev, BTN_LEFT, left);
 	input_report_key (dev, BTN_MIDDLE, middle);
 	input_report_key (dev, BTN_RIGHT, right);
+	input_report_key (dev, BTN_TOUCH, 0);
 	input_report_rel (dev, REL_X, dx);
 	input_report_rel (dev, REL_Y, dy);
 	input_sync (dev);
@@ -256,7 +265,7 @@
 {
 	struct input_dev *dev =3D &mouse->dev;
 	unsigned char *buf =3D mouse->buf;
-	int left, middle, right, extra;
+	int left, middle, right, touch;
 	int x, y;
=20
 	/*
@@ -270,10 +279,12 @@
 	 */
=20
 	/*
-	 * Get X/Y position
+	 * Get X/Y position. Y axis needs to be inverted since VSXXX-AB
+	 * counts down->top while monitor counts top->bottom.
 	 */
 	x =3D ((buf[2] & 0x3f) << 6) | (buf[1] & 0x3f);
 	y =3D ((buf[4] & 0x3f) << 6) | (buf[3] & 0x3f);
+	y =3D 1023 - y;
=20
 	/*
 	 * Get button state. It's bits <4..1> of byte 0.
@@ -281,14 +292,14 @@
 	left	=3D (buf[0] & 0x02)? 1: 0;
 	middle	=3D (buf[0] & 0x04)? 1: 0;
 	right	=3D (buf[0] & 0x08)? 1: 0;
-	extra	=3D (buf[0] & 0x10)? 1: 0;
+	touch	=3D (buf[0] & 0x10)? 1: 0;
=20
 	vsxxxaa_drop_bytes (mouse, 5);
=20
 	DBG (KERN_INFO "%s on %s: x=3D%d, y=3D%d, buttons=3D%s%s%s%s\n",
-			mouse->dev.name, mouse->dev.phys, x, y,
+			mouse->name, mouse->phys, x, y,
 			left? "L": "l", middle? "M": "m",
-			right? "R": "r", extra? "E": "e");
+			right? "R": "r", touch? "T": "t");
=20
 	/*
 	 * Report what we've found so far...
@@ -297,7 +308,7 @@
 	input_report_key (dev, BTN_LEFT, left);
 	input_report_key (dev, BTN_MIDDLE, middle);
 	input_report_key (dev, BTN_RIGHT, right);
-	input_report_key (dev, BTN_EXTRA, extra);
+	input_report_key (dev, BTN_TOUCH, touch);
 	input_report_abs (dev, ABS_X, x);
 	input_report_abs (dev, ABS_Y, y);
 	input_sync (dev);
@@ -334,7 +345,7 @@
=20
 	mouse->version =3D buf[0] & 0x0f;
 	mouse->country =3D (buf[1] >> 4) & 0x07;
-	mouse->type =3D buf[1] & 0x07;
+	mouse->type =3D buf[1] & 0x0f;
 	error =3D buf[2] & 0x7f;
=20
 	/*
@@ -347,7 +358,7 @@
 	right	=3D (buf[0] & 0x01)? 1: 0;
=20
 	vsxxxaa_drop_bytes (mouse, 4);
-	vsxxxaa_report_mouse (mouse);
+	vsxxxaa_detection_done (mouse);
=20
 	if (error <=3D 0x1f) {
 		/* No error. Report buttons */
@@ -355,20 +366,22 @@
 		input_report_key (dev, BTN_LEFT, left);
 		input_report_key (dev, BTN_MIDDLE, middle);
 		input_report_key (dev, BTN_RIGHT, right);
+		input_report_key (dev, BTN_TOUCH, 0);
 		input_sync (dev);
 	} else {
 		printk (KERN_ERR "Your %s on %s reports an undefined error, "
-				"please check it...\n", mouse->dev.name,
-				mouse->dev.phys);
+				"please check it...\n", mouse->name,
+				mouse->phys);
 	}
=20
 	/*
-	 * If the mouse was hot-plugged, we need to
-	 * force differential mode now...
+	 * If the mouse was hot-plugged, we need to force differential mode
+	 * now... However, give it a second to recover from it's reset.
 	 */
 	printk (KERN_NOTICE "%s on %s: Forceing standard packet format and "
-			"streaming mode\n", mouse->dev.name, mouse->dev.phys);
+			"streaming mode\n", mouse->name, mouse->phys);
 	mouse->serio->write (mouse->serio, 'S');
+	mdelay (50);
 	mouse->serio->write (mouse->serio, 'R');
 }
=20
@@ -392,7 +405,7 @@
 		while (mouse->count > 0 && !IS_HDR_BYTE(buf[0])) {
 			printk (KERN_ERR "%s on %s: Dropping a byte to regain "
 					"sync with mouse data stream...\n",
-					mouse->dev.name, mouse->dev.phys);
+					mouse->name, mouse->phys);
 			vsxxxaa_drop_bytes (mouse, 1);
 		}
=20
@@ -475,7 +488,6 @@
=20
 	if ((serio->type & SERIO_TYPE) !=3D SERIO_RS232)
 		return;
-
 	if ((serio->type & SERIO_PROTO) !=3D SERIO_VSXXXAA)
 		return;
=20
@@ -486,14 +498,15 @@
=20
 	init_input_dev (&mouse->dev);
 	set_bit (EV_KEY, mouse->dev.evbit);		/* We have buttons */
-	set_bit (EV_REL, mouse->dev.evbit);		/* We can move */
+	set_bit (EV_REL, mouse->dev.evbit);
+	set_bit (EV_ABS, mouse->dev.evbit);
 	set_bit (BTN_LEFT, mouse->dev.keybit);		/* We have 3 buttons */
 	set_bit (BTN_MIDDLE, mouse->dev.keybit);
 	set_bit (BTN_RIGHT, mouse->dev.keybit);
-	set_bit (BTN_EXTRA, mouse->dev.keybit);		/* ...and Tablet */
-	set_bit (REL_X, mouse->dev.relbit);		/* We can move in */
-	set_bit (REL_Y, mouse->dev.relbit);		/* two dimensions */
-	set_bit (ABS_X, mouse->dev.absbit);		/* DEC tablet support */
+	set_bit (BTN_TOUCH, mouse->dev.keybit);		/* ...and Tablet */
+	set_bit (REL_X, mouse->dev.relbit);
+	set_bit (REL_Y, mouse->dev.relbit);
+	set_bit (ABS_X, mouse->dev.absbit);
 	set_bit (ABS_Y, mouse->dev.absbit);
=20
 	mouse->dev.absmin[ABS_X] =3D 0;
@@ -504,9 +517,10 @@
 	mouse->dev.private =3D mouse;
 	serio->private =3D mouse;
=20
+	sprintf (mouse->name, "DEC VSXXX-AA/GA mouse or VSXXX-AB digitizer");
 	sprintf (mouse->phys, "%s/input0", serio->phys);
+	mouse->dev.name =3D mouse->name;
 	mouse->dev.phys =3D mouse->phys;
-	mouse->dev.name =3D "DEC VSXXX-AA/GA mouse or DEC tablet";
 	mouse->dev.id.bustype =3D BUS_RS232;
 	mouse->serio =3D serio;
=20
@@ -516,20 +530,20 @@
 	}
=20
 	/*
-	 * Request selftest and differential stream mode.
+	 * Request selftest. Standard packet format and differential
+	 * mode will be requested after the device ID'ed successfully.
 	 */
 	mouse->serio->write (mouse->serio, 'T'); /* Test */
-	mouse->serio->write (mouse->serio, 'R'); /* Differential stream */
=20
 	input_register_device (&mouse->dev);
=20
-	printk (KERN_INFO "input: %s on %s\n", mouse->dev.name, serio->phys);
+	printk (KERN_INFO "input: %s on %s\n", mouse->name, mouse->phys);
 }
=20
 static struct serio_dev vsxxxaa_dev =3D {
-	.interrupt =3D	vsxxxaa_interrupt,
-	.connect =3D	vsxxxaa_connect,
-	.disconnect =3D	vsxxxaa_disconnect
+	.connect =3D vsxxxaa_connect,
+	.interrupt =3D vsxxxaa_interrupt,
+	.disconnect =3D vsxxxaa_disconnect,
 };
=20
 int __init
Index: linux-2.6.6-rc2/drivers/input/mouse/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.6-rc2.orig/drivers/input/mouse/Kconfig	2004-04-04 05:37:45.00=
0000000 +0200
+++ linux-2.6.6-rc2/drivers/input/mouse/Kconfig	2004-04-21 14:27:03.0000000=
00 +0200
@@ -119,7 +119,7 @@
 	  module will be called rpcmouse.
=20
 config MOUSE_VSXXXAA
-	tristate "DEC VSXXX-AA/GA mouse and tablet"
+	tristate "DEC VSXXX-AA/GA mouse and VSXXX-AB tablet"
 	depends on INPUT && INPUT_MOUSE
 	select SERIO
 	help

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--/dFl7e5Y0zcWrcPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhmxUHb1edYOZ4bsRAmw6AJ0d+RGXGP+SSMAsTgLIleUmqj7utQCfZtwy
WgQPvvtoLS13p4/sAdHXs6Q=
=sb0E
-----END PGP SIGNATURE-----

--/dFl7e5Y0zcWrcPL--
