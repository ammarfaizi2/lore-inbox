Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWBKW11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWBKW11 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 17:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWBKW10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 17:27:26 -0500
Received: from mh57.de ([217.160.165.8]:15571 "EHLO lamedon.mh57.de")
	by vger.kernel.org with ESMTP id S1750767AbWBKW10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 17:27:26 -0500
Date: Sat, 11 Feb 2006 23:27:18 +0100
From: Martin Hermanowski <lkml@martin.mh57.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.16-rc2-mm1
Message-ID: <20060211222718.GB9020@mh57.de>
References: <20060207220627.345107c3.akpm@osdl.org> <20060211203158.GA9020@mh57.de> <20060211134142.11c1af44.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20060211134142.11c1af44.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::57
X-Spam-Score: -2.8 (--)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 11, 2006 at 01:41:42PM -0800, Andrew Morton wrote:
> Martin Hermanowski <lkml@martin.mh57.de> wrote:
> >
> > Hi,
> >=20
> > 2.6.16-rc2-mm1 is running fine on my IBM notebook, but the hdaps module
> > (acceleration sensor) does not work like I expected:
> >=20
> > ,----[ modprobe hdaps ]
> > | Feb 11 21:24:26 nimrais kernel: hdaps: inverting axis readings.
> > | Feb 11 21:24:26 nimrais kernel: hdaps: IBM ThinkPad T41p detected.
> > | Feb 11 21:24:26 nimrais kernel: hdaps: driver successfully loaded.
> > `----
> >=20
> > AFAIK the module should create sysfs files in
> > /sys/devices/platform/hdaps/, but I see only `bus', `power' and
> > `uevent'.
> >=20
> > When unloading the hdaps module, I get a BUG:
> >=20
> > ,----[ rmmod hdaps ]
> > | Feb 11 21:24:49 nimrais kernel:  <c011d8b6> release_resource+0x76/0x8=
0 <c0265bf4> platform_device_del+0x44/0x60
> > | Feb 11 21:24:49 nimrais kernel:  <c0265c18> platform_device_unregiste=
r+0x8/0x10   <f9b9c8ed> hdaps_exit+0xd/0x25 [hdaps]
> > | Feb 11 21:24:49 nimrais kernel:  <f9b9c8e0> hdaps_exit+0x0/0x25 [hdap=
s] <c0132e05> sys_delete_module+0x145/0x1c0
> > | Feb 11 21:24:49 nimrais kernel:  <c0149901> remove_vma+0x41/0x50 <c01=
4ab57> do_munmap+0x1a7/0x200
> > | Feb 11 21:24:49 nimrais kernel:  <c0102d91> syscall_call+0x7/0xb =20
> > | Feb 11 21:24:49 nimrais kernel: hdaps: driver unloaded.
> > `----
> >=20
> > Do you need more information?
> >=20
>=20
> Thanks, I'll drop hdaps-convert-to-the-new-platform-device-interface.patc=
h,
> which very likely to have caused this.
>=20
> You could try reverting that patch (wget
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/=
2.6.16-rc2-mm1/broken-out/hdaps-convert-to-the-new-platform-device-interfac=
e.patch
> ; patch -p1 -R < hdaps-convert-to-the-new-platform-device-interface.patch=
) or please test next -mm, let us know?

This fails:
,----[ patch -p1 -R < ../hdaps-convert-to-the-new-platform-device-interface=
=2Epatch ]
| patching file drivers/hwmon/hdaps.c
| Hunk #1 succeeded at 37 (offset 1 line).
| Hunk #2 succeeded at 63 (offset 1 line).
| Hunk #3 succeeded at 285 with fuzz 2 (offset 1 line).
| Hunk #4 FAILED at 321.
| Hunk #5 FAILED at 340.
| Hunk #6 succeeded at 474 (offset 1 line).
| Hunk #7 succeeded at 512 (offset 1 line).
| Hunk #8 succeeded at 533 (offset 1 line).
| 2 out of 8 hunks FAILED -- saving rejects to file
| drivers/hwmon/hdaps.c.rej
`----

At hunk 4/5, the patch expects `down_trylock' and `up', while
`mutex_trylock' and `mutex_unlock' are used in the actual file, I think.

I will try next -mm anyway, because although the fsck-errors caused by
ext3_getblocks are not harmful, they make me nervous ;-)

--=20
Martin Hermanowski
http://mh57.de/martin

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD7mTGmGb6Npij0ewRAmpkAJ0aMCXso9GWPsR4MA2mDX+5y/y9VACfTFlr
W1tH1wVMEtQpQrYKxYQ0l8w=
=WPwr
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
