Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTLIFDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 00:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTLIFDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 00:03:14 -0500
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:41477 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S262844AbTLIFDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 00:03:09 -0500
Date: Mon, 8 Dec 2003 23:03:08 -0600
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: Re: APIC support on Slot-A Athlon, K6 [PATCH]
Message-ID: <20031209050308.GA10763@dbz.icequake.net>
References: <200312081707.hB8H7B85014403@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <200312081707.hB8H7B85014403@harpo.it.uu.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: multipart/mixed; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2003 at 06:07:11PM +0100, Mikael Pettersson wrote:
> On Mon, 8 Dec 2003 05:58:59 -0600, Ryan Underwood wrote:
> >> Furthermore, I/O-APIC usage requires (in hardware) that the
> >> processor has a local APIC.
> >
> >What can the APIC support alone accomplish, without an I/O-APIC?
> >Just NMI watchdog and related things? (looking at CONFIG_APIC help)
> >Looks like I/O-APIC is the real desired feature, but a functioning local
> >APIC, though not very useful by itself, is a prerequisite for it.
>=20
> Local APIC gives you:
> - using the local APIC timer instead of the mobo's legacy timer
> - thermal management interrupts on P4s (dunno about K7s/K8s)
> - performance counter interrupts, which can be used as an NMI
>   source (watchdog, profiling) or for performance analysis
>=20
> I/O-APIC gives you:
> - more interrupt vectors =3D=3D> less IRQ sharing =3D=3D> improved
>   stability and performance
> - lower-overhead interrupt management
> - I/O-APIC NMI watchdog (another timer with NMI delivery mode)

I attached a Kconfig patch more explicitly stating the prerequisites for
using the I/O-APIC.

--=20
Ryan Underwood, <nemesis@icequake.net>

--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="kconfig.diff"
Content-Transfer-Encoding: quoted-printable

--- arch/i386/Kconfig.bak	2003-08-08 23:32:43.000000000 -0500
+++ arch/i386/Kconfig	2003-12-08 23:00:36.000000000 -0600
@@ -491,6 +491,10 @@
 	  If you have a system with several CPUs, you do not need to say Y
 	  here: the IO-APIC will be used automatically.
=20
+	  A functioning local APIC is a prerequisite for using the I/O-APIC
+	  on uniprocessor machines. Sometimes working ACPI support is also
+	  required (depending on the BIOS implementation).
+
 config X86_LOCAL_APIC
 	bool
 	depends on !SMP && X86_UP_APIC

--LyciRD1jyfeSSjG0--

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1VeMIonHnh+67jkRAvEtAJ9A8iafkFuFA3G05SwRLhDt2Ke9ewCdEVn4
Vz5lQhApEz6+4cKJrV2A5Lk=
=P2y0
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
