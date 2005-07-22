Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVGVU62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVGVU62 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVGVU61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:58:27 -0400
Received: from flawless.real.com ([207.188.23.141]:23737 "EHLO
	flawless.real.com") by vger.kernel.org with ESMTP id S262163AbVGVU61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:58:27 -0400
Date: Fri, 22 Jul 2005 13:58:25 -0700
From: Tom Marshall <tmarshall@real.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: itimer oddness in 2.6.12
Message-ID: <20050722205825.GB6476@real.com>
References: <20050722171657.GG4311@real.com> <42E14735.1090205@grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_flawless.real.com-2955-1122065901-0001-2"
Content-Disposition: inline
In-Reply-To: <42E14735.1090205@grupopie.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_flawless.real.com-2955-1122065901-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 22, 2005 at 08:21:25PM +0100, Paulo Marques wrote:
> Tom Marshall wrote:
> >The patch to fix "setitimer timer expires too early" is causing issues f=
or
> >the Helix server.  We have a timer processs that updates the server's
> >timestamp on an itimer and it expects the signal to be delivered at roug=
hly
> >the interval retrieved from getitimer.  This is very consistent on every
> >platform, including Linux up to 2.6.11, but breaks on 2.6.12.  On 2.6.12,
> >setting the itimer to 10ms and retrieving the actual interval from=20
> >getitimer
> >reports 10.998ms, but the timer interrupts are consistently delivered at
> >roughly 11.998ms. =20
>=20
> Unfortunately, this is not so clear cut as it seems :(

Yes, I am sure that it is not a simple problem.  I am not a kernel developer
but I imagine that issues such as NTP adjustments would complicate this
issue.  I must also admit that I am not intimately familiar with the POSIX
spec regarding itimers.

Our current code does a setitimer followed by getitimer, then uses the
actual interval retrieved by getitimer to set a global timer delta.  On each
timer signal, it updates the notion of the current time by the timer delta.=
=20
As mentioned, this works on every other platform (Solaris, BSD, HPUX, AIX,
DGUX, IRIX, Tru64, and Linux up to 2.6.11) but breaks on 2.6.12.

This is not an insurmountable problem for userspace.  It can be easily
solved by using gettimeofday in the timer interrupt instead of adding the
delta to the current time blindly.  No big deal.  I just wanted to point
this issue out and ensure that (1) it was a known issue, and (2) it is the
direction that the Linux kernel intends to take.  If so, no big deal and we
can modify the timer code to take that into account.

--=20
Apathy Club meeting this Friday.  If you want to come, you're not invited.

--=_flawless.real.com-2955-1122065901-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC4V3xqznSmcYu2m8RAk+6AJwN0qGV1sV1IcHeTjz3jHPRn2ErpwCfQMQN
Qz2Z70ntJxpCSzHWDhnBd08=
=1KGK
-----END PGP SIGNATURE-----

--=_flawless.real.com-2955-1122065901-0001-2--
