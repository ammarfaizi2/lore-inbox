Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbSJ2MxA>; Tue, 29 Oct 2002 07:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbSJ2MxA>; Tue, 29 Oct 2002 07:53:00 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:27099 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261849AbSJ2Mw6>; Tue, 29 Oct 2002 07:52:58 -0500
Date: Tue, 29 Oct 2002 13:59:04 +0100
From: Martin Waitz <tali@admingilde.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021029125904.GA6840@admingilde.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DBDCC02.6060100@netscape.com> <Pine.LNX.4.44.0210281606390.966-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210281606390.966-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Mon, Oct 28, 2002 at 04:08:04PM -0800, Davide Libenzi wrote:
> > The code you wrote has the standard epoll race condition.  If the file
> > descriptor 's' becomes readable before the call to sys_epoll_ctl,
> > sys_epoll_wait() will never return the socket.  The connection will hang
> > and the file descriptor will effectively leak.
>=20
> So, please don't use :
>=20
> 	free((void *) rand());
>=20
> free() is flawed !! Be warned !!

this is not a good argument.
the situation above is real, and a new poll mechanism should handle it.
(the kevent paper has a nice section about this problem)
why put the burden on the application, if the kernel already has
all information needed?

every api should be build to cause the least astonishment to its users.
epoll is much more scalable than standard poll, yet i don't think
it's a nice api.

you should at least build it in a way that it can be extended later.
it would be sad if one had to add another syscall to build an
better notification mechanism later.

the unified event mechanism introduced in bsd is a good example imho.
we should build something that is similar useful for applications.

don't take me wrong, i greatly appreciate the work put in epoll,
i just think it's far from being perfect at the moment.

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

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9voYXj/Eaxd/oD7IRAhq7AJ9Jn98m/jFM7gDhQerdlr9Wu69M7gCfVW7Z
AaUGQGTK7KXo9+3LCqgOZl8=
=uqmu
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
