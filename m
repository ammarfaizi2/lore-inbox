Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWJDUUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWJDUUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWJDUUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:20:11 -0400
Received: from remus.commandcorp.com ([130.205.32.4]:15828 "EHLO
	remus.wittsend.com") by vger.kernel.org with ESMTP id S1751088AbWJDUUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:20:08 -0400
Subject: Re: [PATCH] Char: remove unneded termbits redefinitions
From: "Michael H. Warfield" <mhw@WittsEnd.com>
Reply-To: mhw@WittsEnd.com
To: Jiri Slaby <jirislaby@gmail.com>
Cc: mhw@WittsEnd.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, support@moxa.com.tw
In-Reply-To: <1236876321987@karneval.cz>
References: <1236876321987@karneval.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PIeruSt8YY1Nm987nVIZ"
Organization: Thaumaturgy & Speculums Technology
Date: Wed, 04 Oct 2006 16:09:41 -0400
Message-Id: <1159992581.6730.50.camel@canyon.wittsend.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-WittsEnd-MailScanner-Information: Please contact the ISP for more information
X-WittsEnd-MailScanner: Found to be clean
X-WittsEnd-MailScanner-From: mhw@wittsend.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PIeruSt8YY1Nm987nVIZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-04 at 18:49 +0200, Jiri Slaby wrote:
> Char, remove unneded termbits redefinitions
>=20
> No need to redefine termbits in char tree.
>=20
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Michael H. Warfield <mhw@wittsend.com>

> ---
> commit b886c49c87ee91a038b917f6933183db8ae58125
> tree 222a9b1893f7d8f52ec3326bbc634296d1ab5603
> parent 6545715838791f2e9f1501b5b48fae69f2d82d35
> author Jiri Slaby <jirislaby@gmail.com> Wed, 04 Oct 2006 18:41:15 +0200
> committer Jiri Slaby <xslaby@anemoi.localdomain> Wed, 04 Oct 2006 18:41:1=
5 +0200
>=20
>  drivers/char/ip2/ip2ioctl.h |   35 -----------------------------------
>  drivers/char/ip2/ip2main.c  |    1 -
>  drivers/char/mxser.c        |    7 -------
>  drivers/char/mxser_new.c    |    3 ---
>  4 files changed, 0 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/char/ip2/ip2ioctl.h b/drivers/char/ip2/ip2ioctl.h
> deleted file mode 100644
> index aa0a9da..0000000
> --- a/drivers/char/ip2/ip2ioctl.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/***********************************************************************=
********
> -*
> -*   (c) 1998 by Computone Corporation
> -*
> -************************************************************************=
********
> -*
> -*
> -*   PACKAGE:     Linux tty Device Driver for IntelliPort II family of mu=
ltiport
> -*                serial I/O controllers.
> -*
> -*   DESCRIPTION: Driver constants for configuration and tuning
> -*
> -*   NOTES:
> -*
> -************************************************************************=
*******/
> -
> -#ifndef IP2IOCTL_H
> -#define IP2IOCTL_H
> -
> -//*************
> -//* Constants *
> -//*************
> -
> -// High baud rates (if not defined elsewhere.
> -#ifndef B153600  =20
> -#	define B153600   0010005
> -#endif
> -#ifndef B307200  =20
> -#	define B307200   0010006
> -#endif
> -#ifndef B921600  =20
> -#	define B921600   0010007
> -#endif
> -
> -#endif
> diff --git a/drivers/char/ip2/ip2main.c b/drivers/char/ip2/ip2main.c
> index 62ef511..30e839c 100644
> --- a/drivers/char/ip2/ip2main.c
> +++ b/drivers/char/ip2/ip2main.c
> @@ -123,7 +123,6 @@ #include <asm/uaccess.h>
> =20
>  #include "ip2types.h"
>  #include "ip2trace.h"
> -#include "ip2ioctl.h"
>  #include "ip2.h"
>  #include "i2ellis.h"
>  #include "i2lib.h"
> diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
> index 04bdcb6..af05faa 100644
> --- a/drivers/char/mxser.c
> +++ b/drivers/char/mxser.c
> @@ -1500,10 +1500,6 @@ static int mxser_ioctl(struct tty_struct
>  	return 0;
>  }
> =20
> -#ifndef CMSPAR
> -#define	CMSPAR 010000000000
> -#endif
> -
>  static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
>  {
>  	int i, result, status;
> @@ -2554,9 +2550,6 @@ static int mxser_change_speed(struct mxs
>  	if (!(info->base))
>  		return ret;
> =20
> -#ifndef B921600
> -#define B921600 (B460800 +1)
> -#endif
>  	if (mxser_set_baud_method[info->port] =3D=3D 0) {
>  		baud =3D tty_get_baud_rate(info->tty);
>  		mxser_set_baud(info, baud);
> diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
> index cb9c865..a555dda 100644
> --- a/drivers/char/mxser_new.c
> +++ b/drivers/char/mxser_new.c
> @@ -592,9 +592,6 @@ static int mxser_change_speed(struct mxs
>  	if (!(info->ioaddr))
>  		return ret;
> =20
> -#ifndef B921600
> -#define B921600 (B460800 +1)
> -#endif
>  	if (mxser_set_baud_method[info->tty->index] =3D=3D 0) {
>  		baud =3D tty_get_baud_rate(info->tty);
>  		mxser_set_baud(info, baud);
--=20
Michael H. Warfield (AI4NB) | (770) 985-6132 |  mhw@WittsEnd.com
   /\/\|=3Dmhw=3D|\/\/          | (678) 463-0932 |  http://www.wittsend.com=
/mhw/
   NIC whois: MHW9          | An optimist believes we live in the best of a=
ll
 PGP Key: 0xDF1DD471        | possible worlds.  A pessimist is sure of it!


--=-PIeruSt8YY1Nm987nVIZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQCVAwUARSQVBeHJS0bfHdRxAQJnYAP/YLqrdklD1BwaSUzKhAISk/j0Afe7mKHj
kBQrBcfJkeX+b0wIQ0ODBMBEUSwSZNk5MgzdPJu4+bLHUmBSD3obxwpv1ozjfERE
z/Rwt60uXFS4s9mtuKyoqiMmtUiuGWZzP8nEHnesvXA49+tl3nLDXbDJUtj7ubvI
kEizI8Zxd+U=
=ffUZ
-----END PGP SIGNATURE-----

--=-PIeruSt8YY1Nm987nVIZ--

