Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVGTPmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVGTPmK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 11:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVGTPmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 11:42:10 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:61382 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S261371AbVGTPmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 11:42:08 -0400
Date: Wed, 20 Jul 2005 17:42:07 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]: Correctly locate RSDP in EBDA
Message-ID: <20050720174207.3a5884fc@laptop.hypervisor.org>
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Wed__20_Jul_2005_17_42_07_+0200_E3J2nFGb42VDVaDO;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Wed__20_Jul_2005_17_42_07_+0200_E3J2nFGb42VDVaDO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


ACPI spec. states that the location of the RSDP structure is found by searc=
hing
* The first 1 KB of the Extended BIOS Data Area (EBDA).
* The BIOS read-only memory space between 0E0000h and 0FFFFFh

The EBDA scan looks wrong. The patch below against 2.6.12 should correct th=
is.

-Udo.

---

Calculate correct EBDA address for ACPI RSDP scan. The word at BIOS Data Ar=
ea
40:0E is the segment address of the EBDA.

Signed-off-by: Udo A. Steinberg <us15@os.inf.tu-dresden.de>

--- linux-2.6.12/arch/i386/kernel/acpi/boot.c.old       2005-07-20 17:28:32=
.000000000 +0200
+++ linux-2.6.12/arch/i386/kernel/acpi/boot.c   2005-07-20 17:31:15.0000000=
00 +0200
@@ -648,7 +648,7 @@
         * Scan memory looking for the RSDP signature. First search EBDA (l=
ow
         * memory) paragraphs and then search upper memory (E0000-FFFFF).
         */
-       rsdp_phys =3D acpi_scan_rsdp (0, 0x400);
+       rsdp_phys =3D acpi_scan_rsdp (*(u16*) 0x40E << 4, 0x400);
        if (!rsdp_phys)
                rsdp_phys =3D acpi_scan_rsdp (0xE0000, 0x20000);
=20

--Signature_Wed__20_Jul_2005_17_42_07_+0200_E3J2nFGb42VDVaDO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFC3nDQnhRzXSM7nSkRAmyvAJ93egsK96cJgO3q3oreV4ZvenFp5wCfRZeK
sstdVXvVkD/Iu8U6Ei0OwOM=
=MARK
-----END PGP SIGNATURE-----

--Signature_Wed__20_Jul_2005_17_42_07_+0200_E3J2nFGb42VDVaDO--
