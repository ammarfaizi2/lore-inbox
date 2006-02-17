Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWBQLjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWBQLjq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 06:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWBQLjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 06:39:46 -0500
Received: from egor.donpac.ru ([80.254.111.31]:55994 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S1750829AbWBQLjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 06:39:45 -0500
Date: Fri, 17 Feb 2006 14:39:42 +0300
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SIIG 8-port serial boards support
Message-ID: <20060217113942.GA30787@pazke>
Mail-Followup-To: Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20060124082538.GB4855@pazke> <20060124210140.GB23513@flint.arm.linux.org.uk> <20060202102644.GC5034@flint.arm.linux.org.uk> <20060202132726.GD24903@pazke> <20060202201734.GA17329@flint.arm.linux.org.uk> <20060203091308.GA19805@pazke> <20060203092435.GA30738@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20060203092435.GA30738@flint.arm.linux.org.uk>
X-Uname: Linux 2.6.16-rc1-pazke i686
User-Agent: Mutt/1.5.11
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 034, 02 03, 2006 at 09:24:36 +0000, Russell King wrote:
> On Fri, Feb 03, 2006 at 12:13:08PM +0300, Andrey Panin wrote:
> > On 033, 02 02, 2006 at 08:17:35 +0000, Russell King wrote:
> > > As I've said many a time, we need a generic way to set different hand-
> > > shaking modes.  I've suggested using some spare bits in termios in the
> > > past, but nothing ever came of that - folk lose interest at that poin=
t.

No wonder they do. Extra bits are not a problem, but for 8250.c we need some
way to glue subdrivers with serial8250_set_termios(). Callback in uart_port
structure ?

> > IMHO there is no need to userspace visible changes to support RS485 on
> > these cards, because some of them are RS485 only and some have jumpers
> > for individual ports.  There is nothing that userspace can configure.
> > We only need to set two bits in ACR according to card type and jumper
> > settings and UART will drive RS485 transiever transparently.
>=20
> In this particular case you may be right, but I'm looking at the bigger
> picture, where plain 16550's may be used for RS485.

Common way to use plain 16550 for RS485 is to wire transiever to the RTS
and force userspace to use RTS/CTS flow control. I doubt there are many=20
other sane way to do it.

> There are drivers which want to implement their own private ioctl to
> enable RS485 mode.  What I'm saying is that we should have one solution,
> not multiple solutions to this problem. When we have such a solution,
> your RS485 card will be able to fit into that model.

But it will need a way to pass ACR value anyway :)

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9bX+PjHNUy6paxMRAhKjAKC0OjoNF8L1kfKISyil+Yv/PmzxOgCfVBf7
/Cx2Xkv/8JpbQ60mAUrF/jU=
=u/Y6
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
