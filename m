Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262548AbTCMTTF>; Thu, 13 Mar 2003 14:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262549AbTCMTTF>; Thu, 13 Mar 2003 14:19:05 -0500
Received: from B57f7.pppool.de ([213.7.87.247]:25549 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S262548AbTCMTS6>; Thu, 13 Mar 2003 14:18:58 -0500
Subject: 2.4.20 and 2.5.64 NIC missing interrupts in APIC mode
From: Daniel Egger <degger@fhm.edu>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-26gLKfvaInRTxDJtSv4i"
Organization: 
Message-Id: <1047581900.1513.36.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 19:58:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-26gLKfvaInRTxDJtSv4i
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hija,

I just bought a new motherboard "ECS L7VTA" sporting a VIA KT400 chipset
and found an annoying bug which took me quite some time to track down:

As soon as I enable the APIC mode in the BIOS the onboard PHY seems
to ignore any packets which are thrown at it *after* the kernel
initialised itself which is especially nasty since the system is booting
from network effectively stopping its boot when trying to get an IP
using DHCP or mounting a NFS volume in case the IP is fixed. The onboard
NIC is a VIA Rhine II (VT6102).

The startup process looks like:
- POST
- BIOS check
- PXE BIOS initialisation
- PXE boot into etherboot
- Correct detection and initialisation of the NIC in etherboot
- Boot of linux kernel
- Correct initialisation of system including NIC (via-rhine driver from
    Donald Becker as in the standard kernels)
- Endless loop like the following:

-------->
eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.
Sending DCHP requests ...... timed out!
<--------

The NIC initialised itself with the correct interrupt according to the
BIOS screen. As soon as I shut down the APIC mode, everything works as
expected.=20

Ideas?

--=20
Servus,
       Daniel

--=-26gLKfvaInRTxDJtSv4i
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+cNTMchlzsq9KoIYRAl8mAJ9hJiekvCWtqxqM4h4bMF95jYmOSACgtvwS
0mzTPS/1VgIH0AP/1aOaARM=
=qQ01
-----END PGP SIGNATURE-----

--=-26gLKfvaInRTxDJtSv4i--

