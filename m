Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUAKFev (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 00:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265769AbUAKFev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 00:34:51 -0500
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171]:640 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id S265768AbUAKFer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 00:34:47 -0500
Date: Sun, 11 Jan 2004 00:34:46 -0500
To: Alex <alex@meerkatsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot boot after new Kernel Build
Message-ID: <20040111053446.GA1242@rivenstone.net>
Mail-Followup-To: Alex <alex@meerkatsoft.com>,
	linux-kernel@vger.kernel.org
References: <3FFFB60C.9010309@meerkatsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <3FFFB60C.9010309@meerkatsoft.com>
User-Agent: Mutt/1.5.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2004 at 05:21:32PM +0900, Alex wrote:
> Hi,
> I am trying to build a new kernel but what ever version 2.4.24, 2.6.0,
> 2.6.1 i am trying to build I come across the same problem.
>=20
> when doing a "make install" i get the following error.
>=20
> /dev/mapper/control: open failed: No such file or directlry
> Is device-mapper driver missing from kernel?
> Comman failed.
>=20
> I have installed the lates packages
> device mapper 1.00.07
> initscripts 7.28.1
> modutils, lvm2.2.00.08
> mkinitrd-3.5.15.1-2
>=20
> If I just ignore the message and try to boot the machine with the new
> kernel then I get a Kernel Panic.
>=20
> VFS: Cannot open root device "LABEL=3D/" or unknown-block(0,0)
> Please append a correct "root=3D" boot option
> Kernel panic: VFS: Unapble to mount root fs on unknown-block(0,0).
>=20
> The boot command in grub is
> root (hd0,0)
> kernel /vmlinuz-2.6.1 ro root=3DLABEL=3D/ hdc=3Dide-scsi
> initrd /initrd-2.6.1.img
>=20
> It is basically the same (except the version) as I use for 2.4.20-28 so
> I assume the label is correct.

    I went through something similar with Fedora Core 1 recently.  I
have never used initrds before.

    First, be sure that the initrd is in fact getting built; my
experience has been that that device-mapper error is non-fatal, but
there may be other problems.  The command that is generating the
error is mkinitrd; if you need to, run the command manually and read
the mkinitrd man page (the --omit-lvm-modules will make the d-m error
go away, assuming you aren't using LVM, but again, it's not a big deal).=20

    You probably don't need to do that though.  More likely, the
problem is the lack of *both* initrd and ramdisk support in your
kernel new kernel config.  Yes, you need to explicitly select ramdisk
support -- I don't know why initrd can be selected without ramdisk on,
but I've been assuming there is a good reason.

    After that, I had a problem with the ramdisk being too big, so
you may want to increase the default ramdisk size to 8192 before
rebuilding your kernel, or otherwise change your kernel command line
to include ramdisk_size=3D8192.

    HTH.

--=20
Joseph Fannin
jhf@rivenstone.net

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAOB2Wv4KsgKfSVgRAo+wAJ0QV4n3TqA+IMaXb9Hu3ryNYDYUkgCdHFBW
ZGvF/YAzEtJQjmvm8DWGymA=
=CR7e
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
