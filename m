Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbUKBLwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbUKBLwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 06:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUKBLwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 06:52:31 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:39118 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261200AbUKBLwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 06:52:22 -0500
Subject: Re: XMMS (or some other audio player) 'hang' issues with intel8x0
	and dmix plugin [u]
From: Christophe Saout <christophe@saout.de>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net
In-Reply-To: <200411021340.03164.jk-lkml@sci.fi>
References: <1099284142.11924.17.camel@nosferatu.lan>
	 <1099385872.21422.10.camel@leto.cs.pocnet.net>
	 <200411021340.03164.jk-lkml@sci.fi>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E9sevDcFr9tshL72PbSN"
Date: Tue, 02 Nov 2004 12:52:09 +0100
Message-Id: <1099396329.713.4.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E9sevDcFr9tshL72PbSN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 02.11.2004, 13:40 +0200 schrieb Jan Knutar:

> > I've tracked this down to what seems to be a bug in the libalsa dmix
> > code with mmap emulation. If the sound output was stopped for some
> > reason (stream paused or underrun) the library will accept more data
> > until the buffer is full but never restart the output.
>=20
> Strangely, I've observed these kinds of "Hangs" with bmp and mplayer,
> without mmap mode enabled in either. Also using dmix as in the other
> reports here. Could of course be some third application using alsa in
> mmap mode, I suppose.

It might have something to do whether dmix needs to convert the data or
not. In my case /proc shows that the card supports 48kHz but bmp plays a
44kHz file.

> Unfortunately, I have no strace to offer right now as the bug is happenin=
g
> randomly and I haven't been able to find any method by which to reproduce
> it.

100% reproducable on my machine. I stopped debugging when I found out
that it happened somewhere deep inside the libalsa dmix core, the code
didn't look easy to follow.

> What's strange is that almost always when it happens, either mplayer or
> beep-media-player will have an extra forked process.

This has something to do with dmix forking off a process, I don't know
exactly what it is for, it does something with the dmix unix socket
in /tmp.


--=-E9sevDcFr9tshL72PbSN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBh3TpZCYBcts5dM0RApiGAJ4sjGfiKFZGJ0S+wWIa2BOPyfE1iwCfZGdb
J7hBuWXn+1HzAMkyP9X6F4Q=
=jSBj
-----END PGP SIGNATURE-----

--=-E9sevDcFr9tshL72PbSN--

