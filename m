Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSKRIUi>; Mon, 18 Nov 2002 03:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSKRIUi>; Mon, 18 Nov 2002 03:20:38 -0500
Received: from ppp-217-133-216-163.dialup.tiscali.it ([217.133.216.163]:11905
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S261644AbSKRIUh>; Mon, 18 Nov 2002 03:20:37 -0500
Subject: Re: [patch] threading fix, tid-2.5.47-A3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD8A306.3040109@redhat.com>
References: <Pine.LNX.4.44.0211172003050.1206-100000@home.transmeta.com>
	<1037606831.1774.13.camel@ldb>  <3DD8A306.3040109@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ptoHREeIDFMZoJ2YheTO"
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Nov 2002 09:27:29 +0100
Message-Id: <1037608049.1774.41.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ptoHREeIDFMZoJ2YheTO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > You could avoid the additional pointer by letting
> > child_tidptr =3D (!(flags & CLONE_VM) && current->user_tid) ?
> > current->user_tid : parent_tidptr;
>=20
> This doesn't work since it would overwrite the TID field in the calling
> thread's descriptor.
No: for the pthread_create case you would pass the pointer to new struct
pthread tid in parent_tidptr, while for fork you would pass the
parameter of cfork as parent_tidptr and child_tidptr would be inherited.

However I don't think that this is a good interface, just a bit better
than having two flags and a single pointer.


--=-ptoHREeIDFMZoJ2YheTO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA92KRxdjkty3ft5+cRAohTAJ4gttuImeeSB9ivuYdkb5EZSCuWdACfUskO
D8qgG0tqSHw5g6W4r+tfIwY=
=Zra3
-----END PGP SIGNATURE-----

--=-ptoHREeIDFMZoJ2YheTO--
