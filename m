Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbTLHIsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 03:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbTLHIsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 03:48:47 -0500
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:12817 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S265350AbTLHIso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 03:48:44 -0500
Date: Mon, 8 Dec 2003 02:48:42 -0600
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: APIC support on Slot-A Athlon, K6
Message-ID: <20031208084842.GA12615@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

2.4.23 kernel on all machines, freshly compiled.

In i386/kernel/apic.c:detect_init_APIC(), we have the following lines:
switch (boot_cpu_data.x86_vendor) {
case X86_VENDOR_AMD:
	if (boot_cpu_data.x86 =3D=3D 6 && boot_cpu_data.x86_model > 1)
		break;
	goto no_apic;
=2E..

Unfortunately, this disables the APIC support (if it existed) on a
Slot-A Athlon 600 MS-6167 (family 6, model 1, AMD-751/756), and a K6/3 400
Tyan S1598 (family 5, model 9, MVP3/686A).

What is the purpose of this check?  Why is the APIC availability dependent
on the CPU, rather than just the southbridge?  Also, there are only
checks for Intel and AMD CPUs.  Is it not possible to use an APIC in
conjunction with a Cyrix, et.al. ?



On to another topic, I would also like to know if anyone has used a
Shuttle HOT-591P successfully in ACPI mode.  It passes the date check as
the BIOS is (dmidecode):
Vendor: Award Software International, Inc.
Version: 4.51 PG
Release Date: 03/27/01

board:
Manufacturer: Shuttle Inc.
Product Name: VIA APOLLO MVP3 (HOT-597)
Version: 2A5LEH2B
(It is actually a 591P, regardless of the DMI string)

However, the kernel does the following on bootup:

ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=3D1
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................=
=2E.......
Table [DSDT](id F004) - 227 Objects with 26 Devices 55 Methods 17 Regions
ACPI Namespace successfully loaded at root c02dba3c
ACPI: IRQ9 SCI: Level Trigger.
evxfevnt-0089: *** Error: Could not transition to ACPI mode.
 utxface-0170 [03] acpi_enable_subsystem : acpi_enable failed.
ACPI: Unable to start the ACPI Interpreter
evxfevnt-0127 [06] acpi_disable          : System is already in legacy (non=
-ACPI) mode
 utalloc-0986 [05] ut_dump_allocations   : No outstanding allocations.
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
=2E..

At the "ACPI: IRQ9 SCI:" part, it pauses for a few seconds before continuin=
g.
The APIC is also not enabled on this machine, but it is a 586B southbridge,=
 which
I am not sure contains an APIC.

Any enlightenment on these topics would be appreciated.

thanks,

--=20
Ryan Underwood, <nemesis@icequake.net>

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1DrqIonHnh+67jkRAv8hAJ9buQM/RB4BM5XXF3yqruD5f3utSwCggAlc
ZBeduPqHtJo0G2QJLkXDlRE=
=laLL
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
