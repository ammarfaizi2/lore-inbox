Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268968AbRHLFaL>; Sun, 12 Aug 2001 01:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268970AbRHLFaC>; Sun, 12 Aug 2001 01:30:02 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:13064
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S268968AbRHLF3s>; Sun, 12 Aug 2001 01:29:48 -0400
Date: Sat, 11 Aug 2001 22:29:36 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Chris Hanson <cph@zurich.ai.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting from USB floppy?
Message-ID: <20010811222936.A13150@one-eyed-alien.net>
Mail-Followup-To: Chris Hanson <cph@zurich.ai.mit.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15VlgK-0005GO-00@trixia.ai.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15VlgK-0005GO-00@trixia.ai.mit.edu>; from cph@zurich.ai.mit.edu on Sat, Aug 11, 2001 at 11:12:52PM -0400
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some people have reported limited success by placing a multi-second delay
just before the root fs is mounted, to give the USB system time to identify
and properly attach the scsi devices.

Matt

On Sat, Aug 11, 2001 at 11:12:52PM -0400, Chris Hanson wrote:
> I have been trying to build Debian 2.2 boot/root floppies for the HP
> OmniBook 500 laptop, which (in some configurations) has only a USB
> floppy drive.  I've been unable to get the kernel to load the root
> floppy.  These tests were done using Linux 2.4.6.
>=20
> At this point, I think this isn't possible without some real work in
> the kernel.  I'd like to get some feedback about whether this is a
> correct deduction.  To that end, here is my analysis.
>=20
> 1. The function mount_root() in "fs/super.c" specially detects floppy
>    devices and handles them differently than other devices that might
>    be specified by the "root=3D" parameter, such as "root=3D/dev/sda" in
>    this case.  So handling a floppy drive that appears to be a SCSI
>    floppy looks like it can't be done without patching that code.
>=20
> 2. If that is worked around, there is a further problem: the USB
>    storage driver sets up the SCSI translator asynchronously.  Prior
>    to this, the device "/dev/sda" doesn't exist, which means there's a
>    race condition between the USB-SCSI initialization and the boot
>    process accessing the root device.  I discovered this by specifying
>    "root=3D/dev/sda", and seeing that the kernel didn't initialize the
>    USB floppy device before it tried to open "/dev/sda", and failed
>    with a "no such device" error.  So fixing this would also requiring
>    synchronizing the race -- but it's not clear how you'd figure out
>    that synchronization would even be needed here.
>=20
> Does this seem like a reasonably correct analysis of the situation?
> Is it easier than I think?  Is anyone else working on booting from USB
> floppies?
>=20
> Please CC me to any replies, since I don't read this list.
>=20
> TIA,
> Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It's not that hard.  No matter what the problem is, tell the customer=20
to reinstall Windows.
					-- Nurse
User Friendly, 3/22/1998

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7dhRAz64nssGU+ykRAlsJAJ9TU9jqPZoIX6qKAg+8hYN335LQ5QCeJPkr
Ojm5rZMOijRmDxKulJ2spD0=
=9vag
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
