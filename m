Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUAEUgK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbUAEUgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:36:10 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:37505 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265288AbUAEUgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:36:00 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Willy Tarreau <willy@w.ods.org>,
       szonyi calin <caszonyi@yahoo.com>, Con Kolivas <kernel@kolivas.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
In-Reply-To: <1073291940.8884.66.camel@localhost>
References: <1073227359.6075.284.camel@nosferatu.lan>
	 <20040104225827.39142.qmail@web40613.mail.yahoo.com>
	 <20040104233312.GA649@alpha.home.local>
	 <20040104234703.GY1882@matchmail.com>  <1073291940.8884.66.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-S3w42REiLqjv5FTUfHkP"
Message-Id: <1073335127.6075.335.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 22:38:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S3w42REiLqjv5FTUfHkP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-05 at 10:39, Soeren Sonnenburg wrote:
> On Mon, 2004-01-05 at 00:47, Mike Fedyk wrote:
> > On Mon, Jan 05, 2004 at 12:33:12AM +0100, Willy Tarreau wrote:
> > > at a time. I have yet to understand why 'ls|cat' behaves
> > > differently, but fortunately it works and it has already saved
> > > me some useful time.
> >=20
> > cat probably does some buffering for you, and sends the output to xterm=
 in
> > larger blocks.
>=20
> interestingly running ls on a remote machine in a directory with a
> similiar amount of files (local xterm with ssh connection to that
> machine) is also as fast as this ls | cat workaround...
>=20

Maybe it is because the process generating the output, and the
xterm is not on the same box?  The X server gets too much time,
so the two childs (xterm and ls/whatever) do not get enough time?
And that might be why renice +10 `pidof X` helps? Although that
do not seem right, as the process level seems the same:

  xterm->bash->ssh vs xterm->bash->ls

Might be because the startup time is ruled out (maybe that is
the big issue - startup of child processes?).  Could it be that
the 'ls | cat' situation now again influence startup times (now
it is xterm->bash->ls->cat) if above could be taken as an reason?


--=20
Martin Schlemmer

--=-S3w42REiLqjv5FTUfHkP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+ctXqburzKaJYLYRAgZOAJ0ZCkk0dxDKqHpsqd1ZgYWGLeMgbgCgiUUQ
eaR7bLTBvxsjQZn5iTqsHFk=
=9R4o
-----END PGP SIGNATURE-----

--=-S3w42REiLqjv5FTUfHkP--

