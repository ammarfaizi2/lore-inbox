Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264998AbUFGSW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264998AbUFGSW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 14:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264996AbUFGSW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 14:22:27 -0400
Received: from zak.futurequest.net ([69.5.6.152]:58561 "HELO
	zak.futurequest.net") by vger.kernel.org with SMTP id S264998AbUFGSUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 14:20:19 -0400
Date: Mon, 7 Jun 2004 12:20:16 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: clone() <-> getpid() bug in 2.6?
Message-ID: <20040607182016.GA8727@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 07, 2004 at 11:35:23PM +0000, Linus Torvalds wrote:
> On Sun, 6 Jun 2004, Kalin KOZHUHAROV wrote:
> >
> > Well, not exactly sure about my reply, but let me try.
> >=20
> > The other day I was debugging some config problems with my qmail instal=
ation and I ended up doing:
> > # strace -p 4563 -f -F
> > ...
> > [pid 13097] read(3, "\347\374\375TBH~\342\233\337\220\302l\220\317\237\=
37\25"..., 32) =3D 32
> > [pid 13097] close(3)                    =3D 0
> > [pid 13097] getpid()                    =3D 13097
> > [pid 13097] getpid()                    =3D 13097
> > [pid 13097] getuid32()                  =3D 89
> > [pid 13097] getpid()                    =3D 13097
> > [pid 13097] time(NULL)                  =3D 1086497450
> > [pid 13097] getpid()                    =3D 13097
> > [pid 13097] getpid()                    =3D 13097
> > [pid 13097] getpid()                    =3D 13097
>=20
> qmail is a piece of crap. The source code is completely unreadable, and i=
t=20
> seems to think that "getpid()" is a good source of random data. Don't ask=
=20
> me why.

In this case, however, it has nothing directly to do with qmail.  This
is tcpserver, and tcpserver only uses getpid for two things: printing
out status lines with the PID in them (which seems perfectly valid to
me), and once when adding to random initializer for DNS requests.

This strace pattern seemed rather odd to me, so for comparison I straced
my own tcpserver setups, and could not get them to produce more than two
getpid calls per connection.  Something is wrong with this trace,
possibly some weirdness in a patch, like whatever the SSL library is
doing.
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxLHg6W+y3GmZgOgRAs/yAJoDzIZ+yXd0obgMTai7rqZbLMsSIwCglcg6
2qhR6cgyu3P0e+8e8zlHVVQ=
=ZsGD
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
