Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268296AbUH2UkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268296AbUH2UkY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268307AbUH2UkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:40:24 -0400
Received: from ipx10602.ipxserver.de ([80.190.249.152]:36103 "EHLO taytron.net")
	by vger.kernel.org with ESMTP id S268296AbUH2UkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:40:20 -0400
From: Florian Schirmer <jolt@tuxbox.org>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Subject: [PATCH][1/4] b44: Ignore carrier lost errors
Date: Sun, 29 Aug 2004 22:33:00 +0200
User-Agent: KMail/1.7
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200408292218.00756.jolt@tuxbox.org>
In-Reply-To: <200408292218.00756.jolt@tuxbox.org>
MIME-Version: 1.0
Message-Id: <200408292233.03879.jolt@tuxbox.org>
Content-Type: multipart/signed;
  boundary="nextPart4363059.hI9ds1C5mR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4363059.hI9ds1C5mR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

some (?) hardware seems to be buggy and is reporting bogus carrier lost=20
values. Both reference implementations from Broadcom indicate that this=20
counter is not reliable and therefore ignore it. We should do the same.=20
"Fixes" the carrier lost problem i've seen.

Regards,
  Florian

Signed-off-by: Florian Schirmer <jolt@tuxbox.org>

=2D-- linux/drivers/net/b44.c-old1 2004-08-29 16:29:08.000000000 +0200
+++ linux/drivers/net/b44.c 2004-08-29 16:27:00.000000000 +0200
@@ -1347,7 +1347,10 @@ static struct net_device_stats *b44_get_
        hwstat->rx_symbol_errs);
=20
  nstat->tx_aborted_errors =3D hwstat->tx_underruns;
+#if 0
+ /* Carrier lost counter seems to be broken for some devices */
  nstat->tx_carrier_errors =3D hwstat->tx_carrier_lost;
+#endif
=20
  return nstat;
 }


--nextPart4363059.hI9ds1C5mR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBMj1/XRF2vHoIlBsRAuu+AJ4g0h+y0C6Pzxs5KRHbzRFYxxQkMgCffMc5
xi/gaTBErr9kmuH3A8usvZE=
=mPTU
-----END PGP SIGNATURE-----

--nextPart4363059.hI9ds1C5mR--
