Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVJ2Ohj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVJ2Ohj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVJ2Ohj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:37:39 -0400
Received: from lug-owl.de ([195.71.106.12]:27116 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751165AbVJ2Ohi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:37:38 -0400
Date: Sat, 29 Oct 2005 16:37:37 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH] drivers/input/keyboard: convert to dynamic input_dev allocation
Message-ID: <20051029143737.GU27184@lug-owl.de>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
References: <1130481024363@kroah.com> <20051028065522.GJ27184@lug-owl.de> <200510280205.35866.dtor_core@ameritech.net> <200510290059.37135.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pzbqGaOtRNiVr7w4"
Content-Disposition: inline
In-Reply-To: <200510290059.37135.dtor_core@ameritech.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pzbqGaOtRNiVr7w4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-10-29 00:59:36 -0500, Dmitry Torokhov <dtor_core@ameritech.net=
> wrote:
> On Friday 28 October 2005 02:05, Dmitry Torokhov wrote:
>  drivers/input/keyboard/lkkbd.c |   28 +++++-----------------------
>  1 files changed, 5 insertions(+), 23 deletions(-)
>=20
> Index: work/drivers/input/keyboard/lkkbd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- work.orig/drivers/input/keyboard/lkkbd.c
> +++ work/drivers/input/keyboard/lkkbd.c
> @@ -440,38 +440,20 @@ lkkbd_interrupt (struct serio *serio, un
>  					input_report_key (lk->dev, lk->keycode[i], 0);
>  			input_sync (lk->dev);
>  			break;
> +
>  		case LK_METRONOME:
> -			DBG (KERN_INFO "Got %#d and don't "
> -					"know how to handle...\n");
> -			break;
>  		case LK_OUTPUT_ERROR:
> -			DBG (KERN_INFO "Got LK_OUTPUT_ERROR and don't "
> -					"know how to handle...\n");
> -			break;
>  		case LK_INPUT_ERROR:
> -			DBG (KERN_INFO "Got LK_INPUT_ERROR and don't "
> -					"know how to handle...\n");
> -			break;
>  		case LK_KBD_LOCKED:
> -			DBG (KERN_INFO "Got LK_KBD_LOCKED and don't "
> -					"know how to handle...\n");
> -			break;
>  		case LK_KBD_TEST_MODE_ACK:
> -			DBG (KERN_INFO "Got LK_KBD_TEST_MODE_ACK and don't "
> -					"know how to handle...\n");
> -			break;
>  		case LK_PREFIX_KEY_DOWN:
> -			DBG (KERN_INFO "Got LK_PREFIX_KEY_DOWN and don't "
> -					"know how to handle...\n");
> -			break;
>  		case LK_MODE_CHANGE_ACK:
> -			DBG (KERN_INFO "Got LK_MODE_CHANGE_ACK and ignored "
> -					"it properly...\n");
> -			break;
>  		case LK_RESPONSE_RESERVED:
> -			DBG (KERN_INFO "Got LK_RESPONSE_RESERVED and don't "
> -					"know how to handle...\n");
> +			DBG (KERN_INFO
> +			     "Got 0x%02x and don't know how to handle...\n",
> +			     data);
>  			break;
> +
>  		case 0x01:
>  			DBG (KERN_INFO "Got 0x01, scheduling re-initialization\n");
>  			lk->ignore_bytes =3D LK_NUM_IGNORE_BYTES;

That'll greatly help in debugging it if needed. Thanks.

If you really want to make that switch smaller, please put some small
table like

#define RESPONSE(x) { .value =3D x, .name =3D #x, }
struct {
	unsigned char value;
	unsigned char *name;
} response[] {
	RESPONSE (LK_KBD_TEST_MODE_ACK),
	RESPONSE (LK_PREFIX_KEY_DOWN),
	...
};

into the driver along with a small search function like

unsigned char *
find_response_name (unsigned char value)
{
	int i;

	for (i =3D 0; i < ARRAY_SIZE (response); i++)
		if (response[i].value =3D=3D value)
			return response[i].name;
=09
	return NULL;
}

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--pzbqGaOtRNiVr7w4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDY4kxHb1edYOZ4bsRAq3NAJ92EsLxZQ87XKWw36ZKiGUhA3dCPgCfQq4R
x7Pd4rMKv+5HWzZABdl+GY4=
=OM5d
-----END PGP SIGNATURE-----

--pzbqGaOtRNiVr7w4--
