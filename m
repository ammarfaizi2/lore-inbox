Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbUA3Ksf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 05:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUA3Kse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 05:48:34 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:12549 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S262965AbUA3Ksb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 05:48:31 -0500
Date: Fri, 30 Jan 2004 05:48:29 -0500
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-rc2-mm1
Message-ID: <20040130104829.GA2505@babylon.d2dc.net>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@osdl.org>
References: <20040127233402.6f5d3497.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20040127233402.6f5d3497.akpm@osdl.org>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2004 at 11:34:02PM -0800, Andrew Morton wrote:
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2=
=2E6.2-rc2-mm1/
>=20
> - From now on, -mm kernels will contain the latest contents of:
>=20
> 	Vojtech's tree:		input.patch

This one seems to have a rather problematic patch, which I can't find
any explanation for.

Specificly:
<snip>
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Thu Jan 29 22:57:25 2004
+++ b/drivers/usb/input/hid-input.c	Thu Jan 29 22:57:25 2004
@@ -432,20 +432,21 @@
 	input_regs(input, regs);
=20
 	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
-			&& (usage->code =3D=3D BTN_BACK)) {
+			&& (usage->code =3D=3D BTN_BACK || usage->code =3D=3D BTN_EXTRA)) {
 		if (value)
 			hid->quirks |=3D HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
 		else
 			hid->quirks &=3D ~HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
 		return;
 	}
<snip>

This seems to be due to trying to use the same flag for
USB_DEVICE_ID_CYPRESS_MOUSE as well, however this is very wrong.

The original user of HID_QUIRK_2WHEEL_MOUSE_HACK,
USB_DEVICE_ID_A4TECH_WCP32PU, actually /HAS/ a button labeled BTN_EXTRA,
which after this patch can no longer even be used.

The only proper approach is to rename HID_QUIRK_2WHEEL_MOUSE_HACK and
add a new one for the Cypress mouse as well.

If need be I can generate such a patch, however I will need to know what
to generate it against.

Zephaniah E. Hull.
(Original author of the HID_QUIRK_2WHEEL_MOUSE_HACK patch.)

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

If I have trouble installing Linux, something is wrong. Very wrong.
  -- Linus Torvalds on l-k.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAGjZ9RFMAi+ZaeAERAnkCAJ9o9F4DNgXDah7WE8T8/17H6YQNmQCcCWK/
e24EwAE2y7KBGww6iEZUdUM=
=HDH6
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
