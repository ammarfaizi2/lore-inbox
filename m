Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbTHZIIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 04:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbTHZIIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 04:08:16 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:37291 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262831AbTHZIIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 04:08:11 -0400
Date: Tue, 26 Aug 2003 11:08:00 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-ID: <20030826080759.GK13390@actcom.co.il>
References: <20030825231449.7de28ba6.akpm@osdl.org> <Pine.LNX.4.44.0308260233550.20822-100000@devserv.devel.redhat.com> <20030826000218.2ceaea1d.akpm@osdl.org> <1061884611.2982.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Content-Disposition: inline
In-Reply-To: <1061884611.2982.4.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2003 at 09:56:51AM +0200, Arjan van de Ven wrote:
> On Tue, 2003-08-26 at 09:02, Andrew Morton wrote:
>=20
> > umm, how about hashing only on offset into page?  That reduces the numb=
er of
> > threads which need to be visited in futex_wake() by a factor of up to 1=
024.
>=20
> How likely do you consider it that we then get a major collision?
> I wouldn't be surprised if, say, glibc lays some hot futexes out in a
> way that's the same for all processes in the system, like start of the
> page.... Might as well not hash :)

How about combining something that's shared to all of the threads that
share a futex but not system wide (the mm?) with something simple that
won't change, like the page offset? Adding the mm into the mix wil
make collisions harder, and limiting the buckets to the number of
different futex offsets will make it simple and differentiate between
different futexes in the same mm.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/SxVfKRs727/VN8sRAgu6AJ9W9u5eRH3cNnC3WeIo37GdSffE4QCgmLIi
yugeE5QzQHJOELXAzIXimGw=
=IvcA
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--
