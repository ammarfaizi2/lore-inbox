Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266449AbUHTLZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266449AbUHTLZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 07:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUHTLZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 07:25:25 -0400
Received: from mail.donpac.ru ([80.254.111.2]:21125 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S266449AbUHTLZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 07:25:15 -0400
Date: Fri, 20 Aug 2004 15:25:14 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.8.1-mm3, fix visws kernel build 
Message-ID: <20040820112514.GB794@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20040820031919.413d0a95.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040803i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

looks like someone broke kernel build for SGI Visws 320/540 again:

  CC      arch/i386/kernel/cpu/intel.o
In file included from arch/i386/kernel/cpu/intel.c:19:
include/asm-i386/mach-visws/mach_apic.h: In function `cpu_present_to_apicid=
':
include/asm-i386/mach-visws/mach_apic.h:67: error: `BAD_APICID' undeclared =
(first use in this function)
include/asm-i386/mach-visws/mach_apic.h:67: error: (Each undeclared identif=
ier is reported only once
include/asm-i386/mach-visws/mach_apic.h:67: error: for each function it app=
ears in.)
make[2]: *** [arch/i386/kernel/cpu/intel.o] =EF=DB=C9=C2=CB=C1 1

attached patch fixes it. Please consider applying.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-visws-2.6.8.1-mm3"
Content-Transfer-Encoding: quoted-printable

diff -urpNX /usr/share/dontdiff linux-2.6.8.1-mm3.vanilla/include/asm-i386/=
mach-visws/mach_apic.h linux-2.6.8.1-mm3/include/asm-i386/mach-visws/mach_a=
pic.h
--- linux-2.6.8.1-mm3.vanilla/include/asm-i386/mach-visws/mach_apic.h	2004-=
08-20 14:46:05.000000000 +0400
+++ linux-2.6.8.1-mm3/include/asm-i386/mach-visws/mach_apic.h	2004-08-20 14=
:55:27.000000000 +0400
@@ -2,6 +2,7 @@
 #define __ASM_MACH_APIC_H
=20
 #include <mach_apicdef.h>
+#include <asm/smp.h>
=20
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
=20

--IS0zKkzwUGydFO0o--

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBJd+aby9O0+A2ZecRAg3NAJ4naXrJHhbwDEfNctezBLJWxfNI/ACgvR+t
0gWpq2FRJFoGcYFVrOoCyFw=
=zCq7
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
