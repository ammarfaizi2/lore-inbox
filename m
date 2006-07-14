Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWGNRWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWGNRWL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422656AbWGNRWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:22:11 -0400
Received: from master.altlinux.org ([62.118.250.235]:30468 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1422655AbWGNRWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:22:10 -0400
Date: Fri, 14 Jul 2006 21:21:53 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Daniel Drake <dsd@gentoo.org>
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, greg@kroah.com, harmon@ksu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Message-Id: <20060714212153.9196b4cb.vsu@altlinux.ru>
In-Reply-To: <44B7CF00.8090204@gentoo.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net>
	<44B77B1A.6060502@garzik.org>
	<44B78294.1070308@gentoo.org>
	<44B78538.6030909@garzik.org>
	<20060714074305.1248b98e.akpm@osdl.org>
	<20060714154240.GA23480@tuatara.stupidest.org>
	<44B7C37F.1050400@gentoo.org>
	<44B7C521.5080009@gentoo.org>
	<1152895734.11043.5.camel@localhost.localdomain>
	<44B7CF00.8090204@gentoo.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__14_Jul_2006_21_21_53_+0400_p=XnsEOh93x4ilBn"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__14_Jul_2006_21_21_53_+0400_p=XnsEOh93x4ilBn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jul 2006 18:06:08 +0100 Daniel Drake wrote:

> Sergio Monteiro Basto wrote:
> >> I just confirmed this on my own system, at least partially. I removed=
=20
> >> the quirk and the system booted fine.
> >>
> >> This is with ACPI enabled, but APIC not enabled (hence the interrupts=
=20
> >> are XT-PIC). I cannot enable APIC on this system due to buggy BIOS.
> >>
> >> Daniel
> >=20
> > Daniel, VIA_SATA is not in the list , so when you write remove , you
> > remove what ? or you want say the opposite ? =20
> > Please rephrase your sentence .
>=20
> Sorry, I should have been clearer. I do not own any VIA SATA hardware=20
> (that info was relayed from a Gentoo bug report). My own hardware is=20
> older, [Apollo KT266/A/333]. The quirk gets applied to my IDE controller=
=20
> only (both before and after Chris's changes), and I boot from a disk=20
> connected to this IDE controller.

Then the quirk effectively does nothing - the IDE controller is most
likely in legacy mode, and therefore does not use its PCI interrupt (it
uses legacy IRQs 15 and 14 instead).

> 00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/33=
3]
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo=20
> KT266/A/333 AGP]
> 00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.=20
> RTL-8139/8139C/8139C+ (rev 10)
> 00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.=20
> RTL-8139/8139C/8139C+ (rev 10)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
> 00:11.1 IDE interface: VIA Technologies, Inc.=20
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=20
> Controller (rev 23)
> 00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=20
> Controller (rev 23)

On this system the quirk would matter only for these USB controllers.

> 01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2=20
> GTS/Pro] (rev a3)
>=20
> When I said I removed the quirk, I meant I removed the whole quirk,=20
> which prevented it from running on my hardware.
>=20
> > Do you need quirk SATA with acpi=3Doff  ?
>=20
> Assuming you mean "quirk IDE", no.
>=20
> > Do you need quirk with ACPI enabled ?=20
>=20
> No. But, my interrupts are always XT-PIC, I cannot enable IO-APIC (not=20
> sure how much relevance that has, possibly worth noting though).

When IO-APIC is used, the "& 0x0f" part of the quirk becomes relevant -
in this mode 0 in the register means IO-APIC IRQ 16, 1 means IRQ 17,
etc...  However, not all chips work like this - e.g., the builtin audio
device of VT8237 has fixed IRQ routing in IO-APIC mode and ignores the
value of PCI_INTERRUPT_LINE completely.

--Signature=_Fri__14_Jul_2006_21_21_53_+0400_p=XnsEOh93x4ilBn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEt9K0W82GfkQfsqIRAtgrAJkBHmyiub1g4jeb2J4VnAzRMYBGmwCfZcJD
6OfzMhw4zDzHhw9yX1Jp458=
=saNI
-----END PGP SIGNATURE-----

--Signature=_Fri__14_Jul_2006_21_21_53_+0400_p=XnsEOh93x4ilBn--
