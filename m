Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161422AbWJZQDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161422AbWJZQDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161421AbWJZQDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:03:17 -0400
Received: from systemlinux.org ([83.151.29.59]:48335 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1161419AbWJZQDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:03:16 -0400
Date: Thu, 26 Oct 2006 18:02:41 +0200
From: Andre Noll <maan@systemlinux.org>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
Subject: Re: ext3: bogus i_mode errors with 2.6.18.1
Message-ID: <20061026160241.GB12843@skl-net.de>
References: <20061023144556.GY22487@skl-net.de> <20061023164416.GM3509@schatzie.adilger.int> <20061023200242.GA5015@schatzie.adilger.int> <20061024091449.GZ22487@skl-net.de> <20061024202716.GX3509@schatzie.adilger.int> <20061025094418.GA22487@skl-net.de> <20061026093613.GM3509@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <20061026093613.GM3509@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03:36, Andreas Dilger wrote:

> On Oct 25, 2006  11:44 +0200, Andre Noll wrote:
> > Are you saying that ext3_set_bit() should simply be called with
> > "ret_block" as its first argument? If yes, that is what the revised
> > patch below does.
>=20
> You might need to call ext3_set_bit_atomic() (as claim_block() does,
> not sure.

I _think_ it doesn't matter much which one is used as on most archs
ext3_set_bit_atomic() is only a wrapper for test_and_set_bit() just like
ext3_set_bit() is. The only exceptions seem to be those archs that use
the generic bitops and m68knommu.

> The other issue is that you need to potentially set "num" bits in the
> bitmap here, if those all overlap metadata.  In fact, it might just
> make more sense at this stage to walk all of the bits in the bitmaps,
> the inode table and the backup superblock and group descriptor to see
> if they need fixing also.

I tried to implement this, but I could not find out how to check at this
point whether a given bit (in the block bitmap, say) needs fixing.

Thanks
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFQNwhWto1QDEAkw8RAm+eAJ4qvpD++YZHgAeCk4E8SBSKDckMawCgnVlq
laElebX7tAz0jKCkNl+ybC4=
=vwEl
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
