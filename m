Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbUA3Mls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 07:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbUA3Mls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 07:41:48 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:60678 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S263726AbUA3Mln
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 07:41:43 -0500
Date: Fri, 30 Jan 2004 07:41:42 -0500
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-rc2-mm1
Message-ID: <20040130124141.GA1226@babylon.d2dc.net>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@osdl.org>
References: <20040127233402.6f5d3497.akpm@osdl.org> <20040130104829.GA2505@babylon.d2dc.net> <20040130110205.GA1583@ucw.cz> <20040130111805.GC2505@babylon.d2dc.net> <20040130112039.GA1731@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20040130112039.GA1731@ucw.cz>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2004 at 12:20:39PM +0100, Vojtech Pavlik wrote:
> On Fri, Jan 30, 2004 at 06:18:05AM -0500, Zephaniah E. Hull wrote:
> > On Fri, Jan 30, 2004 at 12:02:05PM +0100, Vojtech Pavlik wrote:
> > > On Fri, Jan 30, 2004 at 05:48:29AM -0500, Zephaniah E. Hull wrote:
> > > > On Tue, Jan 27, 2004 at 11:34:02PM -0800, Andrew Morton wrote:
> > > > >=20
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6=
=2E2-rc2/2.6.2-rc2-mm1/
> > > > >=20
> > > > > - From now on, -mm kernels will contain the latest contents of:
> > > > >=20
> > > > > 	Vojtech's tree:		input.patch
> > > >=20
> > > > This one seems to have a rather problematic patch, which I can't fi=
nd
> > > > any explanation for.
> > >=20
> > > There is another revision of the same mouse from A4Tech (owned by
> > > Jaroslav Kysela), that reports itself as Cypress and has the buttons a
> > > bit differently.
> > >=20
> > > If it indeed collides with your mouse, then we need somehow to specify
> > > which button carries the wheel information in the quirk list.
> >=20
> > Ugh, that is not fun, it does indeed conflict.
> > How about HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA and
> > HID_QUIRK_2WHEEL_MOUSE_HACK_BACK as quirk names?
>=20
> Sounds OK.

Ok, attached.
It is against 2.6.2-rc2-mm2, and has been tested.
(Yes, I know about the line lengths.  If they are a problem, I can
tweak.)

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

Stubborness will get you where self-esteem won't let you go.
  -- Queen Of Swords in the SDM.

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hid_a4tech_cypress.diff"
Content-Transfer-Encoding: quoted-printable

diff -ur linux-2.6.2-rc2-mm2.orig/drivers/usb/input/hid-core.c linux-2.6.2-=
rc2-mm2/drivers/usb/input/hid-core.c
--- linux-2.6.2-rc2-mm2.orig/drivers/usb/input/hid-core.c	2004-01-30 06:10:=
39.000000000 -0500
+++ linux-2.6.2-rc2-mm2/drivers/usb/input/hid-core.c	2004-01-30 06:35:21.00=
0000000 -0500
@@ -1425,8 +1425,8 @@
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_TANGTOP, USB_DEVICE_ID_TANGTOP_USBPS2, HID_QUIRK_NOGET },
=20
-	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MO=
USE_HACK },
-	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE, HID_QUIRK_2WHEEL_MO=
USE_HACK },
+	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MO=
USE_HACK_BACK },
+	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE, HID_QUIRK_2WHEEL_MO=
USE_HACK_EXTRA },
=20
 	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_=
QUIRK_MULTI_INPUT },
diff -ur linux-2.6.2-rc2-mm2.orig/drivers/usb/input/hid-input.c linux-2.6.2=
-rc2-mm2/drivers/usb/input/hid-input.c
--- linux-2.6.2-rc2-mm2.orig/drivers/usb/input/hid-input.c	2004-01-30 06:10=
:39.000000000 -0500
+++ linux-2.6.2-rc2-mm2/drivers/usb/input/hid-input.c	2004-01-30 06:38:45.0=
00000000 -0500
@@ -377,7 +377,8 @@
=20
 	set_bit(usage->type, input->evbit);
 	if ((usage->type =3D=3D EV_REL)
-			&& (device->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
+			&& (device->quirks & (HID_QUIRK_2WHEEL_MOUSE_HACK_BACK
+				| HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA))
 			&& (usage->code =3D=3D REL_WHEEL)) {
 		set_bit(REL_HWHEEL, bit);
 	}
@@ -431,8 +432,8 @@
=20
 	input_regs(input, regs);
=20
-	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
-			&& (usage->code =3D=3D BTN_BACK || usage->code =3D=3D BTN_EXTRA)) {
+	if (((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA) && (usage->code =
=3D=3D BTN_EXTRA))
+		|| (hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_BACK) && (usage->code =3D=
=3D BTN_BACK)) {
 		if (value)
 			hid->quirks |=3D HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
 		else
diff -ur linux-2.6.2-rc2-mm2.orig/drivers/usb/input/hid.h linux-2.6.2-rc2-m=
m2/drivers/usb/input/hid.h
--- linux-2.6.2-rc2-mm2.orig/drivers/usb/input/hid.h	2004-01-30 05:54:18.00=
0000000 -0500
+++ linux-2.6.2-rc2-mm2/drivers/usb/input/hid.h	2004-01-30 06:33:54.0000000=
00 -0500
@@ -201,15 +201,16 @@
  * HID device quirks.
  */
=20
-#define HID_QUIRK_INVERT		0x001
-#define HID_QUIRK_NOTOUCH		0x002
-#define HID_QUIRK_IGNORE		0x004
-#define HID_QUIRK_NOGET			0x008
-#define HID_QUIRK_HIDDEV		0x010
-#define HID_QUIRK_BADPAD		0x020
-#define HID_QUIRK_MULTI_INPUT		0x040
-#define HID_QUIRK_2WHEEL_MOUSE_HACK	0x080
-#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON	0x100
+#define HID_QUIRK_INVERT			0x001
+#define HID_QUIRK_NOTOUCH			0x002
+#define HID_QUIRK_IGNORE			0x004
+#define HID_QUIRK_NOGET				0x008
+#define HID_QUIRK_HIDDEV			0x010
+#define HID_QUIRK_BADPAD			0x020
+#define HID_QUIRK_MULTI_INPUT			0x040
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_BACK	0x080
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA	0x100
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x200
=20
 /*
  * This is the global environment of the parser. This information is

--sdtB3X0nJg68CQEu--

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAGlEFRFMAi+ZaeAERAkmAAJ0ZJt8REu4J8q6U4Aaw8ugY52GgLwCfUEDd
ZPOcaqfdHoXDurLINZklTFs=
=raAW
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
