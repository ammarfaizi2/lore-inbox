Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312354AbSCVNyk>; Fri, 22 Mar 2002 08:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312484AbSCVNyc>; Fri, 22 Mar 2002 08:54:32 -0500
Received: from 12-216-36-250.client.mchsi.com ([12.216.36.250]:15800 "EHLO
	united.lan.codewhore.org") by vger.kernel.org with ESMTP
	id <S312354AbSCVNyM>; Fri, 22 Mar 2002 08:54:12 -0500
Date: Fri, 22 Mar 2002 08:51:43 -0500
From: David Brown <dave@codewhore.org>
To: Axel Kittenberger <Axel.Kittenberger@maxxio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch, forward release() return values to the close() call
Message-ID: <20020322085143.A16251@codewhore.org>
In-Reply-To: <200203210747.IAA25949@merlin.gams.co.at> <3C999633.2060104@mandrakesoft.com> <20020321113201.A26882@codewhore.org> <200203220758.IAA09819@merlin.gams.co.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2002 at 08:58:02AM +0100, Axel Kittenberger wrote:
> > Forgive me if I'm not completely understanding this, but isn't release()
> > only called when the refcount of the file structure drops to zero? e.g.:
> >
> >   [18]Note that release isn't invoked every time a process calls close.
> >   Whenever a file structure is shared (for example, after a fork or a
> >   dup), release won't be invoked until all copies are closed. If you ne=
ed
> >   to flush pending data when any copy is closed, you should implement t=
he
> >   flush method.
>=20
> Oh that might be, however in my case the device is exclusivly locked, so =
it=20
> doesn't matter that much, since there can be only one writer.
>=20
> To explain what it actually is, it's a driver to program a LCA chip, an=
=20
> userspace opens the device, writes the program for the LCA, and closes th=
e=20
> device. The driver itself can not understand the file format transmitted=
=20
> trough it, and has so no chance to know where the supposed end of stream =
is=20
> until the userspace closes the device. At close() it let's the LCA go, an=
d=20
> looks if it's starting up, if so it has accpeted it's program, if not the=
=20
> file was not a valid image or the LCA might be damaged, and this error=20
> condition should be signaled.
>=20
> Programming a LCA simply works then from the shell like in example this:
> $> cp my-lca-image /dev/lca || echo "LCA failure :("
>=20
> Where cp fails if the lca has not accepted it's image.
>=20
> flush() can also be called in middle of stream, and is not a good indicat=
ion=20
> for an end of stream.=20

This is me talking prior to having coffee, but Chapter 3 of the
Rubini/Corbet book says:

  The flush operation is invoked when a process closes its copy of a file
  descriptor for a device; it should execute (and wait for) any outstanding
  operations on the device. This must not be confused with the fsync operat=
ion
  requested by user programs. Currently, flush is used only in the network =
file
  system (NFS) code. If flush is NULL, it is simply not invoked.

I guess it doesn't specifically say it's not called in midstream, but
it reads as if flush() is called on /only/ close(). I may test this
today, just for fun.

>=20
> > > Your driver is buggy, if it thinks it can fail f_op->release.
>=20
> If this is would be really (always) true, wouldn't it at least be better =
to=20
> have the release() prototype with a void return value?

That wasn't me, that was Jeff. :)


- Dave
  dave@codewhore.org

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjybNu8ACgkQcHEtmM/AAybyqwCfXqB/dGWd1PNzitQxPDJUZuQ+
mggAoL4iVD3L2Pjot5SssKa7f9YiDje5
=x321
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
