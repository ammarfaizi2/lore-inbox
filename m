Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263704AbTDXOUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 10:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTDXOUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 10:20:10 -0400
Received: from marstons.services.quay.plus.net ([212.159.14.223]:39577 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id S263704AbTDXOUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 10:20:07 -0400
Date: Thu, 24 Apr 2003 15:30:58 +0100
From: Chris Sykes <chris@sigsegv.plus.com>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rename("a","b") succeeds multiple times race
Message-ID: <20030424143058.GC23247@spackhandychoptubes.co.uk>
Mail-Followup-To: Ian Jackson <ijackson@chiark.greenend.org.uk>,
	linux-kernel@vger.kernel.org
References: <16039.53523.533498.354359@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <16039.53523.533498.354359@chiark.greenend.org.uk>
User-Agent: Mutt/1.4.1i
x-gpg-fingerprint: 1D0A 139D DDA3 F02F 6FC0  B2CA CBC6 5EC0 540A F377
x-gpg-key: wwwkeys.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2003 at 12:57:07PM +0100, Ian Jackson wrote:
> I'm running 2.2.25 on a dual PIII; I have a program that processes
> mail messages which are left in a queue directory as uniquely named
> files.  The queue runners each `claim' a message by renaming it away
> from the initial filename, so that only one queue runner works on each
> message.
>=20
> However, this does not work because Linux erroneously allows several
> processes to simultaneously and `successfully' rename the same file.
> The filesystem in question is ext2.
>=20
> I ran the system under strace, and saw (for example) the following, in
> five straces of five different processes:
>=20
>  02:11:47.293131 rename("q1988na-000xqY", "proc.1988na-000xqY") =3D 0
>  02:11:47.354497 rename("q1988na-000xqY", "proc.1988na-000xqY") =3D 0
>  02:11:47.412207 rename("q1988na-000xqY", "proc.1988na-000xqY") =3D 0
>  02:11:47.414376 rename("q1988na-000xqY", "proc.1988na-000xqY") =3D 0
>  02:11:47.414559 rename("q1988na-000xqY", "proc.1988na-000xqY") =3D 0

In rename(2):
[1] "If  newpath  already exists it will be atomically replaced
    (subject to a few conditions - see ERRORS below), so  that
    there  is  no point at which another process attempting to
    access newpath will find it missing."

 ...

[2] "However, when overwriting there will probably be a  window
    in  which both oldpath and newpath refer to the file being
    renamed."

Perhaps your program should link(2) the newpath to the oldpath, then
on success unlink(2) the oldpath.  link(2) will fail should newpath
already exist.  Of course this assumes that oldpath & newpath are on
the same filesystem.

--=20

(o-  Chris Sykes  -- GPG Key: http://www.sigsegv.plus.com/key.txt
//\       "Don't worry. Everything is getting nicely out of control ..."
V_/_                          Douglas Adams - The Salmon of Doubt


--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+p/Uiy8ZewFQK83cRAvuuAJ9ApbNS3L1lwAnae/onrJGMxeHswQCgnSQ8
jjbayP039RPXcqmrlVKNW6s=
=Nvy7
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
