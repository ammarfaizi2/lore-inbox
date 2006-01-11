Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWAKNID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWAKNID (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWAKNID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:08:03 -0500
Received: from lug-owl.de ([195.71.106.12]:15027 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751384AbWAKNIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:08:02 -0500
Date: Wed, 11 Jan 2006 14:08:01 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: =?utf-8?B?R8OhYm9yIEzDqW7DoXJ0?= <lgb@lgb.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: fork(): parent or child should run first?
Message-ID: <20060111130800.GJ12091@lug-owl.de>
Mail-Followup-To: =?utf-8?B?R8OhYm9yIEzDqW7DoXJ0?= <lgb@lgb.hu>,
	linux-kernel@vger.kernel.org
References: <20060111123745.GB30219@lgb.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+9faIjRurCDpBc7U"
Content-Disposition: inline
In-Reply-To: <20060111123745.GB30219@lgb.hu>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+9faIjRurCDpBc7U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-01-11 13:37:45 +0100, G=C3=A1bor L=C3=A9n=C3=A1rt <lgb@lgb.hu>=
 wrote:
> Hello,
>=20
> The following problem may be simple for you, so I hope someone can answer
> here. We've got a complex software using child processes and a table
> to keep data of them together, like this:
>=20
> childs[n].pid=3Dfork();
>=20
> where "n" is an integer contains a free "slot" in the childs struct array.
>=20
> I also handle SIGCHLD in the parent and signal handler  searches the chil=
ds
> array for the pid returned by waitpid(). However here is my problem. The
> child process can be fast, ie exits before scheduler of the kernel give
> chance the parent process to run, so storing pid into childs[n].pid in the
> parent context is not done yet. Child may exit, than scheduler gives cont=
rol
> to the signal handler before doing the store of the pid (if child run for
> more time, eg 10 seconds it works of course). So it's impossible to store
> child pids and search by that information in eg the signal handler? It's
> quite problematic, since the code uses blocking I/O a lot, so other
> solutions (like searching in childs[] in the main program and not in sign=
al
> handler) would require to recode the whole project. The problem can be
> avoided with having a fork() run the PARENT first, but I thing this is do=
ne
> by the scheduler so it's a kernel issue. Also the problem that source sho=
uld
> be portable between Linux and Solaris ...

One way to sort this out would be to queue the dead childs to some
thread that clears the child's slot, possibly waiting on a condition
(queue to slot list ready).

Quite easy :-)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--+9faIjRurCDpBc7U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDxQMwHb1edYOZ4bsRAojhAJ4gJBjYek7DKSPf8GRaS3Lt98a+HwCfcAOu
1mfy1KsSEWb60tPGyFUXURA=
=Mrkg
-----END PGP SIGNATURE-----

--+9faIjRurCDpBc7U--
