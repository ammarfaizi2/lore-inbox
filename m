Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUDUMlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUDUMlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 08:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUDUMlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 08:41:15 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:25991 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261210AbUDUMkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 08:40:09 -0400
Date: Wed, 21 Apr 2004 14:40:08 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: [New-PATCH] lkkbd: Current version
Message-ID: <20040421124008.GC12700@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net> <200404210052.28755.dtor_core@ameritech.net> <20040421113947.GA12700@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mWEPrn9k3Wj8m9KK"
Content-Disposition: inline
In-Reply-To: <20040421113947.GA12700@lug-owl.de>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mWEPrn9k3Wj8m9KK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-21 13:39:47 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de>
wrote in message <20040421113947.GA12700@lug-owl.de>:
> On Wed, 2004-04-21 00:52:25 -0500, Dmitry Torokhov <dtor_core@ameritech.n=
et>
> wrote in message <200404210052.28755.dtor_core@ameritech.net>:
> > diff -Nru a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkk=
bd.c
> > --- a/drivers/input/keyboard/lkkbd.c	Tue Apr 20 23:00:57 2004
> > +++ b/drivers/input/keyboard/lkkbd.c	Tue Apr 20 23:00:57 2004
> > @@ -12,7 +12,7 @@
> >   * adaptor).
> >   *
> >   * DISCLAUNER: This works for _me_. If you break anything by using the
>             ^--- If you had only caught this one :)
>=20
> I'll take this patch into my tree, too.

Here we are. Linus, please apply this patch. It incorporated Dmitry's
changes and also updates the lkkbd driver to it's current version (which
I use on my Athlon).


#
# This patch updates the lkkbd driver to it's current version.
# It also incorporates two patches suggested on LKML (fixing
# some leading whitespace and an unneccessary check).
#

Index: linux-2.6.6-rc2/drivers/input/keyboard/lkkbd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.6-rc2.orig/drivers/input/keyboard/lkkbd.c	2004-04-04 05:36:25=
=2E000000000 +0200
+++ linux-2.6.6-rc2/drivers/input/keyboard/lkkbd.c	2004-04-21 14:33:59.0000=
00000 +0200
@@ -11,8 +11,8 @@
  * and VAXstations, but can also be used on any standard RS232 with an
  * adaptor).
  *
- * DISCLAUNER: This works for _me_. If you break anything by using the
- * information given below, I will _not_ be lieable!
+ * DISCLAIMER: This works for _me_. If you break anything by using the
+ * information given below, I will _not_ be liable!
  *
  * RJ11 pinout:		To DB9:		Or DB25:
  * 	1 - RxD <---->	Pin 3 (TxD) <->	Pin 2 (TxD)
@@ -34,23 +34,32 @@
  *		Additionally, you have to get +12V from somewhere.
  * Most easily, you'll get that from a floppy or HDD power connector.
  * It's the yellow cable there (black is ground and red is +5V).
+ *
+ * The keyboard and all the commands it understands are documented in
+ * "VCB02 Video Subsystem - Technical Manual", EK-104AA-TM-001. This
+ * document is LK201 specific, but LK401 is mostly compatible. It comes
+ * up in LK201 mode and doesn't report any of the additional keys it
+ * has. These need to be switched on with the LK_CMD_ENABLE_LK401
+ * command. You'll find this document (scanned .pdf file) on MANX,
+ * a search engine specific to DEC documentation. Try
+ * http://www.vt100.net/manx/details?pn=3DEK-104AA-TM-001;id=3D21;cp=3D1
  */
=20
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
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *=20
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *=20
+ *
  * Should you need to contact me, the author, you can do so either by
  * email or by paper mail:
  * Jan-Benedict Glaw, Lilienstra=DFe 16, 33790 H=F6rste (near Halle/Westf.=
),
@@ -67,8 +76,7 @@
 #include <linux/serio.h>
 #include <linux/workqueue.h>
=20
-
-MODULE_AUTHOR ("Jan-Benedict Glaw <jblaw@lug-owl.de>");
+MODULE_AUTHOR ("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
 MODULE_DESCRIPTION ("LK keyboard driver");
 MODULE_LICENSE ("GPL");
=20
@@ -92,6 +100,11 @@
 module_param (ctrlclick_volume, int, 0);
 MODULE_PARM_DESC (ctrlclick_volume, "Ctrlclick volume (in %), default is 1=
00%");
=20
+static int lk201_compose_is_alt =3D 0;
+module_param (lk201_compose_is_alt, int, 0);
+MODULE_PARM_DESC (lk201_compose_is_alt, "If set non-zero, LK201' Compose k=
ey "
+		"will act as an Alt key");
+
=20
=20
 #undef LKKBD_DEBUG
@@ -126,8 +139,11 @@
 #define LK_CMD_SET_DEFAULTS	0xd3
 #define LK_CMD_POWERCYCLE_RESET	0xfd
 #define LK_CMD_ENABLE_LK401	0xe9
+#define LK_CMD_REQUEST_ID	0xab
=20
 /* Misc responses from keyboard */
+#define LK_STUCK_KEY		0x3d
+#define LK_SELFTEST_FAILED	0x3e
 #define LK_ALL_KEYS_UP		0xb3
 #define LK_METRONOME		0xb4
 #define LK_OUTPUT_ERROR		0xb5
@@ -139,6 +155,7 @@
 #define LK_RESPONSE_RESERVED	0xbb
=20
 #define LK_NUM_KEYCODES		256
+#define LK_NUM_IGNORE_BYTES	6
 typedef u_int16_t lk_keycode_t;
=20
=20
@@ -267,6 +284,7 @@
 struct lkkbd {
 	lk_keycode_t keycode[LK_NUM_KEYCODES];
 	int ignore_bytes;
+	unsigned char id[LK_NUM_IGNORE_BYTES];
 	struct input_dev dev;
 	struct serio *serio;
 	struct work_struct tq;
@@ -313,6 +331,82 @@
 	return ret;
 }
=20
+static void
+lkkbd_detection_done (struct lkkbd *lk)
+{
+	int i;
+
+	/*
+	 * Reset setting for Compose key. Let Compose be KEY_COMPOSE.
+	 */
+	lk->keycode[0xb1] =3D KEY_COMPOSE;
+
+	/*
+	 * Print keyboard name and modify Compose=3DAlt on user's request.
+	 */
+	switch (lk->id[4]) {
+		case 1:
+			sprintf (lk->name, "DEC LK201 keyboard");
+
+			if (lk201_compose_is_alt)
+				lk->keycode[0xb1] =3D KEY_LEFTALT;
+			break;
+
+		case 2:
+			sprintf (lk->name, "DEC LK401 keyboard");
+			break;
+
+		default:
+			sprintf (lk->name, "Unknown DEC keyboard");
+			printk (KERN_ERR "lkkbd: keyboard on %s is unknown, "
+					"please report to Jan-Benedict Glaw "
+					"<jbglaw@lug-owl.de>\n", lk->phys);
+			printk (KERN_ERR "lkkbd: keyboard ID'ed as:");
+			for (i =3D 0; i < LK_NUM_IGNORE_BYTES; i++)
+				printk (" 0x%02x", lk->id[i]);
+			printk ("\n");
+			break;
+	}
+	printk (KERN_INFO "lkkbd: keyboard on %s identified as: %s\n",
+			lk->phys, lk->name);
+
+	/*
+	 * Report errors during keyboard boot-up.
+	 */
+	switch (lk->id[2]) {
+		case 0x00:
+			/* All okay */
+			break;
+
+		case LK_STUCK_KEY:
+			printk (KERN_ERR "lkkbd: Stuck key on keyboard at "
+					"%s\n", lk->phys);
+			break;
+
+		case LK_SELFTEST_FAILED:
+			printk (KERN_ERR "lkkbd: Selftest failed on keyboard "
+					"at %s, keyboard may not work "
+					"properly\n", lk->phys);
+			break;
+
+		default:
+			printk (KERN_ERR "lkkbd: Unknown error %02x on "
+					"keyboard at %s\n", lk->id[2],
+					lk->phys);
+			break;
+	}
+
+	/*
+	 * Try to hint user if there's a stuck key.
+	 */
+	if (lk->id[2] =3D=3D LK_STUCK_KEY && lk->id[3] !=3D 0)
+		printk (KERN_ERR "Scancode of stuck key is 0x%02x, keycode "
+				"is 0x%04x\n", lk->id[3],
+				lk->keycode[lk->id[3]]);
+
+	return;
+}
+
 /*
  * lkkbd_interrupt() is called by the low level driver when a character
  * is received.
@@ -329,7 +423,11 @@
 	if (lk->ignore_bytes > 0) {
 		DBG (KERN_INFO "Ignoring a byte on %s\n",
 				lk->name);
-		lk->ignore_bytes--;
+		lk->id[LK_NUM_IGNORE_BYTES - lk->ignore_bytes--] =3D data;
+
+		if (lk->ignore_bytes =3D=3D 0)
+			lkkbd_detection_done (lk);
+
 		return IRQ_HANDLED;
 	}
=20
@@ -375,7 +473,8 @@
 			break;
 		case 0x01:
 			DBG (KERN_INFO "Got 0x01, scheduling re-initialization\n");
-			lk->ignore_bytes =3D 3;
+			lk->ignore_bytes =3D LK_NUM_IGNORE_BYTES;
+			lk->id[LK_NUM_IGNORE_BYTES - lk->ignore_bytes--] =3D data;
 			schedule_work (&lk->tq);
 			break;
=20
@@ -389,7 +488,7 @@
 				input_sync (&lk->dev);
                         } else
                                 printk (KERN_WARNING "%s: Unknown key with=
 "
-						"scancode %02x on %s.\n",
+						"scancode 0x%02x on %s.\n",
 						__FILE__, data, lk->name);
 	}
=20
@@ -467,6 +566,9 @@
 	unsigned char leds_on =3D 0;
 	unsigned char leds_off =3D 0;
=20
+	/* Ask for ID */
+	lk->serio->write (lk->serio, LK_CMD_REQUEST_ID);
+
 	/* Reset parameters */
 	lk->serio->write (lk->serio, LK_CMD_SET_DEFAULTS);
=20
@@ -527,9 +629,7 @@
=20
 	if ((serio->type & SERIO_TYPE) !=3D SERIO_RS232)
 		return;
-	if (!(serio->type & SERIO_PROTO))
-		return;
-	if ((serio->type & SERIO_PROTO) && (serio->type & SERIO_PROTO) !=3D SERIO=
_LKKBD)
+	if ((serio->type & SERIO_PROTO) !=3D SERIO_LKKBD)
 		return;
=20
 	if (!(lk =3D kmalloc (sizeof (struct lkkbd), GFP_KERNEL)))
@@ -537,10 +637,16 @@
 	memset (lk, 0, sizeof (struct lkkbd));
=20
 	init_input_dev (&lk->dev);
-
-	lk->dev.evbit[0] =3D BIT (EV_KEY) | BIT (EV_LED) | BIT (EV_SND) | BIT (EV=
_REP);
-	lk->dev.ledbit[0] =3D BIT (LED_CAPSL) | BIT (LED_COMPOSE) | BIT (LED_SCRO=
LLL) | BIT (LED_SLEEP);
-	lk->dev.sndbit[0] =3D BIT (SND_CLICK) | BIT (SND_BELL);
+	set_bit (EV_KEY, lk->dev.evbit);
+	set_bit (EV_LED, lk->dev.evbit);
+	set_bit (EV_SND, lk->dev.evbit);
+	set_bit (EV_REP, lk->dev.evbit);
+	set_bit (LED_CAPSL, lk->dev.ledbit);
+	set_bit (LED_SLEEP, lk->dev.ledbit);
+	set_bit (LED_COMPOSE, lk->dev.ledbit);
+	set_bit (LED_SCROLLL, lk->dev.ledbit);
+	set_bit (SND_BELL, lk->dev.sndbit);
+	set_bit (SND_CLICK, lk->dev.sndbit);
=20
 	lk->serio =3D serio;
=20
@@ -564,14 +670,13 @@
 		return;
 	}
=20
-	sprintf (lk->name, "LK keyboard");
+	sprintf (lk->name, "DEC LK keyboard");
+	sprintf (lk->phys, "%s/input0", serio->phys);
=20
 	memcpy (lk->keycode, lkkbd_keycode, sizeof (lk_keycode_t) * LK_NUM_KEYCOD=
ES);
 	for (i =3D 0; i < LK_NUM_KEYCODES; i++)
 		set_bit (lk->keycode[i], lk->dev.keybit);
=20
-	sprintf (lk->name, "%s/input0", serio->phys);
-
 	lk->dev.name =3D lk->name;
 	lk->dev.phys =3D lk->phys;
 	lk->dev.id.bustype =3D BUS_RS232;
@@ -599,9 +704,9 @@
 }
=20
 static struct serio_dev lkkbd_dev =3D {
-	.interrupt =3D lkkbd_interrupt,
 	.connect =3D lkkbd_connect,
 	.disconnect =3D lkkbd_disconnect,
+	.interrupt =3D lkkbd_interrupt,
 };
=20
 /*

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--mWEPrn9k3Wj8m9KK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhmuoHb1edYOZ4bsRAvllAJ9pBHNkOS4USDMe7NAEUXU9jH9vTQCfef1Q
lVNqdUX2URLl3B0rauRLd6U=
=YtF3
-----END PGP SIGNATURE-----

--mWEPrn9k3Wj8m9KK--
