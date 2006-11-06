Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423165AbWKFBby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423165AbWKFBby (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 20:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423161AbWKFBby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 20:31:54 -0500
Received: from mail.isohunt.com ([69.64.61.20]:54188 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1423165AbWKFBbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 20:31:53 -0500
X-Spam-Check-By: mail.isohunt.com
Date: Sun, 5 Nov 2006 17:31:53 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: e1000/ICH8LAN weirdness - no ethtool link until initially forced up
Message-ID: <20061106013153.GN15897@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O8/n5iBOhiUtMkxf"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O8/n5iBOhiUtMkxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Please CC me on responses].

A spot of weirdness I ran into on my e1000 card.
It's the 82566DC model [8086:104b] (rev 02) x1 PCIe.

After modprobe e1000, ethtool reports that there is no link, despite the
correct link lights on the port. This breaks booting during a boot process =
that
checks for actual link status before using a device.

modprobe e1000:
> Intel(R) PRO/1000 Network Driver - version 7.2.9-k4-NAPI
> Copyright (c) 1999-2006 Intel Corporation.
> ACPI: PCI Interrupt 0000:00:19.0[A] -> GSI 20 (level, low) -> IRQ 20
> PCI: Setting latency timer of device 0000:00:19.0 to 64
> e1000: 0000:00:19.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:16:76=
:a3:6c:4d
> e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
> ADDRCONF(NETDEV_UP): eth1: link is not ready
> ADDRCONF(NETDEV_UP): eth1: link is not ready

Now I force the link up with ifconfig:
> e1000: eth1: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
> ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready

This behavior differs from every other network card, and is also present in=
 the
7.3* version of the driver from sourceforge.

I think the e1000 should try to raise the link during the probe, so that it
works properly, without having to set ifconfig ethX up first.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--O8/n5iBOhiUtMkxf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFTpCJPpIsIjIzwiwRApXOAKDC30PMRhS1On4qjtCRepRISIYtugCgue7V
D/QRVsC/nswXV1PinOTAIzE=
=p68i
-----END PGP SIGNATURE-----

--O8/n5iBOhiUtMkxf--
