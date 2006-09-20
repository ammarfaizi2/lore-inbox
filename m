Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWITRV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWITRV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWITRV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:21:28 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:47521 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S932077AbWITRVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:21:25 -0400
Date: Wed, 20 Sep 2006 13:21:23 -0400
From: Will Simoneau <simoneau@ele.uri.edu>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [sparc64] 2.6.18 unaligned acccess in ehci_hub_control
Message-ID: <20060920172123.GA9334@ele.uri.edu>
Mail-Followup-To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 [Linux 2.6.18 sparc64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I upgraded from 2.6.17.7 to 2.6.18 today, and in dmesg I have 5 of these
messages in a row:

Kernel unaligned access at TPC[100be8c8] ehci_hub_control+0x350/0x680 [ehci=
_hcd]

This message wasn't there before... I suppose it is pretty harmless as
the kernel is supposed to handle unaligned accesses (right?) but this is
the first time it's happened.

According to gdb (my first time using it...),
drivers/usb/host/ehci-hub.c:280 is to blame:

(gdb) list *ehci_hub_control+0x350
0x8d0 is in ehci_hub_control (drivers/usb/host/ehci-hub.c:280).
275      struct usb_hub_descriptor  *desc
276   ) {
277      int      ports =3D HCS_N_PORTS (ehci->hcs_params);
278      u16      temp;
279  =20
280      desc->bDescriptorType =3D 0x29;
281      desc->bPwrOn2PwrGood =3D 10; /* ehci 1.0, 2.3.9 says 20ms max */
282      desc->bHubContrCurrent =3D 0;
283  =20
284      desc->bNbrPorts =3D ports;

System is a Sun U80 4x450 with 2.5G and a USB2 PCI card. GCC for the
kernel is 4.1.1 (with gentoo patchset). The only USB2 device is an
external Sony dual layer DVD writer.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFEXiTLYBaX8VDLLURAgDsAKC2rmhf98QKjvglx4FOond3/JyTRQCff1Lc
scEkEtIpxKOkccMXky3OwkM=
=6TjD
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
