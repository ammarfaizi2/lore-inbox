Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265380AbTLHL7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 06:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbTLHL7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 06:59:06 -0500
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:45316 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S265380AbTLHL7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 06:59:01 -0500
Date: Mon, 8 Dec 2003 05:58:59 -0600
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: Re: APIC support on Slot-A Athlon, K6
Message-ID: <20031208115859.GA17909@dbz.icequake.net>
References: <20031208102800.5409.87787.Mailman@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20031208102800.5409.87787.Mailman@lists.us.dell.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >Unfortunately, this disables the APIC support (if it existed) on a
> >Slot-A Athlon 600 MS-6167 (family 6, model 1, AMD-751/756), and a K6/3 4=
00
> >Tyan S1598 (family 5, model 9, MVP3/686A).
> >
> >What is the purpose of this check? Why is the APIC availability dependent
> >on the CPU, rather than just the southbridge?
>=20
> This code checks for the ability to enable the local APIC,
> which is integrated into the processor. The local APIC is
> not implemented in K6 or K7 model 1, so the check is correct.

Thanks, that just cleared up a huge misconception (I had the APIC and I/O-A=
PIC
confused, apparently).

This page cleared a lot up (must remember to STFW occasionally):
http://www.microsoft.com/whdc/hwdev/platform/proc/IO-APIC.mspx

> Furthermore, I/O-APIC usage requires (in hardware) that the
> processor has a local APIC.

What can the APIC support alone accomplish, without an I/O-APIC?
Just NMI watchdog and related things? (looking at CONFIG_APIC help)
Looks like I/O-APIC is the real desired feature, but a functioning local
APIC, though not very useful by itself, is a prerequisite for it.

> > Also, there are only
> >checks for Intel and AMD CPUs. Is it not possible to use an APIC in
> >conjunction with a Cyrix, et.al. ?
>=20
> The other manufacturers haven't yet implemented local APIC
> functionality in their processors.

Ok, much more clear.

> >The APIC is also not enabled on this machine, but it is a 586B southbrid=
ge,=3D
> > which
> >I am not sure contains an APIC.
>=20
> What processor? As I wrote above, I/O-APIC can't be used unless
> the processor has a local APIC.

Cyrix. :D  Obviously, it won't work simply because of that.  I
am curious if the VIA 586B has a IO-APIC though (the 686A/B do) so
that it would work if I put a different processor in it.
VIA no longer put their datasheets on the web anymore...

> Some BIOSen have an option for enabling/disabling I/O-APIC mode.
> Some BIOSen skip the "legacy" MP tables and only announce the
> I/O-APIC config data via ACPI, so working ACPI may be required.

Also useful info.  Thanks!

--=20
Ryan Underwood, <nemesis@icequake.net>

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1GeDIonHnh+67jkRAmztAJ41D6E1Gd5OY6OhZmjjjHLMg1JE0gCfST/I
cM21FnGgZ0cMfBqsiMnPuTU=
=kEc6
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
