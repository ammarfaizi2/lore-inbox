Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVIDV6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVIDV6g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 17:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVIDV6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 17:58:36 -0400
Received: from [204.13.84.100] ([204.13.84.100]:21063 "EHLO
	stargazer.tbdnetworks.com") by vger.kernel.org with ESMTP
	id S932079AbVIDV6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 17:58:35 -0400
Subject: 2.6.13 locks my machine within 1h, 2.6.12.5 works fine (PREEMPT?)
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qzSKpLghevkQHATov3m1"
Organization: TBD Networks
Date: Sun, 04 Sep 2005 14:58:25 -0700
Message-Id: <1125871105.4785.11.camel@defiant>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qzSKpLghevkQHATov3m1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I had 2.6.13 lock my machine three times within a hour each after
upgrading to 2.6.13 (last time within 5 minutes).  The machine was
running 2.6.12.5 (and earlier releases) without any problems, so I'd
suspect it's not a hardware issue.  Problem is that I don't find any
trace of this lockup anywhere in the usual logfiles.  Symptoms are that
screen, keyboard and network is frozen (i.e no screen refresh, even
numlock does no longer toggles the light, and ping from another machine
does not work anymore).  This is a standard 2.6.13 kernel running on
Debian unstable.  New features I enabled were INOTIFY and
PREEMPT_VOLUNTARY instead of PREEMPT:

diff -U0 =3D(grep '^C' /boot/config-2.6.12.5 | sort) =3D(grep
'^C' /boot/config-2.6.13 | sort) | grep '^.C'
-CONFIG_ACPI_DEBUG=3Dy
+CONFIG_ACPI_FAN=3Dm
+CONFIG_ACPI_VIDEO=3Dm
+CONFIG_FLATMEM=3Dy
+CONFIG_FLATMEM_MANUAL=3Dy
+CONFIG_FLAT_NODE_MEM_MAP=3Dy
-CONFIG_HAVE_DEC_LOCK=3Dy
+CONFIG_HWMON=3Dy
+CONFIG_HZ=3D250
+CONFIG_HZ_250=3Dy
+CONFIG_INOTIFY=3Dy
+CONFIG_IP_FIB_HASH=3Dy
-CONFIG_LOCK_KERNEL=3Dy
+CONFIG_NFS_COMMON=3Dy
-CONFIG_PNP=3Dy
-CONFIG_PNPACPI=3Dy
+CONFIG_PHYSICAL_START=3D0x100000
+CONFIG_PM=3Dy
-CONFIG_PREEMPT=3Dy
-CONFIG_PREEMPT_BKL=3Dy
+CONFIG_PREEMPT_VOLUNTARY=3Dy
+CONFIG_SELECT_MEMORY_MODEL=3Dy
+CONFIG_TCP_CONG_BIC=3Dy

I know that that's most likely not enough to pinpoint the problem, so I
think I need to get more information from the lockup itself.  What's the
best way to do this?  As the keyboard is locked up too, even Alt-SysRq
does not work.

Best,
  Norbert


--=-qzSKpLghevkQHATov3m1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDG24BOIJDAvi0wRwRAlYQAKCjUU8LJUko1LEEbkuM/7ShZHXqYQCfTUpo
0jHHpNQ4TNXxx6282a1Nw4o=
=6DpD
-----END PGP SIGNATURE-----

--=-qzSKpLghevkQHATov3m1--

