Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVBIROr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVBIROr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 12:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVBIROq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 12:14:46 -0500
Received: from lug-owl.de ([195.71.106.12]:17844 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261852AbVBIROj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 12:14:39 -0500
Date: Wed, 9 Feb 2005 18:14:38 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Cc: Paulo Marques <pmarques@grupopie.com>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050209171438.GI10594@lug-owl.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>,
	Paulo Marques <pmarques@grupopie.com>,
	Vojtech Pavlik <vojtech@suse.cz>
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2MeieX8lS1K8IJ9W"
Content-Disposition: inline
In-Reply-To: <20050209170015.GC16670@ucw.cz>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2MeieX8lS1K8IJ9W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-09 18:00:15 +0100, Vojtech Pavlik <vojtech@suse.cz>
wrote in message <20050209170015.GC16670@ucw.cz>:
> On Wed, Feb 09, 2005 at 01:23:27PM +0000, Paulo Marques wrote:
> > Vojtech Pavlik wrote:
> > >Hi!
> > >
> > >I've written a driver for probably the most common touchscreen type -
> > >the serial Elo touchscreen.
> >=20
> > If we are serious about getting support for serial touchscreens into th=
e=20
> > kernel, I can certainly give a hand there.
>=20
> I want serious support for ALL touchscreens in Linux.

Maybe I'd write drivers for the T-Sharc and fujitsu controllers, too.
These are in a lot of POS hardware, too, and sometimes they're a pain to
use (esp. calibration).

Linux at the Point Of Sale is quite well running (I'm employed at a POS
software company).

> And I'm glad there is interest. :)

If I find a minute, I'll possibly give it a test run. I've got actual
hardware around.

> > Also, I've already seen touchscreens where the POS manufacturer got the=
=20
> > pin-out wrong (or something like that) so the touch reports the X=20
> > coordinate where the Y should be, and vice-versa. I really don't know=
=20
> > where this should be handled (driver, input layer, application?), but i=
t=20
> > must be handled somewhere for the applications to work.
>=20
> I think the best place would be in the X event driver, if X is used, or
> the graphics toolkit, and worst case the application.

First of all, we need a really properly working Linux event driver in
XFree86/X.Org.  I'm not sure if this is already the case.

> I don't believe the mirroring/flipping is kernel's job, since it tries
> to always pass the data with the least amount of transformation applied
> to achieve hardware abstraction.

ACK. Should be handled by XFree86's driver.

Additionally, there are two other things that need to be addressed (and
I'm willing to actually write code for this, but need input from other
parties, too:)

	- Touchscreen calibration
		Basically all these touchscreens are capable of being
		calibrated. It's not done with just pushing the X/Y
		values the kernel receives into the Input API. These
		beasts may get physically mis-calibrated and eg. report
		things like (xmax - xmin) <=3D 20, so resolution would be
		really bad and kernel reported min/max values were only
		"theoretical" values, based on the protocol specs.

		I think about a simple X11 program for this. Comments?

	- POS keyboards
		These are real beasties. Next to LEDs and keycaps, they
		can contain barcode scanners, magnetic card readers and
		displays. Right now, there's no good API to pass
		something as complex as "three-track magnetic stripe
		data" or a whole scanned EAN barcode. Also, some
		keyboards can be written to (change display contents,
		switch on/off scanners, ...).

		This is usually "solved" with a little patch that allows
		userspace to write to the keyboard (/dev/psaux like),
		but this is a bad hack (just look at the patches
		floating around for this...).

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--2MeieX8lS1K8IJ9W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCCkT+Hb1edYOZ4bsRAvuGAJ9YMGrVsCH1uKKqBgEw+VSbtCwi9gCfb9cd
rgEULRfGKS0kiJDKQbyRBlM=
=BXGu
-----END PGP SIGNATURE-----

--2MeieX8lS1K8IJ9W--
