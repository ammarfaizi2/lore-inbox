Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVFTI4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVFTI4g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 04:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFTI4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 04:56:35 -0400
Received: from mercury.acsalaska.net ([209.112.173.226]:25336 "EHLO
	mercury.acsalaska.net") by vger.kernel.org with ESMTP
	id S261184AbVFTI4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 04:56:23 -0400
Date: Mon, 20 Jun 2005 00:54:40 -0800
From: Ethan Benson <erbenson@alaska.net>
To: yaboot-devel@lists.penguinppc.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1
Message-ID: <20050620085440.GT25980@plato.local.lan>
Mail-Followup-To: yaboot-devel@lists.penguinppc.org,
	linux-kernel@vger.kernel.org
References: <20050619233029.45dd66b8.akpm@osdl.org> <1119250672.18247.94.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXAqmCxJPvkQLT2P"
Content-Disposition: inline
In-Reply-To: <1119250672.18247.94.camel@gaston>
User-Agent: Mutt/1.3.28i
X-OS: Debian GNU
X-gpg-fingerprint: E3E4 D0BC 31BC F7BB C1DD  C3D6 24AC 7B1A 2C44 7AFC
X-gpg-key: http://www.alaska.net/~erbenson/gpg/key.asc
Mail-Copies-To: erbenson@alaska.net
X-ACS-Spam-Status: no
X-ACS-Scanned-By: MD 2.51; SA 3.0.3; spamdefang 1.112
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AXAqmCxJPvkQLT2P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2005 at 04:57:51PM +1000, Benjamin Herrenschmidt wrote:
>=20
> On Sun, 2005-06-19 at 23:30 -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.=
6.12-mm1/
> >=20
> >=20
> > - Someone broke /proc/device-tree on ppc64.  It's being looked into.
>=20
> I did, the breakage is in 2.6.12, and no, it's not broken :)
>=20
> The problem is that the "ofpath" script that is part of the yaboot
> package has a stupid bug where for some reason, when booting from SCSI
> (or libata in this case), it decides to check wether there are any
> symlinks in /proc/device-tree, and if not, decides it's broken and
> aborts. It doesn't actually make any use of the symlinks that were there
> though (and they were useless and partially broken anyway, which is why
> I removed them).

this check was done because of BootX, which caused a broken and
unusable device-tree.

> So it's a bug in "ofpath", a bit annoying, but at the same time, you
> don't need to run it when changing kernels, so it's not too harmful.
>=20
> The fix is :

so long as BootX is no longer in use, yes.

> --- ofpath	2005-06-20 16:56:12.000000000 +1000
> +++ ofpath.patched	2005-06-20 16:57:00.000000000 +1000
> @@ -425,14 +425,6 @@
>  {
>      case "$DEVNODE" in
>  	sd*)
> -	    if ls -l /proc/device-tree | grep -q ^lr ; then
> -		true
> -	    else
> -		echo 1>&2 "$PRG: /proc/device-tree is broken.  Do not use BootX to boo=
t, use yaboot."
> -		echo 1>&2 "$PRG: The yaboot HOWTO can be found here: http://www.alaska=
.net/~erbenson/doc"
> -		return 1
> -	    fi
> -
>  	    ## use common scsiinfo function to get info we need.
>  	    scsiinfo || return 1
> =20
>=20
> --=20
> To UNSUBSCRIBE, email to minimalist@lists.penguinppc.org
> with a subject of "unsubscribe yaboot-devel". Trouble? Contact listmaster=
@lists.penguinppc.org

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--AXAqmCxJPvkQLT2P
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iEYEARECAAYFAkK2hFAACgkQJKx7GixEevwMcwCeL3fFm/VARW4kn9U/JHhI0gJd
iyYAn17CJu8FOVdI/9J4ag4J27827i+1
=lDfU
-----END PGP SIGNATURE-----

--AXAqmCxJPvkQLT2P--
