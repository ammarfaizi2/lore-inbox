Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312419AbSCYNgV>; Mon, 25 Mar 2002 08:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312421AbSCYNgL>; Mon, 25 Mar 2002 08:36:11 -0500
Received: from 12-216-36-250.client.mchsi.com ([12.216.36.250]:40608 "EHLO
	united.lan.codewhore.org") by vger.kernel.org with ESMTP
	id <S312419AbSCYNgG>; Mon, 25 Mar 2002 08:36:06 -0500
Date: Mon, 25 Mar 2002 08:33:50 -0500
From: David Brown <dave@codewhore.org>
To: Axel Kittenberger <Axel.Kittenberger@maxxio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch, forward release() return values to the close() call
Message-ID: <20020325083350.A16464@codewhore.org>
In-Reply-To: <200203210747.IAA25949@merlin.gams.co.at> <200203220758.IAA09819@merlin.gams.co.at> <20020322085143.A16251@codewhore.org> <200203250950.KAA23657@merlin.gams.co.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2002 at 10:50:17AM +0100, Axel Kittenberger wrote:
>=20
> > This is me talking prior to having coffee, but Chapter 3 of the
> > Rubini/Corbet book says:
> >
> >   The flush operation is invoked when a process closes its copy of a fi=
le
> >   descriptor for a device; it should execute (and wait for) any outstan=
ding
> >   operations on the device. This must not be confused with the fsync
> > operation requested by user programs. Currently, flush is used only in =
the
> > network file system (NFS) code. If flush is NULL, it is simply not invo=
ked.
> >
> > I guess it doesn't specifically say it's not called in midstream, but
> > it reads as if flush() is called on /only/ close(). I may test this
> > today, just for fun.
>=20
> Oh thats interesting, indeed, so the function name "flush" is just=20
> contra-intentional. Oxay I know now how I could have written this driver=
=20
> without patching the kernel.....
>=20

And FWIW, I tested this behavior with a dummy chardev and printks()
around open(), release, and flush(). flush() is indeed called only on
each close.

> Still the basic issue/idea is remaining. release() is defined as int retu=
rn=20
> type, but everywhere it's called it's value is discarded. (except interna=
lly=20
> in "intermezzo" whatever that is)
>=20
> btw: blkdev_put()  has int return type and seems to return correctly the=
=20
> return value from release()s for block devices, so I guess it would be th=
e=20
> right thing for char devs to do also.
>=20
> The other way I would also see as okay is to state release() can't return=
=20
> anything senseful to anybody, bet then declare it as void return instead.=
 But=20
> as the state is currently it's suboptimal from both views.

Agreed, but the question is which approach to use. :) Declaring it as void
sounds like it may involve a lot of driver fixup work.


Regards,
- Dave
  dave@codewhore.org

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEUEARECAAYFAjyfJz4ACgkQcHEtmM/AAyadlgCYp7ofGOpN2bmN4WBNG31Hu0qI
ZACfSfxDZkORs8+YY7CMaJSZ3Qt21Dg=
=sSh8
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
