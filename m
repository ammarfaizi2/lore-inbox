Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVAPA7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVAPA7v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 19:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVAPA7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 19:59:51 -0500
Received: from dhcp93115068.columbus.rr.com ([24.93.115.68]:50450 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S262381AbVAPA7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 19:59:45 -0500
Date: Sat, 15 Jan 2005 19:59:30 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Daniel Drake <dsd@gentoo.org>, William Park <opengeometry@yahoo.ca>
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050116005930.GA2273@zion.rivenstone.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
	Daniel Drake <dsd@gentoo.org>, William Park <opengeometry@yahoo.ca>
References: <20050114002352.5a038710.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20050114002352.5a038710.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 14, 2005 at 12:23:52AM -0800, Andrew Morton wrote:
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/=
2.6.11-rc1-mm1/

> waiting-10s-before-mounting-root-filesystem.patch
>   retry mounting the root filesystem at boot time

    With this patch, initrds seem to get 'skipped'.  I think this is
probably the cause for the reports of problems with RAID too.

    Just after loading the initrd (RAMDISK: Loading 5284KiB [1 disk]
into ram disk...) the kernel tries to mount the real root fs -- if the
necessary drivers are built-in, it proceeds from there; if not, not.

    I'm guessing that when the initrd code calls mount_block_root() to
mount the ramdisk, this bit makes it decide to try to mount the real
root instead:

     if (!ROOT_DEV) {
	ROOT_DEV =3D name_to_dev_t(saved_root_name);
	create_dev(name, ROOT_DEV, root_device_name);
     }
   =20
    Perhaps this should not be done until after the first attempt to
mount fails?  Sorry, I haven't had nearly enough coffee today to
attempt to make a patch. :-)
   =20

--=20
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB6bxyWv4KsgKfSVgRAis6AJ9xRwWSN53hprJshFHlQfFUOJ7axgCgphkc
Oofn71+MHmD0JzJgBvkEjtE=
=hMEh
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
