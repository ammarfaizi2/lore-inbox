Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVBVI5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVBVI5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 03:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVBVI5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 03:57:36 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:26350 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262249AbVBVI5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 03:57:32 -0500
From: Amon Ott <ao@rsbac.org>
Organization: RSBAC
To: rsbac@rsbac.org
Subject: Re: [rsbac] Thoughts on the "No Linux Security Modules framework" old claims
Date: Tue, 22 Feb 2005 09:57:10 +0100
User-Agent: KMail/1.7.1
Cc: Casey Schaufler <casey@schaufler-ca.com>,
       Lorenzo "=?iso-8859-1?q?Hern=E1ndez?="
	 "=?iso-8859-1?q?Garc=EDa-Hierro?=" <lorenzo@gnu.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20050221175026.22737.qmail@web50205.mail.yahoo.com>
In-Reply-To: <20050221175026.22737.qmail@web50205.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1248403.U4zJP9MG25";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502220957.16047.ao@rsbac.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1248403.U4zJP9MG25
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Montag 21 Februar 2005 18:50, Casey Schaufler wrote:
>=20
> --- Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>
> wrote:
>=20
>=20
> > > There are cases where Linux DAC and MAC cannot
> > live happily together,=20
> > > because Linux DAC is too limited.
> >=20
> > Agreed.
>=20
> OKay, I'll bite. MAC and DAC are seperate.
> How is it that (the limited nature of) the DAC
> behavior makes a system with both unhappy?

Back in 2001/2002 (versions 1.1.2 and 1.2.0), I added DAC disabling=20
support first for the full filesystem, then for selected dir trees=20
and the converter tool linux2acl to RSBAC. I remember the actual=20
problem coming from a provider of virtual web servers, but I cannot=20
find the old mails. Too long ago.

We were not able to solve the given problem without changing the Linux=20
mode to 0777 (what means disabling DAC effectively). The reason to=20
add this feature was that the dir mode should not be changed to 0777,=20
because this would leave it completely unprotected with a non-RSBAC=20
kernel. Some programs even check Linux modes and refuse to run with=20
too many rights on their config files (what is usually a good idea,=20
but sometimes problematic), this is also a convenient workaround for=20
those.

Personally, I do not use the object based override myself, but rather=20
subject based override with additional Linux capabilities for=20
selected accounts and/or programs (which can be set with the RSBAC=20
CAP module, and which are dangerous because of LD_PRELOAD etc., if=20
the environment is not controlled). This means that I have to use MAC=20
configuration to restrict these users/programs afterwards, but that=20
is not the problem.

The moment you want to implement separation of duty for=20
administration, you will again and again run against Linux DAC=20
limits, because it only knows of one single admin. E.g. think of a=20
separate account doing user management and adding user dirs.

Amon.
=2D-=20
http://www.rsbac.org - GnuPG: 2048g/5DEAAA30 2002-10-22

--nextPart1248403.U4zJP9MG25
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCGvPsq9yn6h5RTo8RAuUhAJ9Jdgl7QrbZxc79J8MhMBQzwY8gXACfVrPh
fmxGOOxGVyva0BpRpWyHZUg=
=sONz
-----END PGP SIGNATURE-----

--nextPart1248403.U4zJP9MG25--
