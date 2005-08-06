Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263550AbVHFUz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263550AbVHFUz1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 16:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbVHFUz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 16:55:27 -0400
Received: from mailin1.k-net.dk ([82.211.192.11]:44302 "EHLO mailin1.k-net.dk")
	by vger.kernel.org with ESMTP id S263550AbVHFUzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 16:55:24 -0400
Subject: Re: Oops when shutting down laptop
From: Kristian =?ISO-8859-1?Q?Gr=F8nfeldt_S=F8rensen?= <kriller@vkr.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050804230818.7d4df88a.akpm@osdl.org>
References: <1123186901.8831.42.camel@localhost.localdomain>
	 <20050804230818.7d4df88a.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LTfj2gYMZFrx6e4sOODl"
Date: Sat, 06 Aug 2005 22:55:23 +0200
Message-Id: <1123361723.8424.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LTfj2gYMZFrx6e4sOODl
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the info.
I am now running 2.6.12-rc5-git4 and it seems that the problem has been
solved. No oops'es  so far.

Thanks=20

/Kristian


On Thu, 2005-08-04 at 23:08 -0700, Andrew Morton wrote:
> Kristian Gr=F8nfeldt S=F8rensen <kriller@vkr.dk> wrote:
> >
> > My laptop oops'es in the final phase of shutdown. It started this
> >  Monday. I don't remember having done anything particular with respect =
to
> >  the kernel around that time. It only happens when going to runlevel 0 =
-
> >  a reboot does not result in an oops.
> >=20
> >  Until yesterday i used kernel 2.6.13-rc3, but i have now compiled
> >  2.6.13-rc5 with some debugging support. However the problem persists.
> >=20
> >  Since the oops happens so late in the shutdown-sequence, that all
> >  filesystems has been unmounted, i am unable to capture the oops on the
> >  disc, but a picture of the oops is available at
> >  http://www.vkr.dk/~kriller/oops.jpg . (Sorry for not writing the oops =
in
> >  this mail).
> >=20
> >  I tried to remove all modules except speedstep_centrino, freqtable,
> >  processor and ipv6 (reported as being in use),  before calling powerof=
f,
> >  but with no change.
>=20
> We've been busily reverting new power management patches and it's likely
> that we fixed this one in the past day or so.  So please test 2.6.13-rc6
> when it comes out, or 2.6.13-rc5-git3 which is about three hours away,
> thanks.
>=20
> If it still happens please add the below patch so we can work out the
> offending device.  Or apply it anyway - we may have a buggy driver which
> will just bite us again later.
>=20
> Thanks.
>=20
> --- devel/drivers/base/power/suspend.c~a	2005-08-04 23:06:27.000000000 -0=
700
> +++ devel-akpm/drivers/base/power/suspend.c	2005-08-04 23:08:06.000000000=
 -0700
> @@ -92,6 +92,8 @@ int device_suspend(pm_message_t state)
>  		get_device(dev);
>  		up(&dpm_list_sem);
> =20
> +		printk("Suspending device %s\n", kobject_name(&dev->kobj));
> +
>  		error =3D suspend_device(dev, state);
> =20
>  		down(&dpm_list_sem);
> _
>=20
>=20

--=-LTfj2gYMZFrx6e4sOODl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC9SO7fHDihydQNssRAmS9AJ93N7WkvzMTVSJkud46oViouAVAiQCeKGMr
MDztSPYreWX59EuJ2GkoOs0=
=wT2t
-----END PGP SIGNATURE-----

--=-LTfj2gYMZFrx6e4sOODl--
