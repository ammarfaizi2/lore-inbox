Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUGRPAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUGRPAT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 11:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUGRPAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 11:00:19 -0400
Received: from wblv-254-37.telkomadsl.co.za ([165.165.254.37]:28095 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264154AbUGRPAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 11:00:07 -0400
Subject: Re: Linux 2.6.8-rc2
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Jens Olav Nygaard <jens_olav.nygaard@chello.no>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <40FA6377.8000206@chello.no>
References: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org>
	 <1090149153.3198.3.camel@paragon.slim>
	 <20040718113552.GA23190@middle.of.nowhere>  <40FA6377.8000206@chello.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5f18Hq35oWLK1xk05Z9d"
Message-Id: <1090162964.9751.1.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Jul 2004 17:02:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5f18Hq35oWLK1xk05Z9d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-07-18 at 13:48, Jens Olav Nygaard wrote:=20
> > From: Jurgen Kramer <gtm.kramer@inter.nl.net>
>=20
> >>Just gave it a try. My EHCI controller is still failing (Asus P4C800-E
> >>i875p) as in the 2.6.7-mm series.
> >>
> >><snip>
> >>ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
> >>ehci_hcd 0000:00:1d.7: EHCI Host Controller
> >>ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
> >>ehci_hcd 0000:00:1d.7: can't reset
> >>ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
> >>ehci_hcd: probe of 0000:00:1d.7 failed with error -95
> >>USB Universal Host Controller Interface driver v2.2
> >><snip>
>=20
> This is also what I see (on my Asus P4P800) more or less:
>=20
> ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
> ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Cont=
roller
> ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
> ehci_hcd 0000:00:1d.7: can't reset
> ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
> ehci_hcd: probe of 0000:00:1d.7 failed with error -95
>=20
> The funny thing is, it has happened with various kernel snapshots
> (right term for the 2.6.7-bk??-patches?) but not all.
> I thought I had one (2.6.7-bk17) which didn't give this response,
> but now it does, and I suspect the problem is really something else.
> (Some automatic irq assignment to usb-hardware?)
>=20
> I'm not into kernel source hacking so I can't really say much more.
>=20
> Jurriaan:
>=20
> > That is most probably something in your bios. My Epox 4PCA3+ (also i875
> > chipset) says:
>=20
> Then it's in mine also.

As I said in previous mail, my p4c800-e dlx works fine:

---=20
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 193
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Contro=
ller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 193, pci mem f9968c00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
---

You using the latest bios version?  Maybe check if there is a beta
bios available ?

I saw somebody said newer bios versions do not work (Locks after
ACPI init).  I am not sure if this is related, but for our boards
you do not want ISAPNP or PNPBIOS, just ACPI (it used to oops at
some stage - either after ACPI init or PNP init), and I did enable
CONFIG_PNP ...

---
# grep PNP .config
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG is not set
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
# CONFIG_BLK_DEV_IDEPNP is not set
# CONFIG_IP_PNP is not set
---


--=20
Martin Schlemmer

--=-5f18Hq35oWLK1xk05Z9d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQBA+pEUqburzKaJYLYRAl67AJoDGct0vYN2UNwA3EEddj1+unKYVgCY8lMH
8ncPUNs0Uy7ks48cWOLOlA==
=QwgC
-----END PGP SIGNATURE-----

--=-5f18Hq35oWLK1xk05Z9d--

