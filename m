Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVBIVkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVBIVkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 16:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVBIVkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 16:40:11 -0500
Received: from lug-owl.de ([195.71.106.12]:18617 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261938AbVBIVjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 16:39:31 -0500
Date: Wed, 9 Feb 2005 22:39:30 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050209213930.GM10594@lug-owl.de>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com> <20050209195854.GJ10594@lug-owl.de> <420A77DF.6040108@grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RU5vHP6eAM91MAfE"
Content-Disposition: inline
In-Reply-To: <420A77DF.6040108@grupopie.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RU5vHP6eAM91MAfE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-09 20:51:43 +0000, Paulo Marques <pmarques@grupopie.com>
wrote in message <420A77DF.6040108@grupopie.com>:
> Jan-Benedict Glaw wrote:
> >On Wed, 2005-02-09 18:08:10 +0000, Paulo Marques <pmarques@grupopie.com>
> >wrote in message <420A518A.9040500@grupopie.com>:
> >That's IMHO not brain-damaged, but pure physics: just consider scratches
> >or dust (or other substances) applied to the touch foil. This happens
> >all the time, so the touch screen gets out of calibration. This won't
> >happen on a screen used only twice a day. But think about a touch screen
> >that's tortured all the day with pencils, finger rings, dirty fingers,
>=20
> The brain-damaged part wasn't the calibration. It was the calibration=20
> being done in the touchscreen itself, instead of letting the PC handle=20
> it for them. We will always need calibration, of course.

Again, you cannot map 0..\inf Ohm or 0..\inf nF to a given set
[0..0xffff] of coordinates. The physical characteristics of touchscreens
*can* change, so you need to recalibrate the A/D converter itself.

> >Min/Max values (as of protocol theory) is possibly not the very best you
> >can do with the hardware. I more thing about submitting these (after
> >physical calibration) to the kernel driver to supply them to it's users.
>=20
> You're missing my point completely... :(
>=20
> What I was suggesting was that we don't use physical calibration *at all*.

But there *needs* to be a way to do that. I don't want to place this
functionality into the kernel, but we need to have a program for that at
some time. Current solutions are bad hacks and don't actually work
reliably.

> We let the touch screen send the widest range it can muster, so that we=
=20
> don't have quantization errors. We then calibrate in software as for any=
=20
> other touch screen, using the coordinates sent as "raw data".

That cannot be done. Just hit a resistor-based touchscreen once with a
hammer. You'll probably see that you need a physical recalibration
then... Or flood it with water-solved citronic acid and let is on the
screen for some days. That's funny, but it's real life...

> >>Modern touchscreens just send the A/D data to the PC, and let the real=
=20
> >>processor do the math (it can even do more complex calculations, like=
=20
> >>compensate for rotation, etc.). IMHO calibration should be handled by=
=20
> >>software.
> >
> >Is this done eg. by Elo, Mutouch, Fujitsu, T-Sharc (to only name the
> >most common)? I don't think so...
>=20
> If you don't try to configure the "physical calibration" of a Elo,=20
> MuTouch, etc, they send coordinates in a nice 0..2^N-1 format. That is=20
> the best approach IMHO.

It is -- as long as the physical characteristics don't change all that
much. Unfortunately (at least for real-life POS usage) this happens
frequently.

> >[...]
> >This only happens if you don't configurethe MSR properly :-) Most of
> >them can be configured to send quite complex (as in: structured) init
> >sequences that cannot be generated by a keyboard (ie multiple break
> >codes without make codes and the like).=20
>=20
> Even if they can not be generated by a keyboard, if you don't handle=20
> them in special way, you'll get a lot of rubbish. We do handle the=20
> special sequences when available, but there still barcode scanners that=
=20
> don't generate a nice sequence.
>=20
> There are even barcode scanners that generate things like <press=20
> Alt>+<numeric X>+<numeric Y>+<numeric Z>+<release Alt> without even=20
> bothering to release the numeric keys, to generate ASCII code XYZ :P

Which then either needs to be parsed by userspace (which needs access to
raw make/break codes and be able to send data to the kbd) or we write
keyboard-specific Input API drivers for them.

However, a userspace library for that (if raw access to the keyboard is
given) could do the same job.

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

--RU5vHP6eAM91MAfE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCCoMSHb1edYOZ4bsRAoXFAKCM9AqMHHvRFjWv26vj543njEQ9oACfQlFM
0IC5Vipkiy7FV/R4PRGlOvc=
=Vpdy
-----END PGP SIGNATURE-----

--RU5vHP6eAM91MAfE--
