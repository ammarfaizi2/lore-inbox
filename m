Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTECMgR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 08:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTECMgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 08:36:16 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:63216 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263301AbTECMgO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 08:36:14 -0400
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3EB3925F.8050801@gmx.net>
References: <Pine.LNX.4.44.0305030249280.30960-100000@devserv.devel.redhat.com>
	 <3EB3925F.8050801@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5xU796SBeykNKZR+MoBR"
Organization: Red Hat, Inc.
Message-Id: <1051966115.1429.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 03 May 2003 14:48:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5xU796SBeykNKZR+MoBR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-05-03 at 11:56, Carl-Daniel Hailfinger wrote:
> Ingo Molnar wrote:
> > On Fri, 2 May 2003, Carl-Daniel Hailfinger wrote:
> >=20
> >=20
> >>Ingo Molnar wrote:
> >>
> >>>Furthermore, the kernel also remaps all PROT_EXEC mappings to the
> >>>so-called ASCII-armor area, which on x86 is the addresses 0-16MB. Thes=
e
>=20
> What happens if the ASCII-armor area is full, i.e. sum(PROT_EXEC sizes)
>  >16MB for a given binary (Mozilla comes to mind)? Does loading fail or
> does the binary run without any errors, giving the user a false sense of
> security?

the binary will run without errors. And all the libs are still below the
main binary (the space for that is much bigger, like 128Mb) so the
executable limit is still the end of the main binary.
> =20
> > the ASCII-armor, more precisely, is between addresses 0x00000000 and
> > 0x0100ffff. Ie. 16 MB + 64K. [in the remaining 64K the \0 character is =
in
> > the second byte of the address.] So the 0x01003fff address is still ins=
ide=20
> > the ASCII-armor.
>=20
> Thanks. However, that brings me to the next question:
>=20
> 01000000-01004000 r-xp 00000000 16:01 2036120    /home/mingo/cat-lowaddr
>=20
> I was wondering why the executable parts of the binary start at the 16
> MB boundary. Is this always the case or just something that happens with
> cat? In the first case, that would be bad for any binary with a
> contiguous executable area bigger than 64K.

the start address of the binary is determined by ld at link time. This
cat binary was forced to go at exactly this address.
The patch to binutils in Ingo's directory will add the linker option to
move apps in this area; it will actually use a lower address than
01000000 to allow for bigger binaries. Obviously this 16Mb zone won't
fit all apps, but daemons like sendmail and sshd etc all just fit.


--=-5xU796SBeykNKZR+MoBR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+s7qjxULwo51rQBIRAiV6AJ9DWMBHGXey/ZNG5oDW5Dn5x39cAgCfTDzD
EwhxVx+dPHa3r9+qe9yUu7I=
=uf5+
-----END PGP SIGNATURE-----

--=-5xU796SBeykNKZR+MoBR--
