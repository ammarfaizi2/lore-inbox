Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161257AbVIPSvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbVIPSvC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161264AbVIPSvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:51:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45205 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161257AbVIPSvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:51:01 -0400
Subject: Re: mmap(2)ping of pci_alloc_consistent() allocated buffers on 2.4
	kernels question/help
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0509162009510.14084@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0509162009510.14084@kepler.fjfi.cvut.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aeIF/p6kIFHz0oc7mNtj"
Organization: Red Hat, Inc.
Date: Fri, 16 Sep 2005 14:50:52 -0400
Message-Id: <1126896652.3103.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aeIF/p6kIFHz0oc7mNtj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-09-16 at 20:33 +0200, Martin Drab wrote:
> Hi,
>=20
> can anyone explain me why it is not possible to mmap(2) a buffer=20
> allocated in kernel by pci_alloc_consistent() to userspace on a 2.4=20
> kernel?
>=20
> In kernel PCI device initialization function I do something like:
>=20
> ...
> kladdr =3D pci_alloc_consistent (dev, BUFSIZE, &baddr);
> ...
>=20
> Then I send the physical address (i.e. the value of phaddr =3D __pa(kladd=
r))=20
> to the userspace application, and then when in the userspace I do=20
> something like
>=20
> ...
> fd =3D fopen ("/dev/mem", O_RDWR);
> buf =3D mmap (NULL, BUFSIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, phaddr=
);
> ...


yuch.
why don't you make your device have an mmap operation instead?
(the device node that you use to get your physical address to userspace
in the first place)

--=-aeIF/p6kIFHz0oc7mNtj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDKxQMpv2rCoFn+CIRAue8AJ9IrW69+iPhHlm4zMUjppHUd9VFUwCeIgg7
gWtZE0Ea3DBwFnytvsev53M=
=bG0o
-----END PGP SIGNATURE-----

--=-aeIF/p6kIFHz0oc7mNtj--

