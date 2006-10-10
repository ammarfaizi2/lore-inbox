Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbWJJMAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWJJMAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWJJMAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:00:21 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:59325 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965040AbWJJMAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:00:19 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6.19 patch] drivers/char/specialix.c: fix the baud conversion
Date: Tue, 10 Oct 2006 14:01:19 +0200
User-Agent: KMail/1.9.4
Cc: Rogier Wolff <R.E.Wolff@bitwizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
References: <20061008221818.GL6755@stusta.de> <20061009063744.GB2877@bitwizard.nl> <20061010061747.GC3650@stusta.de>
In-Reply-To: <20061010061747.GC3650@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2137570.0jQAShu9Oa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610101401.20295.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2137570.0jQAShu9Oa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Adrian Bunk wrote:
> On Mon, Oct 09, 2006 at 08:37:45AM +0200, Rogier Wolff wrote:
> > On Mon, Oct 09, 2006 at 12:18:19AM +0200, Adrian Bunk wrote:
> > > +       if (baud =3D=3D 38400) {
> > >                 if ((port->flags & ASYNC_SPD_MASK) =3D=3D ASYNC_SPD_H=
I)
> > >                         baud ++;
> > >                 if ((port->flags & ASYNC_SPD_MASK) =3D=3D ASYNC_SPD_V=
HI)
> > >                         baud +=3D 2;
> > >         }
> > >
> > > Increasing the index for baud_table[] by 1 or 2 is quite different fr=
om
> > > increasing baud by 1 or 2.
> >
> > In that range,
> > 	baud <<=3D 1;
> > and
> > 	baud <<=3D 2;
> >
> > should work.
>
> Thanks for the hint.
>
> What about the patch below?

> @@ -1090,9 +1085,9 @@
>
>  	if (baud =3D=3D 38400) {
>  		if ((port->flags & ASYNC_SPD_MASK) =3D=3D ASYNC_SPD_HI)
> -			baud ++;
> +			baud <<=3D 1;
>  		if ((port->flags & ASYNC_SPD_MASK) =3D=3D ASYNC_SPD_VHI)
> -			baud +=3D 2;
> +			baud <<=3D 2;
>  	}
>
>  	if (!baud) {

Neither is 38400 <<=3D 1 =3D=3D 57600 nor is 38400 <<=3D 2 =3D=3D 115200. Y=
ou should just=20
set baud to the value you want instead of doing tricks here.

Eike

--nextPart2137570.0jQAShu9Oa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFK4uQXKSJPmm5/E4RArphAKCHgYkz8ZjtHvdxxtsoybgwJp8qYwCfaaUg
RtsfEUGtJLii1aUh/NbLCnA=
=e7AX
-----END PGP SIGNATURE-----

--nextPart2137570.0jQAShu9Oa--
