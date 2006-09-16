Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751751AbWIPUxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWIPUxx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 16:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWIPUxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 16:53:53 -0400
Received: from mail.isohunt.com ([69.64.61.20]:43236 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1751751AbWIPUxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 16:53:52 -0400
X-Spam-Check-By: mail.isohunt.com
Date: Sat, 16 Sep 2006 14:08:57 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
Message-ID: <20060916210857.GD30391@curie-int.orbis-terrarum.net>
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net> <20060916203812.GC30391@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <20060916203812.GC30391@curie-int.orbis-terrarum.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2006 at 01:38:12PM -0700, Robin H. Johnson wrote:
> Ok, I picked up some SATA hard drives now, and the AHCI driver DOES see t=
hem.
> However, it gets more interesting now.
>=20
> The board has 4 SATA ports.
>=20
> In the BIOS, all 4 of them work, and can start the bootloader from any
> of them.
>=20
> In the kernel, ONLY the first two ports work.
>=20
> The only thing I see on this, is that in my original dmesg, when the DVD
> drive was connected to the 4th port, and nothing connected on SATA1-3,
> SControl was 300 for 1/2 and 0 for 3/4.

I recompiled libata and AHCI using the ATA_DEBUG and ATA_VERBOSE_DEBUG
defines, and got an interesting trace.

In specific, look at port_idx 2/3, being all zeros in ahci_host_init.

I'm digging into it further now, but something makes me suspect that
base addresses for ports 3/4 are wrong.

Full file at:
http://orbis-terrarum.net/~robbat2/x86_64-mmconfig-failure/2.6.18-rc7-git1-=
libata-ahci-verbose-failure.dmesg

Initial portion:
libata version 2.00 loaded.
ahci_init_one: ENTER
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 193
ahci_host_init: cap 0xe320ffc3  port_map 0x33  n_ports 4
ahci_host_init: mmio ffffc20000018000  port_mmio ffffc20000018100
ahci_setup_port: ENTER, base=3D=3D0xffffc20000018000, port_idx 0
ahci_setup_port: base now=3D=3D0xffffc20000018100
ahci_setup_port: EXIT
ahci_host_init: PORT_CMD 0x6
ahci_host_init: PORT_SCR_ERR 0x4050000
ahci_host_init: PORT_IRQ_STAT 0x0
ahci_host_init: mmio ffffc20000018000  port_mmio ffffc20000018180
ahci_setup_port: ENTER, base=3D=3D0xffffc20000018000, port_idx 1
ahci_setup_port: base now=3D=3D0xffffc20000018180
ahci_setup_port: EXIT
ahci_host_init: PORT_CMD 0x6
ahci_host_init: PORT_SCR_ERR 0x4050000
ahci_host_init: PORT_IRQ_STAT 0x0
ahci_host_init: mmio ffffc20000018000  port_mmio ffffc20000018200
ahci_setup_port: ENTER, base=3D=3D0xffffc20000018000, port_idx 2
ahci_setup_port: base now=3D=3D0xffffc20000018200
ahci_setup_port: EXIT
ahci_host_init: PORT_CMD 0x0
ahci_host_init: PORT_SCR_ERR 0x0
ahci_host_init: PORT_IRQ_STAT 0x0
ahci_host_init: mmio ffffc20000018000  port_mmio ffffc20000018280
ahci_setup_port: ENTER, base=3D=3D0xffffc20000018000, port_idx 3
ahci_setup_port: base now=3D=3D0xffffc20000018280
ahci_setup_port: EXIT
ahci_host_init: PORT_CMD 0x0
ahci_host_init: PORT_SCR_ERR 0x0
ahci_host_init: PORT_IRQ_STAT 0x0
ahci_host_init: HOST_CTL 0x80000000
ahci_host_init: HOST_CTL 0x80000002
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x33 impl SATA mo=
de
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part=20

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFDGfpPpIsIjIzwiwRAkR7AJ40+cgEJFyF1qIHYvRpgaeS7Y82ZwCg0q6h
+TBxMnP/AgaY3Qz1S60J5Dw=
=3o/j
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
