Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTKNN3n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 08:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTKNN3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 08:29:32 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:30083 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262540AbTKNN3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 08:29:30 -0500
Subject: Re: ptrace + ioctl( LOOP_SET_FD ) brokeness.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Bernhard Kaindl <bernhard.kaindl@gmx.de>
Cc: "Erik A. Hendriks" <hendriks@lanl.gov>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.56.0311141243030.19155@wotan.suse.de>
References: <20031113215506.GO23534@lanl.gov>
	 <Pine.LNX.4.56.0311141243030.19155@wotan.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EPDyZBvukffOaZqJ2Isv"
Organization: Red Hat, Inc.
Message-Id: <1068816558.5206.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 14 Nov 2003 14:29:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EPDyZBvukffOaZqJ2Isv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-11-14 at 14:09, Bernhard Kaindl wrote:

> The reason for the process hang seems to be the way loop_set_fd calls cal=
ls
> kernel_thread():
>=20
>         kernel_thread(loop_thread, lo, CLONE_FS | CLONE_FILES | CLONE_SIG=
HAND);
>         down(&lo->lo_sem); <- This seems to wait for loop_thread()
>=20
> Since kernel_thread can fail at the moment, all places where it is
> called would need to be checked and error handling added.

kernel_thread could fail even before, after all it allocates memory.
So this code has always been buggy just harder to trigger

--=-EPDyZBvukffOaZqJ2Isv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/tNiuxULwo51rQBIRAmNyAKCcS/ZLA6z+nALBvIGtzoSRZn1MHACfcOpu
VWScq+7z4dp+17sQdT42ELA=
=T3gS
-----END PGP SIGNATURE-----

--=-EPDyZBvukffOaZqJ2Isv--
