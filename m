Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269213AbUJKUDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269213AbUJKUDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 16:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269214AbUJKUDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 16:03:48 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:35000 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S269213AbUJKUDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 16:03:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] softdog.c (was: Kernel panic after rmmod softdog (2.6.8.1))
Date: Mon, 11 Oct 2004 22:00:30 +0200
User-Agent: KMail/1.6.2
Cc: Michael Schierl <schierlm@gmx.de>, Joel Becker <joel.becker@oracle.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Wim Van Sebroeck <wim@iguana.be>
References: <200410111304_MC3-1-8C02-813F@compuserve.com>
In-Reply-To: <200410111304_MC3-1-8C02-813F@compuserve.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_hZuaBdD0dIR7L4k";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410112200.33997.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_hZuaBdD0dIR7L4k
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Maandag 11 Oktober 2004 19:01, Chuck Ebbert wrote:

> --- linux-2.6.8.1/drivers/char/watchdog/softdog.c.orig  Sun Oct 10 23:08:=
24 2004
> +++ linux-2.6.8.1/drivers/char/watchdog/softdog.c       Sun Oct 10 23:10:=
12 2004
> @@ -135,8 +135,9 @@
>  {
>         if(test_and_set_bit(0, &timer_alive))
>                 return -EBUSY;
> -       if (nowayout)
> -               __module_get(THIS_MODULE);
> +
> +       __module_get(THIS_MODULE);
> +
>         /*
>          *      Activate timer
>          */
> @@ -152,6 +153,7 @@
>          */
>         if (expect_close =3D=3D 42) {
>                 softdog_stop();
> +               module_put(THIS_MODULE);
>         } else {
>                 printk(KERN_CRIT PFX "Unexpected close, not stopping watc=
hdog!\n");
>                 softdog_keepalive();
>=20
Now if you do open(), close(), open(), write("V"), close(), the module
becomes unremovable, even without nowayout=3D1. Isn't is possible to
simply add a softdog_stop() call to watchdog_exit()?

	Arnd <><

--Boundary-02=_hZuaBdD0dIR7L4k
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBauZh5t5GS2LDRf4RAtAMAJ9esbw9awsrhVQS7gdcHV9lZubyAgCfdBwr
TeCljapph8Xf5PBPm4T/+uI=
=35uA
-----END PGP SIGNATURE-----

--Boundary-02=_hZuaBdD0dIR7L4k--
