Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130453AbRBMJgw>; Tue, 13 Feb 2001 04:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130883AbRBMJgn>; Tue, 13 Feb 2001 04:36:43 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:22540 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S130453AbRBMJg0>; Tue, 13 Feb 2001 04:36:26 -0500
Date: Tue, 13 Feb 2001 12:52:12 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ conflicts
Message-ID: <20010213125212.A2135@debian>
Mail-Followup-To: Brian Gerst <bgerst@didntduck.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E14RfhV-0002A1-00@the-village.bc.nu> <3A85D79C.3DE3A527@didntduck.org> <20010213124400.A1860@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
User-Agent: Mutt/1.0.1i
In-Reply-To: <20010213124400.A1860@debian>; from pazke@orbita.don.sitek.net on Tue, Feb 13, 2001 at 12:44:00PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Hi Brian.

I'm sorry, patch itself was not attached in previous post :(

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-acpiirq
Content-Transfer-Encoding: quoted-printable

--- /linux/arch/i386/kernel/pci-pc.c.orig	Mon Feb 12 02:06:24 2001
+++ /linux/arch/i386/kernel/pci-pc.c	Mon Feb 12 02:08:51 2001
@@ -950,6 +950,26 @@
 	}
 }
=20
+static void __init pci_fixup_via_acpi(struct pci_dev *d)
+{
+	/*
+	 * VIA ACPI device: IRQ line in PCI config byte 0x42
+	 */
+	u8 irq;
+	pci_read_config_byte(d, 0x42, &irq);
+	irq &=3D 0x0f;
+	if (irq && (irq !=3D 2))
+		d->irq =3D irq;
+}
+
+static void __init pci_fixup_piix4_acpi(struct pci_dev *d)
+{
+	/*
+	 * PIIX4 ACPI device: hardwired IRQ9
+	 */
+	d->irq =3D 9;
+}
+
 struct pci_fixup pcibios_fixups[] =3D {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci=
_fixup_i450nx },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	pci=
_fixup_i450gx },
@@ -963,6 +983,9 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		pci_fixup_l=
atency },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5598,		pci_fixup_l=
atency },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	pci_fixu=
p_vt8363 },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	pci_fi=
xup_via_acpi },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	pci_fi=
xup_via_acpi },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	p=
ci_fixup_piix4_acpi },
 	{ 0 }
 };
=20

--sm4nu43k4a2Rpi4c--

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6iQPMBm4rlNOo3YgRAhLoAJ9Ym0RItGVX+eCczWTGrNzBfIZpmgCfWK2W
IRWPn3nC43TJ6ptLV4fpj14=
=RL0D
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
