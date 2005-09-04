Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVIEQir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVIEQir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVIEQir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:38:47 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:19429 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932339AbVIEQiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:38:46 -0400
Date: Sun, 4 Sep 2005 13:20:32 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Chase Venters <chase.venters@clientec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
Message-ID: <20050904112032.GO4415@rama.de.gnumonks.org>
References: <20050904101218.GM4415@rama.de.gnumonks.org> <200509031627.00947.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xwxKudPUn/iIKJJG"
Content-Disposition: inline
In-Reply-To: <200509031627.00947.chase.venters@clientec.com>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xwxKudPUn/iIKJJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 03, 2005 at 04:27:00PM -0500, Chase Venters wrote:
> > Below you can find a driver for the Omnikey CardMan 4040 PCMCIA
> > Smartcard Reader.
>=20
> Someone correct me if I'm wrong, but wouldn't these #defines be a problem=
 with=20
> the new HZ flexibility:
>=20
> #define	CCID_DRIVER_BULK_DEFAULT_TIMEOUT  	(150*HZ)
> #define	CCID_DRIVER_ASYNC_POWERUP_TIMEOUT 	(35*HZ)
> #define	CCID_DRIVER_MINIMUM_TIMEOUT 		(3*HZ)

The defines above certainly have no problems.  They want to wait for
multiples of seconds.

> /* how often to poll for fifo status change */
> #define POLL_PERIOD 				(HZ/100)
>=20
> In particular, 2.6.13 allows a HZ of 100, which would define POLL_PERIOD =
to 0.=20
> Your later calls to mod_timer would be setting cmx_poll_timer to the curr=
ent=20
> value of jiffies.=20

100/100 =3D=3D 1.  As far as my limited math skills go, only 0 divided by
something can give a result of zero ;)

So yes, the code would poll every 1/100th of a second, even with HZ=3D100. =
=20

Obviously, if HZ would ever go below 100, the code above would provide
some problems.  I'm not sure what the future plans with HZ are, but I'll
add an #error statement in case HZ goes smaller than that.

> Also, you've got a typo in the comments:

thanks.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--xwxKudPUn/iIKJJG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDGtiAXaXGVTD0i/8RAtGGAKCy4W5/e9eyx4jn/7kv2NE1arXOKgCfaqCe
RcjUak5iVTz0Y28cfgAjZwY=
=9jMS
-----END PGP SIGNATURE-----

--xwxKudPUn/iIKJJG--
