Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965914AbWKXSQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965914AbWKXSQK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 13:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965916AbWKXSQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 13:16:10 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:24202 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S965914AbWKXSQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 13:16:08 -0500
X-Sasl-enc: c+B13ghoKxspGTHGb3G8oOrD67oeleSIVX3ABU/eEPw3 1164392168
Message-ID: <45673798.1010808@imap.cc>
Date: Fri, 24 Nov 2006 19:19:04 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
CC: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH 4/33] usb: usb-gigaset free kill urb
 cleanup
References: <200611062228.38937.m.kozlowski@tuxland.pl>	<200611071030.57152.m.kozlowski@tuxland.pl>	<20061107013702.46b5710f.akpm@osdl.org> <200611081534.18562.m.kozlowski@tuxland.pl>
In-Reply-To: <200611081534.18562.m.kozlowski@tuxland.pl>
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBB04CA0172CFD8CF6232598E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBB04CA0172CFD8CF6232598E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply. I had overlooked this.

Am 08.11.2006 15:34 schrieb Mariusz Kozlowski:
> Hello,
>=20
> - usb_free_urb() cleanup
> - usb_kill_urb() cleanup
>=20
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

Acked-by: Tilman Schmidt <tilman@imap.cc>

> --- linux-2.6.19-rc4-orig/drivers/isdn/gigaset/usb-gigaset.c	2006-11-06=
 17:07:30.000000000 +0100
> +++ linux-2.6.19-rc4/drivers/isdn/gigaset/usb-gigaset.c	2006-11-07 16:5=
1:17.000000000 +0100
> @@ -815,14 +815,11 @@ static int gigaset_probe(struct usb_inte
>  	return 0;
> =20
>  error:
> -	if (ucs->read_urb)
> -		usb_kill_urb(ucs->read_urb);
> +	usb_kill_urb(ucs->read_urb);
>  	kfree(ucs->bulk_out_buffer);
> -	if (ucs->bulk_out_urb !=3D NULL)
> -		usb_free_urb(ucs->bulk_out_urb);
> +	usb_free_urb(ucs->bulk_out_urb);
>  	kfree(cs->inbuf[0].rcvbuf);
> -	if (ucs->read_urb !=3D NULL)
> -		usb_free_urb(ucs->read_urb);
> +	usb_free_urb(ucs->read_urb);
>  	usb_set_intfdata(interface, NULL);
>  	ucs->read_urb =3D ucs->bulk_out_urb =3D NULL;
>  	cs->inbuf[0].rcvbuf =3D ucs->bulk_out_buffer =3D NULL;
> @@ -850,11 +847,9 @@ static void gigaset_disconnect(struct us
>  	usb_kill_urb(ucs->bulk_out_urb);	/* FIXME: only if active? */
> =20
>  	kfree(ucs->bulk_out_buffer);
> -	if (ucs->bulk_out_urb !=3D NULL)
> -		usb_free_urb(ucs->bulk_out_urb);
> +	usb_free_urb(ucs->bulk_out_urb);
>  	kfree(cs->inbuf[0].rcvbuf);
> -	if (ucs->read_urb !=3D NULL)
> -		usb_free_urb(ucs->read_urb);
> +	usb_free_urb(ucs->read_urb);
>  	ucs->read_urb =3D ucs->bulk_out_urb =3D NULL;
>  	cs->inbuf[0].rcvbuf =3D ucs->bulk_out_buffer =3D NULL;


--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigBB04CA0172CFD8CF6232598E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFZzeiMdB4Whm86/kRAiswAJsElVyffsmt9oMhkG+IO3GNqoCOTQCfYKnh
4SpzqWReuq4VUejge4wTPjw=
=zfWd
-----END PGP SIGNATURE-----

--------------enigBB04CA0172CFD8CF6232598E--
