Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUJLQSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUJLQSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUJLQSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:18:39 -0400
Received: from mgw-x3.nokia.com ([131.228.20.26]:17830 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id S266137AbUJLQR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:17:26 -0400
X-Scanned: Tue, 12 Oct 2004 19:16:34 +0300 Nokia Message Protector V1.3.31 2004060815 - RELEASE
Date: Tue, 12 Oct 2004 19:16:32 +0300
From: Paul Mundt <paul.mundt@nokia.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nico@cam.org, takata@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: fix smc91x build for sh/ppc
Message-ID: <20041012161631.GA8766@hed040-158.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 12 Oct 2004 16:16:32.0229 (UTC) FILETIME=[D65D6150:01C4B076]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current smc91x code uses set_irq_type(). It looks like the m32r guys
worked around this by adding a !defined(__m32r__) check, but this is equally
bogus as set_irq_type() is an arm/arm26-specific function.

Trying to get this to build on sh died in the same spot, so we just back out
the m32r change and make it depend on CONFIG_ARM instead. Notably, the ppc
build would have been broken by this as well, but it doesn't seem like anyo=
ne
noticed this there yet.

Signed-off-by: Paul Mundt <paul.mundt@nokia.com>

 drivers/net/smc91x.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

=3D=3D=3D=3D=3D drivers/net/smc91x.c 1.7 vs edited =3D=3D=3D=3D=3D
--- 1.7/drivers/net/smc91x.c	2004-09-17 03:07:00 +03:00
+++ edited/drivers/net/smc91x.c	2004-10-12 19:05:25 +03:00
@@ -1885,7 +1885,7 @@
       	if (retval)
       		goto err_out;
=20
-#if !defined(__m32r__)
+#ifdef CONFIG_ARM
 	set_irq_type(dev->irq, IRQT_RISING);
 #endif
 #ifdef SMC_USE_PXA_DMA

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBbANfvfgmmv+NIDsRApngAJ9bSyQxJap4fXNUggvFoOeHKj+c2gCgqHtE
ou3puqxlDEPSHp0tTy5vVNU=
=0pVB
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
