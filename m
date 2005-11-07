Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVKGJcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVKGJcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 04:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVKGJcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 04:32:25 -0500
Received: from indigo.cs.bgu.ac.il ([132.72.42.23]:40898 "EHLO
	indigo.cs.bgu.ac.il") by vger.kernel.org with ESMTP id S932470AbVKGJcZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 04:32:25 -0500
Subject: ACPI and PRREMPT bug
From: Nir Tzachar <tzachar@cs.bgu.ac.il>
Reply-To: tzachar@cs.bgu.ac.il
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Hwwbufimd7AV4QYfRuJE"
Organization: bgu
Date: Mon, 07 Nov 2005 11:35:33 +0200
Message-Id: <1131356134.973.23.camel@nexus.cs.bgu.ac.il>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hwwbufimd7AV4QYfRuJE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hello.

I'm encountering a problem with acpi on kernels where preempt is
enabled.
The problem is 100% reproducible on all kernels starting from 2.6.12.1
to 2.6.14
( i didn't try 2.6.11 and below ).

the problem is manifested via the battery proc interface. to produce it,
run in two terminals simultaneously:=20
while true; do cat /proc/acpi/battery/BAT0/info; done

if i turn on kernel preemption (either voluntary or not), i get the
following error messages in dmesg:
Nov  7 08:31:00 lapnir ACPI-0292: *** Error: Looking up [SERN] in
namespace, AE_ALREADY_EXISTS
Nov  7 08:31:00 lapnir ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.GBIF] (Node c18f5d60), AE_ALREADY_EXISTS
Nov  7 08:31:02 lapnir ACPI-0213: *** Error: Method reached maximum
reentrancy limit (255)
Nov  7 08:31:02 lapnir ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f5c20), AE_AML_METHOD_LIMIT

and with acpi debugging info turned on:
Nov  7 08:46:08 lapnir dswload-0292: *** Error: Looking up [SERN] in
namespace, AE_ALREADY_EXISTS
Nov  7 08:46:08 lapnir psloop-0287 [4399] ps_parse_loop         : During
name lookup/catalog, AE_ALREADY_EXISTS
Nov  7 08:46:08 lapnir psparse-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.GBIF] (Node c18f94e8), AE_ALREADY_EXISTS
Nov  7 08:46:08 lapnir osl-0856 [4403] os_wait_semaphore     : Failed to
acquire semaphore[c18de5e0|1|0], AE_TIME
Nov  7 08:46:08 lapnir dsmethod-0213: *** Error: Method reached maximum
reentrancy limit (255)
Nov  7 08:46:08 lapnir psparse-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f9268), AE_AML_METHOD_LIMIT
Nov  7 08:46:08 lapnir acpi_battery-0144 [4449] battery_get_info      :
Error evaluating _BIF
Nov  7 08:46:08 lapnir dsmethod-0213: *** Error: Method reached maximum
reentrancy limit (255)
Nov  7 08:46:08 lapnir psparse-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f9268), AE_AML_METHOD_LIMIT


this is repeated until a reboot. loading and unloading the battery
module does not help.

My computer is a thinkpad t43p, and i didn't try to reproduce it on
another laptop
(have no access to another model..).
If you need more info, let me know.

p.s. please cc me, im not in the list.

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Nir Tzachar.

--=-Hwwbufimd7AV4QYfRuJE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDbx/lIHR+zI+Dam4RAtAaAJ93o7lRT7qq65o94IXHT1s+YSUdNQCgiu+b
CZIjx1ojl6pVSTYG55R3fSs=
=T3Xx
-----END PGP SIGNATURE-----

--=-Hwwbufimd7AV4QYfRuJE--

