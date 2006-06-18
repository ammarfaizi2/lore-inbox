Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWFRNLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWFRNLR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 09:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWFRNLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 09:11:16 -0400
Received: from master.altlinux.org ([62.118.250.235]:21253 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932212AbWFRNLQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 09:11:16 -0400
Date: Sun, 18 Jun 2006 17:10:50 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Chris Wedgwood <cw@f00f.org>
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Hugo Vanwoerkom <rociobarroso@att.net.mx>, ocilent1@gmail.com,
       linux list <linux-kernel@vger.kernel.org>
Subject: Re: sound skips on 2.6.16.17
Message-Id: <20060618171050.1afff478.vsu@altlinux.ru>
In-Reply-To: <20060618024130.GA32399@tuatara.stupidest.org>
References: <4487F942.3030601@att.net.mx>
	<200606161115.53716.ocilent1@gmail.com>
	<4493D24D.2010902@att.net.mx>
	<200606172129.56986.kernel@kolivas.org>
	<20060618024130.GA32399@tuatara.stupidest.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__18_Jun_2006_17_10_50_+0400_nvurZZqD=qRn0W2B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__18_Jun_2006_17_10_50_+0400_nvurZZqD=qRn0W2B
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Jun 2006 19:41:30 -0700 Chris Wedgwood wrote:

> On Sat, Jun 17, 2006 at 09:29:56PM +1000, Con Kolivas wrote:
>=20
> > > > 1)  PCI-VIA-quirk-fixup-additional-PCI-IDs.patch
>=20
> that shouldn't break things, if it does I *really* want to know
>=20
> > > > 2)
> > PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch
>=20
> nor should that, so again i would like to know if this is the one that
> makes a difference
>=20
> > > Works like a charm. End of the sound skips.
>=20
> what cpu/mainboard/etc

Here I have ASUS A8V Deluxe (VIA K8T800Pro + VT8237), and cannot
reproduce the problem in a "normal" way (even when booting with
"acpi=3Doff noapic"), but I have some evidence that a problem really
exists.

VT8237 contains this AC97 controller:

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8=
235/8237 AC97 Audio Controller (rev 60)
	Subsystem: ASUSTeK Computer Inc. A8V Deluxe motherboard (Realtek ALC850 co=
dec)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at d800
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 06 11 59 30 01 00 10 02 60 00 01 04 00 00 00 00
10: 01 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 2a 81
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 03 00 00
40: 01 cc 00 00 10 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

The device ID is 1106:3059 - it is not included in the list for
quirk_via_irq().  However, I have tried to boot with "noapic", and by
trying to change the INTERRUPT_LINE register with setpci have confirmed
that this register is used to set up interrupt routing.  In APIC mode
this register has no effect on VT8237.

We may just add 1106:3059 to the list of PCI IDs which need
quirk_via_irq().  However, is this really a proper solution?  What
exactly was broken with the original quirk code, which was applied to
all VIA devices - just a wrong printk, or some real breakage?

--Signature=_Sun__18_Jun_2006_17_10_50_+0400_nvurZZqD=qRn0W2B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD4DBQFElVDfW82GfkQfsqIRAnBVAJ9Or70VA12RvdgdCV/5xLA4KLRfOgCXfOD6
ckpfwQc+QjYjR049dsi4gQ==
=XT7p
-----END PGP SIGNATURE-----

--Signature=_Sun__18_Jun_2006_17_10_50_+0400_nvurZZqD=qRn0W2B--
