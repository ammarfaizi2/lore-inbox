Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262152AbSJJWrA>; Thu, 10 Oct 2002 18:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262248AbSJJWrA>; Thu, 10 Oct 2002 18:47:00 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:2495 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262152AbSJJWqz>; Thu, 10 Oct 2002 18:46:55 -0400
Date: Fri, 11 Oct 2002 00:52:21 +0200
From: Martin Waitz <tali@admingilde.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: weird semantics of cpu/*/msr
Message-ID: <20021010225221.GA1552@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

the i386 msr driver is a bit strange:

* when reading/writing, it does not update the file position/msr register
* file position is used directly as msr register

that is, reads with count>8 do read from the same register multiple
times, and writes overwrite themselves.

i would expect the following semantics:
* file position is (msr register * 8). position%8!=3D0 is invalid
* read/write updating file position.

that would make it possible to write/read multiple MSRs with one
syscall, which is very handy when initializing P4 performance counters.

should i implement that behaviour?
of course it would break binary compatibility with existing
uses of that drivers.
perhaps we would need a new location for the new api.

comments?

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.
			Benjamin Franklin  (1706 - 1790)

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9pgSkj/Eaxd/oD7IRAk2GAJ0UoEGq8XH7d7Bo9bvemoXc8WLF+QCeMKVO
LFyItz+7lBE8D2D0bmSVczE=
=Ucsa
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
