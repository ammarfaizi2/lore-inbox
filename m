Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992533AbWKAOsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992533AbWKAOsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 09:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992534AbWKAOsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 09:48:33 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:41904 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S2992533AbWKAOsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 09:48:33 -0500
Date: Wed, 1 Nov 2006 15:51:00 +0100
From: Luotao Fu <l.fu@pengutronix.de>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
       Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [PATCH] latency tracer support for ARM ep93xx platform
Message-ID: <20061101145100.GB25890@localhost.localdomain>
Mail-Followup-To: mingo@elte.hu, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
X-PGP-Key-ID: 0xE5325261
X-URL: http://www.pengutronix.de
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EgVrEAR5UttbsTXg
Content-Type: multipart/mixed; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
the following patch adds hardware support for the latency tracer in -rt
patch on ARM ep93xx platform.=20

regards
Luotao Fu
--=20
     Dipl.-Ing. Luotao Fu | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ep93xx_latencytrace.diff"
Content-Transfer-Encoding: quoted-printable

Adds latency tracer support for ep93xx platform.

Signed-off-by: Luotao Fu <lfu@pengutronix.de>

Index: linux-2.6.18-rt.sec/include/asm-arm/arch-ep93xx/timex.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-ep93xx/timex.h
+++ include/asm-arm/arch-ep93xx/timex.h
@@ -3,3 +3,10 @@
  */
=20
 #define CLOCK_TICK_RATE		983040
+
+#include <asm/io.h>
+#include <asm-arm/arch-ep93xx/ep93xx-regs.h>
+
+#define mach_read_cycles() readl(EP93XX_TIMER4_VALUE_LOW)
+#define mach_cycles_to_usecs(d) (((d) * ((1000000LL << 32) / CLOCK_TICK_RA=
TE)) >> 32)
+#define mach_usecs_to_cycles(d) (((d) * (((long long)CLOCK_TICK_RATE << 32=
) / 1000000)) >> 32)

--VV4b6MQE+OnNyhkM--

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFSLRUiruQY+UyUmERAhwZAJ4sqU/ydh6ajMYR/JWqkSroMLXwzwCgoYUn
VolMlRqAbnWRQDgKdAsDlYw=
=6Jwm
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--
