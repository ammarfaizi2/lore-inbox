Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131636AbRANPZg>; Sun, 14 Jan 2001 10:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132021AbRANPZ0>; Sun, 14 Jan 2001 10:25:26 -0500
Received: from [200.43.20.76] ([200.43.20.76]:11012 "EHLO albinux.ddts.net")
	by vger.kernel.org with ESMTP id <S131636AbRANPZR>;
	Sun, 14 Jan 2001 10:25:17 -0500
Date: Sun, 14 Jan 2001 12:23:15 -0300
From: Alberto Bertogli <albertogli@altavista.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird vmstat reports in 2.2.18
Message-ID: <20010114122315.A455@altavista.net>
In-Reply-To: <200101140650.f0E6ot3175465@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200101140650.f0E6ot3175465@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Sun, Jan 14, 2001 at 01:50:55AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2001 at 01:50:55AM -0500, Albert D. Cahalan wrote:
>=20
> > The report is like this:
> > #vmstat 1 60 | awk '{ print $16 }'
> > id
> > 0
> > 0
> > 20452224
> > 1
> > 20452224
> > 0
> > 1
> > 20452224
> > 1
> > 0
> > 0
> >=20
> > I wasnt able to trigger it in a predictable way, it just pops up...
>=20
> You should be able to trigger it by running something on both CPUs.
> Starting a dozen processes should ensure that this happens.
>=20
It wasnt so easy to trigger.. but it did.

> This is the same problem that makes "top" report negative %idle.
>=20
> The kernel's count of idle ticks can briefly run backwards.
> This is because the idle count is derived from other values,
> which are updated without any locking. When vmstat reads the
> idle time during an update, it can go backwards.
>=20
> This may be intentional; locking would add overhead, and these
> values are not really important.
>=20
> The negative number causes an unsigned 32-bit integer underflow.
> After some division and rounding, you get the above values.
>=20
> Do you want to see the values as they arrive (as "-1" or "-2")
> or do you want them converted to "0" to look pretty?
>=20
IMHO it would be better to report the values as they arrive, and to document
this somewhere... this would make us + sys + id =3D 100, which is far more
coherent than the other choices (as-is, and 0).
On the other hand, reporting 0 and adding an option to make it show the real
value could avoid some bug reports like mine.
As you stated before, this values aren't so important.

> I forget where you reported this bug. If it wasn't directly to me,
> then please post my response whereever it was you sent the bug report.
I posted it to lkml

Thanks,
	Alberto


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6YcRitRVPVxHTdS4RAs1MAJ93FKr2hGsHuzJ7su+OpZSVgGe0YQCgslrd
SjWhh1p7OBhP7Zdp2Wxi9R0=
=tjbB
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
