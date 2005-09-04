Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVIDHd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVIDHd7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 03:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVIDHd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 03:33:58 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:4809 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751221AbVIDHd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 03:33:58 -0400
Date: Sun, 4 Sep 2005 09:33:51 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
Message-ID: <20050904073351.GB15212@sunbeam.de.gnumonks.org>
References: <20050904101218.GM4415@rama.de.gnumonks.org> <200509031627.00947.chase.venters@clientec.com> <29495f1d0509031513232b11b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <29495f1d0509031513232b11b1@mail.gmail.com>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nish,=20

thanks for your comments.

On Sat, Sep 03, 2005 at 03:13:43PM -0700, Nish Aravamudan wrote:
> On 9/3/05, Chase Venters <chase.venters@clientec.com> wrote:
> > > Below you can find a driver for the Omnikey CardMan 4040 PCMCIA
> > > Smartcard Reader.
> >=20
> > #define CCID_DRIVER_BULK_DEFAULT_TIMEOUT        (150*HZ)
>=20
> These are all fine. Although I am a bit suspicious of 150 second
> timeouts; but if that is the hardware...

That's a definition from the original vendor-supplied driver.
Unfortunately there's no hardware documentation, so I can't verify it.
But generally speaking, serial smart cards can really be slow, so I
think it could make sense.

> > /* how often to poll for fifo status change */
> > #define POLL_PERIOD                             (HZ/100)
>=20
> This needs to be msecs_to_jiffies(10), please.

thanks, changed in my local tree now.

> Of bigger concern to me is the use of the sleep_on() family of
> functions, all of which are deprecated.

Ok, I'm working on replacing the respective code with
wait_event_interruptible_timeout().

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDGqNfXaXGVTD0i/8RAqshAKCsr82L2zrZUAsf4zNMJSnQpJ5JCACffosJ
bpQbHUvp5x2bYfLZwbXuIPw=
=kzY/
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
