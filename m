Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbUAWD16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 22:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266506AbUAWD16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 22:27:58 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:44971 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S265178AbUAWD14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 22:27:56 -0500
Date: Fri, 23 Jan 2004 16:27:22 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: PATCH: Export console functions for	use	by	Software	Suspend	nice
 display
In-reply-to: <1074827571.974.191.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Daniel Jacobowitz <dan@debian.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074828441.31164.210.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-AwrBiMrT9OOK/XjlBCH5";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1074757083.1943.37.camel@laptop-linux>
 <20040122082438.GV21151@parcelfarce.linux.theplanet.co.uk>
 <1074796577.12771.81.camel@laptop-linux>
 <20040122203529.GB13377@nevyn.them.org> <1074826188.976.185.camel@gaston>
 <1074827229.12773.198.camel@laptop-linux> <1074827571.974.191.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AwrBiMrT9OOK/XjlBCH5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Fri, 2004-01-23 at 16:12, Benjamin Herrenschmidt wrote:
> > Locking is not an issue. This is suspend-to-disk. Everything else is
> > stopped while we're working.
>=20
> No. You can still get a printk from irq...=20

Mmm. But we also adjust the console loglevel depending upon the
verbosity of debugging info required. (And reset it when we're done).
When the nice display is on, the loglevel is 0 or 1. If a driver wants
to printk at KERN_EMERG or KERN_ALERT then, well the display should get
messed up a little :>

> > By the way, am I understanding the suggestion correctly? Do you
> > (collective) mean getting a fd for /dev/console from within kernel code
> > and using that? I've been looking at the way printk works and wondering
> > if con->write is equivalent (once I find the right console to write to)=
?
>=20
> Yes. get an fd and write to it. grep for write to find other uses :)

I did. Didn't find much. I'll look again. Perhaps I'm just blind :>

> You may have to be a bit careful about what context you are in, but I
> suppose it's whatever userland process triggered the sleep in the
> first place, no ? For load, it's probably whatever process did swapon ?

No. There's a kernel daemon - kswsuspd - that does all the hard work.
The userland process that initiates the suspend sleeps in
wait_for_completion until post resume. At boot time, we initiate the
resume via an init call. Still fine?

Regards,

Nigel
.
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-AwrBiMrT9OOK/XjlBCH5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAEJSZVfpQGcyBBWkRAhJVAJ9dn3105oPgZvKRspr6H9D6+fKE4QCfQB1O
QhxuE9a7iGw9r1rql4LBQcs=
=aiNr
-----END PGP SIGNATURE-----

--=-AwrBiMrT9OOK/XjlBCH5--

