Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUAFJWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 04:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbUAFJWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 04:22:42 -0500
Received: from neveragain.de ([217.69.76.1]:23430 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S261606AbUAFJWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 04:22:40 -0500
Date: Tue, 6 Jan 2004 10:22:36 +0100
From: Martin Loschwitz <madkiss@madkiss.org>
To: linux-kernel@vger.kernel.org
Subject: Re: mremap() bug IMHO not in 2.2
Message-ID: <20040106092236.GA1211@minerva.local.lan>
References: <20040105145421.GC2247@rdlg.net> <Pine.LNX.4.58L.0401051323520.1188@logos.cnet> <20040105181053.6560e1e3.grundig@teleline.es> <20040105182607.GB2093@pasky.ji.cz> <20040105225508.GM2093@pasky.ji.cz> <Pine.LNX.4.58.0401051532510.5737@home.osdl.org> <200401052358.i05NwWIe010594@turing-police.cc.vt.edu> <Pine.LNX.4.58.0401051604550.5970@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401051604550.5970@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2004 at 04:08:36PM -0800, Linus Torvalds wrote:
>=20
>=20
> The only page that should matter is likely the one at 0xC0000000, where=
=20
> there can be extra complications from the fact that we use 4MB pages for=
=20
> the kernel, so when fork/exit tries to walk the page table, it would get=
=20
> bogus results.
>=20
This is right, the proof-of-concept exploit to be found on full-disclosure
exactly uses that memory address.

> Still, I'd expect that to lead to a triple fault (and thus a reboot)=20
> rather than any elevation of privileges..
>=20
I agree with Linus. I tested the POC-exploit here on Linux 2.4.22-rc2
and Linux 2.4.23 and everything it does is to simply reboot the box. As=20
for Linux 2.6.0-test9, I get something like a hangup (the same sound is
played again and again and only reset helps).

I actually am not sure whether this should be called 'local privlige
escalation' or rather 'possibility for Denial of Service attacks'.

> Interesting, in any case. Good catch from whoever found it.
>=20
> 		Linus
> -

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+n5cHPo+jNcUXjARAoaSAKCh5m2vMmct64D/KbfOFp+Tvow6RgCfRaEt
e73+kuP1nc3tL5zXTOD6bGM=
=BBxU
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
