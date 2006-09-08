Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWIHNlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWIHNlT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 09:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWIHNlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 09:41:18 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:28856 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1751110AbWIHNlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 09:41:17 -0400
Message-ID: <450172F2.50308@web.de>
Date: Fri, 08 Sep 2006 15:41:06 +0200
From: Jan Kiszka <jan.kiszka@web.de>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: e100 fails, eepro100 works
X-Enigmail-Version: 0.93.2.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig591E44618DEECB2380AB111B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig591E44618DEECB2380AB111B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

we have a couple of industrial PCs here with Intel PRO/100 controllers
on board. Most of them work fine with the e100, but today I stumbled
over one box that doesn't: Reception works (RX counter increases, ARP
cache gets filled up), but transmission fails (TX counter is also zero).
In contrast, the eepro100 is fine, also Etherboot's driver.

I'm currently on 2.6.17.8, but I don't see any changes up to latest git
that may have positive influence. This is what lspci -v tells about this
piece of hardware:

00:12.0 Ethernet controller: Intel Corporation 8255xER/82551IT Fast
Ethernet Controller (rev 08)
        Subsystem: Intel Corporation: Unknown device 1229
        Flags: bus master, medium devsel, latency 66, IRQ 10
        Memory at fc020000 (32-bit, non-prefetchable) [size=3D4K]
        I/O ports at 1080 [size=3D64]
        Memory at fc000000 (32-bit, non-prefetchable) [size=3D128K]
        Capabilities: [dc] Power Management version 2

And here is the kernel log of e100 with highest debug level when sending
out a few pings while other packets arrive on the network:

e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
PCI: Found IRQ 10 for device 0000:00:12.0
e100: eth0: e100_probe: addr 0xfc020000, irq 10, MAC addr 00:30:59:01:07:=
A7
e100: eth0: e100_watchdog: right now =3D 35470
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
e100: eth0: e100_intr: stat_ack =3D 0x04
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_watchdog: right now =3D 35970
e100: eth0: e100_intr: stat_ack =3D 0x04
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_watchdog: right now =3D 36470
e100: eth0: e100_intr: stat_ack =3D 0x04
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_watchdog: right now =3D 36970
e100: eth0: e100_intr: stat_ack =3D 0x04
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_watchdog: right now =3D 37470
e100: eth0: e100_intr: stat_ack =3D 0x04
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_watchdog: right now =3D 37970
e100: eth0: e100_intr: stat_ack =3D 0x04
e100: eth0: e100_watchdog: right now =3D 38470
e100: eth0: e100_intr: stat_ack =3D 0x04
e100: eth0: e100_intr: stat_ack =3D 0x40
e100: eth0: e100_watchdog: right now =3D 38970
e100: eth0: e100_intr: stat_ack =3D 0x04

I may find the time one day to debug this at lower levels, but you could
accelerate this process with any pointer where to dig deeper precisely.

Jan


--------------enig591E44618DEECB2380AB111B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFAXLyniDOoMHTA+kRAg+7AJ9NVLGbOPOi3kwhxEDfI+8dMwiqyQCfQqV2
J1a0Yc/VY+BWvHwwhVWNqXA=
=djId
-----END PGP SIGNATURE-----

--------------enig591E44618DEECB2380AB111B--
