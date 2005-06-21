Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVFUJMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVFUJMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVFUJJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 05:09:50 -0400
Received: from relay.rost.ru ([80.254.111.11]:190 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S262078AbVFUJEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 05:04:47 -0400
Date: Tue, 21 Jun 2005 13:04:42 +0400
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] cleanup patches for strings
Message-ID: <20050621090442.GD18900@pazke>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.9i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 172, 06 21, 2005 at 12:46:26AM +0200, Jesper Juhl wrote:
> Hi,
>=20
> I have a bunch (few hundred) of oneliners like the ones below lying aroun=
d=20
> on my HD and I'm wondering what the best way to submit them is.
>=20
> The patches all make the same change, there's just a lot of files the=20
> change needs to be made in.  The change they make is to change strings=20
> from the form
> 	[const] char *foo =3D "blah";
> to
> 	[const] char foo[] =3D "blah";
>=20
> The reason to do this was well explained by Jeff Garzik in the past (and=
=20
> now found in the Kernel Janitors TODO) :
>=20
> -------------------------------------------------------------------------=
----
> From: Jeff Garzik <jgarzik at mandrakesoft dot com>
>=20
> The string form
>=20
>         [const] char *foo =3D "blah";
>=20
> creates two variables in the final assembly output, a static string, and
> a char pointer to the static string.  The alternate string form
>=20
>         [const] char foo[] =3D "blah";
>=20
> is better because it declares a single variable.
>=20
> For variables marked __initdata, the "*foo" form causes only the
> pointer, not the string itself, to be dropped from the kernel image,
> which is a bug.  Using the "foo[]" form with regular 'ole local
> variables also makes the assembly shorter.
> -------------------------------------------------------------------------=
----
>=20
> What I did was make a small sed script to blindly change all occourances=
=20
> of the first form into the second. Of course this won't always work, sinc=
e=20
> the second form is not always good if we later assign something to the=20
> variable, but it provided a starting point.  I'm now in the process of=20
> weeding out the false positives so that I'll be left with all the patches=
=20
> that actually make a sane change.
>=20
> As for submitting them. I was planning to split them into groups based on=
=20
> top-level kernel source dirs, then concatenate all the patches for one di=
r=20
> into one large patch and send it to lkml + CC:akpm (this would mean <=3D1=
1=20
> patches) - sending each patch to a sepperate maintainer would make it a=
=20
> nightmare and would take ages. Andrew: would you be OK with that? Are=20
> patches like these even wanted?
>=20
>=20
> Below I've just picked 5 of my patches at random to show you what they=20
> look like. These should not be merged yet.
>=20
>=20
> --- linux-2.6.12-orig/drivers/isdn/hardware/avm/b1.c	2005-06-17 21:48:29.=
000000000 +0200
> +++ linux-2.6.12/drivers/isdn/hardware/avm/b1.c	2005-06-20 00:04:10.00000=
0000 +0200
> @@ -28,7 +28,7 @@
>  #include <linux/isdn/capicmd.h>
>  #include <linux/isdn/capiutil.h>
> =20
> -static char *revision =3D "$Revision: 1.1.2.2 $";
> +static char revision[] =3D "$Revision: 1.1.2.2 $";
> =20
>  /* ------------------------------------------------------------- */
> =20
> --- linux-2.6.12-orig/drivers/net/wireless/wavelan_cs.p.h	2005-06-17 21:4=
8:29.000000000 +0200
> +++ linux-2.6.12/drivers/net/wireless/wavelan_cs.p.h	2005-06-20 00:04:11.=
000000000 +0200
> @@ -512,7 +512,7 @@
>  /************************ CONSTANTS & MACROS ************************/
> =20
>  #ifdef DEBUG_VERSION_SHOW
> -static const char *version =3D "wavelan_cs.c : v24 (SMP + wireless exten=
sions) 11/1/02\n";
> +static const char version[] =3D "wavelan_cs.c : v24 (SMP + wireless exte=
nsions) 11/1/02\n";
>  #endif
> =20
>  /* Watchdog temporisation */
>=20
> --- linux-2.6.12-orig/drivers/net/appletalk/cops.c	2005-06-17 21:48:29.00=
0000000 +0200
> +++ linux-2.6.12/drivers/net/appletalk/cops.c	2005-06-20 00:04:11.0000000=
00 +0200
> @@ -84,7 +84,7 @@ static const char *version =3D
>   *      io regions, irqs and dma channels
>   */
> =20
> -static const char *cardname =3D "cops";
> +static const char cardname[] =3D "cops";
> =20
>  #ifdef CONFIG_COPS_DAYNA
>  static int board_type =3D DAYNA;	/* Module exported */
>=20
> --- linux-2.6.12-orig/drivers/net/sun3lance.c	2005-06-17 21:48:29.0000000=
00 +0200
> +++ linux-2.6.12/drivers/net/sun3lance.c	2005-06-20 00:04:11.000000000 +0=
200
> @@ -21,7 +21,7 @@
>   =20
>  */
> =20
> -static char *version =3D "sun3lance.c: v1.2 1/12/2001  Sam Creasey (samm=
y@sammy.net)\n";
> +static char version[] =3D "sun3lance.c: v1.2 1/12/2001  Sam Creasey (sam=
my@sammy.net)\n";
> =20
>  #include <linux/module.h>
>  #include <linux/stddef.h>
>=20
> --- linux-2.6.12-orig/drivers/net/ibmlana.c	2005-06-17 21:48:29.000000000=
 +0200
> +++ linux-2.6.12/drivers/net/ibmlana.c	2005-06-20 00:04:11.000000000 +0200
> @@ -842,7 +842,7 @@ static int ibmlana_tx(struct sk_buff *sk
>  	   Sorry Linus for the filler string but I couldn't resist ;-) */
> =20
>  	if (tmplen > skb->len) {
> -		char *fill =3D "NetBSD is a nice OS too! ";
> +		char fill[] =3D "NetBSD is a nice OS too! ";

This string definitely needs static const attribute.

>  		unsigned int destoffs =3D skb->len, l =3D strlen(fill);
> =20
>  		while (destoffs < tmplen) {
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCt9gqR2OTnxNuAyMRAj6/AJ99LueC4hxZm4jYGIDuoQdxa0CxRgCgrBca
CD3qhjocmhi8iPU2bXXD2aU=
=YOVz
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
